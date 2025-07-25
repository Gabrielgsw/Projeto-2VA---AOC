// Atividade 2VA - Arquitetura e Organizacao de Computadores [2025.1]
// Gabriel Germano dos Santos Wanderley
// Samara Accioly
// Vitor Barros de Carvalho
// Wellington Viana da Silva Junior


module ula (in1, in2, op, result, zero_flag);

// Portas
	input wire [31:0] in1; 			// 1(A) Operando da ULA
	input wire [31:0] in2;			// 2(B) Operando da ULA
	
	input wire [3:0] op;				//	Qual operação vai ser utilizada na ULA, vem do ALUCtrl (4 bits)									
	
	output reg [31:0] result;		// Resultado da operação feita com os dois operandos da ULA						
	output wire zero_flag;			// Se o resultado for igual a 0, então a zero_flag se torna 1(útil para funções de beq, por exemplo)
	
	
	always @ (in1, in2, op) begin
	//Casos de cada operação na ULA
		case(op)
			
			4'b0000: result = in1 + in2;												// 0  = ADD
			4'b0001: result = in1 - in2;												// 1	= SUB
			4'b0010: result = in1 - in2;												// 2  = SUB exclusivo para o BNE (Branch if NOT Equal)
			4'b0011: result = ($signed(in1) < $signed(in2)) ? 1 : 0 ;		// 3  = SLT
			4'b0100: result = (in1 < in2) ? 1 : 0 ;								// 4  = SLTU
			4'b0101: result = in1 & in2;												// 5  = AND
			4'b0110: result = in1 | in2;												// 6  = OR
			4'b0111: result = in1 ^ in2;												// 7 	= XOR (OR exclusivo)
			4'b1000: result = in2 << 16;												// 8	= LUI
			4'b1001: result = in2 << in1[4:0];										// 9 	= SLL (Shift Left Logical)
			4'b1010: result = in2 >> in1[4:0];										// 10 = SRL (Shift Right Logical)
			4'b1011: result = $signed(in1) >>> in2[4:0];							// 11	= SRA (Shift Right Arithmetical)
			4'b1111: result = ~(in1 | in2);											// 15 = NOR (Negação do OR)	
			default: result = 32'b0;													// Valor default vai ser 0, se não for nenhuma delas
			
		endcase
	
	end
	
	// Se result for 0, doi casos, observar a operação de subtração para ver se é BNE ou não
	assign zero_flag = (result == 32'b0) ? (op == 4'b0010 ? 1'b0 : 1'b1) : (op == 4'b0010 ? 1'b1 : 1'b0);	// Se o resultado for igual a 0, então a zero_flag se torna 1(útil para funções de beq, por exemplo)	

endmodule
