-- NetUP Universal Dual DVB-CI FPGA firmware
-- http://www.netup.tv
-- 
-- Copyright (c) 2014 NetUP Inc, AVB Labs
-- License: GPLv3

-- dvb_ts_0.vhd

-- This file was auto-generated as part of a generation operation.
-- If you edit it your changes will probably be lost.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity dvb_ts_0 is
	port (
		address      : in  std_logic_vector(8 downto 0)  := (others => '0'); -- avalon_slave_0.address
		byteenable   : in  std_logic_vector(3 downto 0)  := (others => '0'); --               .byteenable
		writedata    : in  std_logic_vector(31 downto 0) := (others => '0'); --               .writedata
		write        : in  std_logic                     := '0';             --               .write
		readdata     : out std_logic_vector(31 downto 0);                    --               .readdata
		read         : in  std_logic                     := '0';             --               .read
		waitrequest  : out std_logic;                                        --               .waitrequest
		clk          : in  std_logic                     := '0';             --          clock.clk
		rst          : in  std_logic                     := '0';             --     reset_sink.reset
		interrupt    : out std_logic;                                        --    conduit_end.export
		cam_bypass   : in  std_logic                     := '0';             --               .export
		dvb_in0_dsop : in  std_logic                     := '0';             --               .export
		dvb_in0_data : in  std_logic_vector(7 downto 0)  := (others => '0'); --               .export
		dvb_in0_dval : in  std_logic                     := '0';             --               .export
		dvb_in1_dsop : in  std_logic                     := '0';             --               .export
		dvb_in1_data : in  std_logic_vector(7 downto 0)  := (others => '0'); --               .export
		dvb_in1_dval : in  std_logic                     := '0';             --               .export
		dvb_in2_dsop : in  std_logic                     := '0';             --               .export
		dvb_in2_data : in  std_logic_vector(7 downto 0)  := (others => '0'); --               .export
		dvb_in2_dval : in  std_logic                     := '0';             --               .export
		cam_baseclk  : in  std_logic                     := '0';             --               .export
		cam_mclki    : out std_logic;                                        --               .export
		cam_mdi      : out std_logic_vector(7 downto 0);                     --               .export
		cam_mival    : out std_logic;                                        --               .export
		cam_mistrt   : out std_logic;                                        --               .export
		cam_mclko    : in  std_logic                     := '0';             --               .export
		cam_mdo      : in  std_logic_vector(7 downto 0)  := (others => '0'); --               .export
		cam_mostrt   : in  std_logic                     := '0';             --               .export
		cam_moval    : in  std_logic                     := '0';             --               .export
		dvb_out_dsop : out std_logic;                                        --               .export
		dvb_out_dval : out std_logic;                                        --               .export
		dvb_out_data : out std_logic_vector(7 downto 0)                      --               .export
	);
end entity dvb_ts_0;

architecture rtl of dvb_ts_0 is
	component dvb_ts is
		port (
			address      : in  std_logic_vector(8 downto 0)  := (others => 'X'); -- address
			byteenable   : in  std_logic_vector(3 downto 0)  := (others => 'X'); -- byteenable
			writedata    : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			write        : in  std_logic                     := 'X';             -- write
			readdata     : out std_logic_vector(31 downto 0);                    -- readdata
			read         : in  std_logic                     := 'X';             -- read
			waitrequest  : out std_logic;                                        -- waitrequest
			clk          : in  std_logic                     := 'X';             -- clk
			rst          : in  std_logic                     := 'X';             -- reset
			interrupt    : out std_logic;                                        -- export
			cam_bypass   : in  std_logic                     := 'X';             -- export
			dvb_in0_dsop : in  std_logic                     := 'X';             -- export
			dvb_in0_data : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- export
			dvb_in0_dval : in  std_logic                     := 'X';             -- export
			dvb_in1_dsop : in  std_logic                     := 'X';             -- export
			dvb_in1_data : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- export
			dvb_in1_dval : in  std_logic                     := 'X';             -- export
			dvb_in2_dsop : in  std_logic                     := 'X';             -- export
			dvb_in2_data : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- export
			dvb_in2_dval : in  std_logic                     := 'X';             -- export
			cam_baseclk  : in  std_logic                     := 'X';             -- export
			cam_mclki    : out std_logic;                                        -- export
			cam_mdi      : out std_logic_vector(7 downto 0);                     -- export
			cam_mival    : out std_logic;                                        -- export
			cam_mistrt   : out std_logic;                                        -- export
			cam_mclko    : in  std_logic                     := 'X';             -- export
			cam_mdo      : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- export
			cam_mostrt   : in  std_logic                     := 'X';             -- export
			cam_moval    : in  std_logic                     := 'X';             -- export
			dvb_out_dsop : out std_logic;                                        -- export
			dvb_out_dval : out std_logic;                                        -- export
			dvb_out_data : out std_logic_vector(7 downto 0)                      -- export
		);
	end component dvb_ts;

begin

	dvb_ts_0 : component dvb_ts
		port map (
			address      => address,      -- avalon_slave_0.address
			byteenable   => byteenable,   --               .byteenable
			writedata    => writedata,    --               .writedata
			write        => write,        --               .write
			readdata     => readdata,     --               .readdata
			read         => read,         --               .read
			waitrequest  => waitrequest,  --               .waitrequest
			clk          => clk,          --          clock.clk
			rst          => rst,          --     reset_sink.reset
			interrupt    => interrupt,    --    conduit_end.export
			cam_bypass   => cam_bypass,   --               .export
			dvb_in0_dsop => dvb_in0_dsop, --               .export
			dvb_in0_data => dvb_in0_data, --               .export
			dvb_in0_dval => dvb_in0_dval, --               .export
			dvb_in1_dsop => dvb_in1_dsop, --               .export
			dvb_in1_data => dvb_in1_data, --               .export
			dvb_in1_dval => dvb_in1_dval, --               .export
			dvb_in2_dsop => dvb_in2_dsop, --               .export
			dvb_in2_data => dvb_in2_data, --               .export
			dvb_in2_dval => dvb_in2_dval, --               .export
			cam_baseclk  => cam_baseclk,  --               .export
			cam_mclki    => cam_mclki,    --               .export
			cam_mdi      => cam_mdi,      --               .export
			cam_mival    => cam_mival,    --               .export
			cam_mistrt   => cam_mistrt,   --               .export
			cam_mclko    => cam_mclko,    --               .export
			cam_mdo      => cam_mdo,      --               .export
			cam_mostrt   => cam_mostrt,   --               .export
			cam_moval    => cam_moval,    --               .export
			dvb_out_dsop => dvb_out_dsop, --               .export
			dvb_out_dval => dvb_out_dval, --               .export
			dvb_out_data => dvb_out_data  --               .export
		);

end architecture rtl; -- of dvb_ts_0
