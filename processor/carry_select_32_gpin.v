module carry_select_32_gpin(
	input cin,
	input [31:0] x, y, g, p,
	output cout,
	output [31:0] s
	);
	
	wire [7:0] s1a, s1b, s2a, s2b, s3a, s3b;
	wire c1, c2a, c2b, c2, c3a, c3b, c3, c4a, c4b;
	
	cla_8 a0(cin, x[7:0], y[7:0], g[7:0], p[7:0], c1, s[7:0]);
	
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