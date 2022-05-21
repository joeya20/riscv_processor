module alu_control(
	input [1:0]					alu_op_i,
	input [6:0] 				funct7_i,
	input [2:0] 				funct3_i,
	output riscv_pkg::alu_op_t 	alu_control_o
);

	logic [9:0] funct = {funct7_i, funct3_i};

	always_comb begin
		case (alu_op_i)
			2'b00: alu_control_o = ADD;
			2'b01: alu_control_o = SUB;
			2'b10: begin
				case (funct)
					10'h00: alu_control_o = ADD;
					10'h06: alu_control_o = OR;
					10'h07: alu_control_o = AND;
					10'h20: alu_control_o = SUB;
					default: ;
				endcase
			end
			2'b11: ;
			default: ;
		endcase

endmodule