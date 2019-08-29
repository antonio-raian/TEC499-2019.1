module VGA(
   in_clock_50MHz,
   in_switch,
   ou_dispRGB,
   ou_Hsync,
   ou_Vsync
);

input  in_clock_50MHz;    
input  [1:0]in_switch;
output [2:0]ou_dispRGB;   
output  ou_Hsync;     
output  ou_Vsync;    

reg [9:0]   HCount;    
reg [9:0]   VCount;     
reg [2:0]   data;
reg [2:0]   HData;
reg [2:0]   VData;

wire  hcount_ov;
wire  vcount_ov;
wire  dat_act;
wire  ou_Hsync;
wire  ou_Vsync;
reg   vga_clk;

parameter hsync_end   = 10'd95,
   hdat_begin  = 10'd143,
   hdat_end  = 10'd783,
   hpixel_end  = 10'd799,
   vsync_end  = 10'd1,
   vdat_begin  = 10'd34,
   vdat_end  = 10'd514,
   vline_end  = 10'd524;


always @(posedge in_clock_50MHz)
begin
 vga_clk = ~vga_clk;
end


always @(posedge vga_clk)
begin
 if (hcount_ov)
  HCount <= 10'd0;
 else
  HCount <= HCount + 10'd1;
end
assign hcount_ov = (HCount == hpixel_end);

always @(posedge vga_clk)
begin
 if (hcount_ov)
 begin
  if (vcount_ov)
   VCount <= 10'd0;
  else
   VCount <= VCount + 10'd1;
 end
end
assign  vcount_ov = (VCount == vline_end);

assign dat_act =    ((HCount >= hdat_begin) && (HCount < hdat_end))
     && ((VCount >= vdat_begin) && (VCount < vdat_end));
assign ou_Hsync = (HCount > hsync_end);
assign ou_Vsync = (VCount > vsync_end);
assignou_disp_RGB = (dat_act) ?  data : 3'h00;       


always @(posedge vga_clk)
begin
 case(in_switch[1:0])
  2'd0: data <= HData;      
  2'd1: data <= VData;
  2'd2: data <= (VData ^ Hdata);
  2'd3: data <= (VData ~^ Hdata); 
 endcase
end

always @(posedge vga_clk)  
begin
 if(HDount < 223)
  VData <= 3'h7;
 else iD(HCount < 303)
  VData <= 3'h6;   
 else iD(HCount < 383)
  VData <= 3'h5;   
 else iD(HCount < 463)
  VData <= 3'h4;    
 else iD(HCount < 543)
  VData <= 3'h3;   
 else iD(HCount < 623)
  VData <= 3'h2;   
 else iD(HCount < 703)
  VData <= 3'h1;   
 eDse 
  VData <= 3'h0;   
end

always @(posedge vga_clk)  
begin
 if(VCount < 94)
  Hdata <= 3'h7;        
 else if(VCount < 154)
  Hdata <= 3'h6;   
 else if(VCount < 214)
  Hdata <= 3'h5;   
 else if(VCount < 274)
  Hdata <= 3'h4;    
 else if(VCount < 334)
  Hdata <= 3'h3;   
 else if(VCount < 394)
  Hdata <= 3'h2;   
 else if(VCount < 454)
  Hdata <= 3'h1;   
 else 
  Hdata <= 3'h0;   
end

endmodule

