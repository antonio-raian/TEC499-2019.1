module LCD_Controll ctrl (
		Clock, //Pino do clock
		entrada, //Posião de memória de entrada
		LCD_RS, //Pino do RS do display
		LCD_EN, //Pino de enable do display
		LCD_RW, //Pino de RW do display
		LCD_DATA, //Pinos de dados do display
		LED //Pino do led
	);

	input Clock;
	input [3:0] entrada;

	output LCD_RS;
	output LCD_EN;
	output LCD_RW;
	output LED;
	output [7:0] LCD_DATA;

	reg	rs;
	reg	rw;
	reg [3:0] state;
	reg [3:0] next;
	reg [7:0] data_out;
	reg [4:0] led;

	assign LCD_RS = rs;
	assign LCD_EN = Clock;
	assign LCD_RW = rw;
	assign LCD_DATA = data_out;
	assign LED = led;

	//Estados da maquina
	parameter [3:0] M_LED1 = 4'h0, 
		M_LED2 = 4'h1,
		M_LED3 = 4'h2,
		M_LED4 = 4'h3,
		M_LED5 = 4'h4,
		L_LED1 = 4'h5,
		L_LED2 = 4'h6,
		L_LED3 = 4'h7,
		L_LED4 = 4'h8,
		L_LED5 = 4'h9,
		ESCREVE = 4'h10,
		LIMPAR = 4'h11;

	initial begin
		state=>s_LED1;
	end

	reg [5:0] count = 6'b0000000; //Variável pra poder mudar a o tipo de caractere na exibição

	//Array que amazena o valor ASCII do caracter
	wire [7:0] foo [0:13];

	assign foo[0]  = "L";
	assign foo[1]  = "E";
	assign foo[2]  = "D";
	assign foo[3]  = "1";
	assign foo[4]  = "2";
	assign foo[5]  = "3";
	assign foo[6]  = "4";
	assign foo[7]  = "5";
	assign foo[8]  = "A";
	assign foo[9]  = "C";
	assign foo[10] = "E";
	assign foo[11] = "S";
	assign foo[12] = "O";
	assign foo[13] = " ";

	//A cada ciclo do clock ele verifica o estado
	//Se estiverem no estado M verifica o valor da entrada e se for um dos determinados ele migra pra outro estado
	always @(posedge Clock) begin
		case(state)
			M_LED1:begin
				if(entrada == 4'b1000) begin
					state <= M_LED5;
					count <= 0;
				end else if(entrada == 4'b0100)begin
					state <= M_LED2;
				end else if(entrada == 4'b0010)begin
					state <= L_LED1;
				end
			end
			M_LED2:begin
				if(entrada == 4'b1000) begin
					state <= M_LED1;
				end else if(entrada == 4'b0100)begin
					state <= M_LED3;
				end else if(entrada == 4'b0010)begin
					state <= L_LED2;
				end
			end				
			M_LED3:begin
				if(entrada == 4'b1000) begin
					state <= M_LED2;
				end else if(entrada == 4'b0100)begin
					state <= M_LED4;
				end else if(entrada == 4'b0010)begin
					state <= L_LED3;
				end
			end
			M_LED4: begin
				if(entrada == 4'b1000) begin
					state <= M_LED3;
				end else if(entrada == 4'b0100)begin
					state <= M_LED5;
				end else if(entrada == 4'b0010)begin
					state <= L_LED4;
				end 
			end
			M_LED5:begin
				if(entrada == 4'b1000) begin
					state <= M_LED4;
				end else if(entrada == 4'b0100)begin
					state <= M_LED1;
				end else if(entrada == 4'b0010)begin
					state <= L_LED5;
				end 
			end				
			L_LED1: begin
				if(entrada == 4'b0001) begin
					state <= M_LED1;
				end
			end				
			L_LED2:begin
				if(entrada == 4'b0001) begin
					state <= M_LED2;
				end 
			end
			L_LED3:begin
				if(entrada == 4'b0001) begin
					state <= M_LED3;
				end 
			end
			L_LED4:begin
				if(entrada == 4'b0001) begin
					state <= M_LED4;
				end 
			end
			L_LED5:begin
				if(entrada == 4'b0001) begin
					state <= M_LED5;
				end 
			end
		endcase
	end

	//Sempre que o estado mudar ele faz alguma coisa
	//Se o estado estiver nos M deve escrever no data_out "LED (numero)"
	//Se o estado estiver nos L deve escrever no data_out "ACESO (numero)"
	always @(state)
		case (state)
			M_LED1: begin
				if (count == 6'h0) begin
					data_out <= foo[0];
					count <= count+1;
				end
				if (count == 6'h1) begin
					data_out <= foo[1];
					count <= count+1;
				end
				if (count == 6'h2) begin
					data_out <= foo[2];
					count <= count+1;
				end
				if (count == 6'h3) begin
					data_out <= foo[13];
					count <= count+1;
				end
				if (count == 6'h4) begin
					data_out <= foo[3];
					count <= count+1;
				end
			end
			M_LED2:begin
				if (count == 6'h0) begin
					data_out <= foo[0];
					count <= count+1;
				end
				if (count == 6'h1) begin
					data_out <= foo[1];
					count <= count+1;
				end
				if (count == 6'h2) begin
					data_out <= foo[2];
					count <= count+1;
				end
				if (count == 6'h3) begin
					data_out <= foo[13];
					count <= count+1;
				end
				if (count == 6'h4) begin
					data_out <= foo[4];
					count <= count+1;
				end
			end
			M_LED3:begin
				if (count == 6'h0) begin
					data_out <= foo[0];
					count <= count+1;
				end
				if (count == 6'h1) begin
					data_out <= foo[1];
					count <= count+1;
				end
				if (count == 6'h2) begin
					data_out <= foo[2];
					count <= count+1;
				end
				if (count == 6'h3) begin
					data_out <= foo[13];
					count <= count+1;
				end
				if (count == 6'h4) begin
					data_out <= foo[5];
					count <= count+1;
				end
			end
			M_LED4:begin
				if (count == 6'h0) begin
					data_out <= foo[0];
					count <= count+1;
				end
				if (count == 6'h1) begin
					data_out <= foo[1];
					count <= count+1;
				end
				if (count == 6'h2) begin
					data_out <= foo[2];
					count <= count+1;
				end
				if (count == 6'h3) begin
					data_out <= foo[13];
					count <= count+1;
				end
				if (count == 6'h4) begin
					data_out <= foo[6];
					count <= count+1;
				end
			end
			M_LED5:begin
				if (count == 6'h0) begin
					data_out <= foo[0];
					count <= count+1;
				end
				if (count == 6'h1) begin
					data_out <= foo[1];
					count <= count+1;
				end
				if (count == 6'h2) begin
					data_out <= foo[2];
					count <= count+1;
				end
				if (count == 6'h3) begin
					data_out <= foo[13];
					count <= count+1;
				end
				if (count == 6'h4) begin
					data_out <= foo[7];
					count <= count+1;
				end
			end
			L_LED1:begin
				led <= 5'00001;
				if (count == 6'h0) begin
					data_out <= foo[8];
					count <= count+1;
				end
				if (count == 6'h1) begin
					data_out <= foo[9];
					count <= count+1;
				end
				if (count == 6'h2) begin
					data_out <= foo[10];
					count <= count+1;
				end
				if (count == 6'h3) begin
					data_out <= foo[11];
					count <= count+1;
				end
				if (count == 6'h4) begin
					data_out <= foo[12];
					count <= count+1;
				end
				if (count == 6'h5) begin
					data_out <= foo[13];
					count <= count+1;
				end
				if (count == 6'h6) begin
					data_out <= foo[3];
					count <= count+1;
				end
			end
			L_LED2:begin
				led <= 5'00010;
				if (count == 6'h0) begin
					data_out <= foo[8];
					count <= count+1;
				end
				if (count == 6'h1) begin
					data_out <= foo[9];
					count <= count+1;
				end
				if (count == 6'h2) begin
					data_out <= foo[10];
					count <= count+1;
				end
				if (count == 6'h3) begin
					data_out <= foo[11];
					count <= count+1;
				end
				if (count == 6'h4) begin
					data_out <= foo[12];
					count <= count+1;
				end
				if (count == 6'h5) begin
					data_out <= foo[13];
					count <= count+1;
				end
				if (count == 6'h6) begin
					data_out <= foo[4];
					count <= count+1;
				end
			end
			L_LED3:begin
				led <= 5'00100;
				if (count == 6'h0) begin
					data_out <= foo[8];
					count <= count+1;
				end
				if (count == 6'h1) begin
					data_out <= foo[9];
					count <= count+1;
				end
				if (count == 6'h2) begin
					data_out <= foo[10];
					count <= count+1;
				end
				if (count == 6'h3) begin
					data_out <= foo[11];
					count <= count+1;
				end
				if (count == 6'h4) begin
					data_out <= foo[12];
					count <= count+1;
				end
				if (count == 6'h5) begin
					data_out <= foo[13];
					count <= count+1;
				end
				if (count == 6'h6) begin
					data_out <= foo[5];
					count <= count+1;
				end
			end
			L_LED4:begin
				led <= 5'01000;
				if (count == 6'h0) begin
					data_out <= foo[8];
					count <= count+1;
				end
				if (count == 6'h1) begin
					data_out <= foo[9];
					count <= count+1;
				end
				if (count == 6'h2) begin
					data_out <= foo[10];
					count <= count+1;
				end
				if (count == 6'h3) begin
					data_out <= foo[11];
					count <= count+1;
				end
				if (count == 6'h4) begin
					data_out <= foo[12];
					count <= count+1;
				end
				if (count == 6'h5) begin
					data_out <= foo[13];
					count <= count+1;
				end
				if (count == 6'h6) begin
					data_out <= foo[6];
					count <= count+1;
				end
			end
			L_LED5:begin
				led <= 5'10000;
				if (count == 6'h0) begin
					data_out <= foo[8];
					count <= count+1;
				end
				if (count == 6'h1) begin
					data_out <= foo[9];
					count <= count+1;
				end
				if (count == 6'h2) begin
					data_out <= foo[10];
					count <= count+1;
				end
				if (count == 6'h3) begin
					data_out <= foo[11];
					count <= count+1;
				end
				if (count == 6'h4) begin
					data_out <= foo[12];
					count <= count+1;
				end
				if (count == 6'h5) begin
					data_out <= foo[13];
					count <= count+1;
				end
				if (count == 6'h6) begin
					data_out <= foo[7];
					count <= count+1;
				end
			end
		endcase
endmodule
