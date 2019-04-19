module shifter(
	input [31:0] in,
	input [4:0] shamt,
	output [31:0] sll_out, sra_out);

	wire [31:0] w0, w1, w2, w3, w4, w5, w6, w7, o16, o8, o4, o2, o1, ro16, ro8, ro4, ro2, ro1;

	
	left_shift_16 ls16(in, o16);
	mux_2 lm16(shamt[4], in, o16, w0);
	left_shift_8 ls4(w0, o8);
	mux_2 lm8(shamt[3], w0, o8, w1);
	left_shift_4 ls3(w1, o4);
	mux_2 lm4(shamt[2], w1, o4, w2);
	left_shift_2 ls2(w2, o2);
	mux_2 lm2(shamt[1], w2, o2, w3);
	left_shift_1 ls1(w3, o1);
	mux_2 lm1(shamt[0], w3, o1, sll_out);
	
	right_shift_16 rs16(in, ro16);
	mux_2 rm16(shamt[4], in, ro16, w4);
	right_shift_8 rs4(w4, ro8);
	mux_2 rm8(shamt[3], w4, ro8, w5);
	right_shift_4 rs3(w5, ro4);
	mux_2 rm4(shamt[2], w5, ro4, w6);
	right_shift_2 rs2(w6, ro2);
	mux_2 rm2(shamt[1], w6, ro2, w7);
	right_shift_1 rs1(w7, ro1);
	mux_2 rm1(shamt[0], w7, ro1, sra_out);
	
endmodule