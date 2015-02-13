# NetUP Universal Dual DVB-CI FPGA firmware
# http://www.netup.tv
#
# Copyright (c) 2014 NetUP Inc, AVB Labs
# License: GPLv3

# $Id$

post_message "Removing all I/O pins assignments.."

remove_all_instance_assignments -name LOCATION
remove_all_instance_assignments -name RESERVE_PIN
remove_all_instance_assignments -name IO_STANDARD 
remove_all_instance_assignments -name WEAK_PULL_UP_RESISTOR
remove_all_instance_assignments -name SLEW_RATE
remove_all_instance_assignments -name OUTPUT_TERMINATION
remove_all_instance_assignments -name CURRENT_STRENGTH_NEW
remove_all_instance_assignments -name PCI_IO
remove_all_instance_assignments -name TREAT_BIDIR_AS_OUTPUT
remove_all_instance_assignments -name FAST_INPUT_REGISTER
remove_all_instance_assignments -name FAST_OUTPUT_REGISTER
remove_all_instance_assignments -name FAST_OUTPUT_ENABLE_REGISTER
remove_all_instance_assignments -name GLOBAL_SIGNAL
remove_all_instance_assignments -name ENABLE_BUS_HOLD_CIRCUITRY
remove_all_instance_assignments -name PLL_COMPENSATE
remove_all_instance_assignments -name CLOCK_TO_OUTPUT_DELAY
remove_all_instance_assignments -name OUTPUT_ENABLE_DELAY
remove_all_instance_assignments -name PAD_TO_INPUT_REGISTER_DELAY
remove_all_instance_assignments -name PAD_TO_CORE_DELAY

#
# add source files
#
post_message "Source files.."

remove_all_global_assignments -name SDC_FILE
remove_all_global_assignments -name QIP_FILE
remove_all_global_assignments -name VHDL_FILE
remove_all_global_assignments -name VERILOG_FILE

set_global_assignment -name VERILOG_FILE "ip_compiler_for_pci_express-library/altpcie_rs_serdes.v"
set_global_assignment -name VERILOG_FILE "ip_compiler_for_pci_express-library/altpcie_reconfig_3cgx.v"
set_global_assignment -name VHDL_FILE pcie_compiler_0_serdes.vhd
set_global_assignment -name QIP_FILE dvb_dma_fifo_ram.qip
set_global_assignment -name QIP_FILE unici_core.qip
set_global_assignment -name SDC_FILE Dual_Universal_CI.sdc
set_global_assignment -name VHDL_FILE dvb_ts_sync.vhd
set_global_assignment -name QIP_FILE gxb_pll.qip
set_global_assignment -name QIP_FILE dvb_pll.qip
set_global_assignment -name VHDL_FILE pipeline_bridge_0.vhd
set_global_assignment -name VHDL_FILE unici_core_burst_0.vhd
set_global_assignment -name VHDL_FILE unici_core_burst_1.vhd
set_global_assignment -name VHDL_FILE unici_core.vhd
set_global_assignment -name VHDL_FILE Dual_Universal_CI.vhd

post_message "Make I/O pins assignments.."

#
# global project assignments
#
post_message "Global assignments.."

set_global_assignment -name PROJECT_OUTPUT_DIRECTORY out
set_global_assignment -name PROJECT_SHOW_ENTITY_NAME ON
set_global_assignment -name VHDL_INPUT_VERSION VHDL_2008
set_global_assignment -name HDL_MESSAGE_LEVEL Level3
set_global_assignment -name NUM_PARALLEL_PROCESSORS 1
set_global_assignment -name OPTIMIZE_POWER_DURING_FITTING OFF

set_global_assignment -name SYNCHRONIZER_IDENTIFICATION AUTO
set_instance_assignment -name SYNCHRONIZER_IDENTIFICATION FORCED -to *_meta*

set_global_assignment -name DEVICE EP4CGX22CF19C8
set_global_assignment -name DEVICE_MIGRATION_LIST "EP4CGX22CF19C8,EP4CGX30CF19C8"
set_global_assignment -name RESERVE_ALL_UNUSED_PINS_WEAK_PULLUP "AS OUTPUT DRIVING GROUND"

set_global_assignment -name CYCLONEIII_CONFIGURATION_SCHEME "ACTIVE SERIAL"
set_global_assignment -name ACTIVE_SERIAL_CLOCK FREQ_40MHZ
set_global_assignment -name USE_CONFIGURATION_DEVICE OFF
set_global_assignment -name ON_CHIP_BITSTREAM_DECOMPRESSION ON
set_global_assignment -name CONFIGURATION_VCCIO_LEVEL 3.3V
set_global_assignment -name FORCE_CONFIGURATION_VCCIO ON
set_global_assignment -name CYCLONEII_RESERVE_NCEO_AFTER_CONFIGURATION "USE AS REGULAR IO"
set_global_assignment -name RESERVE_DATA0_AFTER_CONFIGURATION "USE AS REGULAR IO"
set_global_assignment -name RESERVE_DATA1_AFTER_CONFIGURATION "USE AS REGULAR IO"
set_global_assignment -name RESERVE_DATA7_THROUGH_DATA2_AFTER_CONFIGURATION "USE AS REGULAR IO"
set_global_assignment -name RESERVE_FLASH_NCE_AFTER_CONFIGURATION "USE AS REGULAR IO"
set_global_assignment -name RESERVE_DCLK_AFTER_CONFIGURATION "USE AS REGULAR IO"

set_global_assignment -name MESSAGE_DISABLE 176674
set_global_assignment -name MESSAGE_DISABLE 169180
set_global_assignment -name MESSAGE_DISABLE 169203
set_global_assignment -name MESSAGE_DISABLE 169177

#
# reserved pins
#
post_message "Reserved pins.."

#
# global pins
#
post_message "Global pins.."

set_location_assignment PIN_C16 -to nPERST
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to nPERST
set_instance_assignment -name GLOBAL_SIGNAL OFF -to nPERST

set_location_assignment PIN_K17 -to SYSCLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SYSCLK
set_instance_assignment -name GLOBAL_SIGNAL OFF -to SYSCLK

#
# PCI-E interface
#
post_message "PCI-E pins.."

set_location_assignment PIN_G10 -to PCI_REFCLK
set_location_assignment PIN_G9 -to PCI_REFCLK(n)
set_instance_assignment -name IO_STANDARD HCSL -to PCI_REFCLK

set_location_assignment PIN_T2 -to PCI_PER0
set_location_assignment PIN_T1 -to PCI_PER0(n)
set_instance_assignment -name IO_STANDARD "1.5-V PCML" -to PCI_PER0
set_instance_assignment -name INPUT_TERMINATION "OCT 100 Ohms" -to PCI_PER0

set_location_assignment PIN_P2 -to PCI_PET0
set_location_assignment PIN_P1 -to PCI_PET0(n)
set_instance_assignment -name IO_STANDARD "1.5-V PCML" -to PCI_PET0

#
# I2C ports
#
post_message "I2C ports pins.."

set_location_assignment PIN_R9 -to IIC0_SCL
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to IIC0_SCL
set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to IIC0_SCL

set_location_assignment PIN_R8 -to IIC0_SDA
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to IIC0_SDA
set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to IIC0_SDA

set_location_assignment PIN_P6 -to IIC1_SCL
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to IIC1_SCL
set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to IIC1_SCL

set_location_assignment PIN_R6 -to IIC1_SDA
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to IIC1_SDA
set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to IIC1_SDA

#
# Boot Flash
#
post_message "Boot Flash pins.."

set_location_assignment PIN_C5 -to FLASH_nCS
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_nCS
set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to FLASH_nCS

set_location_assignment PIN_D5 -to FLASH_SCLK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_SCLK
set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to FLASH_SCLK

set_location_assignment PIN_A4 -to FLASH_MISO
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_MISO
set_instance_assignment -name WEAK_PULL_UP_RESISTOR "ON" -to FLASH_MISO

set_location_assignment PIN_B4 -to FLASH_MOSI
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FLASH_MOSI
set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to FLASH_MOSI

#
# DVB Frontend #1
#
post_message "Frontend A pins.."

set_location_assignment PIN_M10 -to FEA_CLOCK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FEA_CLOCK

set_location_assignment PIN_V10 -to FEA_START
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FEA_START
set_instance_assignment -name FAST_INPUT_REGISTER ON -to FEA_START

set_location_assignment PIN_V9 -to FEA_VALID
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FEA_VALID
set_instance_assignment -name FAST_INPUT_REGISTER ON -to FEA_VALID

set_location_assignment PIN_T12 -to FEA_DATA[0]
set_location_assignment PIN_U12 -to FEA_DATA[1]
set_location_assignment PIN_R11 -to FEA_DATA[2]
set_location_assignment PIN_T11 -to FEA_DATA[3]
set_location_assignment PIN_P10 -to FEA_DATA[4]
set_location_assignment PIN_R10 -to FEA_DATA[5]
set_location_assignment PIN_T10 -to FEA_DATA[6]
set_location_assignment PIN_U10 -to FEA_DATA[7]
for {set i 0} {$i < 8} {incr i} {
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FEA_DATA[$i]
	set_instance_assignment -name FAST_INPUT_REGISTER ON -to FEA_DATA[$i]
}

#
# DVB Frontend #2
#
post_message "Frontend B pins.."

set_location_assignment PIN_M9 -to FEB_CLOCK
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FEB_CLOCK

set_location_assignment PIN_V6 -to FEB_START
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FEB_START
set_instance_assignment -name FAST_INPUT_REGISTER ON -to FEB_START

set_location_assignment PIN_U6 -to FEB_VALID
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FEB_VALID
set_instance_assignment -name FAST_INPUT_REGISTER ON -to FEB_VALID

set_location_assignment PIN_V8 -to FEB_DATA[0]
set_location_assignment PIN_T8 -to FEB_DATA[1]
set_location_assignment PIN_V7 -to FEB_DATA[2]
set_location_assignment PIN_U7 -to FEB_DATA[3]
set_location_assignment PIN_T7 -to FEB_DATA[4]
set_location_assignment PIN_R7 -to FEB_DATA[5]
set_location_assignment PIN_N7 -to FEB_DATA[6]
set_location_assignment PIN_N6 -to FEB_DATA[7]
for {set i 0} {$i < 8} {incr i} {
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FEB_DATA[$i]
	set_instance_assignment -name FAST_INPUT_REGISTER ON -to FEB_DATA[$i]
}

#
# DVB CI common pins
#
post_message "DVB CI common pins.."

set_location_assignment PIN_D14 -to CI_ADDR[0]
set_location_assignment PIN_A15 -to CI_ADDR[1]
set_location_assignment PIN_B15 -to CI_ADDR[2]
set_location_assignment PIN_B16 -to CI_ADDR[3]
set_location_assignment PIN_A17 -to CI_ADDR[4]
set_location_assignment PIN_A18 -to CI_ADDR[5]
set_location_assignment PIN_C15 -to CI_ADDR[6]
set_location_assignment PIN_D15 -to CI_ADDR[7]
set_location_assignment PIN_E16 -to CI_ADDR[8]
set_location_assignment PIN_F15 -to CI_ADDR[9]
set_location_assignment PIN_F17 -to CI_ADDR[10]
set_location_assignment PIN_F16 -to CI_ADDR[11]
set_location_assignment PIN_D16 -to CI_ADDR[12]
set_location_assignment PIN_E15 -to CI_ADDR[13]
set_location_assignment PIN_D17 -to CI_ADDR[14]
for {set i 0} {$i < 15} {incr i} {
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CI_ADDR[$i]
	set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to CI_ADDR[$i]
	set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to CI_ADDR[$i]
	set_instance_assignment -name CLOCK_TO_OUTPUT_DELAY 0 -to CI_ADDR[$i]
}

set_location_assignment PIN_P18 -to CI_DATA[0]
set_location_assignment PIN_N18 -to CI_DATA[1]
set_location_assignment PIN_N17 -to CI_DATA[2]
set_location_assignment PIN_T18 -to CI_DATA[3]
set_location_assignment PIN_R16 -to CI_DATA[4]
set_location_assignment PIN_R17 -to CI_DATA[5]
set_location_assignment PIN_R18 -to CI_DATA[6]
set_location_assignment PIN_P16 -to CI_DATA[7]
for {set i 0} {$i < 8} {incr i} {
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CI_DATA[$i]
	set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to CI_DATA[$i]
	set_instance_assignment -name ENABLE_BUS_HOLD_CIRCUITRY ON -to CI_DATA[$i]
	set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to CI_DATA[$i]
	set_instance_assignment -name FAST_OUTPUT_ENABLE_REGISTER ON -to CI_DATA[$i]
	set_instance_assignment -name FAST_INPUT_REGISTER ON -to CI_DATA[$i]
	set_instance_assignment -name CLOCK_TO_OUTPUT_DELAY 0 -to CI_DATA[$i]
	set_instance_assignment -name OUTPUT_ENABLE_DELAY 0 -to CI_DATA[$i]
	set_instance_assignment -name PAD_TO_INPUT_REGISTER_DELAY 0 -to CI_DATA[$i]
}

set_location_assignment PIN_A16 -to CI_nREG
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CI_nREG
set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to CI_nREG
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to CI_nREG
set_instance_assignment -name CLOCK_TO_OUTPUT_DELAY 0 -to CI_nREG

set_location_assignment PIN_B7 -to CI_nIOWR
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CI_nIOWR
set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to CI_nIOWR
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to CI_nIOWR
set_instance_assignment -name CLOCK_TO_OUTPUT_DELAY 0 -to CI_nIOWR

set_location_assignment PIN_C7 -to CI_nIORD
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CI_nIORD
set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to CI_nIORD
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to CI_nIORD
set_instance_assignment -name CLOCK_TO_OUTPUT_DELAY 0 -to CI_nIORD

set_location_assignment PIN_A7 -to CI_nWR
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CI_nWR
set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to CI_nWR
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to CI_nWR
set_instance_assignment -name CLOCK_TO_OUTPUT_DELAY 0 -to CI_nWR

set_location_assignment PIN_D7 -to CI_nOE
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CI_nOE
set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to CI_nOE
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to CI_nOE
set_instance_assignment -name CLOCK_TO_OUTPUT_DELAY 0 -to CI_nOE

set_location_assignment PIN_U18 -to CI_BUS_DIR
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CI_BUS_DIR
set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to CI_BUS_DIR
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to CI_BUS_DIR
set_instance_assignment -name CLOCK_TO_OUTPUT_DELAY 0 -to CI_BUS_DIR

#
# DVB CI A pins
#
post_message "DVB CI port A pins.."

set_location_assignment PIN_C6 -to CIA_RST
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CIA_RST
set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to CIA_RST
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to CIA_RST
set_instance_assignment -name CLOCK_TO_OUTPUT_DELAY 0 -to CIA_RST

set_location_assignment PIN_B5 -to CIA_nRSTEN
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CIA_nRSTEN
set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to CIA_nRSTEN
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to CIA_nRSTEN
set_instance_assignment -name CLOCK_TO_OUTPUT_DELAY 0 -to CIA_nRSTEN

set_location_assignment PIN_B6 -to CIA_nCE1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CIA_nCE1
set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to CIA_nCE1
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to CIA_nCE1
set_instance_assignment -name CLOCK_TO_OUTPUT_DELAY 0 -to CIA_nCE1

set_location_assignment PIN_T17 -to CIA_nBUS_OE
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CIA_nBUS_OE
set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to CIA_nBUS_OE
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to CIA_nBUS_OE
set_instance_assignment -name CLOCK_TO_OUTPUT_DELAY 0 -to CIA_nBUS_OE

set_location_assignment PIN_G17 -to CIA_nIREQ
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CIA_nIREQ
set_instance_assignment -name FAST_INPUT_REGISTER ON -to CIA_nIREQ
set_instance_assignment -name PAD_TO_INPUT_REGISTER_DELAY 0 -to CIA_nIREQ

set_location_assignment PIN_G16 -to CIA_nWAIT
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CIA_nWAIT
set_instance_assignment -name FAST_INPUT_REGISTER ON -to CIA_nWAIT
set_instance_assignment -name PAD_TO_INPUT_REGISTER_DELAY 0 -to CIA_nWAIT

set_location_assignment PIN_M16 -to CIA_nCD1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CIA_nCD1
set_instance_assignment -name FAST_INPUT_REGISTER ON -to CIA_nCD1
set_instance_assignment -name PAD_TO_INPUT_REGISTER_DELAY 0 -to CIA_nCD1

set_location_assignment PIN_F18 -to CIA_nCD2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CIA_nCD2
set_instance_assignment -name FAST_INPUT_REGISTER ON -to CIA_nCD2
set_instance_assignment -name PAD_TO_INPUT_REGISTER_DELAY 0 -to CIA_nCD2

set_location_assignment PIN_D13 -to CIA_MCLKI
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CIA_MCLKI
set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to CIA_MCLKI
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to CIA_MCLKI
set_instance_assignment -name CLOCK_TO_OUTPUT_DELAY 0 -to CIA_MCLKI

set_location_assignment PIN_C8 -to CIA_MISTRT
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CIA_MISTRT
set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to CIA_MISTRT
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to CIA_MISTRT
set_instance_assignment -name CLOCK_TO_OUTPUT_DELAY 0 -to CIA_MISTRT

set_location_assignment PIN_B13 -to CIA_MIVAL
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CIA_MIVAL
set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to CIA_MIVAL
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to CIA_MIVAL
set_instance_assignment -name CLOCK_TO_OUTPUT_DELAY 0 -to CIA_MIVAL

set_location_assignment PIN_D9 -to CIA_MDI[0]
set_location_assignment PIN_A9 -to CIA_MDI[1]
set_location_assignment PIN_B10 -to CIA_MDI[2]
set_location_assignment PIN_A11 -to CIA_MDI[3]
set_location_assignment PIN_A13 -to CIA_MDI[4]
set_location_assignment PIN_C13 -to CIA_MDI[5]
set_location_assignment PIN_A14 -to CIA_MDI[6]
set_location_assignment PIN_C14 -to CIA_MDI[7]
for {set i 0} {$i < 8} {incr i} {
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CIA_MDI[$i]
	set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to CIA_MDI[$i]
	set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to CIA_MDI[$i]
	set_instance_assignment -name CLOCK_TO_OUTPUT_DELAY 0 -to CIA_MDI[$i]
}

set_location_assignment PIN_J18 -to CIA_MCLKO
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CIA_MCLKO

set_location_assignment PIN_J17 -to CIA_MOSTRT
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CIA_MOSTRT
set_instance_assignment -name FAST_INPUT_REGISTER ON -to CIA_MOSTRT
set_instance_assignment -name PAD_TO_INPUT_REGISTER_DELAY 0 -to CIA_MOSTRT

set_location_assignment PIN_K16 -to CIA_MOVAL
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CIA_MOVAL
set_instance_assignment -name FAST_INPUT_REGISTER ON -to CIA_MOVAL
set_instance_assignment -name PAD_TO_INPUT_REGISTER_DELAY 0 -to CIA_MOVAL

set_location_assignment PIN_J16 -to CIA_MDO[0]
set_location_assignment PIN_H16 -to CIA_MDO[1]
set_location_assignment PIN_G18 -to CIA_MDO[2]
set_location_assignment PIN_M17 -to CIA_MDO[3]
set_location_assignment PIN_M18 -to CIA_MDO[4]
set_location_assignment PIN_L15 -to CIA_MDO[5]
set_location_assignment PIN_L18 -to CIA_MDO[6]
set_location_assignment PIN_K15 -to CIA_MDO[7]
for {set i 0} {$i < 8} {incr i} {
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CIA_MDO[$i]
	set_instance_assignment -name FAST_INPUT_REGISTER ON -to CIA_MDO[$i]
	set_instance_assignment -name PAD_TO_INPUT_REGISTER_DELAY 0 -to CIA_MDO[$i]
}

#
# DVB CI B pins
#
post_message "DVB CI port B pins.."

set_location_assignment PIN_D6 -to CIB_RST
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CIB_RST
set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to CIB_RST
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to CIB_RST
set_instance_assignment -name CLOCK_TO_OUTPUT_DELAY 0 -to CIB_RST

set_location_assignment PIN_A5 -to CIB_nRSTEN
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CIB_nRSTEN
set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to CIB_nRSTEN
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to CIB_nRSTEN
set_instance_assignment -name CLOCK_TO_OUTPUT_DELAY 0 -to CIB_nRSTEN

set_location_assignment PIN_A6 -to CIB_nCE1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CIB_nCE1
set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to CIB_nCE1
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to CIB_nCE1
set_instance_assignment -name CLOCK_TO_OUTPUT_DELAY 0 -to CIB_nCE1

set_location_assignment PIN_V17 -to CIB_nBUS_OE
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CIB_nBUS_OE
set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to CIB_nBUS_OE
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to CIB_nBUS_OE
set_instance_assignment -name CLOCK_TO_OUTPUT_DELAY 0 -to CIB_nBUS_OE

set_location_assignment PIN_R12 -to CIB_nIREQ
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CIB_nIREQ
set_instance_assignment -name FAST_INPUT_REGISTER ON -to CIB_nIREQ
set_instance_assignment -name PAD_TO_INPUT_REGISTER_DELAY 0 -to CIB_nIREQ

set_location_assignment PIN_V13 -to CIB_nWAIT
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CIB_nWAIT
set_instance_assignment -name FAST_INPUT_REGISTER ON -to CIB_nWAIT
set_instance_assignment -name PAD_TO_INPUT_REGISTER_DELAY 0 -to CIB_nWAIT

set_location_assignment PIN_V18 -to CIB_nCD1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CIB_nCD1
set_instance_assignment -name FAST_INPUT_REGISTER ON -to CIB_nCD1
set_instance_assignment -name PAD_TO_INPUT_REGISTER_DELAY 0 -to CIB_nCD1

set_location_assignment PIN_U13 -to CIB_nCD2
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CIB_nCD2
set_instance_assignment -name FAST_INPUT_REGISTER ON -to CIB_nCD2
set_instance_assignment -name PAD_TO_INPUT_REGISTER_DELAY 0 -to CIB_nCD2

set_location_assignment PIN_D11 -to CIB_MCLKI
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CIB_MCLKI
set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to CIB_MCLKI
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to CIB_MCLKI
set_instance_assignment -name CLOCK_TO_OUTPUT_DELAY 0 -to CIB_MCLKI

set_location_assignment PIN_A8 -to CIB_MISTRT
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CIB_MISTRT
set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to CIB_MISTRT
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to CIB_MISTRT
set_instance_assignment -name CLOCK_TO_OUTPUT_DELAY 0 -to CIB_MISTRT

set_location_assignment PIN_C11 -to CIB_MIVAL
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CIB_MIVAL
set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to CIB_MIVAL
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to CIB_MIVAL
set_instance_assignment -name CLOCK_TO_OUTPUT_DELAY 0 -to CIB_MIVAL

set_location_assignment PIN_C9 -to CIB_MDI[0]
set_location_assignment PIN_B9 -to CIB_MDI[1]
set_location_assignment PIN_C10 -to CIB_MDI[2]
set_location_assignment PIN_A10 -to CIB_MDI[3]
set_location_assignment PIN_D10 -to CIB_MDI[4]
set_location_assignment PIN_E10 -to CIB_MDI[5]
set_location_assignment PIN_C12 -to CIB_MDI[6]
set_location_assignment PIN_D12 -to CIB_MDI[7]
for {set i 0} {$i < 8} {incr i} {
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CIB_MDI[$i]
	set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to CIB_MDI[$i]
	set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to CIB_MDI[$i]
	set_instance_assignment -name CLOCK_TO_OUTPUT_DELAY 0 -to CIB_MDI[$i]
}

set_location_assignment PIN_V11 -to CIB_MCLKO
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CIB_MCLKO

set_location_assignment PIN_V14 -to CIB_MOSTRT
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CIB_MOSTRT
set_instance_assignment -name FAST_INPUT_REGISTER ON -to CIB_MOSTRT
set_instance_assignment -name PAD_TO_INPUT_REGISTER_DELAY 0 -to CIB_MOSTRT

set_location_assignment PIN_T14 -to CIB_MOVAL
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CIB_MOVAL
set_instance_assignment -name FAST_INPUT_REGISTER ON -to CIB_MOVAL
set_instance_assignment -name PAD_TO_INPUT_REGISTER_DELAY 0 -to CIB_MOVAL

set_location_assignment PIN_P13 -to CIB_MDO[0]
set_location_assignment PIN_R13 -to CIB_MDO[1]
set_location_assignment PIN_T13 -to CIB_MDO[2]
set_location_assignment PIN_T16 -to CIB_MDO[3]
set_location_assignment PIN_U16 -to CIB_MDO[4]
set_location_assignment PIN_V16 -to CIB_MDO[5]
set_location_assignment PIN_U15 -to CIB_MDO[6]
set_location_assignment PIN_V15 -to CIB_MDO[7]
for {set i 0} {$i < 8} {incr i} {
	set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to CIB_MDO[$i]
	set_instance_assignment -name FAST_INPUT_REGISTER ON -to CIB_MDO[$i]
	set_instance_assignment -name PAD_TO_INPUT_REGISTER_DELAY 0 -to CIB_MDO[$i]
}

#
# LEDs and GPIOs
#
post_message "LEDs and GPIOs.."

set_location_assignment PIN_P15 -to LED0_GRN
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED0_GRN
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to LED0_GRN
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to LED0_GRN
set_instance_assignment -name CLOCK_TO_OUTPUT_DELAY 0 -to LED0_GRN

set_location_assignment PIN_N15 -to LED0_RED
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED0_RED
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to LED0_RED
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to LED0_RED
set_instance_assignment -name CLOCK_TO_OUTPUT_DELAY 0 -to LED0_RED

set_location_assignment PIN_L16 -to LED1_GRN
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED1_GRN
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to LED1_GRN
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to LED1_GRN
set_instance_assignment -name CLOCK_TO_OUTPUT_DELAY 0 -to LED1_GRN

set_location_assignment PIN_G15 -to LED1_RED
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to LED1_RED
set_instance_assignment -name CURRENT_STRENGTH_NEW "MAXIMUM CURRENT" -to LED1_RED
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to LED1_RED
set_instance_assignment -name CLOCK_TO_OUTPUT_DELAY 0 -to LED1_RED

set_location_assignment PIN_N16 -to LED_RSRV0
set_instance_assignment -name RESERVE_PIN "AS INPUT TRI-STATED" -to LED_RSRV0
set_instance_assignment -name WEAK_PULL_UP_RESISTOR "ON" -to LED_RSRV0

set_location_assignment PIN_E18 -to LED_RSRV1
set_instance_assignment -name RESERVE_PIN "AS INPUT TRI-STATED" -to LED_RSRV1
set_instance_assignment -name WEAK_PULL_UP_RESISTOR "ON" -to LED_RSRV1

set_location_assignment PIN_T9 -to RFA_CTL
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to RFA_CTL
set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to RFA_CTL
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to RFA_CTL
set_instance_assignment -name CLOCK_TO_OUTPUT_DELAY 0 -to RFA_CTL

set_location_assignment PIN_R14 -to FEA_nRST
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FEA_nRST
set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to FEA_nRST
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to FEA_nRST
set_instance_assignment -name CLOCK_TO_OUTPUT_DELAY 0 -to FEA_nRST

set_location_assignment PIN_R15 -to FEA_TU_nRST
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FEA_TU_nRST
set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to FEA_TU_nRST
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to FEA_TU_nRST
set_instance_assignment -name CLOCK_TO_OUTPUT_DELAY 0 -to FEA_TU_nRST

set_location_assignment PIN_T15 -to FEA_nIRQ0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FEA_nIRQ0
set_instance_assignment -name FAST_INPUT_REGISTER ON -to FEA_nIRQ0
set_instance_assignment -name PAD_TO_INPUT_REGISTER_DELAY 0 -to FEA_nIRQ0

set_location_assignment PIN_U9 -to FEA_nIRQ1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FEA_nIRQ1
set_instance_assignment -name FAST_INPUT_REGISTER ON -to FEA_nIRQ1
set_instance_assignment -name PAD_TO_INPUT_REGISTER_DELAY 0 -to FEA_nIRQ1

set_location_assignment PIN_V5 -to RFB_CTL
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to RFB_CTL
set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to RFB_CTL
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to RFB_CTL
set_instance_assignment -name CLOCK_TO_OUTPUT_DELAY 0 -to RFB_CTL

set_location_assignment PIN_T6 -to FEB_nRST
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FEB_nRST
set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to FEB_nRST
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to FEB_nRST
set_instance_assignment -name CLOCK_TO_OUTPUT_DELAY 0 -to FEB_nRST

set_location_assignment PIN_P12 -to FEB_TU_nRST
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FEB_TU_nRST
set_instance_assignment -name CURRENT_STRENGTH_NEW Default -to FEB_TU_nRST
set_instance_assignment -name FAST_OUTPUT_REGISTER ON -to FEB_TU_nRST
set_instance_assignment -name CLOCK_TO_OUTPUT_DELAY 0 -to FEB_TU_nRST

set_location_assignment PIN_N5 -to FEB_nIRQ0
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FEB_nIRQ0
set_instance_assignment -name FAST_INPUT_REGISTER ON -to FEB_nIRQ0
set_instance_assignment -name PAD_TO_INPUT_REGISTER_DELAY 0 -to FEB_nIRQ0

set_location_assignment PIN_M7 -to FEB_nIRQ1
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to FEB_nIRQ1
set_instance_assignment -name FAST_INPUT_REGISTER ON -to FEB_nIRQ1
set_instance_assignment -name PAD_TO_INPUT_REGISTER_DELAY 0 -to FEB_nIRQ1

#
# CI power control
#
post_message "CI power control.."

set_location_assignment PIN_C18 -to SW_nEN[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW_nEN[0]
set_instance_assignment -name RESERVE_PIN "AS OUTPUT DRIVING GROUND" -to SW_nEN[0]

set_location_assignment PIN_C17 -to SW_nEN[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW_nEN[1]
set_instance_assignment -name RESERVE_PIN "AS OUTPUT DRIVING GROUND" -to SW_nEN[1]

set_location_assignment PIN_D18 -to SW_nOC[0]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW_nOC[0]
set_instance_assignment -name FAST_INPUT_REGISTER ON -to SW_nOC[0]
set_instance_assignment -name PAD_TO_INPUT_REGISTER_DELAY 0 -to SW_nOC[0]
set_instance_assignment -name WEAK_PULL_UP_RESISTOR "ON" -to SW_nOC[0]

set_location_assignment PIN_B18 -to SW_nOC[1]
set_instance_assignment -name IO_STANDARD "3.3-V LVTTL" -to SW_nOC[1]
set_instance_assignment -name FAST_INPUT_REGISTER ON -to SW_nOC[1]
set_instance_assignment -name PAD_TO_INPUT_REGISTER_DELAY 0 -to SW_nOC[1]
set_instance_assignment -name WEAK_PULL_UP_RESISTOR "ON" -to SW_nOC[1]

post_message "I/O assignments completed"

post_message "all done."
