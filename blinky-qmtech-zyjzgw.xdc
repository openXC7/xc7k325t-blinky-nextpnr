set_property LOC F22 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports {clk}]

##### Daughter board LEDs #####

# LED3_FPGA BANK14_E25
set_property LOC E25 [get_ports led]
set_property IOSTANDARD LVCMOS33 [get_ports {led}]

# LED4_FPGA BANK16_C14
# set_property LOC C14 [get_ports led]
# set_property IOSTANDARD LVCMOS33 [get_ports {led}]

# LED5_FPGA BANK16_B14
# set_property LOC B14 [get_ports led]
# set_property IOSTANDARD LVCMOS33 [get_ports {led}]
