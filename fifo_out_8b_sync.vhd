-- NetUP Universal Dual DVB-CI FPGA firmware
-- http://www.netup.tv
-- 
-- Copyright (c) 2014 NetUP Inc, AVB Labs
-- License: GPLv3


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fifo_out_8b_sync is
	generic (
		FIFO_DEPTH		: natural range 8 to 64 := 16;
		BUS_WIDTH		: natural range 16 to 64 := 32
	);
	port (
		rst			: in std_logic;
		clk			: in std_logic;
		irq			: out std_logic;
		-- Avalon-MM 32-bits slave
		addr		: in std_logic_vector(1 downto 0);
		byte_en		: in std_logic_vector(3 downto 0)	:= (others => '1');
		in_data		: in std_logic_vector(31 downto 0);
		wr_en		: in std_logic;
		out_data	: out std_logic_vector(31 downto 0);
		wait_req	: out std_logic;
		-- output stream
		st_data		: out std_logic_vector(7 downto 0);
		st_valid	: out std_logic;
		st_ready	: in std_logic
	);
end entity;

architecture RTL of fifo_out_8b_sync is

	function log2ceil (arg: natural) return natural is
	begin
		if arg < 2 then 
			return 1;
		else
			return log2ceil(arg / 2) + 1;
		end if;
	end function;

	constant FIFO_ADDR_WIDTH	: natural := log2ceil(FIFO_DEPTH - 1);

	constant REG_DATA		: std_logic_vector(1 downto 0) := "00";
	constant REG_CTRL_STAT	: std_logic_vector(1 downto 0) := "10";

	signal read_ptr		: unsigned(FIFO_ADDR_WIDTH downto 0);
	signal write_ptr	: unsigned(FIFO_ADDR_WIDTH downto 0);

	signal not_empty	: std_logic;

	signal data_wren	: std_logic;
	signal ctrl_wren	: std_logic;

	signal write_phase	: unsigned(1 downto 0);
	signal end_phase	: std_logic_vector(2 downto 0);
	signal write_not_compl	: std_logic;

	signal fifo_reset	: std_logic;

	signal imask		: std_logic;
	signal ipend		: std_logic;
	signal fill			: unsigned(FIFO_ADDR_WIDTH downto 0);
	signal threshold	: unsigned(FIFO_ADDR_WIDTH - 1 downto 0);

	signal st_valid_i	: std_logic;

	type mem_t is array(0 to FIFO_DEPTH - 1) of std_logic_vector(7 downto 0);

	signal fifo_ram		: mem_t;
	signal fifo_ram_we	: std_logic;
	signal fifo_ram_re	: std_logic;
	signal fifo_ram_d	: std_logic_vector(7 downto 0);
	signal fifo_ram_q	: std_logic_vector(7 downto 0);

	attribute ramstyle : string;
	attribute ramstyle of fifo_ram : signal is "logic";

begin
	-- RAM block logic
	process (clk)
	begin
		if rising_edge(clk) then
			if fifo_ram_we = '1' then
				fifo_ram(to_integer(write_ptr(FIFO_ADDR_WIDTH - 1 downto 0))) <= fifo_ram_d;
			end if;
			if fifo_ram_re = '1' then
				fifo_ram_q <= fifo_ram(to_integer(read_ptr(FIFO_ADDR_WIDTH - 1 downto 0)));
			end if;
		end if;
	end process;

	-- FIFO pointers logic
	process (rst, clk)
	begin
		if rising_edge(clk) then
			if fifo_ram_we = '1' then
				write_ptr <= write_ptr + 1;
			end if;
			if fifo_ram_re = '1' then
				read_ptr <= read_ptr + 1;
			end if;
			st_valid_i <= not_empty or (st_valid_i and not st_ready);
			if fifo_reset = '1' then
				read_ptr <= (others => '0');
				write_ptr <= (others => '0');
				st_valid_i <= '0';
			end if;
		end if;
		if rst = '1' then
			read_ptr <= (others => '0');
			write_ptr <= (others => '0');
			st_valid_i <= '0';
		end if;
	end process;

	not_empty <= '0' when read_ptr = write_ptr else '1';
	fill <= write_ptr - read_ptr;

	-- bus interface logic
	ipend <= '0' when fill > unsigned('0' & threshold) else '1';

	with addr select
		out_data <= (BUS_WIDTH - 1 downto 16 => '0') & imask & (14 downto FIFO_ADDR_WIDTH + 8 => '0') & std_logic_vector(threshold) & ipend & (6 downto FIFO_ADDR_WIDTH + 1 => '0') & std_logic_vector(fill) when REG_CTRL_STAT,
					(others => '0') when others;

	data_wren <= wr_en and not fill(FIFO_ADDR_WIDTH) when addr = REG_DATA else '0';
	ctrl_wren <= (byte_en(1) and wr_en) when addr = REG_CTRL_STAT else '0';

	fifo_reset <= ctrl_wren and in_data(14);

	with byte_en select
		end_phase <= 	data_wren & "00" when "0001",
						data_wren & "01" when "0011",
						data_wren & "11" when "1111",
						"000" when others;

	write_not_compl <= end_phase(2) when write_phase /= unsigned(end_phase(1 downto 0)) else '0';

	process (rst, clk)
	begin
		if rising_edge(clk) then
			if ctrl_wren = '1' then
				imask <= in_data(15);
				threshold <= unsigned(in_data(FIFO_ADDR_WIDTH + 7 downto 8));
			end if;
			if write_not_compl = '0' then
				write_phase <= (others => '0');
			else
				write_phase <= write_phase + 1;
			end if;
		end if;
		if rst = '1' then
			imask <= '0';
			threshold <= (others => '0');
			write_phase <= (others => '0');
		end if;
	end process;

	wait_req <= write_not_compl;

	fifo_ram_we <= end_phase(2);
	fifo_ram_re <= not_empty and (st_ready or not st_valid_i);

	with write_phase select
		fifo_ram_d <= 	in_data(31 downto 24) when "11",
						in_data(23 downto 16) when "10",
						in_data(15 downto 8) when "01",
						in_data(7 downto 0) when others;

	st_data <= fifo_ram_q;
	st_valid <= st_valid_i;

	irq <= ipend and imask;

end architecture;
