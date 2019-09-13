module bar #(
	H_SIZE=10,		// half bar width (for ease of co-ordinate calculations)
	V_SIZE=90,		// half bar length
	IX=10,			// initial horizontal position of bar centre
	IY=240,			// initial vertical position of bar centre
	SPEED = 4,		// bar speed	
	D_WIDTH=639,    // width of display
    D_HEIGHT=470    // height of display
	)
	(
	input wire in_clock,	// base clock
	input wire in_ani_stb,	// animation clock: pixel clock is 1 pix/frame
	input wire in_reset, 	// reset: returns animation to starting position
	input wire in_animate,  // animate when input is high
	input wire in_button_up,
	input wire in_button_down,	
	output wire [11:0] out_x1,  // bar left edge: 12-bit value: 0-4095
	output wire [11:0] out_x2,  // bar right edge
    output wire [11:0] out_y1,  // bar top edge
    output wire [11:0] out_y2   // bar bottom edge
	);

	reg [11:0] x = IX;   // horizontal position of bar centre
    reg [11:0] y = IY;   // vertical position of bar centre

    assign out_x1 = x - H_SIZE;  // left: centre minus half horizontal size
    assign out_x2 = x + H_SIZE;  // right
    assign out_y1 = y - V_SIZE;  // top
    assign out_y2 = y + V_SIZE;  // bottom

    always @(posedge in_clock) begin
    	if (in_reset) begin
    		x <= IX;
            y <= IY;
    	end
    	if (in_animate && in_ani_stb) begin
    		if(in_button_down == 1) begin
    			if (y < (D_HEIGHT - V_SIZE - 1)) // edge of bar not at bottom of screen  
    				y <= y + SPEED;	
    		end
    		else if(in_button_up == 1) begin
    			if (y > V_SIZE + 5)				// edge of bar at top of screen  
    				y <= y - SPEED;	
    		end
    	end
    end
endmodule