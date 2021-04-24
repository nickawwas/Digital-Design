# Nicholas Kawwas (40124338)
# COEN 313 LAB UJ-X
# Sum of Min Terms Circuit Mapping to FPGA

# XDC Maps VHDL Synthesis to Nexys Board

# Connect Inputs A, B, C to Switches 0, 1, 2
set_property -dict { PACKAGE_PIN J15 IOSTANDARD LVCMOS33 } [ get_ports { a }  ] ;
set_property -dict { PACKAGE_PIN L16 IOSTANDARD LVCMOS33 } [ get_ports { b }  ] ;
set_property -dict { PACKAGE_PIN M13 IOSTANDARD LVCMOS33 } [ get_ports { c }  ] ;

# Connect Output Y to LED 0
set_property -dict { PACKAGE_PIN H17 IOSTANDARD LVCMOS33 } [ get_ports { y }  ] ;
