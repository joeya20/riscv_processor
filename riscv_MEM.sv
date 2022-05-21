module riscv_EX #(
	parameter XLEN = 32
) (
	input					clk_i,
	input					rst_ni,

	//from EX stage
	input					alu_zero_i,
	input 	[XLEN-1:0]	alu_out_i,
	input 	[XLEN-1:0]	rs2_data_i

	//instr mem
	output 	[XLEN-1:0]	read_addr_o,
	input 	[XLEN-1:0]	read_data_i,
	output 	[XLEN-1:0]	write_data_o,

	//to WB stage
	output	[XLEN-1:0]	data_out_o,
	output	[XLEN-1:0]	alu_out_o,
);


	assign take_branch = branch_EX & alu_zero_i;

endmodule : riscv_EX