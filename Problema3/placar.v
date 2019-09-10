module placar(
    clock,          //clock 25MHz
    reset,          //entrada para limpar o placar
    player1,        //ponto para o jogador da direita
    player2,        //ponto para o jogador da esquerda
    punch_left,     //tocou na esquerda
    punch_right,    //tocou na direita

    write_score,    //saída com os dados para o lcd
    LCD_en,         //enable do lcd
    LCD_rs          //rs do lcd
);
    input clock;
    input reset;
    input [2:0] player1;
    input [2:0] player2;
    input punch_left;
    input punch_right;

    output reg [7:0] write_score;
    output reg LCD_en;
    output reg LCD_rs;

    //6 arrays de 8 posições que armazena os valores dos numeros em hexa
    reg [5:0] foo [7:0];
        foo[0] = 8'h30;
        foo[1] = 8'h31;
        foo[2] = 8'h32;
        foo[3] = 8'h33;
        foo[4] = 8'h34;
        foo[5] = 8'h35;

    //3 arrays de 8 posições que armazena o hexadecimal dos shifts
    reg [2:0] pos [7:0];
        pos[0] = 8'h0A; //Shift na linha 1
        pos[1] = 8'h40; //Pula linha
        pos[2] = 8'h4A; //Shift na linha 2

    parameter [2:0] INIT = 3'b0,
                    WRITE_1 = 3'b1,
                    WRITE_2 = 3'b2,
                    SHIFT_1 = 3'b3,
                    SHIFT_2 = 3'b4,
                    LINE = 3'b5;

    reg [1:0] state;

    initial begin
        state = INIT;
    end

    //loop para mudança de estados
    always @(posedge clock)
    begin
        if(reset)
        begin
            state <= INIT;
        end
        else
        begin
            LCD_en <= 1'b0;
            case (state)
                INIT:
                begin
                    if(punch_left || punch_right) state <= SHIFT_1;
                end
                WRITE_1:
                begin
                    LCD_rs <= 1'b0
                    state <= LINE;
                end
                WRITE_2:
                begin
                    LCD_rs <= 1'b0
                    state <= INIT;
                end
                SHIFT_1:
                begin
                    LCD_rs <= 1'b1
                    state <= WRITE_1;
                end
                SHIFT_2:
                begin
                    LCD_rs <= 1'b1
                    state <= WRITE_2;
                end
                LINE:
                begin
                    LCD_rs <= 1'b1
                    state <= SHIFT_2;
                end
            endcase
        end
    end
    
    //Loop para verificar as ações dos estados
    always @(state)
    begin
        case (state)
            WRITE_1:
            begin
                if(player1 == 3'b0) write_score <= foo[0];
                if(player1 == 3'b1) write_score <= foo[1];
                if(player1 == 3'b2) write_score <= foo[2];
                if(player1 == 3'b3) write_score <= foo[3];
                if(player1 == 3'b4) write_score <= foo[4];
                if(player1 == 3'b5) write_score <= foo[5];
                LCD_en <= 1'b1;
            end
            WRITE_2:
            begin
                if(player2 == 3'b0) write_score <= foo[0];
                if(player2 == 3'b1) write_score <= foo[1];
                if(player2 == 3'b2) write_score <= foo[2];
                if(player2 == 3'b3) write_score <= foo[3];
                if(player2 == 3'b4) write_score <= foo[4];
                if(player2 == 3'b5) write_score <= foo[5];
                LCD_en <= 1'b1;
            end
            SHIFT_1:
            begin
                write_score <= pos[0];
                LCD_en <= 1'b1;
            end
            SHIFT_2:
            begin
                write_score <= pos[2];
                LCD_en <= 1'b1;
            end
            LINE:
            begin
                write_score <= pos[1];
                LCD_en <= 1'b1;
            end
        endcase
    end

endmodule