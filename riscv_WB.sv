module riscv_WB #(
	parameter REGFILE_COUNT = 32,
	parameter XLEN = 32
) (
	input	clk_i,
	input	rst_ni,

	//from MEM stage
	input	[XLEN-1:0]				mem_data_i,
	input	[XLEN-1:0]				alu_out_i,
	input								reg_write_i,
	input								rd_i,

	//to reg file
	output	[$clog2(REGFILE_COUNT)-1:0] write_reg_o,
	output	[XLEN-1:0]				write_data_o,
	output								reg_write_o
);

endmodule : riscv_EX