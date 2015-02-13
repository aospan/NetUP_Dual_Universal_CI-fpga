-- NetUP Universal Dual DVB-CI FPGA firmware
-- http://www.netup.tv
-- 
-- Copyright (c) 2014 NetUP Inc, AVB Labs
-- License: GPLv3


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.avblabs_common_pkg.all;

entity dvb_ts_shaper_tb is
end;

architecture sym of dvb_ts_shaper_tb is

	signal rst		: std_logic := '1';
	signal clk		: std_logic;

	signal src_ready	: std_logic;
	signal src_dsop		: std_logic;
	signal src_data		: std_logic_vector(7 downto 0);
	signal src_dval		: std_logic;

	signal dvb_clk	: std_logic;
	signal dvb_dsop	: std_logic;
	signal dvb_data	: std_logic_vector(7 downto 0);
	signal dvb_dval	: std_logic;

	signal dvb_src_clk	: std_logic := '0';

begin

	DVB_SRC_0 : entity work.dvb_source
		generic map (
			CLOCK_RATE_MHZ	=> 125,
			INTERPACKET_GAP	=> 300,
			INTEROCTET_GAP	=> 0
		)
		port map (
			ts_clk	=> clk,
			ts_strt	=> src_dsop,
			ts_dval	=> src_dval,
			ts_data	=> src_data
		);

	SHAPER_0 : entity work.dvb_ts_shaper
		port map (
			rst		=> rst,
			clk		=> clk,
			--
			clkdiv		=> (others => '0'),
			--
			dvb_indrdy		=> src_ready,
			dvb_indata		=> src_data,
			dvb_indsop		=> src_dsop,
			dvb_indval		=> src_dval,
			--
			dvb_clk			=> dvb_src_clk,
			--
			dvb_out_clk		=> dvb_clk,
			dvb_out_dsop	=> dvb_dsop,
			dvb_out_data	=> dvb_data,
			dvb_out_dval	=> dvb_dval
		);

	process
	begin
		wait until rising_edge(clk);
		rst <= '0';
		--
		wait;
	end process;

	process
	begin
		dvb_src_clk <= not dvb_src_clk;
		wait for 4.63 ns;
	end process;

end;
