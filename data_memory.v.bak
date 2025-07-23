
module data_memory (clk, address, writeData, readData, memWrite, memRead);
// Declarar parâmetros
	parameter data_width 		= 32;
	parameter address_width 	= 32;
	parameter memory_size		= 2**address_width;
	
// Portas Parametrizadas
	input wire [address_width-1:0] address;						// Endereço a ser lido na memória, vindo do resultado da operação da ULA
	input wire [data_width-1:0] writeData;							// Endereço a ser escrito na memória, vindo do 2 Read Data do regfile
		
	input clk; 																// Clock para as leituras assíncronas e escritas síncronas
	input wire memWrite, memRead;										// Flags postas para definir o que será utilizado no ciclo, se é escrita(memWrite) ou leitura(memRead)	
	
	output reg [data_width-1:0] readData;							// O que foi lido da memória(caso for utilizado)
	
reg [data_width-1:0] memory [memory_size-1:0];				// A memória do data_memory
	
	
// Funcionamento do data_memory	
	always @ (posedge clk) begin										// Questão do Clock
	
		if (memWrite == 1) begin							
			memory[address] = writeData[31:0];
		end
		
	end
	
	// Essa parte pode conter mudanças, o professor falou que era pra se testar.
	always @ (negedge clk) begin
		
		if (memRead == 1) begin
			assign readData = memory[address];
		end
	end
	


endmodule