# NetUP Universal Dual DVB-CI FPGA firmware
# http://www.netup.tv
#
# Copyright (c) 2014 NetUP Inc, AVB Labs
# License: GPLv3

set_global_assignment -name FMAX_REQUIREMENT "100 MHz" -section_id refclk_pcie_compiler_0
set_instance_assignment -name CLOCK_SETTINGS refclk_pcie_compiler_0 -to refclk_pcie_compiler_0
set_global_assignment -name ENABLE_CLOCK_LATENCY ON
set_global_assignment -name ENABLE_RECOVERY_REMOVAL_ANALYSIS ON
set_global_assignment -name SDC_FILE pcie_compiler_0.sdc
set_global_assignment -name OPTIMIZE_FAST_CORNER_TIMING ON
set_parameter -name CYCLONEII_SAFE_WRITE RESTRUCTURE
set_instance_assignment -name VIRTUAL_PIN ON -to test_out_pcie_compiler_0
set_instance_assignment -name VIRTUAL_PIN ON -to clk125_out_pcie_compiler_0
set_instance_assignment -name VIRTUAL_PIN ON -to phystatus_ext_pcie_compiler_0
set_instance_assignment -name VIRTUAL_PIN ON -to rxelecidle0_ext_pcie_compiler_0
set_instance_assignment -name VIRTUAL_PIN ON -to rxvalid0_ext_pcie_compiler_0
set_instance_assignment -name VIRTUAL_PIN ON -to rxstatus0_ext_pcie_compiler_0[0]
set_instance_assignment -name VIRTUAL_PIN ON -to rxstatus0_ext_pcie_compiler_0[1]
set_instance_assignment -name VIRTUAL_PIN ON -to rxstatus0_ext_pcie_compiler_0[2]
set_instance_assignment -name VIRTUAL_PIN ON -to rxdata0_ext_pcie_compiler_0[0]
set_instance_assignment -name VIRTUAL_PIN ON -to rxdata0_ext_pcie_compiler_0[1]
set_instance_assignment -name VIRTUAL_PIN ON -to rxdata0_ext_pcie_compiler_0[2]
set_instance_assignment -name VIRTUAL_PIN ON -to rxdata0_ext_pcie_compiler_0[3]
set_instance_assignment -name VIRTUAL_PIN ON -to rxdata0_ext_pcie_compiler_0[4]
set_instance_assignment -name VIRTUAL_PIN ON -to rxdata0_ext_pcie_compiler_0[5]
set_instance_assignment -name VIRTUAL_PIN ON -to rxdata0_ext_pcie_compiler_0[6]
set_instance_assignment -name VIRTUAL_PIN ON -to rxdata0_ext_pcie_compiler_0[7]
set_instance_assignment -name VIRTUAL_PIN ON -to rxdatak0_ext_pcie_compiler_0
set_instance_assignment -name VIRTUAL_PIN ON -to powerdown_ext_pcie_compiler_0[0]
set_instance_assignment -name VIRTUAL_PIN ON -to powerdown_ext_pcie_compiler_0[1]
set_instance_assignment -name VIRTUAL_PIN ON -to txdetectrx_ext_pcie_compiler_0
set_instance_assignment -name VIRTUAL_PIN ON -to rxpolarity0_ext_pcie_compiler_0
set_instance_assignment -name VIRTUAL_PIN ON -to txcompl0_ext_pcie_compiler_0
set_instance_assignment -name VIRTUAL_PIN ON -to txelecidle0_ext_pcie_compiler_0
set_instance_assignment -name VIRTUAL_PIN ON -to txdata0_ext_pcie_compiler_0[0]
set_instance_assignment -name VIRTUAL_PIN ON -to txdata0_ext_pcie_compiler_0[1]
set_instance_assignment -name VIRTUAL_PIN ON -to txdata0_ext_pcie_compiler_0[2]
set_instance_assignment -name VIRTUAL_PIN ON -to txdata0_ext_pcie_compiler_0[3]
set_instance_assignment -name VIRTUAL_PIN ON -to txdata0_ext_pcie_compiler_0[4]
set_instance_assignment -name VIRTUAL_PIN ON -to txdata0_ext_pcie_compiler_0[5]
set_instance_assignment -name VIRTUAL_PIN ON -to txdata0_ext_pcie_compiler_0[6]
set_instance_assignment -name VIRTUAL_PIN ON -to txdata0_ext_pcie_compiler_0[7]
set_instance_assignment -name VIRTUAL_PIN ON -to txdatak0_ext_pcie_compiler_0
set_instance_assignment -name VIRTUAL_PIN ON -to reconfig_clk_pcie_compiler_0
set_instance_assignment -name VIRTUAL_PIN ON -to reconfig_togxb_pcie_compiler_0
set_instance_assignment -name VIRTUAL_PIN ON -to reconfig_fromgxb_pcie_compiler_0
set_instance_assignment -name VIRTUAL_PIN ON -to pipe_mode_pcie_compiler_0
set_global_assignment -name DO_COMBINED_ANALYSIS ON
set_global_assignment -name OPTIMIZE_HOLD_TIMING "ALL PATHS"
set_global_assignment -name PHYSICAL_SYNTHESIS_COMBO_LOGIC ON
set_global_assignment -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON
set_global_assignment -name PHYSICAL_SYNTHESIS_REGISTER_RETIMING ON
set_global_assignment -name FITTER_EFFORT "STANDARD FIT"
set_global_assignment -name PHYSICAL_SYNTHESIS_EFFORT NORMAL
set_instance_assignment -name IO_STANDARD "HCSL" -to refclk_pcie_compiler_0
set_instance_assignment -name INPUT_TERMINATION OFF -to refclk_pcie_compiler_0
set_instance_assignment -name VIRTUAL_PIN ON -to AvlClk_i
set_instance_assignment -name VIRTUAL_PIN ON -to CraAddress_i
set_instance_assignment -name VIRTUAL_PIN ON -to CraByteEnable_i
set_instance_assignment -name VIRTUAL_PIN ON -to CraChipSelect_i
set_instance_assignment -name VIRTUAL_PIN ON -to CraRead
set_instance_assignment -name VIRTUAL_PIN ON -to CraWrite
set_instance_assignment -name VIRTUAL_PIN ON -to CraWriteData_i
set_instance_assignment -name VIRTUAL_PIN ON -to RxmIrqNum_i
set_instance_assignment -name VIRTUAL_PIN ON -to RxmIrq_i
set_instance_assignment -name VIRTUAL_PIN ON -to RxmReadDataValid_i
set_instance_assignment -name VIRTUAL_PIN ON -to RxmReadData_i
set_instance_assignment -name VIRTUAL_PIN ON -to RxmWaitRequest_i
set_instance_assignment -name VIRTUAL_PIN ON -to TxsAddress_i
set_instance_assignment -name VIRTUAL_PIN ON -to TxsBurstCount_i
set_instance_assignment -name VIRTUAL_PIN ON -to TxsByteEnable_i
set_instance_assignment -name VIRTUAL_PIN ON -to TxsChipSelect_i
set_instance_assignment -name VIRTUAL_PIN ON -to TxsRead_i
set_instance_assignment -name VIRTUAL_PIN ON -to TxsWriteData_i
set_instance_assignment -name VIRTUAL_PIN ON -to TxsWrite_i
set_instance_assignment -name VIRTUAL_PIN ON -to busy_altgxb_reconfig
set_instance_assignment -name VIRTUAL_PIN ON -to cal_blk_clk
set_instance_assignment -name VIRTUAL_PIN ON -to fixedclk_serdes
set_instance_assignment -name VIRTUAL_PIN ON -to gxb_powerdown
set_instance_assignment -name VIRTUAL_PIN ON -to pcie_rstn
set_instance_assignment -name VIRTUAL_PIN ON -to phystatus_ext
set_instance_assignment -name VIRTUAL_PIN ON -to pll_powerdown
set_instance_assignment -name VIRTUAL_PIN ON -to reconfig_clk
set_instance_assignment -name VIRTUAL_PIN ON -to reconfig_togxb
set_instance_assignment -name VIRTUAL_PIN ON -to reset_n
set_instance_assignment -name VIRTUAL_PIN ON -to rxdata0_ext
set_instance_assignment -name VIRTUAL_PIN ON -to rxdatak0_ext
set_instance_assignment -name VIRTUAL_PIN ON -to rxelecidle0_ext
set_instance_assignment -name VIRTUAL_PIN ON -to rxstatus0_ext
set_instance_assignment -name VIRTUAL_PIN ON -to rxvalid0_ext
set_instance_assignment -name VIRTUAL_PIN ON -to test_in
set_instance_assignment -name VIRTUAL_PIN ON -to CraIrq_o
set_instance_assignment -name VIRTUAL_PIN ON -to CraReadData_o
set_instance_assignment -name VIRTUAL_PIN ON -to CraWaitRequest_o
set_instance_assignment -name VIRTUAL_PIN ON -to RxmAddress_o
set_instance_assignment -name VIRTUAL_PIN ON -to RxmBurstCount_o
set_instance_assignment -name VIRTUAL_PIN ON -to RxmByteEnable_o
set_instance_assignment -name VIRTUAL_PIN ON -to RxmRead_o
set_instance_assignment -name VIRTUAL_PIN ON -to RxmResetRequest_o
set_instance_assignment -name VIRTUAL_PIN ON -to RxmWriteData_o
set_instance_assignment -name VIRTUAL_PIN ON -to RxmWrite_o
set_instance_assignment -name VIRTUAL_PIN ON -to TxsReadDataValid_o
set_instance_assignment -name VIRTUAL_PIN ON -to TxsReadData_o
set_instance_assignment -name VIRTUAL_PIN ON -to TxsWaitRequest_o
set_instance_assignment -name VIRTUAL_PIN ON -to clk125_out
set_instance_assignment -name VIRTUAL_PIN ON -to clk250_out
set_instance_assignment -name VIRTUAL_PIN ON -to clk500_out
set_instance_assignment -name VIRTUAL_PIN ON -to lane_act
set_instance_assignment -name VIRTUAL_PIN ON -to ltssm
set_instance_assignment -name VIRTUAL_PIN ON -to pcie_core_clk
set_instance_assignment -name VIRTUAL_PIN ON -to powerdown_ext
set_instance_assignment -name VIRTUAL_PIN ON -to rate_ext
set_instance_assignment -name VIRTUAL_PIN ON -to rc_pll_locked
set_instance_assignment -name VIRTUAL_PIN ON -to rc_rx_digitalreset
set_instance_assignment -name VIRTUAL_PIN ON -to reconfig_fromgxb
set_instance_assignment -name VIRTUAL_PIN ON -to reset_status
set_instance_assignment -name VIRTUAL_PIN ON -to rxpolarity0_ext
set_instance_assignment -name VIRTUAL_PIN ON -to suc_spd_neg
set_instance_assignment -name VIRTUAL_PIN ON -to tl_cfg_add
set_instance_assignment -name VIRTUAL_PIN ON -to tl_cfg_ctl
set_instance_assignment -name VIRTUAL_PIN ON -to tl_cfg_ctl_wr
set_instance_assignment -name VIRTUAL_PIN ON -to tl_cfg_sts
set_instance_assignment -name VIRTUAL_PIN ON -to tl_cfg_sts_wr
set_instance_assignment -name VIRTUAL_PIN ON -to txcompl0_ext
set_instance_assignment -name VIRTUAL_PIN ON -to txdata0_ext
set_instance_assignment -name VIRTUAL_PIN ON -to txdatak0_ext
set_instance_assignment -name VIRTUAL_PIN ON -to txdetectrx_ext
set_instance_assignment -name VIRTUAL_PIN ON -to txelecidle0_ext
