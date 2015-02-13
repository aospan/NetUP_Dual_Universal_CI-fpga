-- NetUP Universal Dual DVB-CI FPGA firmware
-- http://www.netup.tv
-- 
-- Copyright (c) 2014 NetUP Inc, AVB Labs
-- License: GPLv3


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity fifo_in_8b_sync is
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
		rd_en		: in std_logic;
		wait_req	: out std_logic;
		-- output stream
		st_data		: in std_logic_vector(7 downto 0);
		st_valid	: in std_logic;
		st_ready	: out std_logic
	);
end entity;

architecture RTL of fifo_in_8b_sync is

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

	signal data_rden	: std_logic;
	signal ctrl_wren	: std_logic;

	signal read_phase		: unsigned(1 downto 0);
	signal end_phase		: std_logic_vector(2 downto 0);
	signal read_not_compl	: std_logic;

	signal fifo_reset	: std_logic;

	signal imask		: std_logic;
	signal ipend		: std_logic;
	signal fill			: unsigned(FIFO_ADDR_WIDTH downto 0);
	signal threshold	: unsigned(FIFO_ADDR_WIDTH - 1 downto 0);

	signal valid_i		: std_logic;
	signal read_buffer	: std_logic_vector(BUS_WIDTH - 1 downto 0);
	signal read_data	: std_logic_vector(BUS_WIDTH - 1 downto 0);

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
			valid_i <= not_empty or (valid_i and not end_phase(2));
			if fifo_reset = '1' then
				read_ptr <= (others => '0');
				write_ptr <= (others => '0');
				valid_i <= '0';
			end if;
		end if;
		if rst = '1' then
			read_ptr <= (others => '0');
			write_ptr <= (others => '0');
			valid_i <= '0';
		end if;
	end process;

	not_empty <= '0' when read_ptr = write_ptr else '1';
	fill <= write_ptr - read_ptr when valid_i = '0' else write_ptr - read_ptr + 1;

	-- bus interface logic
	ipend <= '1' when fill > unsigned('0' & threshold) else '0';

	with addr select
		out_data <= (BUS_WIDTH - 1 downto 16 => '0') & imask & (14 downto FIFO_ADDR_WIDTH + 8 => '0') & std_logic_vector(threshold) & ipend & (6 downto FIFO_ADDR_WIDTH + 1 => '0') & std_logic_vector(fill) when REG_CTRL_STAT,
					read_data when others;

	data_rden <= (rd_en and valid_i) when addr = REG_DATA else '0';
	ctrl_wren <= (byte_en(1) and wr_en) when addr = REG_CTRL_STAT else '0';

	fifo_reset <= ctrl_wren and in_data(14);

	with byte_en select
		end_phase <= 	data_rden & "00" when "0001",
						data_rden & "01" when "0011",
						data_rden & "11" when "1111",
						"000" when others;

	read_not_compl <= end_phase(2) when read_phase /= unsigned(end_phase(1 downto 0)) else '0';

	process (rst, clk)
	begin
		if rising_edge(clk) then
			if ctrl_wren = '1' then
				imask <= in_data(15);
				threshold <= unsigned(in_data(FIFO_ADDR_WIDTH + 7 downto 8));
			end if;
			if read_not_compl = '0' then
				read_phase <= (others => '0');
			else
				read_phase <= read_phase + 1;
			end if;
			if read_not_compl = '1' then
				case read_phase(1 downto 0) is
					when "00" =>
						read_buffer(7 downto 0) <= fifo_ram_q;
					when "01" =>
						read_buffer(15 downto 8) <= fifo_ram_q;
					when "10" =>
						read_buffer(23 downto 16) <= fifo_ram_q;
					when others =>
						read_buffer(31 downto 24) <= fifo_ram_q;
				end case;
			end if;
		end if;
		if rst = '1' then
			imask <= '0';
			threshold <= (others => '0');
			read_phase <= (others => '0');
			read_buffer <= (others => '0');
		end if;
	end process;

	wait_req <= read_not_compl;

	read_data(31 downto 24) <= fifo_ram_q when read_phase(1 downto 0) = 3 else read_buffer(31 downto 24);
	read_data(23 downto 16) <= fifo_ram_q when read_phase(1 downto 0) = 2 else read_buffer(23 downto 16);
	read_data(15 downto 8) <= fifo_ram_q when read_phase(1 downto 0) = 1 else read_buffer(15 downto 8);
	read_data(7 downto 0) <= fifo_ram_q when read_phase(1 downto 0) = 0 else read_buffer(7 downto 0);

	fifo_ram_d <= st_data;
	fifo_ram_we <= st_valid and not fill(FIFO_ADDR_WIDTH);
	fifo_ram_re <= not_empty and (end_phase(2) or not valid_i);

	st_ready <= not fill(FIFO_ADDR_WIDTH);

	irq <= ipend and imask;

end architecture;
