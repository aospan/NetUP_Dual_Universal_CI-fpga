-- NetUP Universal Dual DVB-CI FPGA firmware
-- http://www.netup.tv
-- 
-- Copyright (c) 2014 NetUP Inc, AVB Labs
-- License: GPLv3

-- twi_master_0.vhd

-- This file was auto-generated as part of a generation operation.
-- If you edit it your changes will probably be lost.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity twi_master_0 is
	port (
		addr       : in  std_logic_vector(1 downto 0)  := (others => '0'); --          avalon_slave_0.address
		wr_en      : in  std_logic                     := '0';             --                        .write
		out_data   : out std_logic_vector(15 downto 0);                    --                        .readdata
		byte_en    : in  std_logic_vector(1 downto 0)  := (others => '0'); --                        .byteenable
		in_data    : in  std_logic_vector(15 downto 0) := (others => '0'); --                        .writedata
		clk        : in  std_logic                     := '0';             --                   clock.clk
		rst        : in  std_logic                     := '0';             --              reset_sink.reset
		in_octet   : in  std_logic_vector(7 downto 0)  := (others => '0'); --   avalon_streaming_sink.data
		in_valid   : in  std_logic                     := '0';             --                        .valid
		in_ready   : out std_logic;                                        --                        .ready
		out_octet  : out std_logic_vector(7 downto 0);                     -- avalon_streaming_source.data
		out_valid  : out std_logic;                                        --                        .valid
		out_ready  : in  std_logic                     := '0';             --                        .ready
		scl_in     : in  std_logic                     := '0';             --             conduit_end.export
		scl_act    : out std_logic;                                        --                        .export
		sda_in     : in  std_logic                     := '0';             --                        .export
		sda_act    : out std_logic;                                        --                        .export
		sink_irq   : in  std_logic                     := '0';             --                        .export
		source_irq : in  std_logic                     := '0';             --                        .export
		irq        : out std_logic                                         --                        .export
	);
end entity twi_master_0;

architecture rtl of twi_master_0 is
	component twi_master is
		port (
			addr       : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- address
			wr_en      : in  std_logic                     := 'X';             -- write
			out_data   : out std_logic_vector(15 downto 0);                    -- readdata
			byte_en    : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- byteenable
			in_data    : in  std_logic_vector(15 downto 0) := (others => 'X'); -- writedata
			clk        : in  std_logic                     := 'X';             -- clk
			rst        : in  std_logic                     := 'X';             -- reset
			in_octet   : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- data
			in_valid   : in  std_logic                     := 'X';             -- valid
			in_ready   : out std_logic;                                        -- ready
			out_octet  : out std_logic_vector(7 downto 0);                     -- data
			out_valid  : out std_logic;                                        -- valid
			out_ready  : in  std_logic                     := 'X';             -- ready
			scl_in     : in  std_logic                     := 'X';             -- export
			scl_act    : out std_logic;                                        -- export
			sda_in     : in  std_logic                     := 'X';             -- export
			sda_act    : out std_logic;                                        -- export
			sink_irq   : in  std_logic                     := 'X';             -- export
			source_irq : in  std_logic                     := 'X';             -- export
			irq        : out std_logic                                         -- export
		);
	end component twi_master;

begin

	twi_master_0 : component twi_master
		port map (
			addr       => addr,       --          avalon_slave_0.address
			wr_en      => wr_en,      --                        .write
			out_data   => out_data,   --                        .readdata
			byte_en    => byte_en,    --                        .byteenable
			in_data    => in_data,    --                        .writedata
			clk        => clk,        --                   clock.clk
			rst        => rst,        --              reset_sink.reset
			in_octet   => in_octet,   --   avalon_streaming_sink.data
			in_valid   => in_valid,   --                        .valid
			in_ready   => in_ready,   --                        .ready
			out_octet  => out_octet,  -- avalon_streaming_source.data
			out_valid  => out_valid,  --                        .valid
			out_ready  => out_ready,  --                        .ready
			scl_in     => scl_in,     --             conduit_end.export
			scl_act    => scl_act,    --                        .export
			sda_in     => sda_in,     --                        .export
			sda_act    => sda_act,    --                        .export
			sink_irq   => sink_irq,   --                        .export
			source_irq => source_irq, --                        .export
			irq        => irq         --                        .export
		);

end architecture rtl; -- of twi_master_0
