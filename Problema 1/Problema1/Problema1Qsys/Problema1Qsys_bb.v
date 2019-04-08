
module Problema1Qsys (
	clk_clk,
	reset_reset_n,
	botoes_in_port,
	botoes_out_port,
	leds_export);	

	input		clk_clk;
	input		reset_reset_n;
	input	[7:0]	botoes_in_port;
	output	[7:0]	botoes_out_port;
	output	[7:0]	leds_export;
endmodule
