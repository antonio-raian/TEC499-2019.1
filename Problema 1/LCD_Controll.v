module LCD_Controll ctrl (
		Clock,
		entrada,
		LCD_RS,
		LCD_EN,
		LCD_RW,
		LCD_DATA,
		LED
	);

	input Clock;
	input [3:0] entrada;

	output LCD_RS;
	output LCD_EN;
	output LCD_RW;
	output LED;
	output [7:0] LCD_DATA;

	reg	rs;
	reg	en;
	reg	rw;
	reg [3:0] state;
	reg [3:0] next;
	reg [7:0] data_out;

	assign LCD_RS = rs;
	assign LCD_EN = en;
	assign LCD_RW = rw;
	assign LCD_DATA = data_out;

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

	wire [7:0] foo [0:12];

	int i = 0;
	reg [2:0] aux = 2'b00;

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

	always @(posedge Clock) begin
		case(state)
			M_LED1:
				if(entrada == 4'b1000) begin
					state <= M_LED5
				end else if(entrada == 4'b0100)begin
					state <= M_LED2
				end else if(entrada == 4'b0010)begin
					state <= L_LED1
				end
			M_LED2:
				if(entrada == 4'b1000) begin
					state <= M_LED1
				end else if(entrada == 4'b0100)begin
					state <= M_LED3
				end else if(entrada == 4'b0010)begin
					state <= L_LED2
				end
			M_LED3:
				if(entrada == 4'b1000) begin
					state <= M_LED2
				end else if(entrada == 4'b0100)begin
					state <= M_LED4
				end else if(entrada == 4'b0010)begin
					state <= L_LED3
				end
			M_LED4:
				if(entrada == 4'b1000) begin
					state <= M_LED3
				end else if(entrada == 4'b0100)begin
					state <= M_LED5
				end else if(entrada == 4'b0010)begin
					state <= L_LED4
				end 
			M_LED5:
				if(entrada == 4'b1000) begin
					state <= M_LED4
				end else if(entrada == 4'b0100)begin
					state <= M_LED1
				end else if(entrada == 4'b0010)begin
					state <= L_LED5
				end 
			L_LED1:
				if(entrada == 4'b0001) begin
					state <= M_LED1
				end
			L_LED2:
				if(entrada == 4'b0001) begin
					state <= M_LED2
				end 
			L_LED3:
				if(entrada == 4'b0001) begin
					state <= M_LED3
				end 
			L_LED4:
				if(entrada == 4'b0001) begin
					state <= M_LED4
				end 
			L_LED5:
				if(entrada == 4'b0001) begin
					state <= M_LED5
				end 
			ESCREVE:
			LIMPAR:
	end

	always @(state)
		case (state)
			M_LED1:
				begin
					next <= state;
					if(aux == 2'b00) begin
						state <= EXCREVE;
					end else if(aux == 2'b01) begin
						state <= CURSOR;
					end
				end
			M_LED2:
			M_LED3:
			M_LED4:
			M_LED5:
			L_LED1:
			L_LED2:
			L_LED3:
			L_LED4:
			L_LED5:
			ESCREVE:
				begin
					rs = 1'b1;
					en = 1'b1;
					rw = 1'b0;

					state <= next;
				end
