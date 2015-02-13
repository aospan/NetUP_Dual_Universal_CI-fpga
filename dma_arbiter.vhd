-- NetUP Universal Dual DVB-CI FPGA firmware
-- http://www.netup.tv
-- 
-- Copyright (c) 2014 NetUP Inc, AVB Labs
-- License: GPLv3


-- altera vhdl_input_version vhdl_2008

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dma_arbiter is
	generic (
		MEM_ADDR_WIDTH	: natural := 31
	);
	port (
		rst			: in std_logic;
		clk			: in std_logic;
		-- dma port #0
		dma0_addr	: in std_logic_vector(63 downto 3);
		dma0_byteen	: in std_logic_vector(7 downto 0);
		dma0_size	: in std_logic_vector(6 downto 0);
		dma0_wrdata	: in std_logic_vector(63 downto 0);
		dma0_write	: in std_logic;
		dma0_wait	: out std_logic;
		-- dma port #1
		dma1_addr	: in std_logic_vector(63 downto 3);
		dma1_byteen	: in std_logic_vector(7 downto 0);
		dma1_size	: in std_logic_vector(6 downto 0);
		dma1_wrdata	: in std_logic_vector(63 downto 0);
		dma1_write	: in std_logic;
		dma1_wait	: out std_logic;
		-- memory port
		mem_addr	: out std_logic_vector(MEM_ADDR_WIDTH - 1 downto 0);
		mem_byteen	: out std_logic_vector(7 downto 0);
		mem_size	: out std_logic_vector(6 downto 0);
		mem_wrdata	: out std_logic_vector(63 downto 0);
		mem_write	: out std_logic;
		mem_waitreq	: in std_logic
	);

end;

architecture rtl of dma_arbiter is

	signal burst_cnt	: signed(mem_size'left + 1 downto 0);
	signal mem_addr_i	: std_logic_vector(63 downto 3);

	signal secondary	: std_logic;
	signal dma0_grant	: std_logic;
	signal dma1_grant	: std_logic;

	alias burst			: std_logic is burst_cnt(burst_cnt'left);

begin

	dma0_grant <= burst and not secondary;
	dma1_grant <= burst and secondary;

	dma0_wait <= mem_waitreq or not dma0_grant;
	dma1_wait <= mem_waitreq or not dma1_grant;

	mem_wrdata <= (dma0_wrdata and (dma0_wrdata'range => dma0_grant)) or (dma1_wrdata and (dma1_wrdata'range => dma1_grant));
	mem_write <= (dma0_write and dma0_grant) or (dma1_write and dma1_grant);
	mem_size <= (dma0_size and (dma0_size'range => dma0_grant)) or (dma1_size and (dma1_size'range => dma1_grant));
	mem_addr_i <= (dma0_addr and (dma0_addr'range => dma0_grant)) or (dma1_addr and (dma1_addr'range => dma1_grant));
	mem_byteen <= (dma0_byteen and (dma0_byteen'range => dma0_grant)) or (dma1_byteen and (dma1_byteen'range => dma1_grant));

	mem_addr <= mem_addr_i(mem_addr'left downto 3) & "000";

	process (rst, clk)
		variable burst_step : std_logic;
		variable burst_en0	: std_logic;
		variable burst_en1	: std_logic;
	begin
		if rising_edge(clk) then
			burst_step := burst and ((dma0_write and not secondary) or (dma1_write and secondary)) and not mem_waitreq;
			burst_en0 := not burst and dma0_write and (not dma1_write or secondary);
			burst_en1 := not burst and dma1_write and (dma0_write nand secondary);
			--
			if burst_en0 then
				burst_cnt <= signed('1' & not dma0_size) + 1;
			elsif burst_en1 then
				burst_cnt <= signed('1' & not dma1_size) + 1;
			elsif burst_step then
				burst_cnt <= burst_cnt + 1;
			end if;
			--
			if burst_en1 then
				secondary <= '1';
			elsif burst_en0 then
				secondary <= '0';
			end if;
		end if;
		if rst then
			burst_cnt <= (others => '0');
			secondary <= '0';
		end if;
	end process;

end;
