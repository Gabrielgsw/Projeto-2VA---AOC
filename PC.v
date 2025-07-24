// Atividade 2VA - Arquitetura e Organizacao de Computadores [2025.1]
// Gabriel Germano dos Santos Wanderley
// Samara Accioly
// Vitor Barros de Carvalho
// Wellington Viana da Silva Junior


module PC(
    input wire clk,
    input wire reset,
    input wire [31:0] nextPC,
    output reg [31:0] PC
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            PC <= 32'b0;
        end else begin
            PC <= nextPC;
        end
    end

endmodule
