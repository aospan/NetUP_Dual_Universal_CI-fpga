-- NetUP Universal Dual DVB-CI FPGA firmware
-- http://www.netup.tv
-- 
-- Copyright (c) 2014 NetUP Inc, AVB Labs
-- License: GPLv3

-- dma_arbiter_0.vhd

-- This file was auto-generated as part of a generation operation.
-- If you edit it your changes will probably be lost.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity dma_arbiter_0 is
	port (
		clk         : in  std_logic                     := '0';             --         clock.clk
		rst         : in  std_logic                     := '0';             --    reset_sink.reset
		dma0_addr   : in  std_logic_vector(60 downto 0) := (others => '0'); --   conduit_end.export
		dma0_wrdata : in  std_logic_vector(63 downto 0) := (others => '0'); --              .export
		dma0_size   : in  std_logic_vector(6 downto 0)  := (others => '0'); --              .export
		dma0_write  : in  std_logic                     := '0';             --              .export
		dma0_wait   : out std_logic;                                        --              .export
		dma1_addr   : in  std_logic_vector(60 downto 0) := (others => '0'); --              .export
		dma1_size   : in  std_logic_vector(6 downto 0)  := (others => '0'); --              .export
		dma1_wrdata : in  std_logic_vector(63 downto 0) := (others => '0'); --              .export
		dma1_write  : in  std_logic                     := '0';             --              .export
		dma1_wait   : out std_logic;                                        --              .export
		dma0_byteen : in  std_logic_vector(7 downto 0)  := (others => '0'); --              .export
		dma1_byteen : in  std_logic_vector(7 downto 0)  := (others => '0'); --              .export
		mem_addr    : out std_logic_vector(30 downto 0);                    -- avalon_master.address
		mem_size    : out std_logic_vector(6 downto 0);                     --              .burstcount
		mem_wrdata  : out std_logic_vector(63 downto 0);                    --              .writedata
		mem_write   : out std_logic;                                        --              .write
		mem_waitreq : in  std_logic                     := '0';             --              .waitrequest
		mem_byteen  : out std_logic_vector(7 downto 0)                      --              .byteenable
	);
end entity dma_arbiter_0;

architecture rtl of dma_arbiter_0 is
	component dma_arbiter is
		generic (
			MEM_ADDR_WIDTH : natural := 31
		);
		port (
			clk         : in  std_logic                     := 'X';             -- clk
			rst         : in  std_logic                     := 'X';             -- reset
			dma0_addr   : in  std_logic_vector(60 downto 0) := (others => 'X'); -- export
			dma0_wrdata : in  std_logic_vector(63 downto 0) := (others => 'X'); -- export
			dma0_size   : in  std_logic_vector(6 downto 0)  := (others => 'X'); -- export
			dma0_write  : in  std_logic                     := 'X';             -- export
			dma0_wait   : out std_logic;                                        -- export
			dma1_addr   : in  std_logic_vector(60 downto 0) := (others => 'X'); -- export
			dma1_size   : in  std_logic_vector(6 downto 0)  := (others => 'X'); -- export
			dma1_wrdata : in  std_logic_vector(63 downto 0) := (others => 'X'); -- export
			dma1_write  : in  std_logic                     := 'X';             -- export
			dma1_wait   : out std_logic;                                        -- export
			dma0_byteen : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- export
			dma1_byteen : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- export
			mem_addr    : out std_logic_vector(30 downto 0);                    -- address
			mem_size    : out std_logic_vector(6 downto 0);                     -- burstcount
			mem_wrdata  : out std_logic_vector(63 downto 0);                    -- writedata
			mem_write   : out std_logic;                                        -- write
			mem_waitreq : in  std_logic                     := 'X';             -- waitrequest
			mem_byteen  : out std_logic_vector(7 downto 0)                      -- byteenable
		);
	end component dma_arbiter;

begin

	dma_arbiter_0 : component dma_arbiter
		generic map (
			MEM_ADDR_WIDTH => 31
		)
		port map (
			clk         => clk,         --         clock.clk
			rst         => rst,         --    reset_sink.reset
			dma0_addr   => dma0_addr,   --   conduit_end.export
			dma0_wrdata => dma0_wrdata, --              .export
			dma0_size   => dma0_size,   --              .export
			dma0_write  => dma0_write,  --              .export
			dma0_wait   => dma0_wait,   --              .export
			dma1_addr   => dma1_addr,   --              .export
			dma1_size   => dma1_size,   --              .export
			dma1_wrdata => dma1_wrdata, --              .export
			dma1_write  => dma1_write,  --              .export
			dma1_wait   => dma1_wait,   --              .export
			dma0_byteen => dma0_byteen, --              .export
			dma1_byteen => dma1_byteen, --              .export
			mem_addr    => mem_addr,    -- avalon_master.address
			mem_size    => mem_size,    --              .burstcount
			mem_wrdata  => mem_wrdata,  --              .writedata
			mem_write   => mem_write,   --              .write
			mem_waitreq => mem_waitreq, --              .waitrequest
			mem_byteen  => mem_byteen   --              .byteenable
		);

end architecture rtl; -- of dma_arbiter_0
