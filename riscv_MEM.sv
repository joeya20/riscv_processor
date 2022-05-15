module riscv_EX #(
	parameter WORD_SIZE = 32
) (
	input					clk_i,
	input					rst_ni,

	//from EX stage
	input					alu_zero_i,
	input 	[WORD_SIZE-1:0]	alu_out_i,
	input 	[WORD_SIZE-1:0]	reg1_data_i

	//instr mem
	output 	[WORD_SIZE-1:0]	read_addr_o,
	input 	[WORD_SIZE-1:0]	read_data_i,
	output 	[WORD_SIZE-1:0]	write_data_o,

	//to WB stage
	output	[WORD_SIZE-1:0]	data_out_o,
	output	[WORD_SIZE-1:0]	alu_out_o,
);

endmodule : riscv_EX