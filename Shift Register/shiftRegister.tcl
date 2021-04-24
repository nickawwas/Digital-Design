# Nicholas Kawwas (40124338)
# COEN 313 - LAB UJ-X
# Script to Run Vivado in Batch Mode

# Dependency
# source /CMC/tools/xilinx/Vivado_2018.2/Vivado/2018.2/settings64_CMC_central_license.csh

# Run Script
# vivado -log shiftRegister.log -mode batch -source shiftRegister.tcl

# Read VHDL Source Files and XDC Constraints File
read_vhdl  { ./shiftRegister.vhd }
read_xdc shiftRegister.xdc

# Synthesize Design using Top Level VHDL Entity Name and Target Xilinx FPGA
synth_design -top registers_min_max -part xc7a100tcsg324-1

opt_design
place_design
route_design

report_timing_summary

# Generate Bitstream File
write_bitstream -force shiftRegister.bit
