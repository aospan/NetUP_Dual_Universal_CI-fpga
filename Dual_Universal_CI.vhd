-- NetUP Universal Dual DVB-CI FPGA firmware
-- http://www.netup.tv
-- 
-- Copyright (c) 2014 NetUP Inc, AVB Labs
-- License: GPLv3


library ieee;
use ieee.std_logic_1164.all;

library altera_mf;
use altera_mf.altera_mf_components.all;

entity netup_unidvb_top is
	port (
		nPERST			: in std_logic;
		SYSCLK			: in std_logic;
		-- config
		FLASH_SCLK		: out std_logic;
		FLASH_MOSI		: out std_logic;
		FLASH_MISO		: in std_logic;
		FLASH_nCS		: out std_logic;
		-- Frontend A
		FEA_CLOCK		: in std_logic;
		FEA_START		: in std_logic;
		FEA_VALID		: in std_logic;
		FEA_DATA		: in std_logic_vector(7 downto 0);
		-- Frontend B
		FEB_CLOCK		: in std_logic;
		FEB_START		: in std_logic;
		FEB_VALID		: in std_logic;
		FEB_DATA		: in std_logic_vector(7 downto 0);
		-- CI global
		CI_ADDR			: out std_logic_vector(14 downto 0);
		CI_nREG			: out std_logic;
		CI_DATA			: inout std_logic_vector(7 downto 0);
		CI_nIOWR		: out std_logic;
		CI_nWR			: out std_logic;
		CI_nIORD		: out std_logic;
		CI_nOE			: out std_logic;
		CI_BUS_DIR		: out std_logic;
		-- CI_A
		CIA_RST			: out std_logic;
		CIA_nRSTEN		: out std_logic;
		CIA_nCE1		: out std_logic;
		CIA_nBUS_OE		: out std_logic;
		CIA_nIREQ		: in std_logic;
		CIA_nWAIT		: in std_logic;
		CIA_nCD1		: in std_logic;
		CIA_nCD2		: in std_logic;
		CIA_MCLKI		: out std_logic;
		CIA_MDI			: out std_logic_vector(7 downto 0);
		CIA_MIVAL		: out std_logic;
		CIA_MISTRT		: out std_logic;
		CIA_MCLKO		: in std_logic;
		CIA_MDO			: in std_logic_vector(7 downto 0);
		CIA_MOVAL		: in std_logic;
 		CIA_MOSTRT		: in std_logic;
		-- CI_B
		CIB_RST			: out std_logic;
		CIB_nRSTEN		: out std_logic;
		CIB_nCE1		: out std_logic;
		CIB_nBUS_OE		: out std_logic;
		CIB_nIREQ		: in std_logic;
		CIB_nWAIT		: in std_logic;
		CIB_nCD1		: in std_logic;
		CIB_nCD2		: in std_logic;
		CIB_MCLKI		: out std_logic;
		CIB_MDI			: out std_logic_vector(7 downto 0);
		CIB_MIVAL		: out std_logic;
		CIB_MISTRT		: out std_logic;
		CIB_MCLKO		: in std_logic;
		CIB_MDO			: in std_logic_vector(7 downto 0);
		CIB_MOVAL		: in std_logic;
 		CIB_MOSTRT		: in std_logic;
		-- POWER SWITCH
		SW_nOC			: in std_logic_vector(1 downto 0);
		-- RF switches control
		RFA_CTL			: out std_logic;
		RFB_CTL			: out std_logic;
		-- IIC interfaces
		IIC0_SCL		: inout std_logic;
		IIC0_SDA		: inout std_logic;
		IIC1_SCL		: inout std_logic;
		IIC1_SDA		: inout std_logic;
		-- LED controls
		LED0_GRN		: out std_logic;
		LED0_RED		: out std_logic;
		LED1_GRN		: out std_logic;
		LED1_RED		: out std_logic;
		-- Demod/Tuner controls
		FEA_TU_nRST		: out std_logic;
		FEB_TU_nRST		: out std_logic;
		FEA_nRST		: out std_logic;
		FEB_nRST		: out std_logic;
		FEA_nIRQ0		: in std_logic;
		FEA_nIRQ1		: in std_logic;
		FEB_nIRQ0		: in std_logic;
		FEB_nIRQ1		: in std_logic;
		-- PCIe Interface
		PCI_REFCLK		: in std_logic;
		PCI_PET0		: out std_logic;
		PCI_PER0		: in std_logic
	);

end;

architecture rtl of netup_unidvb_top is

	component altpcie_reconfig_3cgx is
		port (
			signal offset_cancellation_reset	: in std_logic;
			signal reconfig_clk					: in std_logic;
			signal reconfig_fromgxb				: in std_logic_vector (4 downto 0);
			signal busy							: out std_logic;
			signal reconfig_togxb				: out std_logic_vector (3 downto 0)
		);
	end component altpcie_reconfig_3cgx;

	signal pll_rst_meta	: std_logic;
	signal pll_rst_n	: std_logic;

	signal gxb_fixedclk		: std_logic;
	signal gxb_reconfig_clk	: std_logic;
	signal gxb_pll_locked	: std_logic;

	signal reconfig_busy	: std_logic;
	signal reconfig_fromgxb	: std_logic_vector(4 downto 0);
	signal reconfig_togxb	: std_logic_vector(3 downto 0);

	signal bus_reset		: std_logic;
	signal bus_clk			: std_logic;
	signal dvb_clk			: std_logic;

	signal tsa_sop		: std_logic;
	signal tsa_dval		: std_logic;
	signal tsa_data		: std_logic_vector(7 downto 0);
	signal tsb_sop		: std_logic;
	signal tsb_dval		: std_logic;
	signal tsb_data		: std_logic_vector(7 downto 0);

	signal dma0_sop		: std_logic;
	signal dma0_dval	: std_logic;
	signal dma0_data	: std_logic_vector(7 downto 0);
	signal dma1_sop		: std_logic;
	signal dma1_dval	: std_logic;
	signal dma1_data	: std_logic_vector(7 downto 0);

	signal iic0_scl_act	: std_logic;
	signal iic0_sda_act	: std_logic;
	signal iic1_scl_act	: std_logic;
	signal iic1_sda_act	: std_logic;

	signal irq_fifo_in_0	: std_logic;
	signal irq_fifo_out_0	: std_logic;

	signal irq_fifo_in_1	: std_logic;
	signal irq_fifo_out_1	: std_logic;

	signal gpout	: std_logic_vector(15 downto 0);

	signal dma0_wait	: std_logic;
	signal dma0_addr	: std_logic_vector(63 downto 3);
	signal dma0_byteen	: std_logic_vector(7 downto 0);
	signal dma0_size	: std_logic_vector(6 downto 0);
	signal dma0_wrdata	: std_logic_vector(63 downto 0);
	signal dma0_write	: std_logic;

	signal dma1_wait	: std_logic;
	signal dma1_addr	: std_logic_vector(63 downto 3);
	signal dma1_byteen	: std_logic_vector(7 downto 0);
	signal dma1_size	: std_logic_vector(6 downto 0);
	signal dma1_wrdata	: std_logic_vector(63 downto 0);
	signal dma1_write	: std_logic;

	signal irq			: std_logic_vector(15 downto 0);
	signal irq_spi		: std_logic;
	signal irq_twi0		: std_logic;
	signal irq_twi1		: std_logic;
	signal irq_fea0		: std_logic;
	signal irq_fea1		: std_logic;
	signal irq_feb0		: std_logic;
	signal irq_feb1		: std_logic;
	signal irq_dma0		: std_logic;
	signal irq_dma1		: std_logic;
	signal irq_ci_stat	: std_logic;
	signal irq_cam		: std_logic_vector(1 downto 0);
	signal irq_ts		: std_logic_vector(1 downto 0);

	signal irq_fea0_meta	: std_logic;
	signal irq_fea1_meta	: std_logic;
	signal irq_feb0_meta	: std_logic;
	signal irq_feb1_meta	: std_logic;

	signal cam0_bypass	: std_logic;
	signal cam0_ready	: std_logic;
	signal cam0_fail	: std_logic;
	signal cam1_bypass	: std_logic;
	signal cam1_ready	: std_logic;
	signal cam1_fail	: std_logic;

	signal cam_address		: std_logic_vector(17 downto 0);
	signal cam_writedata	: std_logic_vector(7 downto 0);
	signal cam_write		: std_logic;
	signal cam_readdata		: std_logic_vector(7 downto 0);
	signal cam_read			: std_logic;
	signal cam_waitreq		: std_logic;

	signal ci_data_out		: std_logic_vector(7 downto 0);
	signal ci_data_out_en	: std_logic;

begin

	process (SYSCLK, nPERST)
	begin
		if rising_edge(SYSCLK) then
			pll_rst_meta <= '1';
			pll_rst_n <= pll_rst_meta;
		end if;
		if not nPERST then
			pll_rst_meta <= '0';
			pll_rst_n <= '0'; 
		end if;
	end process;

	DVB_PLL_0 : entity work.dvb_pll
		port map (
			areset	=> not pll_rst_n,
			inclk0	=> SYSCLK,
			c0		=> dvb_clk,			-- 108 MHz
			locked	=> open
		);

	GXB_PLL_0 : entity work.gxb_pll
		port map (
			areset	=> '0',
			inclk0	=> SYSCLK,
			c0		=> gxb_fixedclk,		-- 125 MHz
			c1		=> gxb_reconfig_clk,	-- 37.5 MHz
			locked	=> gxb_pll_locked
		);

	DVB_TSIN_0 : entity work.dvb_ts_sync
		port map (
			ts_clk		=> FEA_CLOCK,
			ts_strt		=> FEA_START,
			ts_dval		=> FEA_VALID,
			ts_data		=> FEA_DATA,
			--
			rst			=> bus_reset,
			clk			=> bus_clk,
			--
			strt		=> tsa_sop,
			data		=> tsa_data,
			dval		=> tsa_dval
		);

	DVB_TSIN_1 : entity work.dvb_ts_sync
		port map (
			ts_clk		=> FEB_CLOCK,
			ts_strt		=> FEB_START,
			ts_dval		=> FEB_VALID,
			ts_data		=> FEB_DATA,
			--
			rst			=> bus_reset,
			clk			=> bus_clk,
			--
			strt		=> tsb_sop,
			data		=> tsb_data,
			dval		=> tsb_dval
		);

	bus_reset <= '0';

	BUS_INST_0 : entity work.unici_core
		port map (
			-- global signals
			reset_n	=> pll_rst_n,
			pcie_compiler_0_pcie_core_clk_out	=> bus_clk,
/*			-- the_avalon_export_0
			ex_address_from_the_avalon_export_0		=> bus_address,
			ex_byteenable_from_the_avalon_export_0	=> bus_byteenable,
			ex_clk_from_the_avalon_export_0			=> bus_clk,
			ex_interrupt_to_the_avalon_export_0		=> bus_interrupt,
			ex_read_from_the_avalon_export_0		=> bus_read,
			ex_readdata_to_the_avalon_export_0		=> bus_readdata,
			ex_reset_from_the_avalon_export_0		=> bus_reset,
			ex_waitrequest_to_the_avalon_export_0	=> bus_waitrequest,
			ex_write_from_the_avalon_export_0		=> bus_write,
			ex_writedata_from_the_avalon_export_0	=> bus_writedata,
*/			-- interrupt controller
			avlm_irq_to_the_int_ctrl_0		=> irq,
			-- the_gpio_0
			pins_from_the_gpout_0			=> gpout,
			-- spi_0
			cs_n_from_the_spi_master_0		=> FLASH_nCS,
			sclk_from_the_spi_master_0		=> FLASH_SCLK,
			mosi_from_the_spi_master_0		=> FLASH_MOSI,
			miso_to_the_spi_master_0		=> FLASH_MISO,
			irq_from_the_spi_master_0		=> irq_spi,
			-- twi_0
			irq_from_the_fifo_in_8b_sync_0	=> irq_fifo_in_0,
			sink_irq_to_the_twi_master_0	=> irq_fifo_in_0,
			irq_from_the_fifo_out_8b_sync_0	=> irq_fifo_out_0,
			source_irq_to_the_twi_master_0	=> irq_fifo_out_0,
			scl_in_to_the_twi_master_0		=> IIC0_SCL,
			scl_act_from_the_twi_master_0	=> iic0_scl_act,
			sda_in_to_the_twi_master_0		=> IIC0_SDA,
			sda_act_from_the_twi_master_0	=> iic0_sda_act,
			irq_from_the_twi_master_0		=> irq_twi0,
			-- twi_1
			irq_from_the_fifo_in_8b_sync_1	=> irq_fifo_in_1,
			sink_irq_to_the_twi_master_1	=> irq_fifo_in_1,
			irq_from_the_fifo_out_8b_sync_1	=> irq_fifo_out_1,
			source_irq_to_the_twi_master_1	=> irq_fifo_out_1,
			scl_in_to_the_twi_master_1		=> IIC1_SCL,
			scl_act_from_the_twi_master_1	=> iic1_scl_act,
			sda_in_to_the_twi_master_1		=> IIC1_SDA,
			sda_act_from_the_twi_master_1	=> iic1_sda_act,
			irq_from_the_twi_master_1		=> irq_twi1,
			-- the_pcie_compiler_0
			clk125_out_pcie_compiler_0		=> open,
			clk250_out_pcie_compiler_0		=> open,
			clk500_out_pcie_compiler_0		=> open,
			--
			reconfig_clk_pcie_compiler_0			=> gxb_reconfig_clk,
			busy_altgxb_reconfig_pcie_compiler_0	=> reconfig_busy,
			reconfig_fromgxb_pcie_compiler_0		=> reconfig_fromgxb,
			reconfig_togxb_pcie_compiler_0			=> reconfig_togxb,
			--
			fixedclk_serdes_pcie_compiler_0		=> gxb_fixedclk,
			gxb_powerdown_pcie_compiler_0		=> '0',
			pll_powerdown_pcie_compiler_0		=> '0',
			--
			pcie_rstn_pcie_compiler_0			=> nPERST,
			refclk_pcie_compiler_0				=> PCI_REFCLK,
			rx_in0_pcie_compiler_0				=> PCI_PER0,
			tx_out0_pcie_compiler_0				=> PCI_PET0,
			--
			powerdown_ext_pcie_compiler_0		=> open,
			rate_ext_pcie_compiler_0			=> open,
			phystatus_ext_pcie_compiler_0		=> '0',
			pipe_mode_pcie_compiler_0			=> '0',
			rxdata0_ext_pcie_compiler_0			=> (others => '0'),
			rxdatak0_ext_pcie_compiler_0		=> '0',
			rxelecidle0_ext_pcie_compiler_0		=> '0',
			rxpolarity0_ext_pcie_compiler_0		=> open,
			rxstatus0_ext_pcie_compiler_0		=> (others => '0'),
			rxvalid0_ext_pcie_compiler_0		=> '0',
			test_in_pcie_compiler_0				=> (others => '0'),
			txcompl0_ext_pcie_compiler_0		=> open,
			txdata0_ext_pcie_compiler_0			=> open,
			txdatak0_ext_pcie_compiler_0		=> open,
			txdetectrx_ext_pcie_compiler_0		=> open,
			txelecidle0_ext_pcie_compiler_0		=> open,
			-- DMA arbiter
			dma0_wait_from_the_dma_arbiter_0	=> dma0_wait,
			dma0_addr_to_the_dma_arbiter_0		=> dma0_addr,
			dma0_byteen_to_the_dma_arbiter_0	=> dma0_byteen,
			dma0_size_to_the_dma_arbiter_0		=> dma0_size,
			dma0_wrdata_to_the_dma_arbiter_0	=> dma0_wrdata,
			dma0_write_to_the_dma_arbiter_0		=> dma0_write,
			dma1_wait_from_the_dma_arbiter_0	=> dma1_wait,
			dma1_addr_to_the_dma_arbiter_0		=> dma1_addr,
			dma1_byteen_to_the_dma_arbiter_0	=> dma1_byteen,
			dma1_size_to_the_dma_arbiter_0		=> dma1_size,
			dma1_wrdata_to_the_dma_arbiter_0	=> dma1_wrdata,
			dma1_write_to_the_dma_arbiter_0		=> dma1_write,
			-- dma #0 interface
			dvb_data_to_the_dvb_dma_0			=> dma0_data,
			dvb_dval_to_the_dvb_dma_0			=> dma0_dval,
			dvb_sop_to_the_dvb_dma_0			=> dma0_sop,
			mem_addr_from_the_dvb_dma_0			=> dma0_addr,
			mem_byteen_from_the_dvb_dma_0		=> dma0_byteen,
			mem_size_from_the_dvb_dma_0			=> dma0_size,
			mem_wrdata_from_the_dvb_dma_0		=> dma0_wrdata,
			mem_write_from_the_dvb_dma_0		=> dma0_write,
			mem_waitreq_to_the_dvb_dma_0		=> dma0_wait,
			interrupt_from_the_dvb_dma_0		=> irq_dma0,
			-- dma #1 interface
			dvb_data_to_the_dvb_dma_1			=> dma1_data,
			dvb_dval_to_the_dvb_dma_1			=> dma1_dval,
			dvb_sop_to_the_dvb_dma_1			=> dma1_sop,
			mem_addr_from_the_dvb_dma_1			=> dma1_addr,
			mem_byteen_from_the_dvb_dma_1		=> dma1_byteen,
			mem_size_from_the_dvb_dma_1			=> dma1_size,
			mem_wrdata_from_the_dvb_dma_1		=> dma1_wrdata,
			mem_write_from_the_dvb_dma_1		=> dma1_write,
			mem_waitreq_to_the_dvb_dma_1		=> dma1_wait,
			interrupt_from_the_dvb_dma_1		=> irq_dma1,
			-- CI bridge
			ci_reg_n_from_the_ci_bridge_0			=> CI_nREG,
			ci_a_from_the_ci_bridge_0				=> CI_ADDR,
			ci_d_in_to_the_ci_bridge_0				=> CI_DATA,
			ci_d_out_from_the_ci_bridge_0			=> ci_data_out,
			ci_d_en_from_the_ci_bridge_0			=> ci_data_out_en,
			ci_iord_n_from_the_ci_bridge_0			=> CI_nIORD,
			ci_iowr_n_from_the_ci_bridge_0			=> CI_nIOWR,
			ci_oe_n_from_the_ci_bridge_0			=> CI_nOE,
			ci_we_n_from_the_ci_bridge_0			=> CI_nWR,
			ci_bus_dir_from_the_ci_bridge_0			=> CI_BUS_DIR,
			cia_ce_n_from_the_ci_bridge_0			=> CIA_nCE1,
			cia_data_buf_oe_n_from_the_ci_bridge_0	=> CIA_nBUS_OE,
			cia_reset_buf_oe_n_from_the_ci_bridge_0	=> CIA_nRSTEN,
			cia_reset_from_the_ci_bridge_0			=> CIA_RST,
			cib_ce_n_from_the_ci_bridge_0			=> CIB_nCE1,
			cib_data_buf_oe_n_from_the_ci_bridge_0	=> CIB_nBUS_OE,
			cib_reset_buf_oe_n_from_the_ci_bridge_0	=> CIB_nRSTEN,
			cib_reset_from_the_ci_bridge_0			=> CIB_RST,
			cia_cd_n_to_the_ci_bridge_0				=> CIA_nCD1 & CIA_nCD2,
			cia_ireq_n_to_the_ci_bridge_0			=> CIA_nIREQ,
			cia_overcurrent_n_to_the_ci_bridge_0	=> SW_nOC(0),
			cia_wait_n_to_the_ci_bridge_0			=> CIA_nWAIT,
			cib_cd_n_to_the_ci_bridge_0				=> CIB_nCD1 & CIB_nCD2,
			cib_ireq_n_to_the_ci_bridge_0			=> CIB_nIREQ,
			cib_overcurrent_n_to_the_ci_bridge_0	=> SW_nOC(1),
			cib_wait_n_to_the_ci_bridge_0			=> CIB_nWAIT,
			interrupt_from_the_ci_bridge_0			=> irq_ci_stat,
			cam0_bypass_from_the_ci_bridge_0		=> cam0_bypass,
			cam0_ready_from_the_ci_bridge_0			=> cam0_ready,
			cam0_fail_from_the_ci_bridge_0			=> cam0_fail,
			cam1_bypass_from_the_ci_bridge_0		=> cam1_bypass,
			cam1_ready_from_the_ci_bridge_0			=> cam1_ready,
			cam1_fail_from_the_ci_bridge_0			=> cam1_fail,
			cam_interrupts_from_the_ci_bridge_0		=> irq_cam,
			cam_readdata_from_the_ci_bridge_0 		=> cam_readdata,
			cam_waitreq_from_the_ci_bridge_0		=> cam_waitreq,
			cam_address_to_the_ci_bridge_0			=> cam_address,
			cam_read_to_the_ci_bridge_0				=> cam_read,
			cam_write_to_the_ci_bridge_0			=> cam_write,
			cam_writedata_to_the_ci_bridge_0		=> cam_writedata,
			-- DVB TS 0
			cam_mclki_from_the_dvb_ts_0		=> CIA_MCLKI,
			cam_mdi_from_the_dvb_ts_0		=> CIA_MDI,
			cam_mistrt_from_the_dvb_ts_0	=> CIA_MISTRT,
			cam_mival_from_the_dvb_ts_0		=> CIA_MIVAL,
			dvb_out_data_from_the_dvb_ts_0	=> dma0_data,
			dvb_out_dsop_from_the_dvb_ts_0	=> dma0_sop,
			dvb_out_dval_from_the_dvb_ts_0	=> dma0_dval,
			interrupt_from_the_dvb_ts_0		=> irq_ts(0),
			cam_baseclk_to_the_dvb_ts_0		=> dvb_clk,
			cam_bypass_to_the_dvb_ts_0		=> cam0_bypass,
			cam_mclko_to_the_dvb_ts_0		=> CIA_MCLKO,
			cam_mdo_to_the_dvb_ts_0			=> CIA_MDO,
			cam_mostrt_to_the_dvb_ts_0		=> CIA_MOSTRT,
			cam_moval_to_the_dvb_ts_0		=> CIA_MOVAL,
			dvb_in0_data_to_the_dvb_ts_0	=> tsa_data,
			dvb_in0_dsop_to_the_dvb_ts_0	=> tsa_sop,
			dvb_in0_dval_to_the_dvb_ts_0	=> tsa_dval,
			dvb_in1_data_to_the_dvb_ts_0	=> tsb_data,
			dvb_in1_dsop_to_the_dvb_ts_0	=> tsb_sop, 
			dvb_in1_dval_to_the_dvb_ts_0	=> tsb_dval,
			dvb_in2_data_to_the_dvb_ts_0	=> dma1_data,
			dvb_in2_dsop_to_the_dvb_ts_0	=> dma1_sop, 
			dvb_in2_dval_to_the_dvb_ts_0	=> dma1_dval,
			-- DVB TS 1
			cam_mclki_from_the_dvb_ts_1		=> CIB_MCLKI,
			cam_mdi_from_the_dvb_ts_1		=> CIB_MDI,
			cam_mistrt_from_the_dvb_ts_1	=> CIB_MISTRT,
			cam_mival_from_the_dvb_ts_1		=> CIB_MIVAL,
			dvb_out_data_from_the_dvb_ts_1	=> dma1_data,
			dvb_out_dsop_from_the_dvb_ts_1	=> dma1_sop,
			dvb_out_dval_from_the_dvb_ts_1	=> dma1_dval,
			interrupt_from_the_dvb_ts_1		=> irq_ts(1),
			cam_baseclk_to_the_dvb_ts_1		=> dvb_clk,
			cam_bypass_to_the_dvb_ts_1		=> cam1_bypass,
			cam_mclko_to_the_dvb_ts_1		=> CIB_MCLKO,
			cam_mdo_to_the_dvb_ts_1			=> CIB_MDO,
			cam_mostrt_to_the_dvb_ts_1		=> CIB_MOSTRT,
			cam_moval_to_the_dvb_ts_1		=> CIB_MOVAL,
			dvb_in0_data_to_the_dvb_ts_1	=> tsb_data,
			dvb_in0_dsop_to_the_dvb_ts_1	=> tsb_sop,
			dvb_in0_dval_to_the_dvb_ts_1	=> tsb_dval,
			dvb_in1_data_to_the_dvb_ts_1	=> tsa_data,
			dvb_in1_dsop_to_the_dvb_ts_1	=> tsa_sop,
			dvb_in1_dval_to_the_dvb_ts_1	=> tsa_dval,
			dvb_in2_data_to_the_dvb_ts_1	=> dma0_data,
			dvb_in2_dsop_to_the_dvb_ts_1	=> dma0_sop,
			dvb_in2_dval_to_the_dvb_ts_1	=> dma0_dval,
			-- BAR1 adapter
			out_address_from_the_avalon64_to_avalon8_0		=> cam_address,
			out_readdata_to_the_avalon64_to_avalon8_0		=> cam_readdata,
			out_read_from_the_avalon64_to_avalon8_0			=> cam_read,
			out_writedata_from_the_avalon64_to_avalon8_0	=> cam_writedata,
			out_write_from_the_avalon64_to_avalon8_0		=> cam_write,
			out_waitrequest_to_the_avalon64_to_avalon8_0	=> cam_waitreq
		);

	irq <= (
		0	=> irq_spi,
		1	=> irq_twi0,
		2	=> irq_twi1,
		4	=> irq_fea0,
		5	=> irq_fea1,
		6	=> irq_feb0,
		7	=> irq_feb1,
		8	=> irq_dma0,
		9	=> irq_dma1,
		10	=> irq_ci_stat,
		11	=> irq_cam(0),
		12	=> irq_cam(1),
		13	=> irq_ts(0),
		14	=> irq_ts(1),
		--
		others => '0'
	);

	GX_RECONFIG_0 : altpcie_reconfig_3cgx
		port map (
			offset_cancellation_reset => not gxb_pll_locked,
			reconfig_clk		=> gxb_reconfig_clk,
			reconfig_fromgxb	=> reconfig_fromgxb,
			busy				=> reconfig_busy,
			reconfig_togxb		=> reconfig_togxb
		);

	process (bus_clk, bus_reset)
	begin
		if rising_edge(bus_clk) then
			irq_fea0_meta <= not FEA_nIRQ0;
			irq_fea0 <= irq_fea0_meta;
			irq_fea1_meta <= not FEA_nIRQ1;
			irq_fea1 <= irq_fea1_meta;
			irq_feb0_meta <= not FEB_nIRQ0;
			irq_feb0 <= irq_feb0_meta;
			irq_feb1_meta <= not FEB_nIRQ1;
			irq_feb1 <= irq_feb1_meta;
			--
			LED0_GRN <= not cam0_ready;
			LED0_RED <= not cam0_fail;
			LED1_GRN <= not cam1_ready;
			LED1_RED <= not cam1_fail;
		end if;
		if bus_reset then
			irq_fea0_meta <= '0';
			irq_fea0 <= '0';
			irq_fea1_meta <= '0';
			irq_fea1 <= '0';
			irq_feb0_meta <= '0';
			irq_feb0 <= '0';
			irq_feb1_meta <= '0';
			irq_feb1 <= '0';
			--
			LED0_GRN <= '0';
			LED0_RED <= '0';
			LED1_GRN <= '0';
			LED1_RED <= '0';
		end if;
	end process;

	IIC0_SCL <= '0' when iic0_scl_act else 'Z';
	IIC0_SDA <= '0' when iic0_sda_act else 'Z';

	IIC1_SCL <= '0' when iic1_scl_act else 'Z';
	IIC1_SDA <= '0' when iic1_sda_act else 'Z';

	FEA_nRST <= gpout(0);
	FEB_nRST <= gpout(1);
	RFA_CTL <= gpout(2);
	RFB_CTL <= gpout(3);
	FEA_TU_nRST <= gpout(4);
	FEB_TU_nRST <= gpout(5);

	CI_DATA <= ci_data_out when ci_data_out_en else (others => 'Z');

end;
