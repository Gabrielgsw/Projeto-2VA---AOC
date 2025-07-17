// Unidade de Controle

module controle(opcode, RegDst, RegWrite, ALUSrc, Branch, MemRead, MemWrite, MemToReg, Jump, WritePC4, ALUOp);
	input wire [5:0] opcode;
	output reg RegDst, RegWrite, ALUSrc, Branch, MemRead, MemWrite, MemToReg, Jump, WritePC4;
	output reg [1:0] ALUOp;
	
	always @ (*) begin
			// default
			RegDst = 0;
			RegWrite = 0;
			ALUSrc = 0;
			Branch = 0;
			MemRead = 0;
			MemWrite = 0;
			MemToReg = 0;
			ALUOp = 2'b00;
			Jump = 0;
			WritePC4 = 0;
	
		case(opcode)
			6'b000000: begin // R-type
				RegDst = 1;
				RegWrite = 1;
				ALUSrc = 0;
				Branch = 0;
				MemRead = 0;
				MemWrite = 0;
				MemToReg = 0;
				ALUOp = 2'b10;
				Jump = 0;
				WritePC4 = 0;
			end
				
			6'b100011: begin // LW
				RegDst = 0;
				RegWrite = 1;
				ALUSrc = 1;
				Branch = 0;
				MemRead = 1;
				MemWrite = 0;
				MemToReg = 1;
				ALUOp = 2'b00;
				Jump = 0;
				WritePC4 = 0;
			end
				
			6'b101011: begin // SW
				RegDst = 0; // irrelevante, sem escrita em reg
				RegWrite = 0;
				ALUSrc = 1;
				Branch = 0;
				MemRead = 0;
				MemWrite = 1;
				MemToReg = 0; // irrelevante, sem escrita em reg
				ALUOp = 2'b00;
				Jump = 0;
				WritePC4 = 0;
			end
				
			6'b000100: begin // BEQ
				RegDst = 0; // irrelevante, sem escrite em reg
				RegWrite = 0; // irrelevante, sem escrita em reg
				ALUSrc = 0;
				Branch = 1;
				MemRead = 0;
				MemWrite = 0;
				MemToReg = 0; // irrelevante, sem escrita em reg
				ALUOp = 2'b01;
				Jump = 0;
				WritePC4 = 0;
			end
				
			6'b001000: begin // ADDI
				RegDst = 0;
				RegWrite = 1;
				ALUSrc = 1;
				Branch = 0;
				MemRead = 0;
				MemWrite = 0;
				MemToReg = 0;
				ALUOp = 2'b00;
				Jump = 0;
				WritePC4 = 0;
			end
			
			6'b001100: begin // ANDI (ERRO)
				RegDst = 0;
				RegWrite = 1;
				ALUSrc = 1;
				Branch = 0;
				MemRead = 0;
				MemWrite = 0;
				MemToReg = 0;
				ALUOp = 2'b10;
				Jump = 0;
				WritePC4 = 0;
			end
			
			6'b001101: begin // ORI
				RegDst = 0;
				RegWrite = 1;
				ALUSrc = 1;
				Branch = 0;
				MemRead = 0;
				MemWrite = 0;
				MemToReg = 0;
				ALUOp = 2'b11;
				Jump = 0;
				WritePC4 = 0;
			end
			
			6'b001110: begin // XORI
				RegDst = 0;
				RegWrite = 1;
				ALUSrc = 1;
				Branch = 0;
				MemRead = 0;
				MemWrite = 0;
				MemToReg = 0;
				ALUOp = 2'bxx;
				Jump = 0;
				WritePC4 = 0;
			end
			
			6'b000101: begin // BNE
				RegDst = 0; // irrelevante, sem escrite em reg
				RegWrite = 0; // irrelevante, sem escrita em reg
				ALUSrc = 0;
				Branch = 1;
				MemRead = 0;
				MemWrite = 0;
				MemToReg = 0; // irrelevante, sem escrita em reg
				ALUOp = 2'b01;
				Jump = 0;
				WritePC4 = 0;
			end
			
			6'b001010: begin // SLTI (ERRO)
				RegDst = 0;
				RegWrite = 1;
				ALUSrc = 1;
				Branch = 0;
				MemRead = 0;
				MemWrite = 0;
				MemToReg = 0;
				ALUOp = 2'b10;
				Jump = 0;
				WritePC4 = 0;
			end
			
			6'b001011: begin // SLTIU
				RegDst = 0;
				RegWrite = 1;
				ALUSrc = 1;
				Branch = 0;
				MemRead = 0;
				MemWrite = 0;
				MemToReg = 0;
				ALUOp = 2'b10;
				Jump = 0;
				WritePC4 = 0;
			end
			
			6'b001111: begin // LUI
				RegDst = 0;
				RegWrite = 1;
				ALUSrc = 1;
				Branch = 0;
				MemRead = 0;
				MemWrite = 0;
				MemToReg = 0;
				ALUOp = 2'bxx;
				Jump = 0;
				WritePC4 = 0;
			end
			
			6'b000010: begin // J
				RegDst = 0;
				RegWrite = 0;
				ALUSrc = 0;
				Branch = 0;
				MemRead = 0;
				MemWrite = 0;
				MemToReg = 0;
				ALUOp = 2'bxx;
				Jump = 1;
				WritePC4 = 0;
			end
			
			6'b000011: begin // JAL
				RegDst = 0;
				RegWrite = 1;
				ALUSrc = 0;
				Branch = 0;
				MemRead = 0;
				MemWrite = 0;
				MemToReg = 0;
				ALUOp = 2'bxx;
				Jump = 1;
				WritePC4 = 1;
			end
			
		endcase
	end
endmodule
			