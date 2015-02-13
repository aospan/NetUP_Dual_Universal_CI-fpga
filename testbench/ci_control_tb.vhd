-- NetUP Universal Dual DVB-CI FPGA firmware
-- http://www.netup.tv
-- 
-- Copyright (c) 2014 NetUP Inc, AVB Labs
-- License: GPLv3


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.avblabs_common_pkg.all;

entity ci_control_tb is
end;

architecture sym of ci_control_tb is

	signal rst	: std_logic := '1';
	signal clk	: std_logic := '0';

	signal soft_reset		: std_logic := '0';
	signal stschg_ack		: std_logic := '0';
	signal ci_timeout		: std_logic := '0';

	signal ci_cd_n			: std_logic_vector(1 downto 0) := "11";
	signal ci_reset			: std_logic;
	signal ci_reset_oe_n	: std_logic;
	signal ci_overcurrent_n	: std_logic := '1';
	signal ci_ireq_n		: std_logic := '1';

	signal cam_stat_changed	: std_logic;
	signal cam_stat_present	: std_logic;
	signal cam_stat_reset	: std_logic;
	signal cam_stat_ready	: std_logic;
	signal cam_stat_error	: std_logic;
	signal cam_stat_ovcp	: std_logic;
	signal cam_stat_busy	: std_logic;

	signal cam_interrupt	: std_logic;
	signal cam_reset		: std_logic;

begin

	cam_reset <= 'Z' when ci_reset_oe_n else ci_reset;

	CI_CTRL_0 : entity work.ci_control
		generic map (
			t_h		=> 18750,
			t_w		=> 1250,
			t_su	=> 6250
		)
		port map (
			clk			=> clk,
			rst			=> rst,
			--
			soft_reset		=> soft_reset,
			stschg_ack		=> stschg_ack,
			ci_timeout		=> ci_timeout,
			ci_cd_n				=> ci_cd_n,
			ci_reset			=> ci_reset,
			ci_reset_oe_n		=> ci_reset_oe_n,
			ci_overcurrent_n	=> ci_overcurrent_n,
			ci_ireq_n			=> ci_ireq_n,
			cam_stschg		=> cam_stat_changed,
			cam_present		=> cam_stat_present,
			cam_reset		=> cam_stat_reset,
			cam_ready		=> cam_stat_ready,
			cam_error		=> cam_stat_error,
			cam_ovcp		=> cam_stat_ovcp,
			cam_busy		=> cam_stat_busy,
			cam_interrupt	=> cam_interrupt
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
		wait for 5 us;
		--
		report "CAM inserted";
		ci_cd_n <= "00";
		wait for 100 us;
		ci_ireq_n <= '0';
		wait for 380 us;
		ci_ireq_n <= '1';
		wait until rising_edge(clk) and cam_stat_changed = '1';
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		stschg_ack <= '1';
		wait until rising_edge(clk);
		stschg_ack <= '0';
		wait until rising_edge(clk);
		--
		wait for 100 us;
		--
		report "CAM removed";
		ci_cd_n <= "11";
		wait until rising_edge(clk) and cam_stat_changed = '1';
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		stschg_ack <= '1';
		wait until rising_edge(clk);
		stschg_ack <= '0';
		wait until rising_edge(clk);
		--
		wait for 200 us;
		--
		report "CAM inserted";
		ci_cd_n <= "00";
		wait for 100 us;
		ci_ireq_n <= '0';
		wait for 380 us;
		ci_ireq_n <= '1';
		wait until rising_edge(clk) and cam_stat_changed = '1';
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		stschg_ack <= '1';
		wait until rising_edge(clk);
		stschg_ack <= '0';
		wait until rising_edge(clk);
		--
		wait for 50 us;
		--
		report "Soft reset";
		wait until rising_edge(clk);
		soft_reset <= '1';
		wait until rising_edge(clk);
		soft_reset <= '0';
		wait until rising_edge(clk) and cam_stat_changed = '1';
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		stschg_ack <= '1';
		wait until rising_edge(clk);
		stschg_ack <= '0';
		wait until rising_edge(clk);
		--
		wait for 50 us;
		--
		report "Overcurrent";
		ci_overcurrent_n <= '0';
		wait until rising_edge(clk) and cam_stat_changed = '1';
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		stschg_ack <= '1';
		wait until rising_edge(clk);
		stschg_ack <= '0';
		wait until rising_edge(clk);
		--
		wait for 50 us;
		--
		report "Soft reset";
		wait until rising_edge(clk);
		soft_reset <= '1';
		wait until rising_edge(clk);
		soft_reset <= '0';
		wait until rising_edge(clk) and cam_stat_changed = '1';
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		stschg_ack <= '1';
		wait until rising_edge(clk);
		stschg_ack <= '0';
		wait until rising_edge(clk);
		--
		wait for 50 us;
		--
		report "CAM removed";
		ci_cd_n <= "11";
		wait until rising_edge(clk) and cam_stat_changed = '1';
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		stschg_ack <= '1';
		wait until rising_edge(clk);
		stschg_ack <= '0';
		wait until rising_edge(clk);
		--
		wait for 50 us;
		ci_overcurrent_n <= '1';
		--
		report "CAM inserted";
		ci_cd_n <= "00";
		wait for 100 us;
		ci_ireq_n <= '0';
		wait for 380 us;
		ci_ireq_n <= '1';
		wait until rising_edge(clk) and cam_stat_changed = '1';
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		stschg_ack <= '1';
		wait until rising_edge(clk);
		stschg_ack <= '0';
		wait until rising_edge(clk);
		--
		wait for 50 us;
		--
		report "CAM timeout";
		wait until rising_edge(clk);
		ci_timeout <= '1';
		wait until rising_edge(clk);
		ci_timeout <= '0';
		wait until rising_edge(clk) and cam_stat_changed = '1';
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		stschg_ack <= '1';
		wait until rising_edge(clk);
		stschg_ack <= '0';
		wait until rising_edge(clk);
		--
		wait for 50 us;
		--
		report "Soft reset";
		wait until rising_edge(clk);
		soft_reset <= '1';
		wait until rising_edge(clk);
		soft_reset <= '0';
		wait until rising_edge(clk) and cam_stat_changed = '1';
		wait until rising_edge(clk);
		wait until rising_edge(clk);
		stschg_ack <= '1';
		wait until rising_edge(clk);
		stschg_ack <= '0';
		wait until rising_edge(clk);
		--
		wait;
	end process;

end;
