//top level
module riscv_top #(
	parameter WORD_SIZE = 32
) (
	input clk_i,
	input rst_ni
);
	//TODO
	logic;

	riscv_core core (
		.clk_i,
		.rst_ni,
		.PC_q_o
	);

	mem instr_mem (
		.clk_i,
		.we_i(1'b0),
		.write_data_i('0),
		.read_addr_i(PC_q_o),
		.write_addr_i('0),
		.read_data_o(instr_i)
	);

	reg_file reg_file0 (
		.clk_i,
		.we_i(reg_write_o),
		.read_reg0_i(read_reg0_o),
		.read_reg1_i(read_reg1_o),
		.write_reg_i(write_reg_o),
		.write_data_i(write_data_i),
		.read0_data_o(reg0_data_i),
		.read1_data_o(reg1_data_i)
	);

	mem data_mem (
	);

endmodule