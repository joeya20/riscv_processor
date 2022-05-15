//simple dual port word-aligned memory
module mem #(
	parameter WIDTH = 32,
	parameter DEPTH = 32
) (
	input 				clk_i,
	input				we_i,
	input	[WIDTH-1:0]	write_data_i,
	input 	[DEPTH-1:0]	read_addr_i,
	input 	[DEPTH-1:0]	write_addr_i,
	output	[WIDTH-1:0]	read_data_o
);

	logic [WIDTH-1:0] memory [0:2**DEPTH-1];

	always_ff @(posedge clk_i) begin

		if(we_i) begin
			memory[write_addr_i] <= write_data_i;
		end
		
		read_data_o <= memory[read_addr_i];
	end
	
endmodule