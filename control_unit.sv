module control_unit (
	input	[6:0]	opcode_i,
	output			branch_o,
	output			mem_read_o,
	output 			mem_to_reg_o,
	output 	[1:0]	ALU_op_o,
	output 			mem_write_o,
	output 			ALU_src_o,
	output 			reg_write_o
);

	always_comb begin
		unique case(opcode_i) begin
			7'b0110011: begin	//R-type instructions
				ALU_src_o = 1'b0;
				mem_to_reg_o = 1'b0;
				reg_write_o = 1'b1;
				mem_read_o = 1'b0;
				mem_write_o = 1'b0;
				branch_o = 1'b0;
				ALU_op_o = 2'b10;
			end
			7'b0000011: begin	//lw instruction
				ALU_src_o = 1'b1;
				mem_to_reg_o = 1'b1;
				reg_write_o = 1'b1;
				mem_read_o = 1'b1;
				mem_write_o = 1'b0;
				branch_o = 1'b0;
				ALU_op_o = 2'b00;
			end
			7'b0100011: begin	//sw instruction
				ALU_src_o = 1'b1;
				mem_to_reg_o = 1'b0;
				reg_write_o = 1'b0;
				mem_read_o = 1'b0;
				mem_write_o = 1'b1;
				branch_o = 1'b0;
				ALU_op_o = 2'b00;
			end
			7'b1100011: begin	//beq
				ALU_src_o = 1'b0;
				mem_to_reg_o = 1'b0;
				reg_write_o = 1'b1;
				mem_read_o = 1'b0;
				mem_write_o = 1'b0;
				branch_o = 1'b1;
				ALU_op_o = 2'b01;
			end
			default: begin
				ALU_src_o = 1'bx;
				mem_to_reg_o = 1'bx;
				reg_write_o = 1'bx;
				mem_read_o = 1'bx;
				mem_write_o = 1'bx;
				branch_o = 1'bx;
				ALU_op_o = 2'bxx;
			end
		end
	end

endmodule : control_unit