-- NetUP Universal Dual DVB-CI FPGA firmware
-- http://www.netup.tv
-- 
-- Copyright (c) 2014 NetUP Inc, AVB Labs
-- License: GPLv3

-- fifo_out_8b_sync_1.vhd

-- This file was auto-generated as part of a generation operation.
-- If you edit it your changes will probably be lost.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fifo_out_8b_sync_1 is
	port (
		addr     : in  std_logic_vector(1 downto 0)  := (others => '0'); --          avalon_slave_0.address
		in_data  : in  std_logic_vector(31 downto 0) := (others => '0'); --                        .writedata
		wr_en    : in  std_logic                     := '0';             --                        .write
		out_data : out std_logic_vector(31 downto 0);                    --                        .readdata
		wait_req : out std_logic;                                        --                        .waitrequest
		byte_en  : in  std_logic_vector(3 downto 0)  := (others => '0'); --                        .byteenable
		clk      : in  std_logic                     := '0';             --                   clock.clk
		rst      : in  std_logic                     := '0';             --              reset_sink.reset
		st_data  : out std_logic_vector(7 downto 0);                     -- avalon_streaming_source.data
		st_ready : in  std_logic                     := '0';             --                        .ready
		st_valid : out std_logic;                                        --                        .valid
		irq      : out std_logic                                         --             conduit_end.export
	);
end entity fifo_out_8b_sync_1;

architecture rtl of fifo_out_8b_sync_1 is
	component fifo_out_8b_sync is
		generic (
			FIFO_DEPTH : integer := 16;
			BUS_WIDTH  : integer := 32
		);
		port (
			addr     : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- address
			in_data  : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			wr_en    : in  std_logic                     := 'X';             -- write
			out_data : out std_logic_vector(31 downto 0);                    -- readdata
			wait_req : out std_logic;                                        -- waitrequest
			byte_en  : in  std_logic_vector(3 downto 0)  := (others => 'X'); -- byteenable
			clk      : in  std_logic                     := 'X';             -- clk
			rst      : in  std_logic                     := 'X';             -- reset
			st_data  : out std_logic_vector(7 downto 0);                     -- data
			st_ready : in  std_logic                     := 'X';             -- ready
			st_valid : out std_logic;                                        -- valid
			irq      : out std_logic                                         -- export
		);
	end component fifo_out_8b_sync;

begin

	fifo_out_8b_sync_1 : component fifo_out_8b_sync
		generic map (
			FIFO_DEPTH => 16,
			BUS_WIDTH  => 32
		)
		port map (
			addr     => addr,     --          avalon_slave_0.address
			in_data  => in_data,  --                        .writedata
			wr_en    => wr_en,    --                        .write
			out_data => out_data, --                        .readdata
			wait_req => wait_req, --                        .waitrequest
			byte_en  => byte_en,  --                        .byteenable
			clk      => clk,      --                   clock.clk
			rst      => rst,      --              reset_sink.reset
			st_data  => st_data,  -- avalon_streaming_source.data
			st_ready => st_ready, --                        .ready
			st_valid => st_valid, --                        .valid
			irq      => irq       --             conduit_end.export
		);

end architecture rtl; -- of fifo_out_8b_sync_1
