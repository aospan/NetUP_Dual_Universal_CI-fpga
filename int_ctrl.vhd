-- NetUP Universal Dual DVB-CI FPGA firmware
-- http://www.netup.tv
-- 
-- Copyright (c) 2014 NetUP Inc, AVB Labs
-- License: GPLv3


-- altera vhdl_input_version vhdl_2008

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity int_ctrl is
	port (
		rst			: in std_logic;
		clk			: in std_logic;
		-- Avalon-MM slave
		avls_address		: in std_logic_vector(12 downto 0);
		avls_byteenable		: in std_logic_vector(3 downto 0);
		avls_writedata		: in std_logic_vector(31 downto 0);
		avls_write			: in std_logic;
		avls_readdata		: out std_logic_vector(31 downto 0);
		avls_read			: in std_logic;
		avls_waitrequest	: out std_logic;
		avls_irq			: out std_logic;
		-- Avalon-MM master
		avlm_address		: out std_logic_vector(14 downto 0);
		avlm_byteenable		: out std_logic_vector(3 downto 0);
		avlm_writedata		: out std_logic_vector(31 downto 0);
		avlm_write			: out std_logic;
		avlm_readdata		: in std_logic_vector(31 downto 0);
		avlm_read			: out std_logic;
		avlm_waitrequest	: in std_logic;
		avlm_irq			: in std_logic_vector(15 downto 0);
		-- control registers port
		address		: in std_logic_vector(1 downto 0);
		byteenable	: in std_logic_vector(1 downto 0);
		writedata	: in std_logic_vector(15 downto 0);
		write		: in std_logic;
		readdata	: out std_logic_vector(15 downto 0)
	);
end entity;

architecture rtl of int_ctrl is

	constant REG_ISR			: std_logic_vector(address'range) := "00";
	constant REG_ISR_MASKED		: std_logic_vector(address'range) := "01";
	constant REG_IMASK_SET		: std_logic_vector(address'range) := "10";
	constant REG_IMASK_CLEAR	: std_logic_vector(address'range) := "11";
	
	signal imask				: std_logic_vector(15 downto 0);
	signal irq_masked			: std_logic_vector(15 downto 0);
	signal irq_status			: std_logic_vector(15 downto 0);

begin
	irq_masked <= avlm_irq and imask;
	irq_status <= avlm_irq;

	process (rst, clk)
	begin
		if rising_edge(clk) then
			for i in imask'range loop
				if address(1) and write and byteenable(i / 8) and writedata(i) then
					imask(i) <= not address(0);
				end if;
			end loop;
		end if;
		if rst then
			imask <= (others => '0');
		end if;
	end process;

	with address select
		readdata <= irq_status when REG_ISR,
					irq_masked when REG_ISR_MASKED,
					imask when others;

	avls_irq <= '0' when unsigned(irq_masked) = 0 else '1';

	avlm_address <= avls_address & "00";
	avlm_byteenable <= avls_byteenable;
	avlm_writedata <= avls_writedata;
	avlm_write <= avls_write;
	avls_readdata <= avlm_readdata;
	avlm_read <= avls_read;
	avls_waitrequest <= avlm_waitrequest;

end architecture;
