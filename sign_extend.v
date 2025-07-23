module sign_extend(input wire[15:0] instruction, output wire[31:0] out); 

	assign out = {{16{instruction[15]}}, instruction};
	
endmodule
	
	
