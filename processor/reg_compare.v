module reg_compare(
	input[4:0] reg1, reg2,
	output is_equal);
	
	wire x_0, x_1, x_2, x_3, x_4;
	
	xnor x0(x_0, reg1[0], reg2[0]);
	xnor x1(x_1, reg1[1], reg2[1]);
	xnor x2(x_2, reg1[2], reg2[2]);
	xnor x3(x_3, reg1[3], reg2[3]);
	xnor x4(x_4, reg1[4], reg2[4]);
	
	and a(is_equal, x_0, x_1, x_2, x_3, x_4);

endmodule