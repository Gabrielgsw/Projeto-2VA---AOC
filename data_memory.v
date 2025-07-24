// Atividade 2VA - Arquitetura e Organizacao de Computadores [2025.1]
// Gabriel Germano dos Santos Wanderley
// Samara Accioly
// Vitor Barros de Carvalho
// Wellington Viana da Silva Junior


module data_memory (address, writeData, readData, memWrite, memRead);
// Declarar parâmetros
	parameter data_width 		= 32;
	parameter address_width 	= 32;
	parameter memory_size		= 6;
	
// Portas Parametrizadas
	input wire [address_width-1:0] address;						// Endereço a ser lido na memória, vindo do resultado da operação da ULA
	input wire [data_width-1:0] writeData;							// Endereço a ser escrito na memória, vindo do 2 Read Data do regfile
																				// Clock para as leituras assíncronas e escritas síncronas
	input wire memWrite, memRead;										// Flags postas para definir o que será utilizado no ciclo, se é escrita(memWrite) ou leitura(memRead)	
	
	output reg [data_width-1:0] readData;							// O que foi lido da memória(caso for utilizado)
	
reg [data_width-1:0] memory [0:(1 << memory_size) -1];				// A memória do data_memory
	
	
// Funcionamento do data_memory	
	always @ (*) begin										// Questão da leitura e escrita
	
		if (memRead == 1) begin	// se memRead ativo le e salva o endereco da memoria no readData (LW)						
			readData = memory[address];
		end
		
		else begin // caso nao, verifica se escrita em memoria (SW)
			readData = 32'b0;
			if (memRead == 1)
				memory[address] = writeData;
		end
	end
	


endmodule
