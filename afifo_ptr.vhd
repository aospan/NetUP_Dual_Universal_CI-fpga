-- NetUP Universal Dual DVB-CI FPGA firmware
-- http://www.netup.tv
-- 
-- Copyright (c) 2014 NetUP Inc, AVB Labs
-- License: GPLv3


-- altera vhdl_input_version vhdl_2008

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity afifo_ptr is
	generic (
		PTR_WIDTH	: natural range 3 to natural'high
	);
	port (
		rst		: in std_logic;
		clk		: in std_logic;
		clk_en	: in std_logic;
		--
		ptr		: out std_logic_vector(PTR_WIDTH - 1 downto 0);	-- FIFO pointer (use for crossing clock domains)
		addr	: out unsigned(PTR_WIDTH - 2 downto 0);			-- FIFO ram address
		--
		ptr_async	: in std_logic_vector(PTR_WIDTH - 1 downto 0);
		ptr_sync	: out std_logic_vector(PTR_WIDTH - 1 downto 0)
	);
end entity;

architecture rtl of afifo_ptr is

	signal gray_aux	: std_logic;
	signal gray_i	: std_logic_vector(PTR_WIDTH - 1 downto 0);
	signal addr_h	: std_logic;

	signal ptr_meta	: std_logic_vector(PTR_WIDTH - 1 downto 0);

begin
	process (rst, clk)
		variable toggle	: std_logic;
		variable carry	: std_logic;
		variable nxtbt	: std_logic;
	begin
		if rising_edge(clk) then
			ptr_meta <= ptr_async;
			ptr_sync <= ptr_meta;
			--
			if clk_en then
				-- invert parity
				gray_aux <= not gray_aux;
				-- proceed with bits from 0 to PTR - 2
				toggle := not gray_aux;
				carry := gray_aux;
				for i in 0 to PTR_WIDTH - 2 loop
					nxtbt := gray_i(i) xor toggle;
					toggle := carry and gray_i(i);
					carry := carry and not gray_i(i);
					gray_i(i) <= nxtbt;
				end loop;
				-- proceed with last bit
				toggle := toggle or carry;
				gray_i(PTR_WIDTH - 1) <= gray_i(PTR_WIDTH - 1) xor toggle;
				addr_h <= nxtbt xor gray_i(PTR_WIDTH - 1) xor toggle;
			end if;
		end if;
		if rst then
			ptr_meta <= (others => '0');
			ptr_sync <= (others => '0');
			--
			gray_aux <= '0';
			gray_i <= (others => '0');
			addr_h <= '0';
		end if;
	end process;
	
	ptr <= gray_i;
	addr <= unsigned(addr_h & gray_i(PTR_WIDTH - 3 downto 0));

end architecture;
