module reg_file #(
	parameter REGFILE_COUNT = 32,
	parameter XLEN = 32
) (
	input							clk_i,
	input 							we_i,
	input 	[$clog2(REG_COUNT):0] 	read_reg0_i,	//synthesizable??
	input 	[$clog2(REG_COUNT):0] 	read_reg1_i,	//synthesizable??
	input 	[$clog2(REG_COUNT):0] 	write_reg_i,	//synthesizable??
	input 	[XLEN-1:0] 		write_data_i,
	output 	[XLEN-1:0] 		read0_data_o,
	output 	[XLEN-1:0] 		read1_data_o
);

logic [XLEN-1:0] reg_array [0:REGFILE_COUNT-1];

always_ff @(negedge clk_i) begin
	if(we_i) begin
		reg_array[write_reg_i] <= write_data_i;
	end
end

assign read0_data_o = reg_array[read_reg0_i];
assign read1_data_o = reg_array[read_reg1_i];

endmodule : reg_file