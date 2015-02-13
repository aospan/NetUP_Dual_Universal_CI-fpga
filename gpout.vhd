-- NetUP Universal Dual DVB-CI FPGA firmware
-- http://www.netup.tv
-- 
-- Copyright (c) 2014 NetUP Inc, AVB Labs
-- License: GPLv3


-- altera vhdl_input_version vhdl_2008

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gpout is
	generic (
		POLARITY_MASK	: natural := 0
	);
	port (
		rst			: in std_logic := '0';
		clk			: in std_logic;
		--
		address		: in std_logic_vector(1 downto 0);
		byteenable	: in std_logic_vector(1 downto 0);
		writedata	: in std_logic_vector(15 downto 0);
		write		: in std_logic;
		readdata	: out std_logic_vector(15 downto 0);
		--
		pins		: out std_logic_vector(15 downto 0)
	);
end entity;

architecture rtl of gpout is

	constant REG_IO			: std_logic_vector(address'range) := "00";
	constant REG_IO_TOGGLE	: std_logic_vector(address'range) := "01";
	constant REG_IO_SET		: std_logic_vector(address'range) := "10";
	constant REG_IO_CLEAR	: std_logic_vector(address'range) := "11";
	
	signal latch	: std_logic_vector(pins'range);

begin

	process (rst, clk)
	begin
		if rising_edge(clk) then
			for i in latch'range loop
				if write and byteenable(i / 8) then
					if address = "00" then
						latch(i) <= writedata(i);
					elsif writedata(i) then
						if not address(1) then
							latch(i) <= not latch(i);
						else
							latch(i) <= not address(0);
						end if;
					end if;
				end if;
			end loop;
		end if;
		if rst then
			latch <= (others => '0');
		end if;
	end process;

	readdata <= latch;

	pins <= latch xor std_logic_vector(to_unsigned(POLARITY_MASK, 16));

end architecture;
