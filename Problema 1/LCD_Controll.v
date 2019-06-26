module LCD_Controll ctrl (
		Clock,
		sobe,
		desce,
		selec,
		volta,
		LCD_RS,
		LCD_EN,
		LCD_RW,
		LCD_DATA,
		LED
	);

	input Clock;
	input sobe;
	input desce;
	input selec;
	input volta;

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
	parameter [3:0] s_LED1 = 4'h0,
		s_LED2 = 4'h1,
		s_LED3 = 4'h2,
		s_LED4 = 4'h3,
		s_LED5 = 4'h4,
		CURSOR = 4'h5,
		ESCREVE = 4'h6,
		LIMPAR = 4'h7;

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

	always @(state)
		case (state)
			s_LED1:
				begin
					next <= state;
					if(aux == 2'b00) begin
						state <= EXCREVE;
					end else if(aux == 2'b01) begin
						state <= CURSOR;
					end
				end
			s_LED2:
			s_LED3:
			s_LED4:
			s_LED5:
			CURSOR:
			ESCREVE:
				begin
					rs = 1'b1;
					en = 1'b1;
					rw = 1'b0;

					state <= next;
				end
