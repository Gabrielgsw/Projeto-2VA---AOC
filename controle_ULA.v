// Unidade de Controle da ULA

module controle_ULA(ALUOp, func, ALUControl);
	input wire [1:0] ALUOp; // vindo do Control
	input wire [5:0] func; // vindo da IM para R-type
	output reg [3:0] ALUControl; // utilizado na ALU
	
	always @ (*) begin
		case(ALUOp)
			2'b00: ALUControl = 4'b0010; // ADD do LW e SW
			2'b01: ALUControl = 4'b0110; // SUB do BEQ
			2'b10: begin // R-type
				case(func)
					6'b100000: ALUControl = 4'b0010; // ADD
					6'b100010: ALUControl = 4'b0110; // SUB
					6'b100100: ALUControl = 4'b0000; // AND
					6'b100101: ALUControl = 4'b0001; // OR
					6'b100110: ALUControl = 4'b0011; // XOR
					6'b100111: ALUControl = 4'b1100; // NOR
					6'b101010: ALUControl = 4'b0111; // SLT
					6'b101011: ALUControl = 4'b0111; // SLTU
					6'b000000: ALUControl = 4'b1000; // SLL
					6'b000010: ALUControl = 4'b1001; // SRL
					6'b000011: ALUControl = 4'b1010; // SRA
					6'b000100: ALUControl = 4'b1000; // SLLV
					6'b000111: ALUControl = 4'b1010; // SRAV
					6'b001000: ALUControl = 4'bxxxx; // JR (pode ser removido) 
					default: ALUControl = 4'bxxxx; // invalido
				endcase
			end
			default: ALUControl = 4'bxxxx; // invalido
		endcase
	end
endmodule
