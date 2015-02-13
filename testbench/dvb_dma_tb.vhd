-- NetUP Universal Dual DVB-CI FPGA firmware
-- http://www.netup.tv
-- 
-- Copyright (c) 2014 NetUP Inc, AVB Labs
-- License: GPLv3


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.avblabs_common_pkg.all;

entity dvb_dma_tb is
end;

architecture sym of dvb_dma_tb is

	signal rst	: std_logic := '1';
	signal clk	: std_logic := '0';

	signal dvb0_clk		: std_logic;
	signal dvb0_strt	: std_logic;
	signal dvb0_dval	: std_logic;
	signal dvb0_data	: std_logic_vector(7 downto 0);
	signal dvb1_clk		: std_logic;
	signal dvb1_strt	: std_logic;
	signal dvb1_dval	: std_logic;
	signal dvb1_data	: std_logic_vector(7 downto 0);

	signal tsa_sop		: std_logic;
	signal tsa_data		: std_logic_vector(7 downto 0);
	signal tsa_dval		: std_logic;
	signal tsb_sop		: std_logic;
	signal tsb_data		: std_logic_vector(7 downto 0);
	signal tsb_dval		: std_logic;

	signal address		: std_logic_vector(3 downto 0) := (others => '0');
	signal byteenable	: std_logic_vector(3 downto 0) := (others => '0');
	signal writedata	: std_logic_vector(31 downto 0) := (others => '0');
	signal write		: std_logic := '0';
	signal readdata_0	: std_logic_vector(31 downto 0);
	signal readdata_1	: std_logic_vector(31 downto 0);
	signal interrupt_0	: std_logic;
	signal interrupt_1	: std_logic;

	signal mem0_addr	: std_logic_vector(63 downto 3);
	signal mem0_byteen	: std_logic_vector(7 downto 0);
	signal mem0_size	: std_logic_vector(6 downto 0);
	signal mem0_wrdata	: std_logic_vector(63 downto 0);
	signal mem0_write	: std_logic;
	signal mem0_waitreq	: std_logic;

	signal mem1_addr	: std_logic_vector(63 downto 3);
	signal mem1_byteen	: std_logic_vector(7 downto 0);
	signal mem1_size	: std_logic_vector(6 downto 0);
	signal mem1_wrdata	: std_logic_vector(63 downto 0);
	signal mem1_write	: std_logic;
	signal mem1_waitreq	: std_logic;

	signal mem_addr		: std_logic_vector(30 downto 0);
	signal mem_byteen	: std_logic_vector(7 downto 0);
	signal mem_size		: std_logic_vector(6 downto 0);
	signal mem_wrdata	: std_logic_vector(63 downto 0);
	signal mem_write	: std_logic;
	signal mem_waitreq	: std_logic := '0';

begin

	DVB_SRC_0 : entity work.dvb_source
		generic map (
			CLOCK_RATE_MHZ	=> 15,
			INTERPACKET_GAP	=> 5,
			INTEROCTET_GAP	=> 2
		)
		port map (
			ts_clk	=> dvb0_clk,
			ts_strt	=> dvb0_strt,
			ts_dval	=> dvb0_dval,
			ts_data	=> dvb0_data
		);

	DVB_SRC_1 : entity work.dvb_source
		port map (
			ts_clk	=> dvb1_clk,
			ts_strt	=> dvb1_strt,
			ts_dval	=> dvb1_dval,
			ts_data	=> dvb1_data
		);

	DVB_TSIN_0 : entity work.dvb_ts_sync
		port map (
			ts_clk		=> dvb0_clk,
			ts_strt		=> dvb0_strt,
			ts_dval		=> dvb0_dval,
			ts_data		=> dvb0_data,
			--
			rst			=> rst,
			clk			=> clk,
			--
			strt		=> tsa_sop,
			data		=> tsa_data,
			dval		=> tsa_dval
		);

	DVB_TSIN_1 : entity work.dvb_ts_sync
		port map (
			ts_clk		=> dvb1_clk,
			ts_strt		=> dvb1_strt,
			ts_dval		=> dvb1_dval,
			ts_data		=> dvb1_data,
			--
			rst			=> rst,
			clk			=> clk,
			--
			strt		=> tsb_sop,
			data		=> tsb_data,
			dval		=> tsb_dval
		);

	DVB_DMA_0 : entity work.dvb_dma
		port map (
			rst			=> rst,
			clk			=> clk,
			address		=> address,
			byteenable	=> byteenable,
			writedata	=> writedata,
			write		=> write,
			readdata	=> readdata_0,
			interrupt	=> interrupt_0,
			dvb_sop		=> tsa_sop,
			dvb_data	=> tsa_data,
			dvb_dval	=> tsa_dval,
			mem_addr	=> mem0_addr,
			mem_byteen	=> mem0_byteen,
			mem_size	=> mem0_size,
			mem_wrdata	=> mem0_wrdata,
			mem_write	=> mem0_write,
			mem_waitreq	=> mem0_waitreq
		);

	DVB_DMA_1 : entity work.dvb_dma
		port map (
			rst			=> rst,
			clk			=> clk,
			address		=> address,
			byteenable	=> byteenable,
			writedata	=> writedata,
			write		=> write,
			readdata	=> readdata_1,
			interrupt	=> interrupt_1,
			dvb_sop		=> tsb_sop,
			dvb_data	=> tsb_data,
			dvb_dval	=> tsb_dval,
			mem_addr	=> mem1_addr,
			mem_byteen	=> mem1_byteen,
			mem_size	=> mem1_size,
			mem_wrdata	=> mem1_wrdata,
			mem_write	=> mem1_write,
			mem_waitreq	=> mem1_waitreq
		);

	ARB_0 : entity work.dma_arbiter
		port map (
			rst			=> rst,
			clk			=> clk,
			dma0_addr	=> mem0_addr,
			dma0_byteen	=> mem0_byteen,
			dma0_size	=> mem0_size,
			dma0_wrdata	=> mem0_wrdata,
			dma0_write	=> mem0_write,
			dma0_wait	=> mem0_waitreq,
			dma1_addr	=> mem1_addr,
			dma1_byteen	=> mem1_byteen,
			dma1_size	=> mem1_size,
			dma1_wrdata	=> mem1_wrdata,
			dma1_write	=> mem1_write,
			dma1_wait	=> mem1_waitreq,
			mem_addr	=> mem_addr,
			mem_byteen	=> mem_byteen,
			mem_size	=> mem_size,
			mem_wrdata	=> mem_wrdata,
			mem_write	=> mem_write,
			mem_waitreq	=> mem_waitreq
		);

	process
	begin
		wait for 8 ns;
		clk <= not clk;
	end process;

	process
	begin
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		rst <= '0';
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		byteenable <= "1111";
		write <= '1';
		address <= X"4";
		writedata <= X"040008BC";
		wait until rising_edge(clk);
		address <= X"0";
		writedata <= X"00000001";
		wait until rising_edge(clk);
		write <= '0';
		loop
			wait until interrupt_0 = '1';
--			wait for 225 us;
			wait until rising_edge(clk);
			address <= X"1";
			write <= '1';
			writedata <= X"00000200";
			wait until rising_edge(clk);
			write <= '0';
		end loop;
		--
		wait;
	end process;

	process
	begin
		wait until rising_edge(clk);
		mem_waitreq <= mem_waitreq xor mem_write;
	end process;

end;
