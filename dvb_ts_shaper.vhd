-- NetUP Universal Dual DVB-CI FPGA firmware
-- http://www.netup.tv
-- 
-- Copyright (c) 2014 NetUP Inc, AVB Labs
-- License: GPLv3


-- altera vhdl_input_version vhdl_2008

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.avblabs_common_pkg.all;

entity dvb_ts_shaper is

	generic (
		FIFO_DEPTH	: natural := 16384
	);
	port (
		-- system domain
		rst			: in std_logic;
		clk			: in std_logic;
		--
		clkdiv			: in std_logic_vector(3 downto 0);
		--
		dvb_indrdy		: out std_logic;
		dvb_indata		: in std_logic_vector(7 downto 0);
		dvb_indsop		: in std_logic;
		dvb_indval		: in std_logic;
		-- stream domain
		dvb_clk			: in std_logic;
		--
		dvb_out_clk		: out std_logic;
		dvb_out_data	: out std_logic_vector(7 downto 0);
		dvb_out_dval	: out std_logic;
		dvb_out_dsop	: out std_logic
	);

end entity;

architecture rtl of dvb_ts_shaper is

	attribute ramstyle : string;

	type mem_t is array(0 to FIFO_DEPTH - 1) of std_logic_vector(8 downto 0);

	constant RAM_ADDR_MSB : natural := ulen(FIFO_DEPTH - 1) - 1;
	constant FIFO_PTR_MSB : natural := RAM_ADDR_MSB + 1;

	signal fifo_ram		: mem_t;
	attribute ramstyle of fifo_ram : signal is "M9K, no_rw_check";

	signal ram_wr_addr	: unsigned(RAM_ADDR_MSB downto 0);
	signal ram_rd_addr	: unsigned(RAM_ADDR_MSB downto 0);

	signal fifo_wr_ptr	: std_logic_vector(ram_wr_addr'length downto 0);
	signal fifo_rd_ptr	: std_logic_vector(ram_rd_addr'length downto 0);

	signal fifo_wr_ptr_sync	: std_logic_vector(fifo_wr_ptr'range);
	signal fifo_rd_ptr_sync	: std_logic_vector(fifo_rd_ptr'range);

	signal fifo_we		: std_logic;
	signal fifo_re		: std_logic;
	signal fifo_fill	: unsigned(RAM_ADDR_MSB downto 0);

	signal dvb_out_clk_edge	: std_logic;
	signal dvb_out_clk_cnt	: signed(clkdiv'length downto 0);

	signal fifo_ram_latch		: std_logic_vector(8 downto 0);
	signal fifo_ram_latch_valid	: std_logic;
	signal fifo_ram_latch_clk	: std_logic;

	signal fifo_ram_reg			: std_logic_vector(8 downto 0);
	signal fifo_ram_reg_valid	: std_logic;
	signal fifo_ram_reg_clk		: std_logic;

	signal dvb_out_clk_en	: std_logic;

	signal dvb_rst_meta	: std_logic;
	signal dvb_rst_sync	: std_logic;

begin

	assert (to_unsigned(FIFO_DEPTH, RAM_ADDR_MSB + 2) and to_unsigned(FIFO_DEPTH - 1, RAM_ADDR_MSB + 2)) = 0 
		report "FIFO_DEPTH must be power of two!";

	WR_PTR : entity work.afifo_ptr
		generic map (
			PTR_WIDTH => ram_wr_addr'length + 1
		)
		port map (
			rst		=> rst,
			clk		=> clk,
			clk_en	=> fifo_we,
			--
			ptr		=> fifo_wr_ptr,
			addr	=> ram_wr_addr,
			--
			ptr_async	=> fifo_rd_ptr,
			ptr_sync	=> fifo_rd_ptr_sync
		);

	RD_PTR : entity work.afifo_ptr
		generic map (
			PTR_WIDTH => ram_rd_addr'length + 1
		)
		port map (
			rst		=> not dvb_rst_sync,
			clk		=> dvb_clk,
			clk_en	=> fifo_re,
			--
			ptr		=> fifo_rd_ptr,
			addr	=> ram_rd_addr,
			--
			ptr_async	=> fifo_wr_ptr,
			ptr_sync	=> fifo_wr_ptr_sync
		);

	fifo_we <= fifo_not_full(fifo_wr_ptr, fifo_rd_ptr_sync) and dvb_indval;
	fifo_re <= fifo_not_empty(fifo_wr_ptr_sync, fifo_rd_ptr) and (fifo_ram_latch_clk and dvb_out_clk_edge);
	fifo_fill <= fifo_water_level(fifo_wr_ptr, fifo_rd_ptr_sync);

	process (rst, clk)
	begin
		if rising_edge(clk) then
			if fifo_fill(fifo_fill'left) nor fifo_fill(fifo_fill'left - 1) then
				dvb_indrdy <= '1';
			elsif fifo_fill(fifo_fill'left) and fifo_fill(fifo_fill'left - 1) then
				dvb_indrdy <= '0';
			end if;
			if fifo_we then
				fifo_ram(to_integer(ram_wr_addr)) <= dvb_indsop & dvb_indata;
			end if;
		end if;
		if rst then
			dvb_indrdy <= '0';
		end if;
	end process;

	process (rst, dvb_rst_sync, dvb_clk)
	begin
		if rising_edge(dvb_clk) then
			dvb_rst_meta <= '1';
			dvb_rst_sync <= dvb_rst_meta;
			--
			if dvb_out_clk_cnt = to_signed(-2, dvb_out_clk_cnt'length) then
				dvb_out_clk_edge <= '1';
			else
				dvb_out_clk_edge <= '0';
			end if;
			if dvb_out_clk_edge then
				dvb_out_clk_cnt <= signed('0' & clkdiv);
			else
				dvb_out_clk_cnt <= dvb_out_clk_cnt - 1;
			end if;
			--
			fifo_ram_latch <= fifo_ram(to_integer(ram_rd_addr));
			fifo_ram_latch_clk <= fifo_ram_latch_clk xor dvb_out_clk_edge;
			fifo_ram_latch_valid <= fifo_re;
			--
			fifo_ram_reg <= fifo_ram_latch;
			fifo_ram_reg_valid <= fifo_ram_latch_valid;
			fifo_ram_reg_clk <= fifo_ram_latch_clk;
			--
			dvb_out_clk_en <= fifo_ram_reg_clk and not fifo_ram_latch_clk;
			dvb_out_clk <= fifo_ram_reg_clk;
			if dvb_out_clk_en then
				dvb_out_dval <= fifo_ram_reg_valid;
				dvb_out_data <= fifo_ram_reg(7 downto 0);
				dvb_out_dsop <= fifo_ram_reg(8);
			end if;
		end if;
		if rst then
			dvb_rst_meta <= '0';
			dvb_rst_sync <= '0';
		end if;
		if not dvb_rst_sync then
			dvb_out_clk_edge <= '0';
			dvb_out_clk_cnt <= (others => '0');
			--
			fifo_ram_latch_clk <= '0';
			fifo_ram_latch_valid <= '0';
			--
			fifo_ram_reg <= (others => '0');
			fifo_ram_reg_valid <= '0';
			fifo_ram_reg_clk <= '0';
			--
			dvb_out_clk_en <= '0';
			dvb_out_clk <= '0';
			dvb_out_dval <= '0';
			dvb_out_data <= (others => '0');
			dvb_out_dsop <= '0';
		end if;
	end process;

end architecture;
