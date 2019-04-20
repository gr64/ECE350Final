module render_cube(
	input clock,
	input[9:0] selector_x, selector_y,
	input[18:0] address,
	input color_switch,
	output reg [7:0] cube_index,
	output reg sel_index
);

//will take in address and output an index and whether that index should be used (aka select bit)
//should also take in color changer pin/input (as well as location) and have an always @edge block on the inside that changes colors accordingly

	reg [2:0] sq_1,sq_2,sq_3,sq_4,sq_5,sq_6,sq_7,sq_8,sq_9,sq_10,sq_11,sq_12; //color registers for each cube square
	reg [2:0] sq_13,sq_14,sq_15,sq_16,sq_17,sq_18,sq_19,sq_20,sq_21,sq_22,sq_23,sq_24;
	// good news, these numbers will double as mif file indices and eventual dmem storage values!

	wire[9:0] addr_x, addr_y;

	initial begin
		sq_1 <= 3'd0;
		sq_2 <= 3'd0;
		sq_3 <= 3'd0;
		sq_4 <= 3'd0;
		sq_5 <= 3'd1;
		sq_6 <= 3'd1;
		sq_7 <= 3'd1;
		sq_8 <= 3'd1;
		sq_9 <= 3'd2;
		sq_10 <= 3'd2;
		sq_11 <= 3'd2;
		sq_12 <= 3'd2;
		sq_13 <= 3'd3;
		sq_14 <= 3'd3;
		sq_15 <= 3'd3;
		sq_16 <= 3'd3;
		sq_17 <= 3'd4;
		sq_18 <= 3'd4;
		sq_19 <= 3'd4;
		sq_20 <= 3'd4;
		sq_21 <= 3'd5;
		sq_22 <= 3'd5;
		sq_23 <= 3'd5;
		sq_24 <= 3'd5;
		
		sel_index <= 1'b1;
	end

//for this, check selector locations
	always @(posedge color_switch) begin

	end

//for this, you're looking at address
	assign addr_x = address % 640;
	assign addr_y = address / 480;

//If in SQUARE 1
always @(posedge clock) begin
	if((addr_x > 180 + 5 && addr_x < 240 - 5) && (addr_y > 180 + 5 && addr_y < 240 - 5)) begin //col 3, row 1
		cube_index <= sq_1;
	end
	else begin
		sel_index <= 1'b0;
	end
end
			 

endmodule 