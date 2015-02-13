# NetUP Universal Dual DVB-CI FPGA firmware
# http://www.netup.tv
#
# Copyright (c) 2014 NetUP Inc, AVB Labs
# License: GPLv3

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

post_message "done"
