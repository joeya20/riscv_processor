module riscv_IF #(
	parameter XLEN = 32
) (
	input					clk_i,
	input					rst_ni,
	//instruction memory
	output 	[XLEN-1:0]	PC_q_o,
	input	[XLEN-1:0]	instr_IF_i,
	//to ID stage
	output 	[XLEN-1:0]	PC_IF_o,
	output 	[XLEN-1:0]	instr_IF_o,
	//from MEM stage
	input	[XLEN-1:0] branch_addr_i,
	input					take_branch_i
);
	
	logic [XLEN-1:0] PC_d;

	always_ff @ (posedge clk_i or negedge rst_ni) begin
		if(!rst_ni) begin
			PC_q_o <= '0;
			PC_IF_o <= '0';
			instr_IF_o <= '0;
		end else begin
			PC_q_o <= PC_d;
			PC_IF_o <= PC_q_o;
			instr_IF_o <= instr_IF_i;
		end
	end

	always_comb begin
		PC_d =  (take_branch_i) ?  branch_addr_i : (PC_q_o + 4);
	end

endmodule