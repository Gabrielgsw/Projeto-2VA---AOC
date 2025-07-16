module sign_extend(input wire[15:0] instruction, output wire[31:0] out);

	always @(*) begin
		if(instruction[15] == 1'b0) begin
			out = {16'b0000000000000000, instruction};
		and else begin
			out = {16'b1111111111111111, instruction};
		end
	end
	
endmodule
	
	