module LCD_Controll(
	data_a, 	//dado da função que determina se a entrada b é dado ou instrução
	data_b,		//dado de entrada para realizar ação no LCD
	result, 	//retorno do modulo
	clock, 		//entrada de clock
	clock_en, //Habilitando o clock para função
	start,		//Usado para dar inicio ao modulo
	reset,		//entrada para reiniciar o ciclo
	done,			//saída usada como flag pro assembly continuar
	LCD_rs,		//pino do rs do LCD, usado para definir se é instrução ou dado
	LCD_rw,		//pino de rw do LCD, usado para definir se é leitura ou escrita
	LCD_en,		//pino de en do LCD, usado para acionar o LCD para fazer algo de acordo com os pino acima
	LCD_dados //Pinos de dados do LCD, usado para passar informações ao LCD
);
	//Setando as entradas do sistema
	input [31:0] data_a;
	input [31:0] data_b;
	input clock;
	input clock_en;
	input start;
	input reset;

	//Setando as saídas
	output reg [31:0] result;
	output LCD_rw;
	output reg [7:0] LCD_dados;
	output reg done;
	output reg LCD_rs;
	output reg LCD_en;

	//Registradores internos usados pela maquina de estado e contador
	reg [1:0] state;
	reg [31:0] counter;

	//Informando que o pino de saída será sempre 0
	assign LCD_rw = 1'b0;

	//Setando constantes
	localparam Midle = 2'b00;
	localparam Busy = 2'b01;
	localparam End = 2'b11;

	//sempre que houver uma subida de clock é executado
	always @ (posedge clock)
	begin
		if (reset) //Se a entrada reset estiver em 1, limpa-se os dados abaixo
			begin
				state <= Midle; //Volta pro estado de inicio
				counter <= 16'd0;
				result <= 32'd0;
				LCD_dados <= 8'b0;
				done <= 1'b0;
				LCD_rs <= 1'b0;
				LCD_en <= 1'b1;
			end
		else //Se não tiver reset (reset = 0)
			begin
				if (clock_en) //Se o uso do clock estiver habilitado
					begin
						case (state) //verifica o estado atual
							Midle: //aq ele irá escrever o dado no LCD
								begin
									done <= 1'b0;
									LCD_en <= 1'b1; //seta o enable do LCD para 0 e quando voltar a ser 1 ele escreve algo

									if (start) //Se for solicitado o inico do modulo
										begin
											state <= Busy;
											counter <= 16'd0;
											LCD_rs <= data_a[0]; //Define se é dado ou instrução
											LCD_dados <= data_b[7:0]; //escreve oq estiver no dado
										end
								end
							Busy: //Mantem o modulo em estado de espera durante 10ms
								begin
									if (counter < 32'd100000)
										begin
											counter <= counter + 32'd1;
										end
									else
										begin
											state <= End; //vai pro estado final da maquina
											counter <= 32'd0;
											LCD_en <= 1'b0; //põe o enable do LCD para 0, executando alguma ação (seja instrução ou escrita)
										end
								end
							End: //Estado final, espera alguns mili segundos e volta pro estado inicial
								begin
									if (counter < 32'd100000)
										begin
											counter <= counter + 32'd1;
										end
									else
										begin
											state <= Midle;
											done <= 1'b1; //seta o valor de done para 1, mostrando q a maquina acabou a execução
											result <= 32'd1; //Envia como resultado o valor 1
										end
								end
						endcase
					end
			end
	end

endmodule