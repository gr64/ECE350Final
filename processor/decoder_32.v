module decoder_32(sel, 
	out0, out1, out2, out3, out4, out5, out6, out7, 
	out8, out9, out10, out11, out12, out13, out14, out15, 
	out16, out17, out18, out19, out20, out21, out22, out23,
	out24, out25, out26, out27, out28, out29, out30, out31
);
	//Inputs
   input [4:0] sel;

   //Output
   output out0, out1, out2, out3, out4, out5, out6, out7, 
	out8, out9, out10, out11, out12, out13, out14, out15, 
	out16, out17, out18, out19, out20, out21, out22, out23,
	out24, out25, out26, out27, out28, out29, out30, out31;
	
	wire n0o, n1o, n2o, n3o, n4o;
	
	not n0(n0o, sel[0]);
	not n1(n1o, sel[1]);
	not n2(n2o, sel[2]);
	not n3(n3o, sel[3]);
	not n4(n4o, sel[4]);
	
	and a0(out0, n0o, n1o, n2o, n3o, n4o);
	and a1(out1, sel[0], n1o, n2o, n3o, n4o);
	and a2(out2, n0o, sel[1], n2o, n3o, n4o);
	and a3(out3, sel[0], sel[1], n2o, n3o, n4o);
	and a4(out4, n0o, n1o, sel[2], n3o, n4o);
	and a5(out5, sel[0], n1o, sel[2], n3o, n4o);
	and a6(out6, n0o, sel[1], sel[2], n3o, n4o);
	and a7(out7, sel[0], sel[1], sel[2], n3o, n4o);
	and a8(out8, n0o, n1o, n2o, sel[3], n4o);
	and a9(out9, sel[0], n1o, n2o, sel[3], n4o);
	and a10(out10, n0o, sel[1], n2o, sel[3], n4o);
	and a11(out11, sel[0], sel[1], n2o, sel[3], n4o);
	and a12(out12, n0o, n1o, sel[2], sel[3], n4o);
	and a13(out13, sel[0], n1o, sel[2], sel[3], n4o);
	and a14(out14, n0o, sel[1], sel[2], sel[3], n4o);
	and a15(out15, sel[0], sel[1], sel[2], sel[3], n4o);
	and a16(out16, n0o, n1o, n2o, n3o, sel[4]);
	and a17(out17, sel[0], n1o, n2o, n3o, sel[4]);
	and a18(out18, n0o, sel[1], n2o, n3o, sel[4]);
	and a19(out19, sel[0], sel[1], n2o, n3o, sel[4]);
	and a20(out20, n0o, n1o, sel[2], n3o, sel[4]);
	and a21(out21, sel[0], n1o, sel[2], n3o, sel[4]);
	and a22(out22, n0o, sel[1], sel[2], n3o, sel[4]);
	and a23(out23, sel[0], sel[1], sel[2], n3o, sel[4]);
	and a24(out24, n0o, n1o, n2o, sel[3], sel[4]);
	and a25(out25, sel[0], n1o, n2o, sel[3], sel[4]);
	and a26(out26, n0o, sel[1], n2o, sel[3], sel[4]);
	and a27(out27, sel[0], sel[1], n2o, sel[3], sel[4]);
	and a28(out28, n0o, n1o, sel[2], sel[3], sel[4]);
	and a29(out29, sel[0], n1o, sel[2], sel[3], sel[4]);
	and a30(out30, n0o, sel[1], sel[2], sel[3], sel[4]);
	and a31(out31, sel[0], sel[1], sel[2], sel[3], sel[4]);
	
endmodule
	
	