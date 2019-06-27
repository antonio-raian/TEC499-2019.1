
module Problema1Qsys (
	botoes_in_port,
	botoes_out_port,
	clk_clk,
	leds_export,
	reset_reset_n);	

	input	[7:0]	botoes_in_port;
	output	[7:0]	botoes_out_port;
	input		clk_clk;
	output	[7:0]	leds_export;
	input		reset_reset_n;
endmodule
