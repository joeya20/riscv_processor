module reg_file #(
	parameter WORD_SIZE = 32
) (
	input 		reg_write_i,
	input [4:0] read0_reg_i,
	input [4:0] read1_reg_i,
	input [4:0] w_reg_i,
	input [31:0] write_data_o,
	output [31:0] read0_data_o,
	output [31:0] read1_data_o
);

	


endmodule : reg_file