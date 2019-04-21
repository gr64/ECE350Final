module cla_8_r(
	input cin,
	input [7:0] x, y,
	output cout,
	output [7:0] s
	);
	
	wire[7:0] g, p;
	
	and a0(g[0], x[0], y[0]);
	and a1(g[1], x[1], y[1]);
	and a2(g[2], x[2], y[2]);
	and a3(g[3], x[3], y[3]);
	and a4(g[4], x[4], y[4]);
	and a5(g[5], x[5], y[5]);
	and a6(g[6], x[6], y[6]);
	and a7(g[7], x[7], y[7]);
	
	or or0(p[0], x[0], y[0]);
	or or1(p[1], x[1], y[1]);
	or or2(p[2], x[2], y[2]);
	or or3(p[3], x[3], y[3]);
	or or4(p[4], x[4], y[4]);
	or or5(p[5], x[5], y[5]);
	or or6(p[6], x[6], y[6]);
	or or7(p[7], x[7], y[7]);

	wire w1_1, c1, w2_1, w2_2, c2, w3_1, w3_2, w3_3, c3, w4_1, w4_2, w4_3, w4_4, c4, w5_1, w5_2, w5_3, w5_4, w5_5, c5;
	wire w6_1, w6_2, w6_3, w6_4, w6_5, w6_6, c6, w7_1, w7_2, w7_3, w7_4, w7_5, w7_6, w7_7, c7, w8_1, w8_2, w8_3, w8_4, w8_5, w8_6, w8_7, w8_8;
	
	//computing c1
	and a1_1(w1_1, p[0], cin);
	or o1(c1, g[0], w1_1);
	
	//computing c2
	and a2_1(w2_1, p[1], g[0]);
	and a2_2(w2_2, p[1], p[0], cin);
	or o2(c2, g[1], w2_1, w2_2);
	
	//computing c3
	and a3_1(w3_1, p[2], g[1]);
	and a3_2(w3_2, p[2], p[1], g[0]);
	and a3_3(w3_3, p[2], p[1], p[0], cin);
	or o3(c3, g[2], w3_1, w3_2, w3_3);

	//computing c4
	and a4_1(w4_1, p[3], g[2]);
	and a4_2(w4_2, p[3], p[2], g[1]);
	and a4_3(w4_3, p[3], p[2], p[1], g[0]);
	and a4_4(w4_4, p[3], p[2], p[1], p[0], cin);
	or o4(c4, g[3], w4_1, w4_2, w4_3, w4_4);
	
	//computing c5
	and a5_1(w5_1, p[4], g[3]);
	and a5_2(w5_2, p[4], p[3], g[2]);
	and a5_3(w5_3, p[4], p[3], p[2], g[1]);
	and a5_4(w5_4, p[4], p[3], p[2], p[1], g[0]);
	and a5_5(w5_5, p[4], p[3], p[2], p[1], p[0], cin);
	or o5(c5, g[4], w5_1, w5_2, w5_3, w5_4, w5_5);
	
	//computing c6
	and a6_1(w6_1, p[5], g[4]);
	and a6_2(w6_2, p[5], p[4], g[3]);
	and a6_3(w6_3, p[5], p[4], p[3], g[2]);
	and a6_4(w6_4, p[5], p[4], p[3], p[2], g[1]);
	and a6_5(w6_5, p[5], p[4], p[3], p[2], p[1], g[0]);
	and a6_6(w6_6, p[5], p[4], p[3], p[2], p[1], p[0], cin);
	or o6(c6, g[5], w6_1, w6_2, w6_3, w6_4, w6_5, w6_6);
	
	//computing c7
	and a7_1(w7_1, p[6], g[5]);
	and a7_2(w7_2, p[6], p[5], g[4]);
	and a7_3(w7_3, p[6], p[5], p[4], g[3]);
	and a7_4(w7_4, p[6], p[5], p[4], p[3], g[2]);
	and a7_5(w7_5, p[6], p[5], p[4], p[3], p[2], g[1]);
	and a7_6(w7_6, p[6], p[5], p[4], p[3], p[2], p[1], g[0]);
	and a7_7(w7_7, p[6], p[5], p[4], p[3], p[2], p[1], p[0], cin);
	or o7(c7, g[6], w7_1, w7_2, w7_3, w7_4, w7_5, w7_6, w7_7);
	
	//computing c8
	and a8_1(w8_1, p[7], g[6]);
	and a8_2(w8_2, p[7], p[6], g[5]);
	and a8_3(w8_3, p[7], p[6], p[5], g[4]);
	and a8_4(w8_4, p[7], p[6], p[5], p[4], g[3]);
	and a8_5(w8_5, p[7], p[6], p[5], p[4], p[3], g[2]);
	and a8_6(w8_6, p[7], p[6], p[5], p[4], p[3], p[2], g[1]);
	and a8_7(w8_7, p[7], p[6], p[5], p[4], p[3], p[2], p[1], g[0]);
	and a8_8(w8_8, p[7], p[6], p[5], p[4], p[3], p[2], p[1], p[0], cin);
	or o8(cout, g[7], w8_1, w8_2, w8_3, w8_4, w8_5, w8_6, w8_7, w8_8);
	
	//computing sums
	xor x0(s[0], x[0], y[0], cin);
	xor x1(s[1], x[1], y[1], c1);
	xor x2(s[2], x[2], y[2], c2);
	xor x3(s[3], x[3], y[3], c3);
	xor x4(s[4], x[4], y[4], c4);
	xor x5(s[5], x[5], y[5], c5);
	xor x6(s[6], x[6], y[6], c6);
	xor x7(s[7], x[7], y[7], c7);
	
endmodule