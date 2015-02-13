-- NetUP Universal Dual DVB-CI FPGA firmware
-- http://www.netup.tv
-- 
-- Copyright (c) 2014 NetUP Inc, AVB Labs
-- License: GPLv3


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.avblabs_common_pkg.all;

entity dvb_ts_filter_tb is
end;

architecture sym of dvb_ts_filter_tb is

	signal rst		: std_logic := '1';
	signal clk		: std_logic := '0';
	signal clk_en	: std_logic := '1';

	signal addr		: std_logic_vector(7 downto 0) := (others => '0');
	signal be		: std_logic_vector(3 downto 0) := (others => '1');
	signal wrdata	: std_logic_vector(31 downto 0) := (others => '0');
	signal write	: std_logic := '0';
	signal rddata	: std_logic_vector(31 downto 0);
	signal read		: std_logic := '0';
	signal waitreq	: std_logic;

	signal src_dsop	: std_logic;
	signal src_data	: std_logic_vector(7 downto 0);
	signal src_dval	: std_logic;

	signal dvb_dsop	: std_logic;
	signal dvb_data	: std_logic_vector(7 downto 0);
	signal dvb_dval	: std_logic;

begin

	DVB_SRC_0 : entity work.dvb_source
		generic map (
			CLOCK_RATE_MHZ	=> 125,
			INTERPACKET_GAP	=> 0,
			INTEROCTET_GAP	=> 0
		)
		port map (
			ts_clk	=> clk,
			ts_strt	=> src_dsop,
			ts_dval	=> src_dval,
			ts_data	=> src_data
		);

	FILTER_0 : entity work.dvb_ts_filter
		port map (
			rst		=> rst,
			clk		=> clk,
			--
			pid_tbl_addr	=> addr,
			pid_tbl_be		=> be,
			pid_tbl_wrdata	=> wrdata,	
			pid_tbl_write	=> write,
			pid_tbl_rddata	=> rddata,
			pid_tbl_read	=> read,
			pid_tbl_waitreq	=> waitreq,
			--
			dvb_in_dsop		=> src_dsop,
			dvb_in_data		=> src_data,
			dvb_in_dval		=> src_dval,
			--
			dvb_out_dsop	=> dvb_dsop,
			dvb_out_data	=> dvb_data,
			dvb_out_dval	=> dvb_dval
		);

	process
	begin
		wait until rising_edge(clk);
		rst <= '0';
		--
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		addr <= std_logic_vector(to_unsigned(255, addr'length));
		wrdata <= X"80000000";
		write <= '1';
		read <= '0';
		wait until rising_edge(clk);
		addr <= std_logic_vector(to_unsigned(0, addr'length));
		write <= '0';
		wait until rising_edge(clk);
		addr <= std_logic_vector(to_unsigned(255, addr'length));
		read <= '1';
		wait until rising_edge(clk) and waitreq = '0';
		read <= '0';
		--
		wait;
	end process;

end;
