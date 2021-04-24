# Nicholas Kawwas (40124338)
# COEN 313 LAB UJ-X 

# Map VHDL Synthesis to Nexys Board

# Connect Input signed_mag to Switch 0, 1, 2, 3
set_property -dict {PACKAGE_PIN J15 IOSTANDARD LVCMOS33} [ get_ports { signed_mag[0] } ];
set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVCMOS33} [ get_ports { signed_mag[1] } ];
set_property -dict {PACKAGE_PIN M13 IOSTANDARD LVCMOS33} [ get_ports { signed_mag[2] } ];
set_property -dict {PACKAGE_PIN R15 IOSTANDARD LVCMOS33} [ get_ports { signed_mag[3] } ];

# Connect Output twos_comp to LED 0, 1, 2, 3
set_property -dict {PACKAGE_PIN H17 IOSTANDARD LVCMOS33} [ get_ports { twos_comp[0] } ];
set_property -dict {PACKAGE_PIN K15 IOSTANDARD LVCMOS33} [ get_ports { twos_comp[1] } ];
set_property -dict {PACKAGE_PIN J13 IOSTANDARD LVCMOS33} [ get_ports { twos_comp[2] } ];
set_property -dict {PACKAGE_PIN N14 IOSTANDARD LVCMOS33} [ get_ports { twos_comp[3] } ];
