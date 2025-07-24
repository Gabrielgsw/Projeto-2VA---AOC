// Atividade 2VA - Arquitetura e Organizacao de Computadores [2025.1]
// Gabriel Germano dos Santos Wanderley
// Samara Accioly
// Vitor Barros de Carvalho
// Wellington Viana da Silva Junior


module PC(
    input wire clk,
    input wire reset,
    input wire [31:0] nextPC, // proxima endereco/instrucao
    output reg [31:0] PC 
);
// logica do clk com reset para que seja reiniciado ou avance para nextPC
    always @(posedge clk or posedge reset) begin
        if (reset) begin // zera o pc em caso de reset
            PC <= 32'b0;
        end else begin // avanca para proximo endereco
            PC <= nextPC;
        end
    end

endmodule
