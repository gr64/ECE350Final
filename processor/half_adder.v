module half_adder(
	input x, y,
	output s, c
	);
	
	xor xo(s, x, y);
	and a(c, x, y);

endmodule
