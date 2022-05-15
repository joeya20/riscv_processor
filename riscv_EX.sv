module riscv_EX #(
	parameter REGFILE_COUNT = 32,
	parameter WORD_SIZE = 32
) (
	input								clk_i,
	input								rst_ni,

	//from  ID stage
	input	[WORD_SIZE-1:0]				PC_EX_i,
	input	[WORD_SIZE-1:0]				read_data0_i,
	input	[WORD_SIZE-1:0]				read_data1_i,
	input	[WORD_SIZE-1:0]				imm_i,
	input	[$clog2(REGFILE_COUNT)-1:0] write_reg_i,
	input	[3:0]						alu_ctrl_i,
	//to MEM stage
	output								alu_zero_o,
	output	[WORD_SIZE-1:0]				alu_out_o,
	output	[WORD_SIZE-1:0]				read_data1_o,
	output	[WORD_SIZE-1:0]				jp_addr_o,
	input	[$clog2(REGFILE_COUNT)-1:0] write_reg_o,
);

	logic [WORD_SIZE-1:0]	alu_in_2;
	logic [WORD_SIZE-1:0]	alu_out;
	logic					alu_zero;
	
	alu	alu0 (
		.op_i(),	//TODO
		.A_i(read_data0_i),
		.B_i(alu_in_2),
		.result_o(alu_out),
		.zero_o(alu_zero)
	)

	assign alu_in_2 = (ctrl) ? imm : read_data1_i;	//TODO ctrl signal

	always_ff @(posedge clk_i or negedge rst_ni) begin
		if(!rst_ni) begin
			alu_zero_o <= '0;
			alu_out_o <= '0;
			read_data1_o <= '0;
			jp_addr_o <= '0;
			write_reg_o <= '0;
		end else begin
			alu_zero_o <= alu_zero;
			alu_out_o <= alu_out;
			read_data1_o <= read_data1_i;
			jp_addr_o <= PC_EX_i + imm;
			write_reg_o <= write_reg_i;
		end
	end

endmodule : riscv_EX