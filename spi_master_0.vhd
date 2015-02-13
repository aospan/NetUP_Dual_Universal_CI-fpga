-- NetUP Universal Dual DVB-CI FPGA firmware
-- http://www.netup.tv
-- 
-- Copyright (c) 2014 NetUP Inc, AVB Labs
-- License: GPLv3

-- spi_master_0.vhd

-- This file was auto-generated as part of a generation operation.
-- If you edit it your changes will probably be lost.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity spi_master_0 is
	port (
		in_data  : in  std_logic_vector(15 downto 0) := (others => '0'); -- avalon_slave_0.writedata
		wr_en    : in  std_logic                     := '0';             --               .write
		out_data : out std_logic_vector(15 downto 0);                    --               .readdata
		wait_req : out std_logic;                                        --               .waitrequest
		addr     : in  std_logic_vector(9 downto 0)  := (others => '0'); --               .address
		byte_en  : in  std_logic_vector(1 downto 0)  := (others => '0'); --               .byteenable
		clk      : in  std_logic                     := '0';             --          clock.clk
		rst      : in  std_logic                     := '0';             --     reset_sink.reset
		sclk     : out std_logic;                                        --    conduit_end.export
		mosi     : out std_logic;                                        --               .export
		miso     : in  std_logic                     := '0';             --               .export
		cs_n     : out std_logic;                                        --               .export
		irq      : out std_logic                                         --               .export
	);
end entity spi_master_0;

architecture rtl of spi_master_0 is
	component spi_master_16 is
		port (
			in_data  : in  std_logic_vector(15 downto 0) := (others => 'X'); -- writedata
			wr_en    : in  std_logic                     := 'X';             -- write
			out_data : out std_logic_vector(15 downto 0);                    -- readdata
			wait_req : out std_logic;                                        -- waitrequest
			addr     : in  std_logic_vector(9 downto 0)  := (others => 'X'); -- address
			byte_en  : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- byteenable
			clk      : in  std_logic                     := 'X';             -- clk
			rst      : in  std_logic                     := 'X';             -- reset
			sclk     : out std_logic;                                        -- export
			mosi     : out std_logic;                                        -- export
			miso     : in  std_logic                     := 'X';             -- export
			cs_n     : out std_logic;                                        -- export
			irq      : out std_logic                                         -- export
		);
	end component spi_master_16;

begin

	spi_master_0 : component spi_master_16
		port map (
			in_data  => in_data,  -- avalon_slave_0.writedata
			wr_en    => wr_en,    --               .write
			out_data => out_data, --               .readdata
			wait_req => wait_req, --               .waitrequest
			addr     => addr,     --               .address
			byte_en  => byte_en,  --               .byteenable
			clk      => clk,      --          clock.clk
			rst      => rst,      --     reset_sink.reset
			sclk     => sclk,     --    conduit_end.export
			mosi     => mosi,     --               .export
			miso     => miso,     --               .export
			cs_n     => cs_n,     --               .export
			irq      => irq       --               .export
		);

end architecture rtl; -- of spi_master_0
