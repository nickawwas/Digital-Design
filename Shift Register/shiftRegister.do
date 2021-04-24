# Suppress Warnings 
set StdArithNoWarnings 1

# Reset the Registers
force res 1
run 4
examine min_out max_out reg

# Forces Clk to 0 for 2ns then 1 for 2ns, Repeating Every 4ns
force clk 1 2 -r 4
force clk 0 4 -r 4

# Test Min-Max Logic
force res 0
force sel 10
force din 1010
run 4
examine min_out max_out reg

force din 1011
run 4
examine min_out max_out reg

force din 1100
run 4
examine min_out max_out reg

force din 1010
run 4
examine min_out max_out reg

force din 0111
run 4
examine min_out max_out reg

force din 0101
run 4
examine min_out max_out reg

force din 1101
run 4
examine min_out max_out reg

force din 1011
run 4
examine min_out max_out reg

force din 1100
run 4
examine min_out max_out reg

force din 0010
run 4
examine min_out max_out reg

force din 1011
run 4
examine min_out max_out reg

force din 1100
run 4
examine min_out max_out reg

# Enable Warnings Again
set StdArithNoWarnings 0

# Exit Modelsim 
quit
