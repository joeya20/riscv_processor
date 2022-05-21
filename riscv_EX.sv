module riscv_EX #(
	parameter REGFILE_COUNT = 32,
	parameter XLEN = 32
) (
	input								clk_i,
	input								rst_ni,

	//from  ID stage
	input	[XLEN-1:0]				PC_EX_i,
	input	[XLEN-1:0]				rs1_data_i,
	input	[XLEN-1:0]				rs2_data_i,
	input	[XLEN-1:0]				imm_i,
	input	[$clog2(REGFILE_COUNT)-1:0] rd_i,
	input	[2:0]						funct3_i,
	input	[6:0]						funct7_i,
	input								alu_src_i,
	input								mem_to_reg_i,
	input								reg_write_i,
	input								mem_read_i,
	input								mem_write_i,
	input								branch_i,
	input	[1:0]						alu_op_i,
	//to MEM stage
	output								alu_zero_o,
	output	[XLEN-1:0]				alu_out_o,
	output	[XLEN-1:0]				rs2_data_o,
	output	[XLEN-1:0]				jp_addr_o,
	output	[$clog2(REGFILE_COUNT)-1:0] rd_o,
	output								mem_to_reg_o,
	output								reg_write_o,
	output								mem_read_o,
	output								mem_write_o,
	output								branch_o
);

	logic [XLEN-1:0]	alu_in_2;
	logic [XLEN-1:0]	alu_out;
	logic					alu_zero;
	riscv_pkg::alu_op_t		alu_ctrl;

	assign alu_in_2 = (alu_src_i) ? imm : rs2_data_i;

	always_ff @(posedge clk_i or negedge rst_ni) begin
		if(!rst_ni) begin
			alu_zero_o <= '0;
			alu_out_o <= '0;
			rs2_data_o <= '0;
			jp_addr_o <= '0;
			rd_o <= '0;
			mem_to_reg_o <= '0;
			reg_write_o <= '0;
			mem_read_o <= '0;
			mem_write_o <= '0;
			branch_o <= '0;
		end else begin																						
			alu_zero_o <= alu_zero;
			alu_out_o <= alu_out;
			rs2_data_o <= rs2_data_i;
			jp_addr_o <= PC_EX_i + imm_i;
			rd_o <= rd_i;
			mem_to_reg_o <= mem_to_reg_i;
			reg_write_o <= reg_write_i;
			mem_read_o <= mem_read_i;
			mem_write_o <= mem_write_i;
			branch_o <= branch_i;
		end
	end

	alu	alu0 (
		.op_i(alu_ctrl),
		.A_i(rs1_data_i),
		.B_i(alu_in_2),
		.result_o(alu_out),
		.zero_o(alu_zero)
	);

	alu_control alu_ctrl_unit(
		.alu_op_i(alu_op_i),
		.funct3_i(funct3_i),
		.funct7_i(funct7_i),
		.alu_control_o(alu_ctrl)
	);
	
endmodule : riscv_EX