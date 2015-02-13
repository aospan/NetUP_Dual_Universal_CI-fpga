-- NetUP Universal Dual DVB-CI FPGA firmware
-- http://www.netup.tv
-- 
-- Copyright (c) 2014 NetUP Inc, AVB Labs
-- License: GPLv3

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.avblabs_common_pkg.all;

entity afifo_ptr_tb is
end;

architecture sym of afifo_ptr_tb is

	signal rst		: std_logic := '1';
	signal clk		: std_logic := '0';
	signal clk_en	: std_logic := '1';

	signal ptr		: std_logic_vector(4 downto 0);
	signal addr		: unsigned(ptr'left - 1 downto 0);

begin

	PTR_0 : entity work.afifo_ptr
		generic map (
			PTR_WIDTH	=> ptr'length
		)
		port map (
			clk		=> clk,
			rst		=> rst,
			clk_en	=> clk_en,
			ptr		=> ptr,
			addr	=> addr,
			ptr_async	=> (others => '0'),
			ptr_sync	=> open
		);

	process
	begin
		wait for 8 ns;
		clk <= '0';
		wait for 8 ns;
		clk <= '1';
		clk_en <= '0';
		wait for 8 ns;
		clk <= '0';
		wait for 8 ns;
		clk <= '1';
		clk_en <= '1';
	end process;

	process
	begin
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		rst <= '0';
		--
		wait;
	end process;

end;
