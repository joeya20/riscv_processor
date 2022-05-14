module riscv_core #(
	parameter REGFILE_COUNT = 32,
	parameter WORD_SIZE = 32
) (
	input					clk_i,
	input 					rst_ni,
	//inst mem
	output	[WORD_SIZE-1:0] 	PC_q_o,
	input	[WORD_SIZE-1:0]		instr_i,
	//reg file
	output	[$clog2(REGFILE_COUNT)-1:0]	read_reg0_o,	//synthesizable??
	output	[$clog2(REGFILE_COUNT)-1:0] read_reg1_o,	//synthesizable??
	output	[$clog2(REGFILE_COUNT)-1:0] write_reg_o,	//synthesizable??
	output	[WORD_SIZE-1:0] 			write_data_o,
	output								reg_write_o,
	input	[WORD_SIZE-1:0] 			read0_data_i,
	input	[WORD_SIZE-1:0]				read1_data_i
	//data mem
	//TODO
);

	//program counter
	logic [WORD_SIZE-1:0] PC_q_o;
	logic [WORD_SIZE-1:0] PC_d;

	//alu
	riscv_pkg::alu_op_t alu_op;
	logic zero;
	logic [WORD_SIZE-1:0] alu_result;

	always_ff @ (posedge clk_i or negedge rst_ni) begin
		if(!rst_ni) begin
			PC_q_o <= '0;
		end else begin
			PC_q_o <= PC_d;
		end
	end

	always_comb begin
		PC_d = PC_q_o + 4;
	end

	mem instr_mem (
		//TODO
	)

	reg_file reg_file0 (
		.reg_write_i(reg_write_o),
		.read_reg0_i(read_reg0_o),
		.read_reg1_i(read_reg1_o),
		.write_reg_i(write_reg_o),
		.write_data_i(write_data_i),
		.read0_data_o(reg0_data_i),
		.read1_data_o(reg1_data_i)
	)

	alu alu0 (
		.op(alu_op),
		.A(reg0_data_i),
		.B(reg1_data_i),
		.result(alu_result),
		.zero
	)

	mem data_mem (
		//TODO
	)

endmodule