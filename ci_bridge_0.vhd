-- NetUP Universal Dual DVB-CI FPGA firmware
-- http://www.netup.tv
-- 
-- Copyright (c) 2014 NetUP Inc, AVB Labs
-- License: GPLv3

-- ci_bridge_0.vhd

-- This file was auto-generated as part of a generation operation.
-- If you edit it your changes will probably be lost.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity ci_bridge_0 is
	port (
		clk                : in  std_logic                     := '0';             --          clock.clk
		address            : in  std_logic_vector(1 downto 0)  := (others => '0'); -- avalon_slave_0.address
		byteenable         : in  std_logic_vector(1 downto 0)  := (others => '0'); --               .byteenable
		writedata          : in  std_logic_vector(15 downto 0) := (others => '0'); --               .writedata
		write              : in  std_logic                     := '0';             --               .write
		readdata           : out std_logic_vector(15 downto 0);                    --               .readdata
		rst                : in  std_logic                     := '0';             --     reset_sink.reset
		cia_reset          : out std_logic;                                        --    conduit_end.export
		cib_reset          : out std_logic;                                        --               .export
		cia_ce_n           : out std_logic;                                        --               .export
		cib_ce_n           : out std_logic;                                        --               .export
		ci_reg_n           : out std_logic;                                        --               .export
		ci_a               : out std_logic_vector(14 downto 0);                    --               .export
		ci_we_n            : out std_logic;                                        --               .export
		ci_oe_n            : out std_logic;                                        --               .export
		ci_iowr_n          : out std_logic;                                        --               .export
		ci_iord_n          : out std_logic;                                        --               .export
		cia_wait_n         : in  std_logic                     := '0';             --               .export
		cib_wait_n         : in  std_logic                     := '0';             --               .export
		cia_ireq_n         : in  std_logic                     := '0';             --               .export
		cib_ireq_n         : in  std_logic                     := '0';             --               .export
		cia_cd_n           : in  std_logic_vector(1 downto 0)  := (others => '0'); --               .export
		cib_cd_n           : in  std_logic_vector(1 downto 0)  := (others => '0'); --               .export
		cia_overcurrent_n  : in  std_logic                     := '0';             --               .export
		cib_overcurrent_n  : in  std_logic                     := '0';             --               .export
		cia_reset_buf_oe_n : out std_logic;                                        --               .export
		cib_reset_buf_oe_n : out std_logic;                                        --               .export
		cia_data_buf_oe_n  : out std_logic;                                        --               .export
		cib_data_buf_oe_n  : out std_logic;                                        --               .export
		ci_bus_dir         : out std_logic;                                        --               .export
		interrupt          : out std_logic;                                        --               .export
		cam_interrupts     : out std_logic_vector(1 downto 0);                     --               .export
		cam0_ready         : out std_logic;                                        --               .export
		cam0_bypass        : out std_logic;                                        --               .export
		cam1_ready         : out std_logic;                                        --               .export
		cam1_bypass        : out std_logic;                                        --               .export
		cam0_fail          : out std_logic;                                        --               .export
		cam1_fail          : out std_logic;                                        --               .export
		ci_d_out           : out std_logic_vector(7 downto 0);                     --               .export
		ci_d_in            : in  std_logic_vector(7 downto 0)  := (others => '0'); --               .export
		ci_d_en            : out std_logic;                                        --               .export
		cam_writedata      : in  std_logic_vector(7 downto 0)  := (others => '0'); --               .export
		cam_write          : in  std_logic                     := '0';             --               .export
		cam_readdata       : out std_logic_vector(7 downto 0);                     --               .export
		cam_read           : in  std_logic                     := '0';             --               .export
		cam_address        : in  std_logic_vector(17 downto 0) := (others => '0'); --               .export
		cam_waitreq        : out std_logic                                         --               .export
	);
end entity ci_bridge_0;

architecture rtl of ci_bridge_0 is
	component ci_bridge is
		port (
			clk                : in  std_logic                     := 'X';             -- clk
			address            : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- address
			byteenable         : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- byteenable
			writedata          : in  std_logic_vector(15 downto 0) := (others => 'X'); -- writedata
			write              : in  std_logic                     := 'X';             -- write
			readdata           : out std_logic_vector(15 downto 0);                    -- readdata
			rst                : in  std_logic                     := 'X';             -- reset
			cia_reset          : out std_logic;                                        -- export
			cib_reset          : out std_logic;                                        -- export
			cia_ce_n           : out std_logic;                                        -- export
			cib_ce_n           : out std_logic;                                        -- export
			ci_reg_n           : out std_logic;                                        -- export
			ci_a               : out std_logic_vector(14 downto 0);                    -- export
			ci_we_n            : out std_logic;                                        -- export
			ci_oe_n            : out std_logic;                                        -- export
			ci_iowr_n          : out std_logic;                                        -- export
			ci_iord_n          : out std_logic;                                        -- export
			cia_wait_n         : in  std_logic                     := 'X';             -- export
			cib_wait_n         : in  std_logic                     := 'X';             -- export
			cia_ireq_n         : in  std_logic                     := 'X';             -- export
			cib_ireq_n         : in  std_logic                     := 'X';             -- export
			cia_cd_n           : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- export
			cib_cd_n           : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- export
			cia_overcurrent_n  : in  std_logic                     := 'X';             -- export
			cib_overcurrent_n  : in  std_logic                     := 'X';             -- export
			cia_reset_buf_oe_n : out std_logic;                                        -- export
			cib_reset_buf_oe_n : out std_logic;                                        -- export
			cia_data_buf_oe_n  : out std_logic;                                        -- export
			cib_data_buf_oe_n  : out std_logic;                                        -- export
			ci_bus_dir         : out std_logic;                                        -- export
			interrupt          : out std_logic;                                        -- export
			cam_interrupts     : out std_logic_vector(1 downto 0);                     -- export
			cam0_ready         : out std_logic;                                        -- export
			cam0_bypass        : out std_logic;                                        -- export
			cam1_ready         : out std_logic;                                        -- export
			cam1_bypass        : out std_logic;                                        -- export
			cam0_fail          : out std_logic;                                        -- export
			cam1_fail          : out std_logic;                                        -- export
			ci_d_out           : out std_logic_vector(7 downto 0);                     -- export
			ci_d_in            : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- export
			ci_d_en            : out std_logic;                                        -- export
			cam_writedata      : in  std_logic_vector(7 downto 0)  := (others => 'X'); -- export
			cam_write          : in  std_logic                     := 'X';             -- export
			cam_readdata       : out std_logic_vector(7 downto 0);                     -- export
			cam_read           : in  std_logic                     := 'X';             -- export
			cam_address        : in  std_logic_vector(17 downto 0) := (others => 'X'); -- export
			cam_waitreq        : out std_logic                                         -- export
		);
	end component ci_bridge;

begin

	ci_bridge_0 : component ci_bridge
		port map (
			clk                => clk,                --          clock.clk
			address            => address,            -- avalon_slave_0.address
			byteenable         => byteenable,         --               .byteenable
			writedata          => writedata,          --               .writedata
			write              => write,              --               .write
			readdata           => readdata,           --               .readdata
			rst                => rst,                --     reset_sink.reset
			cia_reset          => cia_reset,          --    conduit_end.export
			cib_reset          => cib_reset,          --               .export
			cia_ce_n           => cia_ce_n,           --               .export
			cib_ce_n           => cib_ce_n,           --               .export
			ci_reg_n           => ci_reg_n,           --               .export
			ci_a               => ci_a,               --               .export
			ci_we_n            => ci_we_n,            --               .export
			ci_oe_n            => ci_oe_n,            --               .export
			ci_iowr_n          => ci_iowr_n,          --               .export
			ci_iord_n          => ci_iord_n,          --               .export
			cia_wait_n         => cia_wait_n,         --               .export
			cib_wait_n         => cib_wait_n,         --               .export
			cia_ireq_n         => cia_ireq_n,         --               .export
			cib_ireq_n         => cib_ireq_n,         --               .export
			cia_cd_n           => cia_cd_n,           --               .export
			cib_cd_n           => cib_cd_n,           --               .export
			cia_overcurrent_n  => cia_overcurrent_n,  --               .export
			cib_overcurrent_n  => cib_overcurrent_n,  --               .export
			cia_reset_buf_oe_n => cia_reset_buf_oe_n, --               .export
			cib_reset_buf_oe_n => cib_reset_buf_oe_n, --               .export
			cia_data_buf_oe_n  => cia_data_buf_oe_n,  --               .export
			cib_data_buf_oe_n  => cib_data_buf_oe_n,  --               .export
			ci_bus_dir         => ci_bus_dir,         --               .export
			interrupt          => interrupt,          --               .export
			cam_interrupts     => cam_interrupts,     --               .export
			cam0_ready         => cam0_ready,         --               .export
			cam0_bypass        => cam0_bypass,        --               .export
			cam1_ready         => cam1_ready,         --               .export
			cam1_bypass        => cam1_bypass,        --               .export
			cam0_fail          => cam0_fail,          --               .export
			cam1_fail          => cam1_fail,          --               .export
			ci_d_out           => ci_d_out,           --               .export
			ci_d_in            => ci_d_in,            --               .export
			ci_d_en            => ci_d_en,            --               .export
			cam_writedata      => cam_writedata,      --               .export
			cam_write          => cam_write,          --               .export
			cam_readdata       => cam_readdata,       --               .export
			cam_read           => cam_read,           --               .export
			cam_address        => cam_address,        --               .export
			cam_waitreq        => cam_waitreq         --               .export
		);

end architecture rtl; -- of ci_bridge_0
