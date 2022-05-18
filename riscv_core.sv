module riscv_core #(
	parameter REGFILE_COUNT = 32,
	parameter WORD_SIZE = 32
) (
	input								clk_i,
	input 								rst_ni,

	//instruction memory
	output	[WORD_SIZE-1:0]				PC_q_o,
	input	[WORD_SIZE-1:0]				instr_IF_i,

	//reg file
	output								reg_write_o,
	output	[$clog2(REGFILE_COUNT)-1:0]	read_reg0_o,
	output	[$clog2(REGFILE_COUNT)-1:0]	read_reg1_o,
	output	[$clog2(REGFILE_COUNT)-1:0]	write_reg_o,
	input	[WORD_SIZE-1:0]				read_data0_i,
	input	[WORD_SIZE-1:0]				read_data1_i,
	output	[WORD_SIZE-1:0]				write_data_o
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

	//EX stage
	logic [3:0]	alu_ctrl;

	//write reg# signals
	logic [$clog2(REGFILE_COUNT)-1:0] write_reg_ID_EX;
	logic [$clog2(REGFILE_COUNT)-1:0] write_reg_EX_MEM;
	logic [$clog2(REGFILE_COUNT)-1:0] write_reg_MEM_WB;

	//control signals
	logic			ALU_src_ID;
	logic			mem_to_reg_ID;
	logic			reg_write_ID;
	logic			mem_read_ID;
	logic			mem_write_ID;
	logic			branch_ID;
	logic	[1:0]	ALU_op_ID;

	logic			mem_to_reg_EX;
	logic			reg_write_EX;
	logic			mem_read_EX;
	logic			mem_write_EX;
	logic			branch_EX;


	riscv_IF IF_stage(	//done
		.clk_i,
		.rst_ni,
		//instruction memory
		.PC_q_o,
		.instr_IF_i,
		//to ID stage
		.PC_IF_o(PC_IF),
		.instr_IF_o(instr_IF),
		//from MEM stage
		.jp_addr_i(jp_addr),
		.PC_src_i(PC_src)
	);

	riscv_ID ID_stage(	//TODO controller
		.clk_i,
		.rst_ni,
		//from ID stage
		.PC_ID_i(PC_IF),
		.instr_ID_i(instr_IF),
		//reg file
		.read_reg0_o,
		.read_reg1_o,
		.read_data0_i,
		.read_data1_i,
		//to EX stage
		.PC_ID_o(PC_ID),
		.extended_imm_o(extended_imm_ID),
		.read_data0_o(reg0_data),
		.read_data1_o(reg1_data),
		.write_reg_o(write_reg_ID_EX),
		.alu_ctrl_o(alu_ctrl),
		.ALU_src_o(ALU_src_ID),
		.mem_to_reg_o(mem_to_reg_ID),
		.reg_write_o(reg_write_ID),
		.mem_read_o(mem_read_ID),
		.mem_write_o(mem_write_ID),
		.branch_o(branch_ID),
		.ALU_op_o(ALU_op_ID)
	);

	riscv_EX EX_stage(	//TODO ALU controller
		.clk_i,
		.rst_ni,
		//from ID stage
		.PC_EX_i(PC_ID),
		.read_data0_i(reg0_data),
		.read_data1_i(reg1_data),
		.imm_i(extended_imm_ID),
		.write_reg_i(write_reg_ID_EX),
		.alu_ctrl_i(alu_ctrl),
		.ALU_src_i(ALU_src_ID),
		.mem_to_reg_i(mem_to_reg_ID),
		.reg_write_i(reg_write_ID),
		.mem_read_i(mem_read_ID),
		.mem_write_i(mem_write_ID),
		.branch_i(branch_ID),
		.ALU_op_i(ALU_op_ID),
		//to MEM stage
		.alu_zero_o(),
		.alu_out_o(),
		.read_data1_o(),
		.jp_addr_o(jp_addr),
		.write_reg_o(write_reg_EX_MEM),
		.mem_to_reg_o(mem_to_reg_EX),
		.reg_write_o(reg_write_EX),
		.mem_read_o(mem_read_EX),
		.mem_write_o(mem_write_EX),
		.branch_o(branch_EX)
	);

	riscv_MEM MEM_stage(
		.clk_i,
		.rst_ni,
		.PC_src_o(PC_src)
	);

	riscv_WB WB_stage(
		.clk_i,
		.rst_ni,
		.write_reg_o,
		.write_data_o,
		.reg_write_o
	);

endmodule : riscv_core