module mux_16(select, in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15, out);
	input[3:0] select;
	input[31:0] in0, in1, in2, in3, in4, in5, in6, in7, in8, in9, in10, in11, in12, in13, in14, in15;
	output[31:0] out;
	wire [31:0] w1, w2, w3, w4;
	mux_4 first_top(.select(select[1:0]), .in0(in0), .in1(in1), .in2(in2), .in3(in3), .out(w1));
	mux_4 first_second(.select(select[1:0]), .in0(in4), .in1(in5), .in2(in6), .in3(in7), .out(w2));
	mux_4 first_third(.select(select[1:0]), .in0(in8), .in1(in9), .in2(in10), .in3(in11), .out(w3));
	mux_4 first_bottom(.select(select[1:0]), .in0(in12), .in1(in13), .in2(in14), .in3(in15), .out(w4));
	mux_4 second(.select(select[3:2]), .in0(w1), .in1(w2), .in2(w3), .in3(w4), .out(out));
endmodule


	