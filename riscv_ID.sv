module riscv_ID #(
	parameter REGFILE_COUNT = 32,
	parameter WORD_SIZE = 32
) (
	input					clk_i,
	input					rst_ni,
	//from ID stage
	input	[WORD_SIZE-1:0]	PC_ID_i,
	input	[WORD_SIZE-1:0]	instr_ID_i,
	//reg file
	//TODO add writeback signals
	output	[$clog2(REGFILE_COUNT)-1:0]	read_reg0_o,
	output	[$clog2(REGFILE_COUNT)-1:0]	read_reg1_o,
	input	[WORD_SIZE-1:0]	read_data0_i,
	input	[WORD_SIZE-1:0]	read_data1_i,
	//to EX stage
	output	[WORD_SIZE-1:0]	PC_ID_o,
	output	[WORD_SIZE-1:0]	extended_imm_o,
	output	[WORD_SIZE-1:0]	read_data0_o,
	output	[WORD_SIZE-1:0]	read_data1_o
);

	always_ff @ (posedge clk_i or negedge rst_ni) begin
		if(!rst_ni) begin
			PC_ID_o <= '0;
			extended_imm <= '0;
			read_data0_o <= '0;
			read_data1_o <= '0;
		end else begin
			PC_ID_o <= PC_IF_i;
			extended_imm <= {{20{instr_ID_i[31]}},instr_ID_i[31:20]};
			read_data0_o <= read_data0_i;
			read_data1_o <= read_data1_i;
		end
	end

	always_comb begin	//TODO
		funct7_o = instr_ID_i[31:25];
		read_reg1_o = instr_ID_i[24:20];
		read_reg0_o = instr_ID_i[19:15];
		funct3_o = instr_ID_i[14:12];
		write_reg_o = instr_ID_i[11:7];
		opcode_o = instr_ID_i[6:0];
	end

endmodule