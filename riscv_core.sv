module riscv_core #(
	parameter REGFILE_COUNT = 32,
	parameter WORD_SIZE = 32
) (
	input					clk_i,
	input 					rst_ni,

	//instruction memory
	output	[WORD_SIZE-1:0]	PC_q_o,
	input	[WORD_SIZE-1:0]	instr_IF_i,

	//reg file
	output	[$clog2(REGFILE_COUNT)-1:0]	read_reg0_o,
	output	[$clog2(REGFILE_COUNT)-1:0]	read_reg1_o,
	input	[WORD_SIZE-1:0]	read_data0_i,
	input	[WORD_SIZE-1:0]	read_data1_i,


);
	//IF stage
	logic [WORD_SIZE-1:0]	instr_IF;
	logic [WORD_SIZE-1:0]	PC_IF;
	logic [WORD_SIZE-1:0]	jp_addr;
	logic					PC_src;

	//ID stage
	logic [WORD_SIZE-1:0]	PC_ID;
	logic [WORD_SIZE-1:0]	extended_imm_ID;
	logic [WORD_SIZE-1:0]	reg0_data;
	logic [WORD_SIZE-1:0]	reg1_data;

	riscv_IF IF_stage(
		.clk_i,
		.rst_ni,
		.PC_q_o,
		.instr_IF_i,
		.PC_IF_o(PC_IF),
		.instr_IF_o(instr_IF),
		.jp_addr_i(jp_addr),
		.PC_src_i(PC_src)
	);

	riscv_ID ID_stage(
		.clk_i,
		.rst_ni,
		.PC_ID_i(PC_IF),
		.instr_ID_i(instr_IF),
		.read_reg0_o,
		.read_reg1_o,
		.read_data0_i,
		.read_data1_i,
		//TODO add writeback signals
		.PC_ID_o(PC_ID),
		.extended_imm_o(extended_imm_ID),
		.read_data0_o(reg0_data),
		.read_data1_o(reg1_data)
	);

	riscv_EX EX_stage(
		.clk_i,
		.rst_ni,
		.PC_EX_i(PC_ID),
		.read_data0_i(reg0_data),
		.read_data1_i(reg1_data),
		.imm(extended_imm_ID),
		.alu_zero_o(),
		.alu_out_o(),
		.read_data1_o(),
		.jp_addr_o(jp_addr)
	);

	riscv_MEM MEM_stage(
		.clk_i,
		.rst_ni
	);

	riscv_WB WB_stage(
		.clk_i,
		.rst_ni,
		.PC_src_o(PC_src)
	);

endmodule : riscv_core