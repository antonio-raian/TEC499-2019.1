module ball #(
	H_SIZE=10,		// half object width (for ease of co-ordinate calculations)
	V_SIZE=10,		// half object length
	IX=320,			// initial horizontal position of object centre
	IY=240,			// initial vertical position of object centre		
	IX_DIR = 0,		// initial horizontal direction: 0 is right, 1 is left
	IY_DIR = 1,    	// initial vertical direction: 0 is down, 1 is up
    BAR_WIDTH = 20,
    BAR_HEIGTH = 180,
	D_WIDTH = 639,   // width of display
    D_HEIGHT=470    // height of display
	)
	(
	input wire in_clock,	// base clock
	input wire in_ani_stb,	// animation clock: pixel clock is 1 pix/frame
	input wire in_reset, 	// reset: returns animation to starting position
	input wire in_animate,  // animate when input is high
    input wire leftbar_top,
    input wire rigthbar_top,
	output wire [11:0] out_x1,  // object left edge: 12-bit value: 0-4095
	output wire [11:0] out_x2,  // object right edge
    output wire [11:0] out_y1,  // object top edge
    output wire [11:0] out_y2   // object bottom edge
    output wire left_score,
    output wire right_score
	);

	reg [11:0] x = IX;   // horizontal position of object centre
    reg [11:0] y = IY;   // vertical position of object centre
    reg x_dir = IX_DIR;  // horizontal animation direction
    reg y_dir = IY_DIR;  // vertical animation direction
    reg stop = 0;

    assign out_x1 = x - H_SIZE;  // left: centre minus half horizontal size
    assign out_x2 = x + H_SIZE;  // right
    assign out_y1 = y - V_SIZE;  // top
    assign out_y2 = y + V_SIZE;  // bottom

    always @(posedge in_clock) begin
    	if (in_reset) begin
    		x <= IX;
            y <= IY;
            x_dir <= IX_DIR;
            y_dir <= IY_DIR;
    	end
    	if (in_animate && in_ani_stb) begin
            if(out_x1 < BAR_WIDTH) begin
                if((out_y1 > leftbar_top + BAR_HEIGTH) & (out_y2 < leftbar_top)) begin
                    right_score <= 1;
                    stop <= 1;
                end
            end
            else if(out_x2 > D_WIDTH - BAR_WIDTH) begin
                if((out_y1 > rightbar_top + BAR_HEIGTH) & (out_y2 < rightbar_top)) begin
                    right_score <= 1;
                    stop <= 1;
                end
            end

            if(stop == 0) begin
                if(x_dir == 0) 
                    x <= x + 3;
                else if(x_dir == 1) 
                    x <= x - 3;

                if(y_dir == 0) 
                    y <= y + 3;
                else if(y_dir == 1)
                    y <= y - 3;

                
                if (x < H_SIZE + 5)                 // edge of object is at left of screen
                    x_dir <= 0;                     // change direction to right
                if (x > (D_WIDTH - H_SIZE))          // edge of object at right
                    x_dir <= 1;                     // change direction to left

                if (y < V_SIZE + 5)                 // edge of object at top of screen
                    y_dir <= 0;                     // change direction to down
                if (y > (D_HEIGHT - V_SIZE - 1))    // edge of object at bottom
                    y_dir <= 1;                     // change direction to up
            end
    	end
    end
endmodule