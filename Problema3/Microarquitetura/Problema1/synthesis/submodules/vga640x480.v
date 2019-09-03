module vga640x480(
	input wire in_clock,
	input wire in_pixel_stb,
	input wire in_reset,
	output wire out_Hsync,
	output wire out_Vsync,
	output wire out_blanking,
	output wire out_active,
	output wire out_screend,
	output wire out_animate,
	output wire [9:0] out_x,
	output wire [8:0] out_y
	);

	localparam 	hs_start = 16,		//Horizontal sync start
				hs_end = 112,		//Horizontal sync end
				ha_start = 160,		//Horizontal active pixel start
				vs_start = 490,		//Vertical sync start
				vs_end = 492,		//Vertical sync end
				va_end = 480,		//Vertical active pixel end
				line = 800,			//Complete line (pixels)
				screen = 525;		//Complete screen (lines)

	reg [9:0] h_count, v_count; //Line and screen position 

	// generate sync signals (active low for 640x480)
	assign out_Hsync = ~((h_count >= hs_start) & (h_count < hs_end));
	assign out_Vsync = ~((v_count >= vs_start) & (v_count < vs_end));

	// keep x and y bound within the active pixels
	assign out_x = (h_count < ha_start) ? 0 : (h_count - ha_start);
	assign out_y = (v_count >= va_end) ? (va_end - 1) : (v_count);

	// blanking: high within the blanking period
	assign out_blanking = ((h_count < ha_start) | (v_count > va_end - 1));
	
	// active: high during active pixel drawing
	assign out_ative = ~((h_count < ha_start) | (v_count > va_end - 1));

	// screenend: high for one tick at the end of the screen
	assign out_screend = ((v_count == screen - 1) & (h_count == line));
	
	// animate: high for one tick at the end of the final active pixel line
	assign out_animate = ((v_count == va_end - 1) & (h_count == line));

	always @(posedge in_clock)
	begin
		if(in_reset)	//Reset to start of frame
		begin
			h_count <= 0;
			v_count <= 0;
		end
		if(in_pixel_stb)	//Once per pixel
		begin
			if(h_count == line)	//End of line
			begin
				h_count <= 0;
				v_count <= v_count + 1; //Next line
			end
			else 
				h_count <= h_count + 1;	//Next pixel   

			if(v_count == screen)	//End of screen 
				v_count <= 0;
		end
	end
endmodule