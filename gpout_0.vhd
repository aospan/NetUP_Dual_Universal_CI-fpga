-- NetUP Universal Dual DVB-CI FPGA firmware
-- http://www.netup.tv
-- 
-- Copyright (c) 2014 NetUP Inc, AVB Labs
-- License: GPLv3

-- gpout_0.vhd

-- This file was auto-generated as part of a generation operation.
-- If you edit it your changes will probably be lost.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity gpout_0 is
	port (
		address    : in  std_logic_vector(1 downto 0)  := (others => '0'); -- avalon_slave_0.address
		byteenable : in  std_logic_vector(1 downto 0)  := (others => '0'); --               .byteenable
		writedata  : in  std_logic_vector(15 downto 0) := (others => '0'); --               .writedata
		write      : in  std_logic                     := '0';             --               .write
		readdata   : out std_logic_vector(15 downto 0);                    --               .readdata
		clk        : in  std_logic                     := '0';             --          clock.clk
		rst        : in  std_logic                     := '0';             --     reset_sink.reset
		pins       : out std_logic_vector(15 downto 0)                     --    conduit_end.export
	);
end entity gpout_0;

architecture rtl of gpout_0 is
	component gpout is
		generic (
			POLARITY_MASK : natural := 0
		);
		port (
			address    : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- address
			byteenable : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- byteenable
			writedata  : in  std_logic_vector(15 downto 0) := (others => 'X'); -- writedata
			write      : in  std_logic                     := 'X';             -- write
			readdata   : out std_logic_vector(15 downto 0);                    -- readdata
			clk        : in  std_logic                     := 'X';             -- clk
			rst        : in  std_logic                     := 'X';             -- reset
			pins       : out std_logic_vector(15 downto 0)                     -- export
		);
	end component gpout;

begin

	gpout_0 : component gpout
		generic map (
			POLARITY_MASK => 0
		)
		port map (
			address    => address,    -- avalon_slave_0.address
			byteenable => byteenable, --               .byteenable
			writedata  => writedata,  --               .writedata
			write      => write,      --               .write
			readdata   => readdata,   --               .readdata
			clk        => clk,        --          clock.clk
			rst        => rst,        --     reset_sink.reset
			pins       => pins        --    conduit_end.export
		);

end architecture rtl; -- of gpout_0
