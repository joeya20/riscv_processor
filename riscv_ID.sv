module riscv_ID #(
	parameter REGFILE_COUNT = 32,
	parameter WORD_SIZE = 32
) (
	input					clk_i,
	input					rst_ni,

	input	[WORD_SIZE-1:0]	PC_ID_i,
	input	[WORD_SIZE-1:0]	instr_ID_i,

	//reg file
	//writeback signals sent directly from WB stage
	output	[$clog2(REGFILE_COUNT)-1:0]	read_reg0_o,
	output	[$clog2(REGFILE_COUNT)-1:0]	read_reg1_o,
	input	[WORD_SIZE-1:0]				read_data0_i,
	input	[WORD_SIZE-1:0]				read_data1_i,

	//to EX stage
	output	[WORD_SIZE-1:0]				PC_ID_o,
	output	[WORD_SIZE-1:0]				extended_imm_o,
	output	[WORD_SIZE-1:0]				read_data0_o,
	output	[WORD_SIZE-1:0]				read_data1_o,
	output	[$clog2(REGFILE_COUNT)-1:0]	write_reg_o,
	output	[3:0]						alu_ctrl_o,
	output								ALU_src_o,
	output								mem_to_reg_o,
	output								reg_write_o,
	output								mem_read_o,
	output								mem_write_o,
	output								branch_o,
	output	[1:0]						ALU_op_o
);

	logic			ALU_src;
	logic			mem_to_reg;
	logic			reg_write;
	logic			mem_read;
	logic			mem_write;
	logic			branch;
	logic	[1:0]	ALU_op;
	
	always_ff @ (posedge clk_i or negedge rst_ni) begin
		if(!rst_ni) begin
			PC_ID_o <= '0;
			extended_imm <= '0;
			read_data0_o <= '0;
			read_data1_o <= '0;
			write_reg_o <= '0;
			alu_ctrl_o <= '0;
			ALU_src_o <= '0;
			mem_to_reg_o <= '0;
			reg_write_o <= '0;
			mem_read_o <= '0;
			mem_write_o <= '0;
			branch_o <= '0;
			ALU_op_o <= '0;
		end else begin
			PC_ID_o <= PC_ID_i;
			extended_imm <= {{20{instr_ID_i[31]}},instr_ID_i[31:20]};
			read_data0_o <= read_data0_i;
			read_data1_o <= read_data1_i;
			write_reg_o <= write_reg;
			alu_ctrl_o <= {instr_ID_i[30], instr_ID_i[14:12]};
			ALU_src_o <= ALU_src;
			mem_to_reg_o <= mem_to_reg;
			reg_write_o <= reg_write;
			mem_read_o <= mem_read;
			mem_write_o <= mem_write;
			branch_o <= branch;
			ALU_op_o <= ALU_op;
		end
	end

	always_comb begin
		funct7 = instr_ID_i[31:25];
		read_reg1_o = instr_ID_i[24:20];
		read_reg0_o = instr_ID_i[19:15];
		funct3 = instr_ID_i[14:12];
		write_reg = instr_ID_i[11:7];
		opcode = instr_ID_i[6:0];
	end

	control_unit controller(
		.opcode_i(opcode),
		.branch_o(branch),
		.mem_read_o(mem_read),
		.mem_to_reg_o(mem_to_reg),
		.ALU_op_o(ALU_op),
		.mem_write_o(mem_write),
		.ALU_src_o(ALU_src),
		.reg_write_o(reg_write)
	);

endmodule