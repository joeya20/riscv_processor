module control_unit (
	input	[6:0]	opcode_i,
	output			branch_o,
	output			mem_read_o,
	output 			mem_to_reg_o,
	output 	[1:0]	alu_op_o,
	output 			mem_write_o,
	output 			alu_src_o,
	output 			reg_write_o
);

	always_comb begin
		unique case(opcode_i) begin
			7'b0110011: begin	//R-type instructions
				alu_src_o = 1'b0;
				mem_to_reg_o = 1'b0;
				reg_write_o = 1'b1;
				mem_read_o = 1'b0;
				mem_write_o = 1'b0;
				branch_o = 1'b0;
				alu_op_o = 2'b10;
			end
			7'b0000011: begin	//lw instruction
				alu_src_o = 1'b1;
				mem_to_reg_o = 1'b1;
				reg_write_o = 1'b1;
				mem_read_o = 1'b1;
				mem_write_o = 1'b0;
				branch_o = 1'b0;
				alu_op_o = 2'b00;
			end
			7'b0100011: begin	//sw instruction
				alu_src_o = 1'b1;
				mem_to_reg_o = 1'b0;
				reg_write_o = 1'b0;
				mem_read_o = 1'b0;
				mem_write_o = 1'b1;
				branch_o = 1'b0;
				alu_op_o = 2'b00;
			end
			7'b1100011: begin	//beq
				alu_src_o = 1'b0;
				mem_to_reg_o = 1'b0;
				reg_write_o = 1'b1;
				mem_read_o = 1'b0;
				mem_write_o = 1'b0;
				branch_o = 1'b1;
				alu_op_o = 2'b01;
			end
			default: ;
			end
		end
	end

endmodule : control_unit