-- NetUP Universal Dual DVB-CI FPGA firmware
-- http://www.netup.tv
-- 
-- Copyright (c) 2014 NetUP Inc, AVB Labs
-- License: GPLv3

-- fifo_in_8b_sync_0.vhd

-- This file was auto-generated as part of a generation operation.
-- If you edit it your changes will probably be lost.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity fifo_in_8b_sync_0 is
	port (
		byte_en  : in  std_logic_vector(3 downto 0)  := (others => '0'); --        avalon_slave_0.byteenable
		in_data  : in  std_logic_vector(31 downto 0) := (others => '0'); --                      .writedata
		wr_en    : in  std_logic                     := '0';             --                      .write
		out_data : out std_logic_vector(31 downto 0);                    --                      .readdata
		rd_en    : in  std_logic                     := '0';             --                      .read
		wait_req : out std_logic;                                        --                      .waitrequest
		addr     : in  std_logic_vector(1 downto 0)  := (others => '0'); --                      .address
		clk      : in  std_logic                     := '0';             --                 clock.clk
		rst      : in  std_logic                     := '0';             --            reset_sink.reset
		st_data  : in  std_logic_vector(7 downto 0)  := (others => '0'); -- avalon_streaming_sink.data
		st_valid : in  std_logic                     := '0';             --                      .valid
		st_ready : out std_logic;                                        --                      .ready
		irq      : out std_logic                                         --           conduit_end.export
	);
end entity fifo_in_8b_sync_0;

architecture rtl of fifo_in_8b_sync_0 is
	component fifo_in_8b_sync is
		generic (
			FIFO_DEPTH : integer := 16;
			BUS_WIDTH  : integer := 32
		);
		port (
			byte_en  : in  std_logic_vector(3 downto 0)  := (others => 'X'); -- byteenable
			in_data  : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			wr_en    : in  std_logic                     := 'X';             -- write
			out_data : out std_logic_vector(31 downto 0);                    -- readdata
			rd_en    : in  std_logic                     := 'X';             -- read
			wait_req : out std_logic;                                        -- waitrequest
			addr     : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- address
			clk      : in  std_logic                     := 'X';             -- clk
			rst      : in  std_logic                     := 'X';             -- reset
			st_data  : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- data
			st_valid : in  std_logic                     := 'X';             -- valid
			st_ready : out std_logic;                                        -- ready
			irq      : out std_logic                                         -- export
		);
	end component fifo_in_8b_sync;

begin

	fifo_in_8b_sync_0 : component fifo_in_8b_sync
		generic map (
			FIFO_DEPTH => 16,
			BUS_WIDTH  => 32
		)
		port map (
			byte_en  => byte_en,  --        avalon_slave_0.byteenable
			in_data  => in_data,  --                      .writedata
			wr_en    => wr_en,    --                      .write
			out_data => out_data, --                      .readdata
			rd_en    => rd_en,    --                      .read
			wait_req => wait_req, --                      .waitrequest
			addr     => addr,     --                      .address
			clk      => clk,      --                 clock.clk
			rst      => rst,      --            reset_sink.reset
			st_data  => st_data,  -- avalon_streaming_sink.data
			st_valid => st_valid, --                      .valid
			st_ready => st_ready, --                      .ready
			irq      => irq       --           conduit_end.export
		);

end architecture rtl; -- of fifo_in_8b_sync_0
