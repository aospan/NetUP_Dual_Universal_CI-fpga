-- NetUP Universal Dual DVB-CI FPGA firmware
-- http://www.netup.tv
-- 
-- Copyright (c) 2014 NetUP Inc, AVB Labs
-- License: GPLv3

-- avalon64_to_avalon8_0.vhd

-- This file was auto-generated as part of a generation operation.
-- If you edit it your changes will probably be lost.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity avalon64_to_avalon8_0 is
	port (
		address         : in  std_logic_vector(14 downto 0) := (others => '0'); -- avalon_slave_0.address
		byteenable      : in  std_logic_vector(7 downto 0)  := (others => '0'); --               .byteenable
		writedata       : in  std_logic_vector(63 downto 0) := (others => '0'); --               .writedata
		write           : in  std_logic                     := '0';             --               .write
		readdata        : out std_logic_vector(63 downto 0);                    --               .readdata
		read            : in  std_logic                     := '0';             --               .read
		waitrequest     : out std_logic;                                        --               .waitrequest
		clk             : in  std_logic                     := '0';             --          clock.clk
		rst             : in  std_logic                     := '0';             --     reset_sink.reset
		out_address     : out std_logic_vector(17 downto 0);                    --    conduit_end.export
		out_writedata   : out std_logic_vector(7 downto 0);                     --               .export
		out_write       : out std_logic;                                        --               .export
		out_readdata    : in  std_logic_vector(7 downto 0)  := (others => '0'); --               .export
		out_read        : out std_logic;                                        --               .export
		out_waitrequest : in  std_logic                     := '0'              --               .export
	);
end entity avalon64_to_avalon8_0;

architecture rtl of avalon64_to_avalon8_0 is
	component avalon64_to_avalon8 is
		generic (
			OUT_ADDR_WIDTH : integer := 15
		);
		port (
			address         : in  std_logic_vector(14 downto 0) := (others => 'X'); -- address
			byteenable      : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- byteenable
			writedata       : in  std_logic_vector(63 downto 0) := (others => 'X'); -- writedata
			write           : in  std_logic                     := 'X';             -- write
			readdata        : out std_logic_vector(63 downto 0);                    -- readdata
			read            : in  std_logic                     := 'X';             -- read
			waitrequest     : out std_logic;                                        -- waitrequest
			clk             : in  std_logic                     := 'X';             -- clk
			rst             : in  std_logic                     := 'X';             -- reset
			out_address     : out std_logic_vector(17 downto 0);                    -- export
			out_writedata   : out std_logic_vector(7 downto 0);                     -- export
			out_write       : out std_logic;                                        -- export
			out_readdata    : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- export
			out_read        : out std_logic;                                        -- export
			out_waitrequest : in  std_logic                     := 'X'              -- export
		);
	end component avalon64_to_avalon8;

begin

	avalon64_to_avalon8_0 : component avalon64_to_avalon8
		generic map (
			OUT_ADDR_WIDTH => 18
		)
		port map (
			address         => address,         -- avalon_slave_0.address
			byteenable      => byteenable,      --               .byteenable
			writedata       => writedata,       --               .writedata
			write           => write,           --               .write
			readdata        => readdata,        --               .readdata
			read            => read,            --               .read
			waitrequest     => waitrequest,     --               .waitrequest
			clk             => clk,             --          clock.clk
			rst             => rst,             --     reset_sink.reset
			out_address     => out_address,     --    conduit_end.export
			out_writedata   => out_writedata,   --               .export
			out_write       => out_write,       --               .export
			out_readdata    => out_readdata,    --               .export
			out_read        => out_read,        --               .export
			out_waitrequest => out_waitrequest  --               .export
		);

end architecture rtl; -- of avalon64_to_avalon8_0
