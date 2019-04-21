module register(outval, inval, clk, en, clr);

   //Inputs
	input [31:0] inval;
   input clk, en, clr;
   
   //Internal wire
   wire clr;

   //Output
   output [31:0] outval;
	
	dffe_ref dffe0(outval[0], inval[0], clk, en, clr);
	dffe_ref dffe1(outval[1], inval[1], clk, en, clr);
	dffe_ref dffe2(outval[2], inval[2], clk, en, clr);
	dffe_ref dffe3(outval[3], inval[3], clk, en, clr);
	dffe_ref dffe4(outval[4], inval[4], clk, en, clr);
	dffe_ref dffe5(outval[5], inval[5], clk, en, clr);
	dffe_ref dffe6(outval[6], inval[6], clk, en, clr);
	dffe_ref dffe7(outval[7], inval[7], clk, en, clr);
	dffe_ref dffe8(outval[8], inval[8], clk, en, clr);
	dffe_ref dffe9(outval[9], inval[9], clk, en, clr);
	dffe_ref dffe10(outval[10], inval[10], clk, en, clr);
	dffe_ref dffe11(outval[11], inval[11], clk, en, clr);
	dffe_ref dffe12(outval[12], inval[12], clk, en, clr);
	dffe_ref dffe13(outval[13], inval[13], clk, en, clr);
	dffe_ref dffe14(outval[14], inval[14], clk, en, clr);
	dffe_ref dffe15(outval[15], inval[15], clk, en, clr);
	dffe_ref dffe16(outval[16], inval[16], clk, en, clr);
	dffe_ref dffe17(outval[17], inval[17], clk, en, clr);
	dffe_ref dffe18(outval[18], inval[18], clk, en, clr);
	dffe_ref dffe19(outval[19], inval[19], clk, en, clr);
	dffe_ref dffe20(outval[20], inval[20], clk, en, clr);
	dffe_ref dffe21(outval[21], inval[21], clk, en, clr);
	dffe_ref dffe22(outval[22], inval[22], clk, en, clr);
	dffe_ref dffe23(outval[23], inval[23], clk, en, clr);
	dffe_ref dffe24(outval[24], inval[24], clk, en, clr);
	dffe_ref dffe25(outval[25], inval[25], clk, en, clr);
	dffe_ref dffe26(outval[26], inval[26], clk, en, clr);
	dffe_ref dffe27(outval[27], inval[27], clk, en, clr);
	dffe_ref dffe28(outval[28], inval[28], clk, en, clr);
	dffe_ref dffe29(outval[29], inval[29], clk, en, clr);
	dffe_ref dffe30(outval[30], inval[30], clk, en, clr);
	dffe_ref dffe31(outval[31], inval[31], clk, en, clr);
	
endmodule
	