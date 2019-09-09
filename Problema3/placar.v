module placar(
    clock,          //clock 25MHz
    reset,          //entrada para limpar o placar
    ponto_esquerda, //ponto para o jogador da direita
    ponto_direita,  //ponto para o jogador da esquerda
    enable,         //ativa a escrita
    ganhador        //informa o campeao da partida, 0: partida em curso, 1 e 2 para os respectivos players
);
    input clock;
    input ponto_esquerda;
    input ponto_direita;
    input enable;

    output reg [1:0] ganhador;

    reg [2:0] player1 = 0, player2 = 0;

    always @(posedge clock) 
    begin
        if(reset) begin
            player1 = 0;
            player2 = 0;
        end
        else begin
            
        end
    end

endmodule