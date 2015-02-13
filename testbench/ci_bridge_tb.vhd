-- NetUP Universal Dual DVB-CI FPGA firmware
-- http://www.netup.tv
-- 
-- Copyright (c) 2014 NetUP Inc, AVB Labs
-- License: GPLv3


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.avblabs_common_pkg.all;

entity ci_bridge_tb is
end;

architecture sym of ci_bridge_tb is

	signal rst	: std_logic := '1';
	signal clk	: std_logic := '0';

	signal address			: std_logic_vector(14 downto 0) := (others => '0');
	signal byteenable		: std_logic_vector(7 downto 0) := (others => '0');
	signal writedata		: std_logic_vector(63 downto 0) := (others => '0');
	signal write			: std_logic := '0';
	signal readdata			: std_logic_vector(63 downto 0);
	signal read				: std_logic := '0';
	signal waitrequest		: std_logic;

	signal cam_address		: std_logic_vector(17 downto 0);
	signal cam_writedata	: std_logic_vector(7 downto 0);
	signal cam_write		: std_logic;
	signal cam_readdata		: std_logic_vector(7 downto 0);
	signal cam_read			: std_logic;
	signal cam_waitreq		: std_logic;

	signal cia_ce_n				: std_logic;
	signal cib_ce_n				: std_logic;
	signal ci_reg_n				: std_logic;
	signal ci_a					: std_logic_vector(14 downto 0);
	signal ci_d_out				: std_logic_vector(7 downto 0);
	signal ci_d_out_en			: std_logic;
	signal ci_we_n				: std_logic;
	signal ci_oe_n				: std_logic;
	signal ci_iowr_n			: std_logic;
	signal ci_iord_n			: std_logic;
	signal cia_wait_n			: std_logic := '1';
	signal cib_wait_n			: std_logic := '1';
	signal cia_data_buf_oe_n	: std_logic;
	signal cib_data_buf_oe_n	: std_logic;
	signal ci_bus_dir			: std_logic;

	signal cia_data		: std_logic_vector(7 downto 0) := (others => 'Z');
	signal cib_data		: std_logic_vector(7 downto 0) := (others => 'Z');
	signal ci_data		: std_logic_vector(7 downto 0) := (others => 'Z');

begin

	cia_data <= (others => 'L') when cia_data_buf_oe_n or ci_bus_dir else ci_data;
	cib_data <= (others => 'H') when cib_data_buf_oe_n or ci_bus_dir else ci_data;

	ci_data <=	ci_d_out when ci_d_out_en else
				cia_data when not cia_data_buf_oe_n and ci_bus_dir else
				cib_data when not cib_data_buf_oe_n and ci_bus_dir else
				(others => 'Z');

	ADAPTER_0 : entity work.avalon64_to_avalon8
		generic map(
			OUT_ADDR_WIDTH => 18
		)
		port map (
			rst		=> rst,
			clk		=> clk,
			address			=> address,
			byteenable		=> byteenable,
			writedata		=> writedata,
			write			=> write,
			readdata		=> readdata,
			read			=> read,
			waitrequest		=> waitrequest,
			out_address		=> cam_address,
			out_writedata	=> cam_writedata,
			out_write		=> cam_write,
			out_readdata	=> cam_readdata,
			out_read		=> cam_read,
			out_waitrequest	=> cam_waitreq
		);

	BRIDGE_0 : entity work.ci_bridge
		port map (
			clk			=> clk,
			rst			=> rst,
			address		=> (others => '0'),
			byteenable	=> (others => '0'),
			writedata	=> (others => '0'),
			write		=> '0',
			readdata	=> open,
			interrupt	=> open,
			cam_address		=> cam_address,
			cam_writedata	=> cam_writedata,
			cam_write		=> cam_write,
			cam_readdata	=> cam_readdata,
			cam_read		=> cam_read,
			cam_waitreq		=> cam_waitreq,
			cam_interrupts	=> open,
			cia_reset		=> open,
			cib_reset		=> open,
			cia_ce_n		=> cia_ce_n,
			cib_ce_n		=> cib_ce_n,
			ci_reg_n		=> ci_reg_n,
			ci_a			=> ci_a,
			ci_d_in			=> ci_data,
			ci_d_out		=> ci_d_out,
			ci_d_en			=> ci_d_out_en,
			ci_we_n			=> ci_we_n,
			ci_oe_n			=> ci_oe_n,
			ci_iowr_n		=> ci_iowr_n,
			ci_iord_n		=> ci_iord_n,
			cia_wait_n		=> cia_wait_n,
			cib_wait_n		=> cib_wait_n,
			cia_ireq_n		=> '1',
			cib_ireq_n		=> '1',
			cia_cd_n		=> "00",
			cib_cd_n		=> "00",
			cia_overcurrent_n	=> '1',
			cib_overcurrent_n	=> '1',
			cia_reset_buf_oe_n	=> open,
			cib_reset_buf_oe_n	=> open,
			cia_data_buf_oe_n	=> cia_data_buf_oe_n,
			cib_data_buf_oe_n	=> cib_data_buf_oe_n,
			ci_bus_dir			=> ci_bus_dir
		);

	process
	begin
		wait for 8 ns;
		clk <= not clk;
	end process;

	process
	begin
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		rst <= '0';
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		--
		wait until rising_edge(clk);
		address <= std_logic_vector(to_unsigned(0, 15));
		byteenable <= "11111111";
		read <= '1';
		wait until rising_edge(clk) and waitrequest = '0';
		--
		address <= std_logic_vector(to_unsigned(2, 15));
		byteenable <= "00110000";
		read <= '1';
		wait until rising_edge(clk) and waitrequest = '0';
		read <= '0';
		--
		wait until rising_edge(clk);
		--
		wait;
	end process;

end;
