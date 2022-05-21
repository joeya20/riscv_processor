module riscv_ID #(
	parameter REGFILE_COUNT = 32,
	parameter XLEN = 32
) (
	input					clk_i,
	input					rst_ni,
	//from IF stage
	input	[XLEN-1:0]		PC_ID_i,
	input	[XLEN-1:0]		instr_ID_i,

	//reg file
	//writeback signals sent directly from WB stage
	output	[$clog2(REGFILE_COUNT)-1:0]	rs1_o,
	output	[$clog2(REGFILE_COUNT)-1:0]	rs2_o,
	input	[XLEN-1:0]					rs1_data_i,
	input	[XLEN-1:0]					rs2_data_i,

	//to EX stage
	output	[XLEN-1:0]					PC_ID_o,
	output	[XLEN-1:0]					extended_imm_o,
	output	[XLEN-1:0]					rs1_data_o,
	output	[XLEN-1:0]					rs2_data_o,
	output	[$clog2(REGFILE_COUNT)-1:0]	rd_o,
	output								alu_src_o,
	output								mem_to_reg_o,
	output								reg_write_o,
	output								mem_read_o,
	output								mem_write_o,
	output								branch_o,
	output	[1:0]						alu_op_o,
	output	[2:0]						funct3_o,
	output	[6:0]						funct7_o
);

	logic			alu_src;
	logic			mem_to_reg;
	logic			reg_write;
	logic			mem_read;
	logic			mem_write;
	logic			branch;
	logic	[1:0]	alu_op;
	logic	[31:0]	imm;
	
	always_ff @ (posedge clk_i or negedge rst_ni) begin
		if(!rst_ni) begin
			PC_ID_o <= '0;
			extended_imm_o <= '0;
			rs1_data_o <= '0;
			rs2_data_o <= '0;
			rd_o <= '0;
			//ctrl signals
			alu_src_o <= '0;
			mem_to_reg_o <= '0;
			reg_write_o <= '0;
			mem_read_o <= '0;
			mem_write_o <= '0;
			branch_o <= '0;
			alu_op_o <= '0;
		end else begin
			PC_ID_o <= PC_ID_i;
			extended_imm_o <= imm;
			rs1_data_o <= rs1_data_i;
			rs2_data_o <= rs2_data_i;
			rd_o <= rd;
			//ctrl signals
			alu_src_o <= alu_src;
			mem_to_reg_o <= mem_to_reg;
			reg_write_o <= reg_write;
			mem_read_o <= mem_read;
			mem_write_o <= mem_write;
			branch_o <= branch;
			alu_op_o <= alu_op;
			funct3_o <= funct3;
			funct7_o <= funct7;
		end
	end

	always_comb begin
		imm = {{20{instr_ID_i[31]}},instr_ID_i[31:20]};
		funct7 = instr_ID_i[31:25];
		rs2_o = instr_ID_i[24:20];
		rs1_o = instr_ID_i[19:15];
		funct3 = instr_ID_i[14:12];
		rd = instr_ID_i[11:7];
		opcode = instr_ID_i[6:0];
	end

	control_unit controller(
		.opcode_i(opcode),
		.branch_o(branch),
		.mem_read_o(mem_read),
		.mem_to_reg_o(mem_to_reg),
		.alu_op_o(alu_op),
		.mem_write_o(mem_write),
		.alu_src_o(alu_src),
		.reg_write_o(reg_write)
	);

endmodule