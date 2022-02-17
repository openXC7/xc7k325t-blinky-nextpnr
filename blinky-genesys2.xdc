# Use an external TCXO for now (connected to JB)
set_property LOC T25 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports {clk}]

set_property LOC T28 [get_ports led]
set_property IOSTANDARD LVCMOS33 [get_ports {led}]

# We follow the bizarre Digilent convention here that uart_rx is the output rather than the receiver
set_property LOC Y23 [get_ports {uart_rx_out}]
set_property IOSTANDARD LVCMOS33 [get_ports {uart_rx_out}]

set_property LOC Y20 [get_ports {uart_tx_in}]
set_property IOSTANDARD LVCMOS33 [get_ports {uart_tx_in}]

