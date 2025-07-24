// Atividade 2VA - Arquitetura e Organizacao de Computadores [2025.1]
// Gabriel Germano dos Santos Wanderley
// Samara Accioly
// Vitor Barros de Carvalho
// Wellington Viana da Silva Junior


module Regfile(
    input [4:0] ReadRegister1,     // Endereço do registrador a ser lido (porta 1)
    input [4:0] ReadRegister2,     // Endereço do registrador a ser lido (porta 2)
    input [4:0] WriteRegister,     // Endereço do registrador a ser escrito
    input [31:0] WriteData,        // Dado a ser escrito no registrador
    input clk,                   // Sinal de clock (subida de borda)
    input rst,                   // Sinal de reset (ativa todos os registradores para 0)
    input RegWrite,                // Sinal de controle que habilita escrita
    output [31:0] ReadData1,       // Dado lido da porta 1
    output [31:0] ReadData2        // Dado lido da porta 2
);

// Banco de 32 registradores, com 32 bits cada
reg [31:0] registradores[0:31];

// Variável auxiliar para laço de inicialização
integer aux;

// Bloco sempre sensível à borda de subida do clock ou do reset
always @ (posedge clk or posedge rst) begin
    if (rst) begin
        // Zera todos os registradores no reset
        for (aux = 0; aux < 32; aux = aux + 1) begin
            registradores[aux] <= 32'b0;
				aux = aux + 1;
        end
    
	 end else begin
        // Escrita apenas se RegWrite estiver ativo e registrador não for o zero
        if (RegWrite && WriteRegister != 5'b00000) begin
            registradores[WriteRegister] <= WriteData;
        end
    end
end

// Atribuição dos dados de saída
assign ReadData1 = registradores[ReadRegister1];
assign ReadData2 = registradores[ReadRegister2];

endmodule
