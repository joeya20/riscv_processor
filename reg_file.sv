module reg_file #(
	parameter REGFILE_COUNT = 32,
	parameter WORD_SIZE = 32
) (
	input 							reg_write_i,
	input 	[$clog2(REG_COUNT):0] 	read_reg0_i,	//synthesizable??
	input 	[$clog2(REG_COUNT):0] 	read_reg1_i,	//synthesizable??
	input 	[$clog2(REG_COUNT):0] 	write_reg_i,	//synthesizable??
	input 	[WORD_SIZE-1:0] 		write_data_i,
	output 	[WORD_SIZE-1:0] 		read0_data_o,
	output 	[WORD_SIZE-1:0] 		read1_data_o
);

endmodule : reg_file