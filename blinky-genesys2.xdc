# (ab)use the single ended 60MHz clock from the ULPI PHY
set_property LOC T25 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports {clk}]

set_property LOC T28 [get_ports led]
set_property IOSTANDARD LVCMOS33 [get_ports {led}]
