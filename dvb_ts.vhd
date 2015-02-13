-- NetUP Universal Dual DVB-CI FPGA firmware
-- http://www.netup.tv
-- 
-- Copyright (c) 2014 NetUP Inc, AVB Labs
-- License: GPLv3


-- altera vhdl_input_version vhdl_2008

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.avblabs_common_pkg.all;

entity dvb_ts is

	port (
		rst			: in std_logic;
		clk			: in std_logic;
		-- control
		address		: in std_logic_vector(8 downto 0);
		byteenable	: in std_logic_vector(3 downto 0);
		writedata	: in std_logic_vector(31 downto 0);
		write		: in std_logic;
		readdata	: out std_logic_vector(31 downto 0);
		read		: in std_logic;
		waitrequest	: out std_logic;
		--
		interrupt	: out std_logic;
		cam_bypass	: in std_logic;
		-- input port 1
		dvb_in0_dsop	: in std_logic;
		dvb_in0_data	: in std_logic_vector(7 downto 0);
		dvb_in0_dval	: in std_logic;
		-- input port 2
		dvb_in1_dsop	: in std_logic;
		dvb_in1_data	: in std_logic_vector(7 downto 0);
		dvb_in1_dval	: in std_logic;
		-- input port 3
		dvb_in2_dsop	: in std_logic;
		dvb_in2_data	: in std_logic_vector(7 downto 0);
		dvb_in2_dval	: in std_logic;
		-- CAM port
		cam_baseclk		: in std_logic;
		cam_mclki		: out std_logic;
		cam_mdi			: out std_logic_vector(7 downto 0);
		cam_mival		: out std_logic;
		cam_mistrt		: out std_logic;
		cam_mclko		: in std_logic;
		cam_mdo			: in std_logic_vector(7 downto 0);
		cam_moval		: in std_logic;
		cam_mostrt		: in std_logic;
		-- output port (DMA)
		dvb_out_dsop	: out std_logic;
		dvb_out_data	: out std_logic_vector(7 downto 0);
		dvb_out_dval	: out std_logic
	);

end entity;

architecture rtl of dvb_ts is

	constant REG_CLKDIV	: natural := 0;
	constant REG_SRCSEL	: natural := 1;

	signal clkdiv		: std_logic_vector(3 downto 0);
	signal srcsel		: std_logic_vector(1 downto 0);

	signal cam_dsop		: std_logic;
	signal cam_data		: std_logic_vector(7 downto 0);
	signal cam_dval		: std_logic;

	signal swts_dsop	: std_logic;
	signal swts_data	: std_logic_vector(7 downto 0);
	signal swts_dval	: std_logic;

	signal mux_dsop		: std_logic;
	signal mux_data		: std_logic_vector(7 downto 0);
	signal mux_dval		: std_logic;

	signal filter_dsop	: std_logic;
	signal filter_data	: std_logic_vector(7 downto 0);
	signal filter_dval	: std_logic;

	signal pid_tbl_read		: std_logic;
	signal pid_tbl_write	: std_logic;
	signal pid_tbl_rddata	: std_logic_vector(31 downto 0);
	signal pid_tbl_waitreq	: std_logic;

begin
	-- control
	pid_tbl_write <= write and address(8);
	pid_tbl_read <= read and address(8);

	waitrequest <= pid_tbl_waitreq;
	readdata <= pid_tbl_rddata when address(8) else 
				X"0000000" & clkdiv when not address(0) else
				X"0000000" & "00" & srcsel;

	interrupt <= '0';

	process (rst, clk)
	begin
		if rising_edge(clk) then
			if write and byteenable(0) then
				if not address(0) and not address(8) then
					clkdiv <= writedata(clkdiv'range);
				end if;
				if address(0) and not address(8) then
					srcsel <= writedata(srcsel'range);
				end if;
			end if;
		end if;
		if rst then
			clkdiv <= (others => '0');
			srcsel <= (others => '0');
		end if;
	end process;

	-- input demux
	process (rst, clk)
	begin
		if rising_edge(clk) then
			case srcsel is
				when "00" =>
					mux_dsop <= dvb_in0_dsop;
					mux_data <= dvb_in0_data;
					mux_dval <= dvb_in0_dval;
				when "01" =>
					mux_dsop <= dvb_in1_dsop;
					mux_data <= dvb_in1_data;
					mux_dval <= dvb_in1_dval;
				when "10" =>
					mux_dsop <= dvb_in2_dsop;
					mux_data <= dvb_in2_data;
					mux_dval <= dvb_in2_dval;
				when others =>
					mux_dsop <= swts_dsop;
					mux_data <= swts_data;
					mux_dval <= swts_dval;
			end case;
		end if;
		if rst then
			mux_dsop <= '0';
			mux_data <= (others => '0');
			mux_dval <= '0';
		end if;
	end process;

	FILTER_0 : entity work.dvb_ts_filter
		port map (
			rst		=> rst,
			clk		=> clk,
			--
			pid_tbl_addr	=> address(7 downto 0),
			pid_tbl_be		=> byteenable,
			pid_tbl_wrdata	=> writedata,	
			pid_tbl_write	=> pid_tbl_write,
			pid_tbl_rddata	=> pid_tbl_rddata,
			pid_tbl_read	=> pid_tbl_read,
			pid_tbl_waitreq	=> pid_tbl_waitreq,
			--
			dvb_in_dsop		=> mux_dsop,
			dvb_in_data		=> mux_data,
			dvb_in_dval		=> mux_dval,
			--
			dvb_out_dsop	=> filter_dsop,
			dvb_out_data	=> filter_data,
			dvb_out_dval	=> filter_dval
		);

	CAM_OUT_0 : entity work.dvb_ts_shaper
		port map (
			rst		=> rst,
			clk		=> clk,
			--
			clkdiv	=> X"2",
			--
			dvb_indrdy		=> open,
			dvb_indata		=> filter_data,
			dvb_indsop		=> filter_dsop,
			dvb_indval		=> filter_dval,
			-- stream domain
			dvb_clk			=> cam_baseclk,
			--
			dvb_out_clk		=> cam_mclki,
			dvb_out_data	=> cam_mdi,
			dvb_out_dval	=> cam_mival,
			dvb_out_dsop	=> cam_mistrt
		);

	CAM_IN_0 : entity work.dvb_ts_sync
		port map (
			ts_clk		=> cam_mclko,
			ts_strt		=> cam_mostrt,
			ts_dval		=> cam_moval,
			ts_data		=> cam_mdo,
			--
			rst			=> rst,
			clk			=> clk,
			--
			strt		=> cam_dsop,
			data		=> cam_data,
			dval		=> cam_dval
		);

	-- CAM bypass cotrol
	process (rst, clk)
	begin
		if rising_edge(clk) then
			if cam_bypass then
				dvb_out_dsop <= filter_dsop;
				dvb_out_data <= filter_data;
				dvb_out_dval <= filter_dval;
			else
				dvb_out_dsop <= cam_dsop;
				dvb_out_data <= cam_data;
				dvb_out_dval <= cam_dval;
			end if;
		end if;
		if rst then
			dvb_out_dsop <= '0';
			dvb_out_data <= (others => '0');
			dvb_out_dval <= '0';
		end if;
	end process;

end architecture;
