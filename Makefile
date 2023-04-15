all:
	iverilog -o control_testbench control_testbench.v
	vvp control_testbench
	gtkwave control_testbench.vcd
	rm control_testbench control_testbench.vcd