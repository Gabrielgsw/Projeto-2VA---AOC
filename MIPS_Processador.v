// Atividade 2VA - Arquitetura e Organizacao de Computadores [2025.1]
// Gabriel Germano dos Santos Wanderley
// Samara Accioly
// Vitor Barros de Carvalho
// Wellington Viana da Silva Junior

module MIPS_Processador(clock, reset, PC_out, ULA_out, d_mem_out);

	// Entradas e saídas do Top Level
	input wire clock, reset; // clock e reset
	output wire [31:0] PC_out, ULA_out, d_mem_out; //remover as ulas dps	
	
	
	
	// Cabos para o funcionamento do MIPS
	
	
	// ####### Cabos para o funcionamento do PC #######
	wire [31:0] mux_nextPC; 			// mux para decidir entre jump, branch e pc+4
	wire [31:0] cabo_PC_out; 			// saida do PC
	wire [31:0] cabo_somador_jump; 	// somador para jump
	wire [31:0] somador_PC_4; 			// somador para PC+4
	wire [31:0] cabo_shift_left2; 	// shift left 2
	wire [31:0] jump_address;			// endereço de jump
	
	
	// ####### Cabos para o funcionamento da ULA #######
	wire [31:0] mux_alu_1; 				// mux para decidir entre sham ou reg1 do regfile
	wire [31:0] mux_alusrc;				// mux ALUSrc
	wire [31:0] ALU_result; 			// saida da ULA
	wire cabo_zero_flag; 				// cabo para checar BEQ
	
	
	// ####### Cabos da ULA Control #######
	wire [3:0] cabo_ALU_ctrl_out; 	// saida do controle da ULA
	wire shamt; 							// shift amount
	
	
	// ####### Cabos para o funcionamento do Sign Extend #######
	wire [15:0] cabo_sign_extend; 						// extensor de sinal
	assign cabo_sign_extend = cabo_i_mem_out[15:0]; // recebe os bits menos significativos da instrucao
	wire [31:0] cabo_sign_extend_out; 					// saida do extensor de sinal
	wire [31:0] immediate;
	assign immediate = cabo_sign_extend_out;

	
	// ####### Cabos para a separação de dados na instrução #######
	wire [25:0] cabo_jump;
	wire [5:0] cabo_opcode, cabo_funct; // cabo opcode e funct para controle e ALUControl
	wire [4:0] cabo_rs, cabo_rt, cabo_rd, cabo_shamt, cabo_regfile_dst; // cabos dos registradores, shamt e do registrador destino
	
	
	// ####### Cabos para o funcionamento no RegFile #######
	wire [31:0] valor_reg1; 					// valor do primeiro reg
	wire [31:0] valor_reg2; 					// valor do segundo reg
	
	wire [31:0] cabo_mux_regfile_dst; 		// cabo do mux RegDst -> Decidir WriteRegister
	wire [31:0] mux_MemToReg; 					// cabo do mux MemToReg -> Ir para o WriteData


	
	// ####### Cabos de saída de dados na memória(seja ela ROM ou RAM) #######
	wire [31:0] cabo_i_mem_out; 	// saida de instruction memory
	wire [31:0] cabo_d_mem_out; 	// saida do data memory
	
	
	// ####### Sinais de Controle #######
	wire RegDst; 
	wire RegWrite;
	wire ALUSrc;
	wire Branch;
	wire MemRead;
	wire MemWrite;
	wire MemToReg;
	wire Jump; 				// usado para instrucoes j e jal
	wire WriteLink; 		// usado para jal
	wire JumpRegister;	// Usado para JR
	wire [3:0] ALUOp; 	// expansao para 3 bits para suportar mais instrucoes de forma direta
	
	
	// ####### Assign dos bits da saida do instruction memory #######
	assign cabo_opcode = cabo_i_mem_out [31:26];
	assign cabo_funct = cabo_i_mem_out [5:0];
	assign cabo_rs = cabo_i_mem_out [25:21];
	assign cabo_rt = cabo_i_mem_out [20:16];
	assign cabo_rd = cabo_i_mem_out [15:11];
	assign cabo_shamt = cabo_i_mem_out[10:6];
	assign cabo_jump = cabo_i_mem_out[25:0];
	
	
	// ####### Parte acima dos JUMPS e PC + 4 #######
	assign jump_address = {somador_PC_4, cabo_jump, 2'b00};

	assign mux_nextPC = JumpRegister ? valor_reg1 :
                    Branch && cabo_zero_flag ? cabo_somador_jump :
                    Jump ? jump_address :
                    somador_PC_4;
								
	// PC + 4
	assign somador_PC_4 = cabo_PC_out + 4;
	
	// Shift Left no Sign-Extend
	assign cabo_shift_left2 = cabo_sign_extend_out << 2;
	
	// Somador ALU Result lá de cima (PC+4 + Shift Left 2)
	assign cabo_somador_jump = somador_PC_4 + cabo_shift_left2;

	
	
	// modulo da unidade de controle
	controle controle_inst(
	.opcode(cabo_opcode),
	.RegDst(RegDst),
	.RegWrite(RegWrite),
	.ALUSrc(ALUSrc),
	.Branch(Branch),
	.MemRead(MemRead),
	.MemWrite(MemWrite),
	.MemToReg(MemToReg),
	.Jump(Jump),
	.WriteLink(WriteLink),
	.ALUOp(ALUOp)
	);
	
	// modo da unidade de controle da ULA
	controle_ULA controle_ULA_inst(
	.ALUOp(ALUOp),
	.funct(cabo_funct),
	.ALUControl(cabo_ALU_ctrl_out),
	.shamt(shamt),
	.JumpRegister(JumpRegister)
	);

	// modulo do PC
	PC pc_inst(
		.clk(clock),
		.reset(reset),
		.nextPC(mux_nextPC),
		.PC(cabo_PC_out)
	);

	
	// modulo do instruction memory
	i_mem i_mem_inst(
	.address(cabo_PC_out),
	.i_out(cabo_i_mem_out)
	);
	
	// modulo do extensor de sinal
	sign_extend sign_extend_inst (
	.instruction(cabo_sign_extend),
	.out(cabo_sign_extend_out)
	);
	 

	// decide entre rd ou rt para regdst
	assign cabo_regfile_dst = RegDst ? cabo_rd : cabo_rt;

	// decide entre saida do data memory ou saida da ULA para MemToReg
	assign mux_MemToReg = MemToReg ? cabo_d_mem_out : ALU_result;

	// modulo do regfile
	Regfile regfile_inst(
	.ReadRegister1(cabo_rs),
	.ReadRegister2(cabo_rt),
	.WriteRegister(cabo_regfile_dst),
	.WriteData(mux_MemToReg),  
	.clk(clock),
	.rst(reset),
	.RegWrite(RegWrite),
	.ReadData1(valor_reg1),
	.ReadData2(valor_reg2)
	);
	
	// modulo do data memory
	data_memory data_memory_inst(
	.clock(clock),
	.address(ALU_result),				// Entrada saindo da ula
	.writeData(valor_reg2),				// Entrada vindo do RegFile(Escrita)
	.readData(cabo_d_mem_out),	
	.memWrite(MemWrite),
	.memRead(MemRead)
	);

	assign mux_alu_1 = shamt ? cabo_shamt : valor_reg1;		//mux: shamt or reg1
	assign mux_alusrc = ALUSrc ? immediate : valor_reg2;		//mux: immediate or valor_reg2

	// modulo da ULA
	ula ULA_inst (
	.in1(mux_alu_1),					// Entrada Que pode ser shamt ou reg1
	.in2(mux_alusrc),					// Entrada ALUSrc
	.op(ALUOp),
	.result(ALU_result),
	.zero_flag(cabo_zero_flag)
	);
		
	assign PC_out = cabo_PC_out; // saida do PC
	assign d_mem_out = cabo_d_mem_out; // saida do data memory
	assign ULA_out = ALU_result; // saida da ULA 


endmodule
