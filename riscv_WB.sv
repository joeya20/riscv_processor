module riscv_WB #(
	parameter WORD_SIZE = 32
) (
	input	clk_i,
	input	rst_ni,

	//from MEM stage
	input	[WORD_SIZE-1:0]	mem_data_i,
	input	[WORD_SIZE-1:0]	alu_out_i
);

endmodule : riscv_EX