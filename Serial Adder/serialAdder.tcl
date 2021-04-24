#Nicholas Kawwas (40124338)
#COEN 313 - LAB UJ-X
#Script to Run Vivado in Batch Mode

#Run Script
#vivado -log serialAdder.log -mode batch -source serialAdder.tcl

#Read VHDL Source Files and XDC Constraints File
read_vhdl  { serialAdder.vhd }
read_xdc serialAdder.xdc

#Synthesize Design using Top Level VHDL Entity Name and Target Xilinx FPGA
synth_design -top serial_adder_ent -part xc7a100tcsg324-1

opt_design
place_design
route_design

report_timing_summary

#Generate Bitstream File
write_bitstream -force serialAdder.bit
