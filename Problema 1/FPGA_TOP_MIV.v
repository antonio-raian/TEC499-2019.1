module FPGA_TOP_MIV	(
		clock_50MHz,						//	50 MHz
		Switch,
		LCD_EN,
		LCD_RS,
		LCD_RW,
		LCD_D,
		LEDM_C,
		LEDM_R,
		KEY
	);

  input       clock_50MHz;						//	50 MHz
	input   [3:0]  Switch;
	input   [11:0] KEY;

	output				LCD_RS;
	output				LCD_EN;
	output				LCD_RW;
	output [7:0]		LCD_D;
	output [7:0] 		LEDM_R;
	output [4:0] 		LEDM_C;

  wire rs;
	wire en;
	wire rw;
	wire [7:0] data_out;
	wire [4:0] led_aceso;
	wire unlock;


  LCD_Controll	ctrl	(.Clock(			clock_50MHz),
					.sobe(KEY[0]),
          .desce(KEY[1]),
          .selec(KEY[2]),
          .volta(KEY[3]),
					.LCD_RS(		rs),
					.LCD_EN(		en),
					.LCD_RW(		rw),
					.LCD_DATA(		data_out),
					.LED(			led_aceso));

  assign LCD_RS = rs;
	assign LCD_EN = en;
	assign LCD_RW = rw;
	assign LCD_D = data_out;

	assign LEDM_C[4:0] = 5'b11111;

	assign LEDM_R[4:0] = ~led_aceso;
	assign LEDM_R[7:5] = 3'b111;
