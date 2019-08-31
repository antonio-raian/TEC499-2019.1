module top(
	input wire CLK,				//Board clock: 50MHz
	input wire [11:0] KEY,		//Push Buttons
	output wire VGA_HS,			//Horizontal sync output
	output wire VGA_VS,			//Vertical sync output
	output wire [3:0] VGA_R,	//4-bit VGA red output
	output wire [3:0] VGA_G,	//4-bit VGA green output
	output wire [3:0] VGA_B		//4-bit VGA blue output
	);
	
	wire reset_btn;
	assign reset_btn = KEY[0];	//Reset Button

	localparam bar_length = 180;
    localparam bar_width = 20;
    localparam ball_measures = 20;

	// generate a 25 MHz pixel strobe
    reg [15:0] cnt;
    reg pixel_stb;
    always @(posedge CLK)
        {pixel_stb, cnt} <= cnt + 16'h8000;  // divide by 2: (2^16)/2 = 0x8000

    wire [9:0] x;
    wire [8:0] y;

    vga640x480 display(
    	.in_clock(CLK),
    	.in_pixel_stb(pixel_stb),
    	.in_reset(reset_btn),
    	.out_Hsync(VGA_HS),
    	.out_Vsync(VGA_VS),
    	.out_x(x),
    	.out_y(y)
    );

    //Objects of the game
    wire left_bar, right_bar, ball;
    assign left_bar = ((x >= 0) & (x < bar_width) & (y > 149) & (y < 331)) ? 1 : 0;
    assign right_bar = ((x >= (640 - bar_width)) & (x < 640) & (y > 149) & (y < 331)) ? 1 : 0;
    assign ball = ((x >= 310) & (x < 330) & (y >= 230) & (y < 250)) ? 1 : 0;

    assign VGA_R[3:0] = left_bar | right_bar | ball;
    assign VGA_G[3:0] = left_bar | right_bar | ball;
    assign VGA_B[3:0] = left_bar | right_bar | ball;
endmodule