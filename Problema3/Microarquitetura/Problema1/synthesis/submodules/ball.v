module ball #(
	H_SIZE=10,		// half ball width (for ease of co-ordinate calculations)
	V_SIZE=10,		// half ball length
	IX=320,			// initial horizontal position of ball centre
	IY=240,			// initial vertical position of ball centre		
    BAR_WIDTH = 20, // bar width
    BAR_LENGTH = 180,   // bar length
    SPEED = 2,          // ball speed
	D_WIDTH = 639,   // width of display
    D_HEIGHT=470    // height of display
	)
	(
	input wire in_clock,	// base clock
	input wire in_ani_stb,	// animation clock: pixel clock is 1 pix/frame
	input wire in_reset, 	// reset: returns animation to starting position
	input wire in_animate,  // animate when input is high
    input wire in_start,    // start a new round
    input wire [11:0] in_leftbar_top,  // leftbar top edge
    input wire [11:0] in_rightbar_top, // rightbar top edge
	output wire [11:0] out_x1,  // ball left edge: 12-bit value: 0-4095
	output wire [11:0] out_x2,  // ball right edge
    output wire [11:0] out_y1,  // ball top edge
    output wire [11:0] out_y2,   // ball bottom edge
    output wire out_left_score,
    output wire out_right_score
	);

    wire [3:0] random;

    LFSR #(.NUM_BITS(4)) lfsr(
        .i_Clk(in_clock),
        .i_Enable(1'b1),
        .o_LFSR_Data(random)
    );

	reg [11:0] x = IX;   // horizontal position of ball centre
    reg [11:0] y = IY;   // vertical position of ball centre
    reg x_dir;  // horizontal animation direction: 0 is right, 1 is left
    reg y_dir;  // vertical animation direction: 0 is down, 1 is up
    reg stop = 1;        // 1 when the game is paused, 0 otherwise
    reg y_stopped = 0;
    reg left_score, right_score;

    wire [11:0] leftbar_bottom, rightbar_bottom;
    assign leftbar_bottom = in_leftbar_top + BAR_LENGTH;
    assign rightbar_bottom = in_rightbar_top + BAR_LENGTH;

    assign out_x1 = x - H_SIZE;  // left: centre minus half horizontal size
    assign out_x2 = x + H_SIZE;  // right
    assign out_y1 = y - V_SIZE;  // top
    assign out_y2 = y + V_SIZE;  // bottom
    
    assign out_left_score = left_score;
    assign out_right_score = right_score;

    always @(posedge in_clock) begin
    	if (in_reset) begin
    		x <= IX;
            y <= IY;
            x_dir <= random[0];
            y_dir <= random[1];
            y_stopped <= 0;
    	end
        if (in_start) begin
            y_stopped <= 0;
            stop <= 0;
            left_score <= 0;
            right_score <= 0;
            x_dir <= random[0];
            y_dir <= random[1];
        end
    	if (in_animate && in_ani_stb) begin
            if(out_x1 < BAR_WIDTH) begin            //Checks if the ball hit the wall in leftside
                if((out_y1 > leftbar_bottom) | (out_y2 < in_leftbar_top)) begin 
                    right_score <= 1;
                    stop <= 1;
                    x <= IX;
                    y <= IY;
                end
                else begin
                    x_dir <= 0;                     // change direction to right
                    if(out_y2 < (in_leftbar_top + (BAR_LENGTH/3)) | out_y1 > (in_leftbar_top + (2*BAR_LENGTH/3))) begin
                       y_dir <= random[2];
                       y_stopped <= 0; 
                    end
                    else begin  // middle of the bar
                       y_stopped <= 1; 
                    end
                end
            end
            else if(out_x2 > D_WIDTH - BAR_WIDTH) begin //Checks if the ball hit the wall in rightside
                if((out_y1 > rightbar_bottom) | (out_y2 < in_rightbar_top)) begin
                    left_score <= 1;
                    stop <= 1;
                    x <= IX;
                    y <= IY;
                end
                else begin
                    x_dir <= 1;                     // change direction to left
                    if(out_y2 < (in_rightbar_top + (BAR_LENGTH/3)) | out_y1 > (in_rightbar_top + (2*BAR_LENGTH/3))) begin
                       y_dir <= random[3];
                       y_stopped <= 0; 
                    end
                    else begin  // middle of the bar
                       y_stopped <= 1; 
                    end
                end
            end

            if(stop == 0) begin
                if(x_dir == 0) 
                    x <= x + SPEED;
                else if(x_dir == 1) 
                    x <= x - SPEED;

                if(y_stopped == 0) begin
                    if(y_dir == 0) 
                        y <= y + SPEED;
                    else if(y_dir == 1)
                        y <= y - SPEED;
                end

                if (y < V_SIZE + 5)                 // edge of ball at top of screen
                    y_dir <= 0;                     // change direction to down
                if (y > (D_HEIGHT - V_SIZE - 1))    // edge of ball at bottom
                    y_dir <= 1;                     // change direction to up
            end
    	end
    end
endmodule