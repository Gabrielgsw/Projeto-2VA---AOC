// Atividade 2VA - Arquitetura e Organizacao de Computadores [2025.1]
// Gabriel Germano dos Santos Wanderley
// Samara Accioly
// Vitor Barros de Carvalho
// Wellington Viana da Silva Junior


module sign_extend(input wire[15:0] instruction, output wire[31:0] out); 

	assign out = {{16{instruction[15]}}, instruction};
	
endmodule
	
	
