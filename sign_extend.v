// Atividade 2VA - Arquitetura e Organizacao de Computadores [2025.1]
// Gabriel Germano dos Santos Wanderley
// Samara Accioly
// Vitor Barros de Carvalho
// Wellington Viana da Silva Junior


module sign_extend(input wire[15:0] instruction, output wire[31:0] out); // entrada de 16 bits e saida de 32 bits
	// repete 16 vezes o bit ins[15] (mais significativo) e faz concatenacao com a instrucao total
	assign out = {{16{instruction[15]}}, instruction};
	
endmodule
	
	
