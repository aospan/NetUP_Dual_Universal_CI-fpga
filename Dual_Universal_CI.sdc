# NetUP Universal Dual DVB-CI FPGA firmware
# http://www.netup.tv
#
# Copyright (c) 2014 NetUP Inc, AVB Labs
# License: GPLv3

#**************************************************************
# Create Clock
#**************************************************************

# Main DVB clock
create_clock -name {SYSCLK} -period "27 MHz" [get_ports {SYSCLK}]

# Frontend transport stream clocks (restricted to 25 MHz)
create_clock -name {FEA_CLOCK} -period "25 MHz" [get_ports {FEA_CLOCK}]
create_clock -name {FEB_CLOCK} -period "25 MHz" [get_ports {FEB_CLOCK}]

# CAM transport stream clocks (restricted to 25 MHz)
create_clock -name {CIA_CLOCK} -period "25 MHz" [get_ports {CIA_MCLKO}]
create_clock -name {CIB_CLOCK} -period "25 MHz" [get_ports {CIB_MCLKO}]

#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {FEA_CLOCK_v} -source [get_ports {FEA_CLOCK}]
create_generated_clock -name {FEB_CLOCK_v} -source [get_ports {FEB_CLOCK}]

create_generated_clock -name {CIA_CLOCK_v} -source [get_ports {CIA_MCLKO}]
create_generated_clock -name {CIB_CLOCK_v} -source [get_ports {CIB_MCLKO}]

derive_pll_clocks

#**************************************************************
# Set Clock Latency
#**************************************************************


#**************************************************************
# Set Clock Uncertainty
#**************************************************************

derive_clock_uncertainty

#**************************************************************
# Set Input Delay
#**************************************************************

set_input_delay -add_delay -clock_fall -clock [get_clocks {FEA_CLOCK_v}] -min -2.400 [get_ports {FEA_START FEA_VALID FEA_DATA*}]
set_input_delay -add_delay -clock_fall -clock [get_clocks {FEA_CLOCK_v}] -max 2.400 [get_ports {FEA_START FEA_VALID FEA_DATA*}]
set_input_delay -add_delay -clock_fall -clock [get_clocks {FEB_CLOCK_v}] -min -2.400 [get_ports {FEB_START FEB_VALID FEB_DATA*}]
set_input_delay -add_delay -clock_fall -clock [get_clocks {FEB_CLOCK_v}] -max 2.400 [get_ports {FEB_START FEB_VALID FEB_DATA*}]

set_input_delay -add_delay -clock_fall -clock [get_clocks {CIA_CLOCK_v}] -min -2.400 [get_ports {CIA_MOSTRT CIA_MOVAL CIA_MDO*}]
set_input_delay -add_delay -clock_fall -clock [get_clocks {CIA_CLOCK_v}] -max 2.400 [get_ports {CIA_MOSTRT CIA_MOVAL CIA_MDO*}]
set_input_delay -add_delay -clock_fall -clock [get_clocks {CIB_CLOCK_v}] -min -2.400 [get_ports {CIB_MOSTRT CIB_MOVAL CIB_MDO*}]
set_input_delay -add_delay -clock_fall -clock [get_clocks {CIB_CLOCK_v}] -max 2.400 [get_ports {CIB_MOSTRT CIB_MOVAL CIB_MDO*}]

#**************************************************************
# Set Output Delay
#**************************************************************

#**************************************************************
# Set Clock Groups
#**************************************************************

set_clock_groups -asynchronous -group [get_clocks {SYSCLK}]
set_clock_groups -asynchronous -group [get_clocks {DVB_PLL_0*clk*}]
set_clock_groups -asynchronous -group [get_clocks {GXB_PLL_0*clk*}]

set_clock_groups -asynchronous -group [get_clocks {FEA_CLOCK*}]
set_clock_groups -asynchronous -group [get_clocks {FEB_CLOCK*}]

set_clock_groups -asynchronous -group [get_clocks {CIA_CLOCK*}]
set_clock_groups -asynchronous -group [get_clocks {CIB_CLOCK*}]

#**************************************************************
# Set False Path
#**************************************************************

set_false_path -from [get_ports {nPERST}]

set_false_path -from [get_ports {FE?_nIRQ*}]

set_false_path -from [get_ports {CI?_nIREQ CI?_nWAIT CI?_nCD?}]

set_false_path -to [get_ports {IIC?_SCL IIC?_SDA}]
set_false_path -from [get_ports {IIC?_SCL IIC?_SDA}]

set_false_path -to [get_ports {RF?_CTL FE*_nRST}]

set_false_path -to [get_ports {LED*}]

#**************************************************************
# Set Multicycle Path
#**************************************************************

#**************************************************************
# Set Maximum Skew
#**************************************************************

#**************************************************************
# Set Maximum Delay
#**************************************************************

#**************************************************************
# Set Minimum Delay
#**************************************************************

#**************************************************************
# Set Input Transition
#**************************************************************
