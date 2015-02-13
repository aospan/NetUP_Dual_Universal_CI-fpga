# The refclk assignment may need to be renamed to match design top level port name.
# May be desireable to move refclk assignment to a top level SDC file.
create_clock -period "100 MHz" -name {refclk_pcie_compiler_0} {PCI_REFCLK}
#create_clock -period "27 MHz" -name {fixedclk} {SYSCLK}
# testin bits are either static or treated asynchronously, cut the paths.
#set_false_path -to [get_pins -hierarchical {*hssi_pcie_hip|testin[*]} ]
# SERDES reconfig busy input is asynchronous
set_false_path -to [get_keepers {*|pcie_compiler_0:*|altpcie_rs_serdes:rs_serdes|busy_altgxb_reconfig_r[0]}]
