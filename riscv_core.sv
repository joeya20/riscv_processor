module riscv_core #(
	parameter REGFILE_COUNT = 32,
	parameter XLEN = 32
) (
	input								clk_i,
	input 								rst_ni,

	//instruction memory
	output	[XLEN-1:0]				PC_q_o,
	input	[XLEN-1:0]				instr_IF_i,

	//reg file
	output								regfile_we_o,
	output	[$clog2(REGFILE_COUNT)-1:0]	rs1_o,
	output	[$clog2(REGFILE_COUNT)-1:0]	rs2_o,
	output	[$clog2(REGFILE_COUNT)-1:0]	rd_o,
	input	[XLEN-1:0]				rs1_data_i,
	input	[XLEN-1:0]				rs2_data_i,
	output	[XLEN-1:0]				rd_data_o,

	//data memory

);

	//PC signal
	logic [XLEN-1:0]	PC_IF;
	logic [XLEN-1:0]	PC_ID;

	//IF stage
	logic [XLEN-1:0]	instr;
	logic [XLEN-1:0]	branch_addr;
	logic					take_branch;

	//ID stage
	logic [XLEN-1:0]	extended_imm_ID;
	logic [XLEN-1:0]	rs1_data;
	logic [XLEN-1:0]	rs2_data;
	logic [6:0]	funct7;
	logic [2:0]	funct3;

	//EX stage	
	logic 					alu_zero;
	logic [XLEN-1:0]	alu_out_EX;
	logic [XLEN-1:0]	rs2_data_EX;
	logic [XLEN-1:0]	branch_addr_EX;

	//MEM stage
	logic [XLEN-1:0]	alu_out_MEM;
	logic 					reg_write_MEM;


	//write reg# signals
	logic [$clog2(REGFILE_COUNT)-1:0] rd_ID;
	logic [$clog2(REGFILE_COUNT)-1:0] rd_EX;
	logic [$clog2(REGFILE_COUNT)-1:0] rd_MEM;

	//control signals
	logic			alu_src_ID;
	logic			mem_to_reg_ID;
	logic			reg_write_ID;
	logic			mem_read_ID;
	logic			mem_write_ID;
	logic			branch_ID;
	logic	[1:0]	alu_op_ID;

	logic			mem_to_reg_EX;
	logic			reg_write_EX;
	logic			mem_read_EX;
	logic			mem_write_EX;
	logic			branch_EX;

	riscv_IF IF_stage(	//done
		.clk_i,
		.rst_ni,
		//instruction memory
		.PC_q_o(PC_q_o),
		.instr_IF_i(instr_IF_i),
		//to ID stage
		.PC_IF_o(PC_IF),
		.instr_IF_o(instr),
		//from MEM stage
		.branch_addr_i(branch_addr),
		.take_branch_i(take_branch)
	);

	riscv_ID ID_stage(
		.clk_i,
		.rst_ni,
		//from ID stage
		.PC_ID_i(PC_IF),
		.instr_ID_i(instr),
		//reg file
		.rs1_o(rs1_o),
		.rs2_o(rs2_o),
		.rs1_data_i(rs1_data_i),
		.rs2_data_i(rs2_data_i),
		//to EX stage
		.PC_ID_o(PC_ID),
		.extended_imm_o(extended_imm_ID),
		.rs1_data_o(rs1_data),
		.rs2_data_o(rs2_data),
		.rd_o(rd_ID),
		//control signals
		.alu_src_o(alu_src_ID),
		.mem_to_reg_o(mem_to_reg_ID),
		.reg_write_o(reg_write_ID),
		.mem_read_o(mem_read_ID),
		.mem_write_o(mem_write_ID),
		.branch_o(branch_ID),
		.alu_op_o(alu_op_ID),
		.funct3_o(funct3),
		.funct7_o(funct7)
	);

	riscv_EX EX_stage(
		.clk_i,
		.rst_ni,
		//from ID stage
		.PC_EX_i(PC_ID),
		.rs1_data_i(rs1_data),
		.rs2_data_i(rs2_data),
		.imm_i(extended_imm_ID),
		.rd_i(rd_ID),
		.funct3_i(funct3),
		.funct7_i(funct7),
		.alu_src_i(alu_src_ID),
		.mem_to_reg_i(mem_to_reg_ID),
		.reg_write_i(reg_write_ID),
		.mem_read_i(mem_read_ID),
		.mem_write_i(mem_write_ID),
		.branch_i(branch_ID),
		.alu_op_i(alu_op_ID),
		//to MEM stage
		.alu_zero_o(alu_zero),
		.alu_out_o(alu_out_EX),
		.rs2_data_o(rs2_data_EX),
		.rd_o(rd_EX),
		.mem_to_reg_o(mem_to_reg_EX),
		.reg_write_o(reg_write_EX),
		.mem_read_o(mem_read_EX),
		.mem_write_o(mem_write_EX),
		.branch_o(branch_EX),
		//to IF stage	
		.jp_addr_o(branch_addr_EX)
	);

	riscv_MEM MEM_stage(
		.clk_i,
		.rst_ni,
		//from EX stage
		.alu_zero_i(alu_zero),
		.alu_out_i(alu_out_EX),
		.rs2_data_i(rs2_data_EX),
		.rd_i(rd_EX),
		.mem_to_reg_i(mem_to_reg_EX),
		.reg_write_i(reg_write_EX),
		.mem_read_i(mem_read_EX),
		.mem_write_i(mem_write_EX),
		.branch_i(branch_EX),
		.branch_addr_i(branch_addr_EX),

		//data mem

		//to IF stage
		.PC_src_o(take_branch),
		.branch_addr_o(branch_addr),

		//to WB stage
		.alu_out_o(alu_out_MEM),
		.rd_o(rd_MEM),
		.reg_write_o(reg_write_MEM),
		.mem_to_reg_o(mem_to_reg_MEM)
	);

	riscv_WB WB_stage(
		.clk_i,
		.rst_ni,
		.write_reg_o,
		.write_data_o,
		.reg_write_o
	);

endmodule : riscv_core