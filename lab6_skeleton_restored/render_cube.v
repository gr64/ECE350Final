module render_cube(
	input clock,
	input[18:0] address,
	input color_switch, north, south, west, east,
	output reg [7:0] cube_index,
	output reg sel_index,
	output reg [2:0] sq_1,sq_2,sq_3,sq_4,sq_5,sq_6,sq_7,sq_8,sq_9,sq_10,sq_11,sq_12,
	output reg [2:0] sq_13,sq_14,sq_15,sq_16,sq_17,sq_18,sq_19,sq_20,sq_21,sq_22,sq_23,sq_24
);

//will take in address and output an index and whether that index should be used (aka select bit)
//should also take in color changer pin/input (as well as location) and have an always @edge block on the inside that changes colors accordingly
	reg [40:0] counter, color_counter;
	reg[3:0] sel_x, sel_y; //for square chooser

	//reg [2:0] sq_1,sq_2,sq_3,sq_4,sq_5,sq_6,sq_7,sq_8,sq_9,sq_10,sq_11,sq_12; //color registers for each cube square
	//reg [2:0] sq_13,sq_14,sq_15,sq_16,sq_17,sq_18,sq_19,sq_20,sq_21,sq_22,sq_23,sq_24;
	// good news, these numbers will double as mif file indices and eventual dmem storage values!
	
	reg [9:0] px_off, x_offset, y_offset, x_scale, y_scale, sel_scale, sel_xoff, sel_yoff;

	wire[9:0] addr_x, addr_y, addr_xnOff, addr_ynOff;

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
		
		sel_x <= 4'd1;
		sel_y <= 4'd3;
		sel_scale <= 10'd3; //make this less than x and y scale
		
		px_off <= 10'd3;			// space around each square
		x_offset <= 10'd120;		// where in x does cube start
		y_offset <= 10'd160;		//
		x_scale <= 10'd60;		// size of squares
		y_scale <= 10'd60;		//
		
//		sel_xoff <= (x_scale / 2) - sel_scale;
//		sel_yoff <= (y_scale / 2) - sel_scale;
		sel_xoff <= 20;
		sel_yoff <= 20;
		
		cube_index <= 8'd7;
		sel_index <= 1'b0;
		
		counter <= 0;
		color_counter <= 0;
	end


//for this, you're looking at address
	assign addr_xnOff = address % 640; //addresses without offsets of cube location
	assign addr_ynOff = address / 480;
	
	assign addr_x = addr_xnOff - x_offset;
	assign addr_y = addr_ynOff - y_offset;

always @(posedge clock) begin
/////MOVING SELECTOR
	counter <= counter + 1;
	color_counter <= color_counter + 1;
	if(counter > 5000000) begin //every 0.1 seconds
		if(north == 0 && ((sel_y > 1 && (sel_x > 2 && sel_x < 5)) || (sel_y > 3 && (sel_x < 3 || sel_x > 4)))) begin //these if conditions will become more complicated later
			sel_y <= sel_y - 1;
		end
		else if (south == 0 && ((sel_y < 6 && (sel_x > 2 && sel_x < 5)) || (sel_y < 4 && (sel_x < 3 || sel_x > 4)))) begin
			sel_y <= sel_y + 1;
		end
		else if (east == 0 && ((sel_x < 8 && (sel_y > 2 && sel_y < 5)) || (sel_x < 4 && (sel_y < 3 && sel_y > 4)))) begin
			sel_x <= sel_x + 1;
		end
		else if (west == 0 && ((sel_x > 1 && (sel_y > 2 && sel_y < 5)) || (sel_x > 3 && (sel_y < 3 && sel_y > 4)))) begin
			sel_x <= sel_x - 1;
		end
		counter <= 0;
	end
/////CHANGING COLORS
	if(color_counter > 15000000) begin //every 0.3 seconds, so if you leave the switch on it should continuously change colors
		//if(color_switch == 1) begin
		// 
			if(color_switch == 1 && sel_x == 3 && sel_y == 1) begin
				sq_1 <= sq_1 + 3'd1;
				if(sq_1 == 5) begin
					sq_1 <= 0;
				end
			end
			else if(color_switch == 1 && sel_x == 4 && sel_y == 1) begin
				sq_2 <= sq_2 + 3'd1;
				if(sq_2 == 5) begin
					sq_2 <= 0;
				end
			end
			else if(color_switch == 1 && sel_x == 3 && sel_y == 2) begin
				sq_3 <= sq_3 + 3'd1;
				if(sq_3 == 5) begin
					sq_3 <= 0;
				end
			end
			else if(color_switch == 1 && sel_x == 4 && sel_y == 2) begin
				sq_4 <= sq_4 + 3'd1;
				if(sq_4 == 5) begin
					sq_4 <= 0;
				end
			end
			else if(color_switch == 1 && sel_x == 1 && sel_y == 3) begin
				sq_5 <= sq_5 + 3'd1;
				if(sq_5 == 5) begin
					sq_5 <= 0;
				end
			end
			else if(color_switch == 1 && sel_x == 2 && sel_y == 3) begin
				sq_6 <= sq_6 + 3'd1;
				if(sq_6 == 5) begin
					sq_6 <= 0;
				end
			end
			else if(color_switch == 1 && sel_x == 1 && sel_y == 4) begin
				sq_7 <= sq_7 + 3'd1;
				if(sq_7 == 5) begin
					sq_7 <= 0;
				end
			end
			else if(color_switch == 1 && sel_x == 2 && sel_y == 4) begin
				sq_8 <= sq_8 + 3'd1;
				if(sq_8 == 5) begin
					sq_8 <= 0;
				end
			end
			else if(color_switch == 1 && sel_x == 3 && sel_y == 3) begin
				sq_9 <= sq_9 + 3'd1;
				if(sq_9 == 5) begin
					sq_9 <= 0;
				end
			end
			else if(color_switch == 1 && sel_x == 4 && sel_y == 3) begin
				sq_10 <= sq_10 + 3'd1;
				if(sq_10 == 5) begin
					sq_10 <= 0;
				end
			end
			else if(color_switch == 1 && sel_x == 3 && sel_y == 4) begin
				sq_11 <= sq_11 + 3'd1;
				if(sq_11 == 5) begin
					sq_11 <= 0;
				end
			end
			else if(color_switch == 1 && sel_x == 4 && sel_y == 4) begin
				sq_12 <= sq_12 + 3'd1;
				if(sq_12 == 5) begin
					sq_12 <= 0;
				end
			end
			else if(color_switch == 1 && sel_x == 5 && sel_y == 3) begin
				sq_13 <= sq_13 + 3'd1;
				if(sq_13 == 5) begin
					sq_13 <= 0;
				end
			end
			else if(color_switch == 1 && sel_x == 6 && sel_y == 3) begin
				sq_14 <= sq_14 + 3'd1;
				if(sq_14 == 5) begin
					sq_14 <= 0;
				end
			end
			else if(color_switch == 1 && sel_x == 5 && sel_y == 4) begin
				sq_15 <= sq_15 + 3'd1;
				if(sq_15 == 5) begin
					sq_15 <= 0;
				end
			end
			else if(color_switch == 1 && sel_x == 6 && sel_y == 4) begin
				sq_16 <= sq_16 + 3'd1;
				if(sq_16 == 5) begin
					sq_16 <= 0;
				end
			end
			else if(color_switch == 1 && sel_x == 7 && sel_y == 3) begin
				sq_17 <= sq_17 + 3'd1;
				if(sq_17 == 5) begin
					sq_17 <= 0;
				end
			end
			else if(color_switch == 1 && sel_x == 8 && sel_y == 3) begin
				sq_18 <= sq_18 + 3'd1;
				if(sq_18 == 5) begin
					sq_18 <= 0;
				end
			end
			else if(color_switch == 1 && sel_x == 7 && sel_y == 4) begin
				sq_19 <= sq_19 + 3'd1;
				if(sq_19 == 5) begin
					sq_19 <= 0;
				end
			end
			else if(color_switch == 1 && sel_x == 8 && sel_y == 4) begin
				sq_20 <= sq_20 + 3'd1;
				if(sq_20 == 5) begin
					sq_20 <= 0;
				end
			end
			else if(color_switch == 1 && sel_x == 3 && sel_y == 5) begin
				sq_21 <= sq_21 + 3'd1;
				if(sq_21 == 5) begin
					sq_21 <= 0;
				end
			end
			else if(color_switch == 1 && sel_x == 4 && sel_y == 5) begin
				sq_22 <= sq_22 + 3'd1;
				if(sq_22 == 5) begin
					sq_22 <= 0;
				end
			end
			else if(color_switch == 1 && sel_x == 3 && sel_y == 6) begin
				sq_23 <= sq_23 + 3'd1;
				if(sq_23 == 5) begin
					sq_23 <= 0;
				end
			end
			else if(color_switch == 1 && sel_x == 4 && sel_y == 6) begin
				sq_24 <= sq_24 + 3'd1;
				if(sq_24 == 5) begin
					sq_24 <= 0;
				end
			end
		//end
		color_counter <= 0;
	end
/////CALCULATING PIXELS

	//If in SQUARE 1
	if((addr_x > (2 * x_scale + px_off) && addr_x < (3 * x_scale - px_off)) && (addr_y > (0 + px_off) && addr_y < (1 * y_scale - px_off))) begin //col 3, row 1
		if(sel_x == 3 && sel_y == 1 && (addr_x > (2 * x_scale + sel_xoff) && addr_x < (3 * x_scale - sel_xoff)) && (addr_y > (0 + sel_yoff) && addr_y < (1 * y_scale - sel_yoff))) begin
			cube_index <=  8'd7;
		end 
		else begin
			cube_index <= sq_1;
		end
		sel_index <= 1'b1;
	end
	//If in SQUARE 2
	else if((addr_x > (3 * x_scale + px_off) && addr_x < (4 * x_scale - px_off)) && (addr_y > (0 + px_off) && addr_y < (1 * y_scale - px_off))) begin //col 4, row 1
		if(sel_x == 4 && sel_y == 1 && (addr_x > (3 * x_scale + sel_xoff) && addr_x < (4 * x_scale - sel_xoff)) && (addr_y > (0 + sel_yoff) && addr_y < (1 * y_scale - sel_yoff))) begin
			cube_index <=  8'd7;
		end
		else begin
			cube_index <= sq_2;
		end
		sel_index <= 1'b1;
	end
	//If in SQUARE 3
	else if((addr_x > (2 * x_scale + px_off) && addr_x < (3 * x_scale - px_off)) && (addr_y > (1 * y_scale + px_off) && addr_y < (2 * y_scale - px_off))) begin //col 3, row 2
		if(sel_x == 3 && sel_y == 2 && (addr_x > (2 * x_scale + sel_xoff) && addr_x < (3 * x_scale - sel_xoff)) && (addr_y > (1 * y_scale + sel_yoff) && addr_y < (2 * y_scale - sel_yoff))) begin
			cube_index <=  8'd7;
		end
		else begin
			cube_index <= sq_3;
		end
		sel_index <= 1'b1;
	end
	//If in SQUARE 4
	else if((addr_x > (3 * x_scale + px_off) && addr_x < (4 * x_scale - px_off)) && (addr_y > (1 * y_scale + px_off) && addr_y < (2 * y_scale - px_off))) begin //col 4, row 2
		if(sel_x == 4 && sel_y == 2 && (addr_x > (3 * x_scale + sel_xoff) && addr_x < (4 * x_scale - sel_xoff)) && (addr_y > (1 * y_scale + sel_yoff) && addr_y < (2 * y_scale - sel_yoff))) begin
			cube_index <=  8'd7;
		end
		else begin
			cube_index <= sq_4;
		end
		sel_index <= 1'b1;
	end
	//If in SQUARE 5
	else if((addr_x > (0 * x_scale + px_off) && addr_x < (1 * x_scale - px_off)) && (addr_y > (2 * y_scale + px_off) && addr_y < (3 * y_scale - px_off))) begin //col 1, row 3
		if(sel_x == 1 && sel_y == 3 && (addr_x > (0 * x_scale + sel_xoff) && addr_x < (1 * x_scale - sel_xoff)) && (addr_y > (2 * y_scale + sel_yoff) && addr_y < (3 * y_scale - sel_yoff))) begin
			cube_index <=  8'd7;
		end
		else begin
			cube_index <= sq_5;
		end
		sel_index <= 1'b1;
	end
	//If in SQUARE 6
	else if((addr_x > (1 * x_scale + px_off) && addr_x < (2 * x_scale - px_off)) && (addr_y > (2 * y_scale + px_off) && addr_y < (3 * y_scale - px_off))) begin //col 2, row 3
		if(sel_x == 2 && sel_y == 3 && (addr_x > (1 * x_scale + sel_xoff) && addr_x < (2 * x_scale - sel_xoff)) && (addr_y > (2 * y_scale + sel_yoff) && addr_y < (3 * y_scale - sel_yoff))) begin
			cube_index <=  8'd7;
		end
		else begin
			cube_index <= sq_6;
		end
		sel_index <= 1'b1;
	end
	//If in SQUARE 7
	else if((addr_x > (0 * x_scale + px_off) && addr_x < (1 * x_scale - px_off)) && (addr_y > (3 * y_scale + px_off) && addr_y < (4 * y_scale - px_off))) begin //col 1, row 4
		if(sel_x == 1 && sel_y == 4 && (addr_x > (0 * x_scale + sel_xoff) && addr_x < (1 * x_scale - sel_xoff)) && (addr_y > (3 * y_scale + sel_yoff) && addr_y < (4 * y_scale - sel_yoff))) begin
			cube_index <=  8'd7;
		end
		else begin
			cube_index <= sq_7;
		end
		sel_index <= 1'b1;
	end
	//If in SQUARE 8
	else if((addr_x > (1 * x_scale + px_off) && addr_x < (2 * x_scale - px_off)) && (addr_y > (3 * y_scale + px_off) && addr_y < (4 * y_scale - px_off))) begin //col 2, row 4
		if(sel_x == 2 && sel_y == 4 && (addr_x > (1 * x_scale + sel_xoff) && addr_x < (2 * x_scale - sel_xoff)) && (addr_y > (3 * y_scale + sel_yoff) && addr_y < (4 * y_scale - sel_yoff))) begin
			cube_index <=  8'd7;
		end
		else begin
			cube_index <= sq_8;
		end
		sel_index <= 1'b1;
	end
	//If in SQUARE 9
	else if((addr_x > (2 * x_scale + px_off) && addr_x < (3 * x_scale - px_off)) && (addr_y > (2 * y_scale + px_off) && addr_y < (3 * y_scale - px_off))) begin //col 3, row 3
		if(sel_x == 3 && sel_y == 3 && (addr_x > (2 * x_scale + sel_xoff) && addr_x < (3 * x_scale - sel_xoff)) && (addr_y > (2 * y_scale + sel_yoff) && addr_y < (3 * y_scale - sel_yoff))) begin
			cube_index <=  8'd7;
		end
		else begin
			cube_index <= sq_9;
		end
		sel_index <= 1'b1;
	end
	//If in SQUARE 10
	else if((addr_x > (3 * x_scale + px_off) && addr_x < (4 * x_scale - px_off)) && (addr_y > (2 * y_scale + px_off) && addr_y < (3 * y_scale - px_off))) begin //col 4, row 3
		if(sel_x == 4 && sel_y == 3 && (addr_x > (3 * x_scale + sel_xoff) && addr_x < (4 * x_scale - sel_xoff)) && (addr_y > (2 * y_scale + sel_yoff) && addr_y < (3 * y_scale - sel_yoff))) begin
			cube_index <=  8'd7;
		end
		else begin
			cube_index <= sq_10;
		end
		sel_index <= 1'b1;
	end
	//If in SQUARE 11
	else if((addr_x > (2 * x_scale + px_off) && addr_x < (3 * x_scale - px_off)) && (addr_y > (3 * y_scale + px_off) && addr_y < (4 * y_scale - px_off))) begin //col 3, row 4
		if(sel_x == 3 && sel_y == 4 && (addr_x > (2 * x_scale + sel_xoff) && addr_x < (3 * x_scale - sel_xoff)) && (addr_y > (3 * y_scale + sel_yoff) && addr_y < (4 * y_scale - sel_yoff))) begin
			cube_index <=  8'd7;
		end
		else begin
			cube_index <= sq_11;
		end
		sel_index <= 1'b1;
	end
	//If in SQUARE 12
	else if((addr_x > (3 * x_scale + px_off) && addr_x < (4 * x_scale - px_off)) && (addr_y > (3 * y_scale + px_off) && addr_y < (4 * y_scale - px_off))) begin //col 4, row 4
		if(sel_x == 4 && sel_y == 4 && (addr_x > (3 * x_scale + sel_xoff) && addr_x < (4 * x_scale - sel_xoff)) && (addr_y > (3 * y_scale + sel_yoff) && addr_y < (4 * y_scale - sel_yoff))) begin
			cube_index <=  8'd7;
		end
		else begin
			cube_index <= sq_12;
		end
		sel_index <= 1'b1;
	end
	//If in SQUARE 13
	else if((addr_x > (4 * x_scale + px_off) && addr_x < (5 * x_scale - px_off)) && (addr_y > (2 * y_scale + px_off) && addr_y < (3 * y_scale - px_off))) begin //col 5, row 3
		if(sel_x == 5 && sel_y == 3 && (addr_x > (4 * x_scale + sel_xoff) && addr_x < (5 * x_scale - sel_xoff)) && (addr_y > (2 * y_scale + sel_yoff) && addr_y < (3 * y_scale - sel_yoff))) begin
			cube_index <=  8'd7;
		end
		else begin
			cube_index <= sq_13;
		end
		sel_index <= 1'b1;
	end
	//If in SQUARE 14
	else if((addr_x > (5 * x_scale + px_off) && addr_x < (6 * x_scale - px_off)) && (addr_y > (2 * y_scale + px_off) && addr_y < (3 * y_scale - px_off))) begin //col 6, row 3
		if(sel_x == 6 && sel_y == 3 && (addr_x > (5 * x_scale + sel_xoff) && addr_x < (6 * x_scale - sel_xoff)) && (addr_y > (2 * y_scale + sel_yoff) && addr_y < (3 * y_scale - sel_yoff))) begin
			cube_index <=  8'd7;
		end
		else begin
			cube_index <= sq_14;
		end
		sel_index <= 1'b1;
	end
	//If in SQUARE 15
	else if((addr_x > (4 * x_scale + px_off) && addr_x < (5 * x_scale - px_off)) && (addr_y > (3 * y_scale + px_off) && addr_y < (4 * y_scale - px_off))) begin //col 5, row 4
		if(sel_x == 5 && sel_y == 4 && (addr_x > (4 * x_scale + sel_xoff) && addr_x < (5 * x_scale - sel_xoff)) && (addr_y > (3 * y_scale + sel_yoff) && addr_y < (4 * y_scale - sel_yoff))) begin
			cube_index <=  8'd7;
		end
		else begin
			cube_index <= sq_15;
		end
		sel_index <= 1'b1;
	end
	//If in SQUARE 16
	else if((addr_x > (5 * x_scale + px_off) && addr_x < (6 * x_scale - px_off)) && (addr_y > (3 * y_scale + px_off) && addr_y < (4 * y_scale - px_off))) begin //col 6, row 4
		if(sel_x == 6 && sel_y == 4 && (addr_x > (5 * x_scale + px_off) && addr_x < (6 * x_scale - px_off)) && (addr_y > (3 * y_scale + sel_yoff) && addr_y < (4 * y_scale - sel_yoff))) begin
			cube_index <=  8'd7;
		end
		else begin
			cube_index <= sq_16;
		end
		sel_index <= 1'b1;
	end
	//If in SQUARE 17
	else if((addr_x > (6 * x_scale + px_off) && addr_x < (7 * x_scale - px_off)) && (addr_y > (2 * y_scale + px_off) && addr_y < (3 * y_scale - px_off))) begin //col 7, row 3
		if(sel_x == 7 && sel_y == 3 && (addr_x > (6 * x_scale + px_off) && addr_x < (7 * x_scale - px_off)) && (addr_y > (2 * y_scale + sel_yoff) && addr_y < (3 * y_scale - sel_yoff))) begin
			cube_index <=  8'd7;
		end
		else begin
			cube_index <= sq_17;
		end
		sel_index <= 1'b1;
	end
	//If in SQUARE 18
	else if((addr_x > (7 * x_scale + px_off) && addr_x < (8 * x_scale - px_off)) && (addr_y > (2 * y_scale + px_off) && addr_y < (3 * y_scale - px_off))) begin //col 8, row 3
		if(sel_x == 8 && sel_y == 3 && (addr_x > (7 * x_scale + px_off) && addr_x < (8 * x_scale - px_off)) && (addr_y > (2 * y_scale + sel_yoff) && addr_y < (3 * y_scale - sel_yoff))) begin
			cube_index <=  8'd7;
		end
		else begin
			cube_index <= sq_18;
		end
		sel_index <= 1'b1;
	end
	//If in SQUARE 19
	else if((addr_x > (6 * x_scale + px_off) && addr_x < (7 * x_scale - px_off)) && (addr_y > (3 * y_scale + px_off) && addr_y < (4 * y_scale - px_off))) begin //col 7, row 4
		if(sel_x == 7 && sel_y == 4 && (addr_x > (6 * x_scale + px_off) && addr_x < (7 * x_scale - px_off)) && (addr_y > (3 * y_scale + sel_yoff) && addr_y < (4 * y_scale - sel_yoff))) begin
			cube_index <=  8'd7;
		end
		else begin
			cube_index <= sq_19;
		end
		sel_index <= 1'b1;
	end
	//If in SQUARE 20
	else if((addr_x > (7 * x_scale + px_off) && addr_x < (8 * x_scale - px_off)) && (addr_y > (3 * y_scale + px_off) && addr_y < (4 * y_scale - px_off))) begin //col 8, row 4
		if(sel_x == 8 && sel_y == 4 && (addr_x > (7 * x_scale + sel_xoff) && addr_x < (8 * x_scale - sel_xoff)) && (addr_y > (3 * y_scale + sel_yoff) && addr_y < (4 * y_scale - sel_yoff))) begin
			cube_index <=  8'd7;
		end
		else begin
			cube_index <= sq_20;
		end
		sel_index <= 1'b1;
	end
	//If in SQUARE 21
	else if((addr_x > (2 * x_scale + px_off) && addr_x < (3 * x_scale - px_off)) && (addr_y > (4 * y_scale + px_off) && addr_y < (5 * y_scale - px_off))) begin //col 3, row 5
		if(sel_x == 3 && sel_y == 5 && (addr_x > (2 * x_scale + sel_xoff) && addr_x < (3 * x_scale - sel_xoff)) && (addr_y > (4 * y_scale + sel_yoff) && addr_y < (5 * y_scale - sel_yoff))) begin
			cube_index <=  8'd7;
		end
		else begin
			cube_index <= sq_21;
		end
		sel_index <= 1'b1;
	end
	//If in SQUARE 22
	else if((addr_x > (3 * x_scale + px_off) && addr_x < (4 * x_scale - px_off)) && (addr_y > (4 * y_scale + px_off) && addr_y < (5 * y_scale - px_off))) begin //col 4, row 5
		if(sel_x == 4 && sel_y == 5 && (addr_x > (3 * x_scale + sel_xoff) && addr_x < (4 * x_scale - sel_xoff)) && (addr_y > (4 * y_scale + sel_yoff) && addr_y < (5 * y_scale - sel_yoff))) begin
			cube_index <=  8'd7;
		end
		else begin
			cube_index <= sq_22;
		end
		sel_index <= 1'b1;
	end
	//If in SQUARE 23
	else if((addr_x > (2 * x_scale + px_off) && addr_x < (3 * x_scale - px_off)) && (addr_y > (5 * y_scale + px_off) && addr_y < (6 * y_scale - px_off))) begin //col 3, row 6
		if(sel_x == 3 && sel_y == 6 && (addr_x > (2 * x_scale + sel_xoff) && addr_x < (3 * x_scale - sel_xoff)) && (addr_y > (5 * y_scale + sel_yoff) && addr_y < (6 * y_scale - sel_yoff))) begin
			cube_index <=  8'd7;
		end
		else begin
			cube_index <= sq_23;
		end
		sel_index <= 1'b1;
	end
	//If in SQUARE 24
	else if((addr_x > (3 * x_scale + px_off) && addr_x < (4 * x_scale - px_off)) && (addr_y > (5 * y_scale + px_off) && addr_y < (6 * y_scale - px_off))) begin //col 4, row 6
		if(sel_x == 4 && sel_y == 6 && (addr_x > (3 * x_scale + sel_xoff) && addr_x < (4 * x_scale - sel_xoff)) && (addr_y > (5 * y_scale + sel_yoff) && addr_y < (6 * y_scale - sel_yoff))) begin
			cube_index <=  8'd7;
		end
		else begin
			cube_index <= sq_24;
		end
		sel_index <= 1'b1;
	end
	else begin
		sel_index <= 1'b0;
	end
end
			 

endmodule 