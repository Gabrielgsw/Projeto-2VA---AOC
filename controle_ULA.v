// Unidade de Controle da ULA

module controle_ULA(ALUOp, funct, ALUControl, shamt);
	input wire [3:0] ALUOp; // vindo do Control
	input wire [5:0] funct; // vindo da IM para R-type
	output reg shamt; // shift amount
	output reg [3:0] ALUControl; // utilizado na ALU


	always @ (*) begin
		shamt = 0;
		case(ALUOp)
			4'b0000: ALUControl = 4'b0000; // ADDI
			4'b0001: ALUControl = 4'b0001; // SUB do BEQ
			4'b0010: ALUControl = 4'b0010; // SUB do BNE
			4'b0011: ALUControl = 4'b0011; // SLTI
			4'b0100: ALUControl = 4'b0100; // SLTIU (!)
			4'b0101: ALUControl = 4'b0101; // ANDI
			4'b0110: ALUControl = 4'b0110; // ORI
			4'b0111: ALUControl = 4'b0111; // XORI
			4'b1000: ALUControl = 4'b1000; // LUI
			4'b1111: begin // R-type
			
				case(funct)
					6'b100000: ALUControl = 4'b0000; // ADD
					6'b100010: ALUControl = 4'b0001; // SUB
					6'b100100: ALUControl = 4'b0101; // AND
					6'b100101: ALUControl = 4'b0110; // OR
					6'b100110: ALUControl = 4'b0111; // XOR
					6'b100111: ALUControl = 4'b1111; // NOR
					6'b101010: ALUControl = 4'b0011; // SLT
					6'b101011: ALUControl = 4'b0100; // SLTU (!)
					
					6'b000000: begin
						ALUControl = 4'b1001; // SLL
						shamt = 1;
						end
						
					6'b000010: begin
						ALUControl = 4'b1010; // SRL
						shamt = 1;
						end
						
					6'b000011: begin
						ALUControl = 4'b1011; // SRA
						shamt = 1;
						end
						
					6'b000100: ALUControl = 4'b1001; // SLLV
					6'b000110: ALUControl = 4'b1010; // SRLV
					6'b000111: ALUControl = 4'b1011; // SRAV
					default: ALUControl = 4'bxxxx; // invalido
					
				endcase
			end
			default: ALUControl = 4'b0000; // ADD para o LW/SW
			
		endcase
	end

endmodule
