module control_unit (
	input	[6:0]	opcode_i,
	output			branch_o,
	output			mem_read_o,
	output 			mem_to_reg_o,
	output 			ALU_op_o,
	output 			mem_write_o,
	output 			ALU_src_o,
	output 			reg_write_o
);

	always_comb begin
		unique case(opcode_i) begin
			7'b0110011: begin	//R-type instructions

			end
			7'b0110011: begin	//R-type instructions

			end
			7'b0110011: begin	//R-type instructions

			end
			7'b0110011: begin	//R-type instructions

			end
			default: begin
				
			end
		end
	end

endmodule : control_unit