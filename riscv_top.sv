//top level
module riscv_top #(
	parameter WORD_SIZE = 32
) (
	input clk_i,
	input rst_ni
);
	

	logic PC;
	riscv_core core(
		.clk_i,
		.rst_ni,
		.PC_q_o
	);

	mem inst_mem(

	);

	mem data_mem(
		
	);

endmodule