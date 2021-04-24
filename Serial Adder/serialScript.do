#Test Resetting Properly
force clk 0
force shift 0
force sin 0
force res 1
run 2
examine *

#Forces Clk to 0 for 2ns then 1 for 2ns, Repeating Every 4ns
force clk 0 2 -r 4
force clk 1 4 -r 4

#Test Performing Addition Properly
# regA -> 0110, regB -> 0001: sum -> 0 0111

# regA -> 0110

# Start 1 Cycle
force res 0
run 2

# sin 0, clk 1
force shift 1
run 2
examine *

# Start 2 Cycle
run 2

# sin 1, clk 1
force sin 1
run 2
examine * 

# Start 3 Cycle
run 2 

# sin 0, clk 1
force sin 1
run 2
examine *

# Start 4 Cycle
run 2 

#sin 1, clk 1
force sin 0
run 2
examine *

# regB -> 0001

# Start 5 Cycle
force sin 1
run 2

#sin 1, clk 1
run 2
examine *

# Start 6 Cycle
run 2

#sin 0, clk 1
force sin 0
run 2
examine *

# Start 7 Cycle
run 2

#sin 0, clk 1
run 2
examine *

# Start 8 Cycle
run 2

#sin 0, Clk 1
run 2
examine * 

# Reg A and Reg B Should Have Contents of Data A and Data B
echo "regA and regB are Filled"
examine regA regB 

#Start 9 Cycle
run 2

run 2
examine * 

#Start 10 Cycle
run 2

run 2
examine * 

#Start 11 Cycle
run 2

run 2
examine *

# Start 12 Cycle
run 2

run 2
examine *

# Sum Should Be Outputted With Cout
echo "Sum and Cout are"
examine sum cout
