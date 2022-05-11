module alu #(
	parameter WORD_SIZE = 32
) (
	riscv_pkg::alu_op_t 	op,
	input [WORD_SIZE-1:0]	A,
	input [WORD_SIZE-1:0]	B,
	output [WORD_SIZE-1:0]	result,
	output					zero
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

	assign zero = (result=='0);

endmodule : alu