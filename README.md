# CA_HW4_2021-Single-Cycle-CPU-in-verilog-

## Prerequisites
Install Icarus Verilog
Gtkwave is optional.

## HOW TO RUN
1) In testbench, edit the input instruction part depending on which instruction/machine code you want to give. (default: instruction.txt)

2) In terminal, go to the directory where the verilog files are.

3) Type the following commands:\
  iverilog -o cpu.out *.v     (Compile the verilog files and generate a file named "cpu.out")\
  vvp cpu.out                 (Run output file and generate output.txt which shows the values in the registers)

