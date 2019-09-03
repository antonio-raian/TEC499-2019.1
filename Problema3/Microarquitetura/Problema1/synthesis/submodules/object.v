module object #(
	H_SIZE=10,		// half object width (for ease of co-ordinate calculations)
	V_SIZE=90,		// half object length
	IX=10,			// initial horizontal position of object centre
	IY=240,			// initial vertical position of object centre
	IX_DIR=0,		// initial horizontal direction: 1 is right, 2 is left, 0 is none
	IY_DIR=1,		// initial vertical direction: 1 is down, 2 is up, 0 is none
	D_WIDTH=640,    // width of display
    D_HEIGHT=480    // height of display
	)
	(
	input wire in_clock,	// base clock
	input wire in_ani_stb,	// animation clock: pixel clock is 1 pix/frame
	input wire in_reset, 	// reset: returns animation to starting position
	input wire in_animate,  // animate when input is high	
	output wire [11:0] out_x1,  // object left edge: 12-bit value: 0-4095
	output wire [11:0] out_x2,  // object right edge
    output wire [11:0] out_y1,  // object top edge
    output wire [11:0] out_y2   // object bottom edge
	);

	reg [11:0] x = IX;   // horizontal position of object centre
    reg [11:0] y = IY;   // vertical position of object centre
    reg x_dir = IX_DIR;  // horizontal animation direction
    reg y_dir = IY_DIR;  // vertical animation direction

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
    		if(x_dir == 1) 
    			x <= x + 1;
    		else if(x_dir == 2) 
    			x <= x - 1;

    		if(y_dir == 1) 
    			y <= y + 1;
    		else if(y_dir == 2)
    			y <= y - 1;

    		if(x_dir != 0) begin
    			if (x <= H_SIZE + 1)  				// edge of object is at left of screen
                	x_dir <= 1;  					// change direction to right
            	if (x >= (D_WIDTH - H_SIZE - 1))  	// edge of object at right
                	x_dir <= 2;  					// change direction to left
    		end

    		if(y_dir != 0) begin
    			if (y <= H_SIZE + 1)  				// edge of object at top of screen
                	y_dir <= 1;  					// change direction to down
            	if (y >= (D_HEIGHT - H_SIZE - 1))  	// edge of object at bottom
                	y_dir <= 2;  					// change direction to up
    		end
    	end
    end
endmodule