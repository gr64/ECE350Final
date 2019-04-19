module full_adder(
	input a, b, cin,
	output s, c);
	
	wire w0, w1, w2;
	
	xor x(s, a, b, cin);
	and a0(w0, a, b);
	and a1(w1, a, cin);
	and a2(w2, b, cin);
	or o(c, w0, w1, w2);
endmodule
