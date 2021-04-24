# Nicholas Kawwas (40124338)
# COEN 313 LAB UJ-X 

# Eliminate Clock Routing Delays by Using Non Dedicated Routing Path 
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk]

# Connect Inputs sin, clk, res, shift to Switch 0, 1, 2, 3
set_property -dict {PACKAGE_PIN J15 IOSTANDARD LVCMOS33} [ get_ports { sin } ];
set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [ get_ports { clk } ];
set_property -dict {PACKAGE_PIN M13 IOSTANDARD LVCMOS33} [ get_ports { res } ];
set_property -dict {PACKAGE_PIN R15 IOSTANDARD LVCMOS33} [ get_ports { shift } ];

# Connect Outputs sum, cout to LED 0, 1, 2, 3, 4
set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVCMOS33} [ get_ports { sum[0] } ];
set_property -dict {PACKAGE_PIN K15 IOSTANDARD LVCMOS33} [ get_ports { sum[1] } ];
set_property -dict {PACKAGE_PIN J13 IOSTANDARD LVCMOS33} [ get_ports { sum[2] } ];
set_property -dict {PACKAGE_PIN N14 IOSTANDARD LVCMOS33} [ get_ports { sum[3] } ];
set_property -dict {PACKAGE_PIN R18 IOSTANDARD LVCMOS33} [ get_ports { cout } ];
