# An arbitrary pin in the X0 bank
set_property LOC R19 [get_ports clkio]
set_property IOSTANDARD LVCMOS33 [get_ports {clkio}]

## LEDs
set_property PACKAGE_PIN T28  [get_ports led[0]]
set_property PACKAGE_PIN V19  [get_ports led[1]]
set_property PACKAGE_PIN U30  [get_ports led[2]]
set_property PACKAGE_PIN U29  [get_ports led[3]]
set_property PACKAGE_PIN V20  [get_ports led[4]]
set_property PACKAGE_PIN V26  [get_ports led[5]]
set_property PACKAGE_PIN W24  [get_ports led[6]]
set_property PACKAGE_PIN W23  [get_ports led[7]]

set_property  IOSTANDARD LVCMOS33 [get_ports led[0]]
set_property  IOSTANDARD LVCMOS33 [get_ports led[1]]
set_property  IOSTANDARD LVCMOS33 [get_ports led[2]]
set_property  IOSTANDARD LVCMOS33 [get_ports led[3]]
set_property  IOSTANDARD LVCMOS33 [get_ports led[4]]
set_property  IOSTANDARD LVCMOS33 [get_ports led[5]]
set_property  IOSTANDARD LVCMOS33 [get_ports led[6]]
set_property  IOSTANDARD LVCMOS33 [get_ports led[7]]

## Switches
set_property  PACKAGE_PIN G19 [get_ports  sw[0] ]
set_property  PACKAGE_PIN G25 [get_ports  sw[1] ]
set_property  PACKAGE_PIN H24 [get_ports  sw[2] ]
set_property  PACKAGE_PIN K19 [get_ports  sw[3] ]
set_property  PACKAGE_PIN N19 [get_ports  sw[4] ]
set_property  PACKAGE_PIN P19 [get_ports  sw[5] ]
set_property  PACKAGE_PIN P26 [get_ports  sw[6] ]
set_property  PACKAGE_PIN P27 [get_ports  sw[7] ]

set_property     IOSTANDARD LVCMOS12 [get_ports  sw[0] ]
set_property     IOSTANDARD LVCMOS12 [get_ports  sw[1] ]
set_property     IOSTANDARD LVCMOS12 [get_ports  sw[2] ]
set_property     IOSTANDARD LVCMOS12 [get_ports  sw[3] ]
set_property     IOSTANDARD LVCMOS12 [get_ports  sw[4] ]
set_property     IOSTANDARD LVCMOS12 [get_ports  sw[5] ]
set_property     IOSTANDARD LVCMOS33 [get_ports  sw[6] ]
set_property     IOSTANDARD LVCMOS33 [get_ports  sw[7] ]
## centre button
set_property PACKAGE_PIN E18 [get_ports btnc ]
set_property IOSTANDARD LVCMOS12 [get_ports btnc ]
