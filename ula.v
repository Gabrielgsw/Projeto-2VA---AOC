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
		
			4'b0000: result = in1 & in2;						// 0  = AND
			4'b0001: result = in1 | in2;						// 1  = OR
			4'b0010: result = in1 + in2;						// 2  = Soma
			4'b0011: result = in1 ^ in2;						// 3 	= XOR (OR exclusivo)
			4'b0110: result = in1 - in2;						// 6  = Subtração
			4'b0111: result = (in1 < in2) ? 1 : 0 ;		// 7  = Set less than(se A for menor que B, então o resultado é 1)
			4'b1000: result = in2 << in1[4:0];				// 8 	= SLL (Shift Left Logical)
			4'b1001: result = in2 >> in1[4:0];				// 9 	= SRL (Shift Right Logical)
			4'b1010: result = $signed(in2) >>> in1[4:0];	// 10	= SRA (Shift Right Arithmetical)
			4'b1100: result = ~(in1 | in2);					// 12 = NOR (Negação do OR)	
			default: result = 32'b0;							// Valor default vai ser 0, se não for nenhuma delas
			
		endcase
	
	end
	
	assign zero_flag = (result == 0) ? 1 : 0 ;			// Se o resultado for igual a 0, então a zero_flag se torna 1(útil para funções de beq, por exemplo)	

endmodule