module MIPS_Processador(clock, reset, PC_out, ULA_A, ULA_B, ULA_out, d_mem_out);

	// Entradas e saídas do Top Level
	input wire clock, reset;
	output wire [31:0] PC_out, ULA_A, ULA_B, ULA_out, d_mem_out; //remover as ulas dps

	// Cabos para o funcionamento do MIPS
	wire [31:0] cabo_next_PC;
	wire [31:0] cabo_PC_out;


	wire [31:0] cabo_i_mem_out;
	wire [31:0] cabo_d_mem_out;

	wire [15:0] cabo_sign_extend;
	assign cabo_sign_extend = cabo_i_mem_out[15:0];
	wire [31:0] cabo_sign_extend_out;

	wire [5:0] cabo_opcode, cabo_funct;
	wire [4:0] cabo_rs, cabo_rt, cabo_rd, cabo_shamt, cabo_regfile_dst;

	wire [31:0] valor_reg1;
	wire [31:0] valor_reg2;
	wire [31:0] cabo_regfile_write_data;

	wire [31:0] cabo_mux_entrada_A_ULA;							
	wire [31:0] cabo_mux_entrada_B_ULA;

	wire [31:0] cabo_mux_regfile_dst;

	// Declaração dos cabos da ULA:
	wire cabo_zero_flag;
	wire [31:0] cabo_ALU_out;

	// Cabos da ULA Control
	wire [3:0] cabo_ALU_ctrl_out;
	wire shamt;


	//Sinais de Controle
	wire RegDst; 
	wire RegWrite;
	wire ALUSrc;
	wire Branch;
	wire MemRead;
	wire MemWrite;
	wire MemToReg;
	wire Jump;
	wire WriteLink;
	wire [3:0] ALUOp;
	
	
	//Assign de tudo
	assign cabo_opcode = cabo_i_mem_out [31:26];
	assign cabo_funct = cabo_i_mem_out [5:0];
	assign cabo_rs = cabo_i_mem_out [25:21];
	assign cabo_rt = cabo_i_mem_out [20:16];
	assign cabo_rd = cabo_i_mem_out [15:11];
	assign cabo_shamt = cabo_i_mem_out[10:6];
	


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
	
	controle_ULA controle_ULA_inst(
	.ALUOp(ALUOp),
	.funct(cabo_funct),
	.ALUControl(cabo_ALU_ctrl_out),
	.shamt(shamt)
	);


	PC pc_inst(
		.clk(clock),
		.reset(reset),
		.nextPC(mux_nextPC),
		.PC(cabo_PC_out)
	);
	
	
	
	i_mem i_mem_inst(
	.address(cabo_PC_out),
	.i_out(cabo_i_mem_out)
	);
	
	sign_extend sign_extend_inst (
	.instruction(cabo_sign_extend),
	.out(cabo_sign_extend_out)
	);
	
	assign cabo_shift_left2 = cabo_sign_extend_out << 2;
	assign mux_RegDst = RegDst ? cabo_rd : cabo_rt;

	 
	
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
	
	
	assign mux_ALUSrc = ALUSrc ? cabo_sign_extend_out : valor_reg2;
	assign mux_shamt_or_reg1 = shamt ? cabo_shamt : valor_reg1;
	
	ula ula_inst(
	.in1(mux_shamt_or_reg1),
	.in2(mux_ALUSrc),
	.op(cabo_ALU_ctrl_out),
	.result(cabo_ALU_out),
	.zero_flag(cabo_zero_flag)
	);
	

	
	data_memory data_memory_inst(
	.clk(clock),
	.address(cabo_ALU_out),
	.writeData(valor_reg2),
	.readData(cabo_d_mem_out),
	.memWrite(MemWrite),
	.memRead(MemRead)
	);
	
	assign mux_MemToReg = MemToReg ? cabo_d_mem_out : cabo_ALU_out;
	
	assign PC_out = cabo_PC_out;
	assign ULA_A = mux_shamt_or_reg1;
	assign ULA_B = mux_ALUSrc;
	assign ULA_out = cabo_ALU_out;
	assign d_mem_out = cabo_d_mem_out;
	
	
	// Somador PC+4	
	assign cabo_somador_pc_4 = cabo_PC_out + 4;
	
	assign sel_nextPC = Branch & cabo_zero_flag;

	assign mux_nextPC = sel_nextPC ? ALU_result : cabo_somador_pc_4;
	
	assign ALU_result = cabo_somador_pc_4 + cabo_shift_left2;

endmodule
