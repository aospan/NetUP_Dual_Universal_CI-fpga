-- NetUP Universal Dual DVB-CI FPGA firmware
-- http://www.netup.tv
-- 
-- Copyright (c) 2014 NetUP Inc, AVB Labs
-- License: GPLv3


-- altera vhdl_input_version vhdl_2008

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity spi_master_16 is
	port (
		rst			: in std_logic;
		clk			: in std_logic;
		--
		addr		: in std_logic_vector(9 downto 0);
		byte_en		: in std_logic_vector(1 downto 0) := (others => '1');
		in_data		: in std_logic_vector(15 downto 0);
		wr_en		: in std_logic;
		out_data	: out std_logic_vector(15 downto 0);
		wait_req	: out std_logic;
		irq			: out std_logic;
		--
		sclk		: out std_logic;
		mosi		: out std_logic;
		miso		: in std_logic;
		cs_n		: out std_logic
	);
end entity;

architecture rtl of spi_master_16 is

	constant BIT_IRQ		: natural := 12;
	constant BIT_IMASK		: natural := 13;
	constant BIT_LAST_BLOCK	: natural := 14;
	constant BIT_START		: natural := 15;

	signal ctrlstat_reg	: std_logic_vector(15 downto 10);
	signal length_reg	: unsigned(9 downto 0);
	signal clkdiv_reg	: unsigned(15 downto 0);

	signal ctrlstat_reg_wren	: std_logic;
	signal clkdiv_reg_wren		: std_logic;

	signal spi_run			: std_logic;
	signal spi_last_block	: std_logic;
	signal spi_irq			: std_logic;
	signal spi_imask		: std_logic;

	signal bus_ram_addr		: std_logic_vector(8 downto 0);
	signal bus_ram_data		: std_logic_vector(15 downto 0);
	signal bus_ram_we		: std_logic;

	signal spi_ram_addr		: unsigned(9 downto 0);
	signal spi_ram_data		: std_logic_vector(7 downto 0);
	signal spi_ram_we		: std_logic;
	signal spi_ram_rdy_n	: std_logic;

	signal clk_cnt			: unsigned(16 downto 0);
	signal bit_cnt			: unsigned(2 downto 0);
	signal spi_shift_reg	: std_logic_vector(8 downto 0);

	signal clk_cnt_rst		: std_logic;
	signal clk_tick_en		: std_logic;
	signal clk_tick			: std_logic;

	signal spi_shift_en		: std_logic;
	signal spi_load_en		: std_logic;
	signal spi_sample_en	: std_logic;
	signal spi_complete		: std_logic;

	signal cs_i				: std_logic;
	signal cs_ext_i			: std_logic;
	signal sclk_i			: std_logic;

begin
	-- system bus interface

	bus_ram_we <= wr_en and not addr(addr'left);
	wait_req <= wr_en nor addr(addr'left) when bus_ram_addr /= addr(bus_ram_addr'range) else '0';

	RAM_BUFFER_0 : entity work.spi_ram_buffer
		port map (
			clock		=> clk,
			--
			address_a	=> addr(bus_ram_addr'range),
			byteena_a	=> byte_en,
			data_a		=> in_data,
			wren_a		=> bus_ram_we,
			q_a			=> bus_ram_data,
			--
			address_b	=> std_logic_vector(spi_ram_addr),
			data_b		=> spi_shift_reg(7 downto 0),
			wren_b		=> spi_ram_we,
			q_b			=> spi_ram_data
		);

	ctrlstat_reg_wren <= wr_en when addr(addr'left) and not addr(0) else '0'; 
	clkdiv_reg_wren <= wr_en when addr(addr'left) and addr(0) else '0'; 

	ctrlstat_reg <= (
		BIT_START		=> spi_run,
		BIT_LAST_BLOCK	=> spi_last_block,
		BIT_IRQ			=> spi_irq,
		BIT_IMASK		=> spi_imask,
		--
		others => '0'
	);

	process (rst, clk)
	begin
		if rising_edge(clk) then
			bus_ram_addr <= addr(bus_ram_addr'range);
			if ctrlstat_reg_wren and byte_en(0) then
				length_reg(7 downto 0) <= unsigned(in_data(7 downto 0));
			end if;
			if ctrlstat_reg_wren and byte_en(1) then
				spi_imask <= in_data(BIT_IMASK);
				spi_last_block <= in_data(BIT_LAST_BLOCK);
				length_reg(9 downto 8) <= unsigned(in_data(9 downto 8));
			end if;
			if spi_complete then
				spi_run <= '0';
			elsif ctrlstat_reg_wren and byte_en(1) then
				spi_run <= in_data(BIT_START);
			end if;
			if spi_complete then
				spi_irq <= '1';
			elsif ctrlstat_reg_wren and byte_en(1) and in_data(BIT_IRQ) then
				spi_irq <= '0';
			end if;
			if clkdiv_reg_wren and byte_en(0) then
				clkdiv_reg(7 downto 0) <= unsigned(in_data(7 downto 0));
			end if;
			if clkdiv_reg_wren and byte_en(1) then
				clkdiv_reg(15 downto 8) <= unsigned(in_data(15 downto 8));
			end if;
		end if;
		if rst = '1' then
			bus_ram_addr <= (others => '0');
			spi_imask <= '0';
			spi_irq <= '0';
			spi_last_block <= '0';
			spi_run <= '0';
			length_reg <= (others => '0');
			clkdiv_reg <= (others => '0');
		end if;
	end process;

	out_data <= bus_ram_data when addr(addr'left) = '0' else 
				ctrlstat_reg & std_logic_vector(length_reg) when addr(0) = '0' else
				std_logic_vector(clkdiv_reg);

	irq <= spi_irq and spi_imask;

	-- SPI part
	clk_cnt_rst <= '1' when clkdiv_reg = clk_cnt else '0';
	clk_tick <= clk_tick_en and not spi_ram_rdy_n;
	spi_shift_en <= clk_tick and (sclk_i or not cs_i);
	spi_load_en <= spi_shift_en when bit_cnt = 0 else '0';
	spi_sample_en <= clk_tick and not sclk_i and cs_i;
	spi_complete <= spi_ram_we when spi_ram_addr = length_reg - 1 else '0';

	process (rst, spi_run, clk)
	begin
		if rising_edge(clk) then
			-- main clock divider
			if clk_cnt_rst or clkdiv_reg_wren then
				clk_cnt <= (others => '0');
			else
				clk_cnt <= clk_cnt + 1;
			end if;
			clk_tick_en <= clk_cnt_rst;
			-- chip select
			if clk_tick then
				cs_i <= '1';
			end if;
			-- external clock
			if cs_i and clk_tick then
				sclk_i <= not sclk_i;
			end if;
			-- shift register processing
			if spi_load_en then
				spi_shift_reg(8 downto 1) <= spi_ram_data;
			elsif spi_shift_en then
				spi_shift_reg(8 downto 1) <= spi_shift_reg(7 downto 0);
			end if;
			if spi_shift_en then
				bit_cnt <= bit_cnt + 1;
			end if;
			-- sample input data on rising edge os sclk
			if spi_sample_en then
				spi_shift_reg(0) <= miso;
			end if;
			-- increment bufer address after store byte
			if spi_sample_en = '1' and bit_cnt = 0 then
				spi_ram_we <= '1';
				spi_ram_rdy_n <= '1';
			else
				spi_ram_we <= '0';
				spi_ram_rdy_n <= spi_ram_we;
			end if;
			if spi_ram_we then
				spi_ram_addr <= spi_ram_addr + 1;
			end if;
			-- external chip select control
			if clk_tick then
				cs_ext_i <= '1';
			elsif spi_last_block and (spi_complete or (ctrlstat_reg_wren and byte_en(1) and not in_data(BIT_LAST_BLOCK))) then
				cs_ext_i <= '0';
			end if;
		end if;
		if not spi_run then
			clk_cnt <= (others => '0');
			clk_tick_en <= '0';
			bit_cnt <= (others => '0');
			sclk_i <= '0';
			cs_i <= '0';
			spi_shift_reg <= (others => '0');
			spi_ram_addr <= (others => '0');
			spi_ram_we <= '0';
			spi_ram_rdy_n <= '0';
		end if;
		if rst then
			cs_ext_i <= '0';
		end if;
	end process;

	cs_n <= not cs_ext_i;
	sclk <= sclk_i;
	mosi <= spi_shift_reg(8);

end architecture;
