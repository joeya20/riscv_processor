module riscv_IF #(
	parameter WORD_SIZE = 32
) (
	input					clk_i,
	input					rst_ni,
	//instruction memory
	output 	[WORD_SIZE-1:0]	PC_q_o,
	input	[WORD_SIZE-1:0]	instr_IF_i,
	//to ID stage
	output 	[WORD_SIZE-1:0]	PC_IF_o,
	output 	[WORD_SIZE-1:0]	instr_IF_o,
	//from MEM stage
	input	[WORD_SIZE-1:0] jp_addr_i,
	input					PC_src_i
);
	
	logic [WORD_SIZE-1:0] PC_d;

	always_ff @ (posedge clk_i or negedge rst_ni) begin
		if(!rst_ni) begin
			PC_q_o <= '0;
			instr_IF_o <= '0;
		end else begin
			PC_q_o <= PC_d;
			PC_IF_o <= PC_q_o;
			instr_IF_o <= instr_IF_i;
		end
	end

	always_comb begin
		PC_d =  (PC_src_i) ?  jp_addr_i : (PC_q_o + 4);
	end

endmodule