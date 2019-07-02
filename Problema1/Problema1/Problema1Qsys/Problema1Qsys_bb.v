
module Problema1Qsys (
	botoes_export,
	clk_clk,
	lcd_controller_rs,
	lcd_controller_rw,
	lcd_controller_en,
	lcd_controller_lcd,
	m_led_coluna_export,
	m_led_linha_export,
	reset_reset_n);	

	input	[3:0]	botoes_export;
	input		clk_clk;
	output		lcd_controller_rs;
	output		lcd_controller_rw;
	output		lcd_controller_en;
	output	[7:0]	lcd_controller_lcd;
	output	[4:0]	m_led_coluna_export;
	output	[4:0]	m_led_linha_export;
	input		reset_reset_n;
endmodule
