// Atividade 2VA - Arquitetura e Organizacao de Computadores [2025.1]
// Gabriel Germano dos Santos Wanderley
// Samara Accioly
// Vitor Barros de Carvalho
// Wellington Viana da Silva Junior


module data_memory (clock, address, writeData, readData, memWrite, memRead);
// Declarar parâmetros
	parameter data_width 		= 32;
	parameter address_width 	= 32;
	parameter memory_size		= 128;
	
// Portas Parametrizadas
	input wire clock;
	input wire [address_width-1:0] address;						// Endereço a ser lido na memória, vindo do resultado da operação da ULA
	input wire [data_width-1:0] writeData;							// Endereço a ser escrito na memória, vindo do 2 Read Data do regfile
																				// Clock para as leituras assíncronas e escritas síncronas
	input wire memWrite, memRead;										// Flags postas para definir o que será utilizado no ciclo, se é escrita(memWrite) ou leitura(memRead)	
	
	output reg [data_width-1:0] readData;							// O que foi lido da memória(caso for utilizado)
	
reg [data_width-1:0] memory [0:memory_size-1];				// A memória do data_memory
	
	
// Funcionamento do data_memory	

	// Escrita síncrona
    always @(posedge clock) begin
        if (memWrite)
            memory[address] <= writeData;
    end

    // Leitura assíncrona
    always @(*) begin
        if (memRead)
            readData = memory[address];
        else
            readData = 32'b0;
    end
	 
endmodule
