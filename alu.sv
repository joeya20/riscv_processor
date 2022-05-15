//Simple ALU module
module alu #(
	parameter WORD_SIZE = 32
) (
	input 	riscv_pkg::alu_op_t 	op_i,
	input 	[WORD_SIZE-1:0]			A_i,
	input 	[WORD_SIZE-1:0]			B_i,
	output 	[WORD_SIZE-1:0]			result_o,
	output							zero_o
);

	always_comb begin
		unique case (op) begin
			AND: result = A & B;
			OR:  result = A | B;
			ADD: result = A + B;
			SUB: result = A - B;
			default: result = 'x;
		end
	end
	
	assign zero = (result == '0);

endmodule : alu