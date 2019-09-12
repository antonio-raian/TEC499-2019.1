module top(
	input wire CLK,				//Board clock: 50MHz
	input wire RESET,			//Reset
	input wire [3:0] BUTTONS,	//Controll Buttons
	input wire START,			//Start Button
	output wire VGA_HS,			//Horizontal sync output
	output wire VGA_VS,			//Vertical sync output
	output wire [3:0] VGA_R,	//4-bit VGA red output
	output wire [3:0] VGA_G,	//4-bit VGA green output
	output wire [3:0] VGA_B,	//4-bit VGA blue output
	output wire [7:0] out_Player1,
	output wire [7:0] out_Player2
	);

	localparam bar_length = 180;
    localparam bar_width = 20;
    localparam ball_measures = 20;

	// generate a 25 MHz pixel strobe
    reg [15:0] cnt;
    reg pixel_stb;
    always @(posedge CLK)
        {pixel_stb, cnt} <= cnt + 16'h8000;  // divide by 2: (2^16)/2 = 0x8000

    wire [9:0] x;	// current pixel x position: 10-bit value: 0-1023
    wire [8:0] y;  	// current pixel y position:  9-bit value: 0-511
    wire animate;  	// high when we're ready to animate at end of drawing

    vga640x480 display(
    	.in_clock(CLK),
    	.in_pixel_stb(pixel_stb),
    	.in_reset(RESET),
    	.out_Hsync(VGA_HS),
    	.out_Vsync(VGA_VS),
    	.out_x(x),
    	.out_y(y),
    	.out_animate(animate)
    );

    //Objects of the game
    wire left_bar, right_bar, ball, right_score, left_score;
    wire [11:0] left_bar_x1, left_bar_x2, left_bar_y1, left_bar_y2;  // 12-bit values: 0-4095 
    wire [11:0] right_bar_x1, right_bar_x2, right_bar_y1, right_bar_y2;
    wire [11:0] ball_x1, ball_x2, ball_y1, ball_y2;

    reg [7:0] player1 = 8'h30;
    reg [7:0] player2 = 8'h30;

    bar left_bar_anim (
        .in_clock(CLK), 
        .in_ani_stb(pixel_stb),
        .in_reset(RESET),
        .in_animate(animate),
        .in_button_up(BUTTONS[0]),
        .in_button_down(BUTTONS[1]),
        .out_x1(left_bar_x1),
        .out_x2(left_bar_x2),
        .out_y1(left_bar_y1),
        .out_y2(left_bar_y2)
    );

    bar #(.IX(630)) right_bar_anim (
    	.in_clock(CLK), 
        .in_ani_stb(pixel_stb),
        .in_reset(RESET),
        .in_animate(animate),
        .in_button_up(BUTTONS[2]),
        .in_button_down(BUTTONS[3]),
        .out_x1(right_bar_x1),
        .out_x2(right_bar_x2),
        .out_y1(right_bar_y1),
        .out_y2(right_bar_y2)
    );

    ball ball_anim (
    	.in_clock(CLK), 
        .in_ani_stb(pixel_stb),
        .in_reset(RESET),
        .in_animate(animate),
        .in_start(START),
        .in_leftbar_top(left_bar_y1),
        .in_rightbar_top(right_bar_y1),
        .out_x1(ball_x1),
        .out_x2(ball_x2),
        .out_y1(ball_y1),
        .out_y2(ball_y2),
        .out_left_score(left_score),
        .out_right_score(right_score)
    );

    always @(posedge CLK or posedge RESET) begin
    	if (RESET) begin
    		player1 <= 8'h30;
    		player2 <= 8'h30;
    	end
    	else if (left_score == 1) begin
    		if(player1 == 8'h34) begin
    			player1 <= 8'h30;
    		end
    		else begin
    			player1 <= player1 + 8'h01;
    		end
    	end
    	else if (right_score == 1) begin
    		if(player2 == 8'h34) begin
    			player2 <= 8'h30;
    		end
    		else begin
    			player2 <= player2 + 8'h01;
    		end
    	end
    end

    assign out_Player1 = player1;
    assign out_Player2 = player2;

    assign left_bar = ((x > left_bar_x1) & (x < left_bar_x2) & (y > left_bar_y1) & (y < left_bar_y2)) ? 1 : 0;
    assign right_bar = ((x > right_bar_x1) & (x < right_bar_x2) & (y > right_bar_y1) & (y < right_bar_y2)) ? 1 : 0;
    assign ball = ((x > ball_x1) & (x < ball_x2) & (y > ball_y1) & (y < ball_y2)) ? 1 : 0;

    assign VGA_R = {4{left_bar}} | {4{right_bar}} | {4{ball}};
    assign VGA_G = {4{left_bar}} | {4{right_bar}} | {4{ball}};
    assign VGA_B = {4{left_bar}} | {4{right_bar}} | {4{ball}};
endmodule