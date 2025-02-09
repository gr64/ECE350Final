module carry_select_32(
	input cin,
	input [31:0] x, y,
	output cout,
	output [31:0] s
	);
	
	wire [31:0] g, p;
	wire [7:0] s1a, s1b, s2a, s2b, s3a, s3b;
	wire c1, c2a, c2b, c2, c3a, c3b, c3, c4a, c4b;
	
	and a0(g[0], x[0], y[0]);
	and a1(g[1], x[1], y[1]);
	and a2(g[2], x[2], y[2]);
	and a3(g[3], x[3], y[3]);
	and a4(g[4], x[4], y[4]);
	and a5(g[5], x[5], y[5]);
	and a6(g[6], x[6], y[6]);
	and a7(g[7], x[7], y[7]);
	and a8(g[8], x[8], y[8]);
	and a9(g[9], x[9], y[9]);
	and a10(g[10], x[10], y[10]);
	and a11(g[11], x[11], y[11]);
	and a12(g[12], x[12], y[12]);
	and a13(g[13], x[13], y[13]);
	and a14(g[14], x[14], y[14]);
	and a15(g[15], x[15], y[15]);
	and a16(g[16], x[16], y[16]);
	and a17(g[17], x[17], y[17]);
	and a18(g[18], x[18], y[18]);
	and a19(g[19], x[19], y[19]);
	and a20(g[20], x[20], y[20]);
	and a21(g[21], x[21], y[21]);
	and a22(g[22], x[22], y[22]);
	and a23(g[23], x[23], y[23]);
	and a24(g[24], x[24], y[24]);
	and a25(g[25], x[25], y[25]);
	and a26(g[26], x[26], y[26]);
	and a27(g[27], x[27], y[27]);
	and a28(g[28], x[28], y[28]);
	and a29(g[29], x[29], y[29]);
	and a30(g[30], x[30], y[30]);
	and a31(g[31], x[31], y[31]);
	
	or o0(p[0], x[0], y[0]);
	or o1(p[1], x[1], y[1]);
	or o2(p[2], x[2], y[2]);
	or o3(p[3], x[3], y[3]);
	or o4(p[4], x[4], y[4]);
	or o5(p[5], x[5], y[5]);
	or o6(p[6], x[6], y[6]);
	or o7(p[7], x[7], y[7]);
	or o8(p[8], x[8], y[8]);
	or o9(p[9], x[9], y[9]);
	or o10(p[10], x[10], y[10]);
	or o11(p[11], x[11], y[11]);
	or o12(p[12], x[12], y[12]);
	or o13(p[13], x[13], y[13]);
	or o14(p[14], x[14], y[14]);
	or o15(p[15], x[15], y[15]);
	or o16(p[16], x[16], y[16]);
	or o17(p[17], x[17], y[17]);
	or o18(p[18], x[18], y[18]);
	or o19(p[19], x[19], y[19]);
	or o20(p[20], x[20], y[20]);
	or o21(p[21], x[21], y[21]);
	or o22(p[22], x[22], y[22]);
	or o23(p[23], x[23], y[23]);
	or o24(p[24], x[24], y[24]);
	or o25(p[25], x[25], y[25]);
	or o26(p[26], x[26], y[26]);
	or o27(p[27], x[27], y[27]);
	or o28(p[28], x[28], y[28]);
	or o29(p[29], x[29], y[29]);
	or o30(p[30], x[30], y[30]);
	or o31(p[31], x[31], y[31]);

	cla_8 a00(cin, x[7:0], y[7:0], g[7:0], p[7:0], c1, s[7:0]);
	
	cla_8 a1a(1'b0, x[15:8], y[15:8], g[15:8], p[15:8], c2a, s1a[7:0]);
	cla_8 a1b(1'b1, x[15:8], y[15:8], g[15:8], p[15:8], c2b, s1b[7:0]);
	
	mux_2_8 m1s(c1, s1a, s1b, s[15:8]);
	mux_2_1 m1c(c1, c2a, c2b, c2);

	cla_8 a2a(1'b0, x[23:16], y[23:16], g[23:16], p[23:16], c3a, s2a[7:0]);
	cla_8 a2b(1'b1, x[23:16], y[23:16], g[23:16], p[23:16], c3b, s2b[7:0]);
	
	mux_2_8 m2s(c2, s2a, s2b, s[23:16]);
	mux_2_1 m2c(c2, c3a, c3b, c3);
	
	cla_8 a3a(1'b0, x[31:24], y[31:24], g[31:24], p[31:24], c4a, s3a[7:0]);
	cla_8 a3b(1'b1, x[31:24], y[31:24], g[31:24], p[31:24], c4b, s3b[7:0]);
	
	mux_2_8 m3s(c3, s3a, s3b, s[31:24]);
	mux_2_1 m3c(c3, c4a, c4b, cout);
	
	
endmodule