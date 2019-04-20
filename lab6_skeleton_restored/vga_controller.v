module vga_controller(iRST_n,
                      iVGA_CLK,
                      oBLANK_n,
                      oHS,
                      oVS,
                      b_data,
                      g_data,
                      r_data,
							 north,
							 south,
							 east,
							 west,
							 color_switch);

	
input iRST_n, north,south,east,west, color_switch;
input iVGA_CLK;
output reg oBLANK_n;
output reg oHS;
output reg oVS;
output [7:0] b_data;
output [7:0] g_data;  
output [7:0] r_data;                        
///////// ////                     
reg [18:0] ADDR;
reg [23:0] bgr_data;
wire VGA_CLK_n;
wire [7:0] index, cube_index, chosen_index;
wire [23:0] bgr_data_raw;
wire cBLANK_n,cHS,cVS,rst;
wire[9:0] addr_x, addr_y;
wire x_in_s, y_in_s;
reg[9:0] x,y; //from lab
reg[9:0] selector_x, selector_y; //for square chooser
reg [40:0] counter;
////
assign rst = ~iRST_n;
video_sync_generator LTM_ins (.vga_clk(iVGA_CLK),
                              .reset(rst),
                              .blank_n(cBLANK_n),
                              .HS(cHS),
                              .VS(cVS));

//initial begin
//	x = 10'b0;
//	y = 10'b0;
//	counter = 41'b0;
//end

initial begin 
	selector_x <= 10'd210;
	selector_y <= 10'd90;
end

always @(posedge VGA_CLK_n) begin
	counter <= counter + 1;
	if(counter >  5000000) begin //every 0.1 seconds
		if(north == 1) begin
			selector_y <= selector_y + 60;
		end
		else if (south == 1) begin
			selector_y <= selector_y - 60;
		end
		else if (east== 1) begin
			selector_x <= selector_x + 60;
		end
		else if (west== 1) begin
			selector_x <= selector_x - 60;
		end
		counter <= 0;
	end
end

////Addresss generator
always@(posedge iVGA_CLK,negedge iRST_n)
begin
  if (!iRST_n)
     ADDR<=19'd0;
  else if (cHS==1'b0 && cVS==1'b0)
     ADDR<=19'd0;
  else if (cBLANK_n==1'b1)
     ADDR<=ADDR+1;
end
//ADDR is the address of the particular pixel it's rendering atm
//////////////////////////
//////INDEX addr.
assign VGA_CLK_n = ~iVGA_CLK;
img_data	img_data_inst (
	.address ( ADDR ),
	.clock ( VGA_CLK_n ),
	.q ( index )
	);
	
/////////////////////////
//////Add switch-input logic here

//will take in address and output an index and whether that index should be used (aka select bit)
//should also take in color changer pin/input (as well as location) and have an always @edge block on the inside that changes colors accordingly
render_cube my_cube(VGA_CLK_n, selector_x, selector_y, ADDR, color_switch, cube_index, sel_index);


//////Color table output
assign chosen_index = sel_index ? cube_index : index; //choose cube_index if sel_index = 1
//assign chosen_index = 19'd4; //choose cube_index if sel_index = 1
img_index	img_index_inst (
	.address ( chosen_index ), //index is the 6; mux in something else for index
	.clock ( iVGA_CLK ),
	.q ( bgr_data_raw)
	);	
//////



//think this is theirs imma just comment that out
// assign addr_x = ADDR % 640;
// assign addr_y = ADDR/640;
// assign y_in_s = (addr_y < (y + 160)) && (addr_y > y);
// assign x_in_s = (addr_x < (x + 160)) && (addr_x > x);
//wire isin;
// assign isin = y_in_s && x_in_s;
// 
// wire [23:0] in_square_data;
// assign in_square_data = 24'b111111110000000000000000;
// wire [23:0] use_data;
// assign use_data = isin ? in_square_data : bgr_data_raw;
//////latch valid data at falling edge;
//always@(posedge VGA_CLK_n) bgr_data <= use_data;
always@(posedge VGA_CLK_n) bgr_data <= bgr_data_raw;
assign b_data =  bgr_data[23:16];
assign g_data = bgr_data[15:8];
assign r_data = bgr_data[7:0];




///////////////////
//////Delay the iHD, iVD,iDEN for one clock cycle;
always@(negedge iVGA_CLK)
begin
  oHS<=cHS;
  oVS<=cVS;
  oBLANK_n<=cBLANK_n;
end

endmodule
 	















