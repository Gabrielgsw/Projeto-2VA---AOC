// Unidade de Controle

module controle(opcode, RegDst, RegWrite, ALUSrc, Branch, MemRead, MemWrite, MemToReg, Jump, WriteLink, ALUOp);
	input wire [5:0] opcode;
	output reg RegDst, RegWrite, ALUSrc, Branch, MemRead, MemWrite, MemToReg, Jump, WriteLink;
	output reg [3:0] ALUOp;
	
	always @ (*) begin
			// default
			RegDst = 0;
			RegWrite = 0;
			ALUSrc = 0;
			Branch = 0;
			MemRead = 0;
			MemWrite = 0;
			MemToReg = 0;
			ALUOp = 4'b0000;
			Jump = 0;
			WriteLink = 0;
	
		case(opcode)
			6'b000000: begin // R-type
				RegDst = 1;
				RegWrite = 1;
				ALUOp = 4'b1111;
			end
				
			6'b100011: begin // LW
				RegWrite = 1;
				ALUSrc = 1;
				MemRead = 1;
				MemToReg = 1;
			end
				
			6'b101011: begin // SW
				ALUSrc = 1;
				MemWrite = 1;
			end
				
			6'b000100: begin // BEQ
				Branch = 1;
				ALUOp = 4'b0001;
			end
				
			6'b001000: begin // ADDI
				RegWrite = 1;
				ALUSrc = 1; // ALUOp fica o mesmo da soma de LW e SW (0000)
			end
			
			6'b001100: begin // ANDI
				RegWrite = 1;
				ALUSrc = 1;
				ALUOp = 4'b0101;
			end
			
			6'b001101: begin // ORI
				RegWrite = 1;
				ALUSrc = 1;
				ALUOp = 4'b0110;
			end
			
			6'b001110: begin // XORI
				RegWrite = 1;
				ALUSrc = 1;
				ALUOp = 4'b0111;
			end
			
			6'b000101: begin // BNE
				Branch = 1;
				ALUOp = 4'b0010;
			end
			
			6'b001010: begin // SLTI
				RegWrite = 1;
				ALUSrc = 1;
				ALUOp = 4'b0011;
			end
			
			6'b001011: begin // SLTIU
				RegWrite = 1;
				ALUSrc = 1;
				ALUOp = 4'b0100;
			end
			
			6'b001111: begin // LUI
				RegWrite = 1;
				ALUSrc = 1;
				ALUOp = 4'b1000;
			end
			
			6'b000010: begin // J
				Jump = 1;
			end
			
			6'b000011: begin // JAL
				RegWrite = 1;
				Jump = 1;
				WriteLink = 1;
			end
			
		endcase
	end
endmodule
			