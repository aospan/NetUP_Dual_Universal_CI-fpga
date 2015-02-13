-- NetUP Universal Dual DVB-CI FPGA firmware
-- http://www.netup.tv
-- 
-- Copyright (c) 2014 NetUP Inc, AVB Labs
-- License: GPLv3


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dvb_source is
	generic (
		CLOCK_RATE_MHZ		: natural := 11;
		INTERPACKET_GAP		: natural := 0;
		INTEROCTET_GAP		: natural := 0
	);
	port (
		ts_clk		: out std_logic;
		ts_strt		: out std_logic;
		ts_dval		: out std_logic;
		ts_data		: out std_logic_vector(7 downto 0)
	);

end entity;

architecture rtl of dvb_source is

	constant t_clk_h	: natural := 1000 / CLOCK_RATE_MHZ;
	constant t_clk_l	: natural := t_clk_h;

	signal clk	: std_logic := '0';

begin
	ts_clk <= clk;

	process
	begin
		wait for t_clk_l * 1 ns;
		clk <= '1';
		wait for t_clk_h * 1 ns;
		clk <= '0';
	end process;

	process
		variable octet	: unsigned(7 downto 0);
	begin
		octet := (others => '0');
		loop
			wait until falling_edge(clk);
			ts_strt <= '1';
			ts_dval <= '1';
			ts_data <= X"47";
			for i in 1 to INTEROCTET_GAP loop
				wait until falling_edge(clk);
				ts_dval <= '0';
			end loop;
			--
			wait until falling_edge(clk);
			ts_strt <= '0';
			ts_dval <= '1';
			ts_data <= X"1F";
			for i in 1 to INTEROCTET_GAP loop
				wait until falling_edge(clk);
				ts_dval <= '0';
			end loop;
			--
			wait until falling_edge(clk);
			ts_dval <= '1';
			ts_data <= X"FF";
			for i in 1 to INTEROCTET_GAP loop
				wait until falling_edge(clk);
				ts_dval <= '0';
			end loop;
			--
			for j in 3 to 187 loop
				wait until falling_edge(clk);
				ts_dval <= '1';
				ts_data <= std_logic_vector(octet);
				octet := octet + 1;
				for i in 1 to INTEROCTET_GAP loop
					wait until falling_edge(clk);
					ts_dval <= '0';
				end loop;
			end loop;
			--
			for i in 1 to INTERPACKET_GAP loop
				wait until falling_edge(clk);
				ts_dval <= '0';
				ts_data <= (others => '0');
			end loop;
		end loop;
	end process;

end;
