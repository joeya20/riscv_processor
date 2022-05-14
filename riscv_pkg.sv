package riscv_pkg;

	typedef enum logic [3:0] { 
		AND = 4'b0000,
		OR 	= 4'b0001,
		ADD = 4'b0010,
		SUB = 4'b0110
	} alu_op_t;

endpackage : riscv_pkg