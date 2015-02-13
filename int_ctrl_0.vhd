-- NetUP Universal Dual DVB-CI FPGA firmware
-- http://www.netup.tv
-- 
-- Copyright (c) 2014 NetUP Inc, AVB Labs
-- License: GPLv3

-- int_ctrl_0.vhd

-- This file was auto-generated as part of a generation operation.
-- If you edit it your changes will probably be lost.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity int_ctrl_0 is
	port (
		clk              : in  std_logic                     := '0';             --            clock.clk
		rst              : in  std_logic                     := '0';             --       reset_sink.reset
		avls_byteenable  : in  std_logic_vector(3 downto 0)  := (others => '0'); --     avalon_slave.byteenable
		avls_writedata   : in  std_logic_vector(31 downto 0) := (others => '0'); --                 .writedata
		avls_write       : in  std_logic                     := '0';             --                 .write
		avls_readdata    : out std_logic_vector(31 downto 0);                    --                 .readdata
		avls_read        : in  std_logic                     := '0';             --                 .read
		avls_waitrequest : out std_logic;                                        --                 .waitrequest
		avls_address     : in  std_logic_vector(12 downto 0) := (others => '0'); --                 .address
		address          : in  std_logic_vector(1 downto 0)  := (others => '0'); --       avalon_cra.address
		byteenable       : in  std_logic_vector(1 downto 0)  := (others => '0'); --                 .byteenable
		writedata        : in  std_logic_vector(15 downto 0) := (others => '0'); --                 .writedata
		write            : in  std_logic                     := '0';             --                 .write
		readdata         : out std_logic_vector(15 downto 0);                    --                 .readdata
		avlm_address     : out std_logic_vector(14 downto 0);                    --    avalon_master.address
		avlm_byteenable  : out std_logic_vector(3 downto 0);                     --                 .byteenable
		avlm_writedata   : out std_logic_vector(31 downto 0);                    --                 .writedata
		avlm_write       : out std_logic;                                        --                 .write
		avlm_readdata    : in  std_logic_vector(31 downto 0) := (others => '0'); --                 .readdata
		avlm_read        : out std_logic;                                        --                 .read
		avlm_waitrequest : in  std_logic                     := '0';             --                 .waitrequest
		avls_irq         : out std_logic;                                        -- interrupt_sender.irq
		avlm_irq         : in  std_logic_vector(15 downto 0) := (others => '0')  --      conduit_end.export
	);
end entity int_ctrl_0;

architecture rtl of int_ctrl_0 is
	component int_ctrl is
		port (
			clk              : in  std_logic                     := 'X';             -- clk
			rst              : in  std_logic                     := 'X';             -- reset
			avls_byteenable  : in  std_logic_vector(3 downto 0)  := (others => 'X'); -- byteenable
			avls_writedata   : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			avls_write       : in  std_logic                     := 'X';             -- write
			avls_readdata    : out std_logic_vector(31 downto 0);                    -- readdata
			avls_read        : in  std_logic                     := 'X';             -- read
			avls_waitrequest : out std_logic;                                        -- waitrequest
			avls_address     : in  std_logic_vector(12 downto 0) := (others => 'X'); -- address
			address          : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- address
			byteenable       : in  std_logic_vector(1 downto 0)  := (others => 'X'); -- byteenable
			writedata        : in  std_logic_vector(15 downto 0) := (others => 'X'); -- writedata
			write            : in  std_logic                     := 'X';             -- write
			readdata         : out std_logic_vector(15 downto 0);                    -- readdata
			avlm_address     : out std_logic_vector(14 downto 0);                    -- address
			avlm_byteenable  : out std_logic_vector(3 downto 0);                     -- byteenable
			avlm_writedata   : out std_logic_vector(31 downto 0);                    -- writedata
			avlm_write       : out std_logic;                                        -- write
			avlm_readdata    : in  std_logic_vector(31 downto 0) := (others => 'X'); -- readdata
			avlm_read        : out std_logic;                                        -- read
			avlm_waitrequest : in  std_logic                     := 'X';             -- waitrequest
			avls_irq         : out std_logic;                                        -- irq
			avlm_irq         : in  std_logic_vector(15 downto 0) := (others => 'X')  -- export
		);
	end component int_ctrl;

begin

	int_ctrl_0 : component int_ctrl
		port map (
			clk              => clk,              --            clock.clk
			rst              => rst,              --       reset_sink.reset
			avls_byteenable  => avls_byteenable,  --     avalon_slave.byteenable
			avls_writedata   => avls_writedata,   --                 .writedata
			avls_write       => avls_write,       --                 .write
			avls_readdata    => avls_readdata,    --                 .readdata
			avls_read        => avls_read,        --                 .read
			avls_waitrequest => avls_waitrequest, --                 .waitrequest
			avls_address     => avls_address,     --                 .address
			address          => address,          --       avalon_cra.address
			byteenable       => byteenable,       --                 .byteenable
			writedata        => writedata,        --                 .writedata
			write            => write,            --                 .write
			readdata         => readdata,         --                 .readdata
			avlm_address     => avlm_address,     --    avalon_master.address
			avlm_byteenable  => avlm_byteenable,  --                 .byteenable
			avlm_writedata   => avlm_writedata,   --                 .writedata
			avlm_write       => avlm_write,       --                 .write
			avlm_readdata    => avlm_readdata,    --                 .readdata
			avlm_read        => avlm_read,        --                 .read
			avlm_waitrequest => avlm_waitrequest, --                 .waitrequest
			avls_irq         => avls_irq,         -- interrupt_sender.irq
			avlm_irq         => avlm_irq          --      conduit_end.export
		);

end architecture rtl; -- of int_ctrl_0
