module left_shift_2(in, out);
	input [31:0] in;
	output [31:0] out;
	and a0(out[0], 1'b0, 1'b0);
	and a1(out[1], 1'b0, 1'b0);
	and a2(out[2], in[0], 1'b1);
	and a3(out[3], in[1], 1'b1);
	and a4(out[4], in[2], 1'b1);
	and a5(out[5], in[3], 1'b1);
	and a6(out[6], in[4], 1'b1);
	and a7(out[7], in[5], 1'b1);
	and a8(out[8], in[6], 1'b1);
	and a9(out[9], in[7], 1'b1);
	and a10(out[10], in[8], 1'b1);
	and a11(out[11], in[9], 1'b1);
	and a12(out[12], in[10], 1'b1);
	and a13(out[13], in[11], 1'b1);
	and a14(out[14], in[12], 1'b1);
	and a15(out[15], in[13], 1'b1);
	and a16(out[16], in[14], 1'b1);
	and a17(out[17], in[15], 1'b1);
	and a18(out[18], in[16], 1'b1);
	and a19(out[19], in[17], 1'b1);
	and a20(out[20], in[18], 1'b1);
	and a21(out[21], in[19], 1'b1);
	and a22(out[22], in[20], 1'b1);
	and a23(out[23], in[21], 1'b1);
	and a24(out[24], in[22], 1'b1);
	and a25(out[25], in[23], 1'b1);
	and a26(out[26], in[24], 1'b1);
	and a27(out[27], in[25], 1'b1);
	and a28(out[28], in[26], 1'b1);
	and a29(out[29], in[27], 1'b1);
	and a30(out[30], in[28], 1'b1);
	and a31(out[31], in[29], 1'b1);
	
endmodule