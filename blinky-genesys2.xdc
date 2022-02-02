# An arbitrary pin in the X0 bank
set_property LOC F22 [get_ports clkio]
set_property IOSTANDARD LVCMOS18 [get_ports {clkio}]

set_property LOC T28 [get_ports led]
set_property IOSTANDARD LVCMOS33 [get_ports {led}]
