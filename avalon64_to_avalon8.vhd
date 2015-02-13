-- NetUP Universal Dual DVB-CI FPGA firmware
-- http://www.netup.tv
-- 
-- Copyright (c) 2014 NetUP Inc, AVB Labs
-- License: GPLv3


-- altera vhdl_input_version vhdl_2008

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity avalon64_to_avalon8 is
	generic (
		OUT_ADDR_WIDTH : natural range 1 to natural'high := 15
	);
	port (
		rst		: in std_logic;
		clk		: in std_logic;
		-- Avalon-MM slave (input) port
		address			: in std_logic_vector(OUT_ADDR_WIDTH - 4 downto 0);
		byteenable		: in std_logic_vector(7 downto 0);
		writedata		: in std_logic_vector(63 downto 0);
		write			: in std_logic;
		readdata		: out std_logic_vector(63 downto 0);
		read			: in std_logic;
		waitrequest		: out std_logic;
		-- Avalon-MM master (output) port
		out_address		: out std_logic_vector(OUT_ADDR_WIDTH - 1 downto 0);
		out_writedata	: out std_logic_vector(7 downto 0);
		out_write		: out std_logic;
		out_readdata	: in std_logic_vector(7 downto 0);
		out_read		: out std_logic;
		out_waitrequest	: in std_logic
	);

end entity;

architecture rtl of avalon64_to_avalon8 is

	signal idle_n		: std_logic;
	signal cntr			: unsigned(3 downto 0);
	signal shift_reg	: std_logic_vector(63 downto 0);
	signal writes		: std_logic_vector(7 downto 0);
	signal reads		: std_logic_vector(7 downto 0);

begin

	readdata <= shift_reg;
	waitrequest <= not cntr(cntr'left) and (read or write);

	out_address <= address & std_logic_vector(cntr(2 downto 0));
	out_writedata <= shift_reg(7 downto 0);
	out_write <= writes(0);
	out_read <= reads(0);

	process (rst, clk)
		variable shift_en	: std_logic;
	begin
		if rising_edge(clk) then
			shift_en := out_waitrequest nand (writes(0) or reads(0));
			--
			idle_n <= not cntr(cntr'left) and (idle_n or read or write);
			if cntr(cntr'left) then
				cntr <= (others => '0');
			elsif shift_en then
				cntr <= cntr + unsigned'(0 => idle_n);
			end if;
			if not idle_n then
				shift_reg <= writedata;
				writes <= byteenable and (byteenable'range => write);
				reads <= byteenable and (byteenable'range => read);
			elsif shift_en then
				shift_reg <= out_readdata & shift_reg(63 downto 8);
				writes <= '0' & writes(7 downto 1);
				reads <= '0' & reads(7 downto 1);
			end if;
		end if;
		if rst then
			idle_n <= '0';
			cntr <= (others => '0');
			shift_reg <= (others => '0');
			writes <= (others => '0');
			reads <= (others => '0');
		end if;
	end process;

end;
