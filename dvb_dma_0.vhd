-- NetUP Universal Dual DVB-CI FPGA firmware
-- http://www.netup.tv
-- 
-- Copyright (c) 2014 NetUP Inc, AVB Labs
-- License: GPLv3

-- dvb_dma_0.vhd

-- This file was auto-generated as part of a generation operation.
-- If you edit it your changes will probably be lost.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity dvb_dma_0 is
	port (
		address     : in  std_logic_vector(3 downto 0)  := (others => '0'); -- avalon_slave_0.address
		byteenable  : in  std_logic_vector(3 downto 0)  := (others => '0'); --               .byteenable
		writedata   : in  std_logic_vector(31 downto 0) := (others => '0'); --               .writedata
		write       : in  std_logic                     := '0';             --               .write
		readdata    : out std_logic_vector(31 downto 0);                    --               .readdata
		clk         : in  std_logic                     := '0';             --          clock.clk
		dvb_sop     : in  std_logic                     := '0';             --    conduit_end.export
		dvb_data    : in  std_logic_vector(7 downto 0)  := (others => '0'); --               .export
		dvb_dval    : in  std_logic                     := '0';             --               .export
		mem_size    : out std_logic_vector(6 downto 0);                     --               .export
		mem_addr    : out std_logic_vector(60 downto 0);                    --               .export
		mem_byteen  : out std_logic_vector(7 downto 0);                     --               .export
		mem_wrdata  : out std_logic_vector(63 downto 0);                    --               .export
		mem_write   : out std_logic;                                        --               .export
		mem_waitreq : in  std_logic                     := '0';             --               .export
		interrupt   : out std_logic;                                        --               .export
		rst         : in  std_logic                     := '0'              --     reset_sink.reset
	);
end entity dvb_dma_0;

architecture rtl of dvb_dma_0 is
	component dvb_dma is
		port (
			address     : in  std_logic_vector(3 downto 0)  := (others => 'X'); -- address
			byteenable  : in  std_logic_vector(3 downto 0)  := (others => 'X'); -- byteenable
			writedata   : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			write       : in  std_logic                     := 'X';             -- write
			readdata    : out std_logic_vector(31 downto 0);                    -- readdata
			clk         : in  std_logic                     := 'X';             -- clk
			dvb_sop     : in  std_logic                     := 'X';             -- export
			dvb_data    : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- export
			dvb_dval    : in  std_logic                     := 'X';             -- export
			mem_size    : out std_logic_vector(6 downto 0);                     -- export
			mem_addr    : out std_logic_vector(60 downto 0);                    -- export
			mem_byteen  : out std_logic_vector(7 downto 0);                     -- export
			mem_wrdata  : out std_logic_vector(63 downto 0);                    -- export
			mem_write   : out std_logic;                                        -- export
			mem_waitreq : in  std_logic                     := 'X';             -- export
			interrupt   : out std_logic;                                        -- export
			rst         : in  std_logic                     := 'X'              -- reset
		);
	end component dvb_dma;

begin

	dvb_dma_0 : component dvb_dma
		port map (
			address     => address,     -- avalon_slave_0.address
			byteenable  => byteenable,  --               .byteenable
			writedata   => writedata,   --               .writedata
			write       => write,       --               .write
			readdata    => readdata,    --               .readdata
			clk         => clk,         --          clock.clk
			dvb_sop     => dvb_sop,     --    conduit_end.export
			dvb_data    => dvb_data,    --               .export
			dvb_dval    => dvb_dval,    --               .export
			mem_size    => mem_size,    --               .export
			mem_addr    => mem_addr,    --               .export
			mem_byteen  => mem_byteen,  --               .export
			mem_wrdata  => mem_wrdata,  --               .export
			mem_write   => mem_write,   --               .export
			mem_waitreq => mem_waitreq, --               .export
			interrupt   => interrupt,   --               .export
			rst         => rst          --     reset_sink.reset
		);

end architecture rtl; -- of dvb_dma_0
