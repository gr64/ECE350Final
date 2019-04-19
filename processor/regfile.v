module regfile (
    clock,
    ctrl_writeEnable,
    ctrl_reset, ctrl_writeReg,
    ctrl_readRegA, ctrl_readRegB, data_writeReg,
    data_readRegA, data_readRegB
);
   input clock, ctrl_writeEnable, ctrl_reset;
   input [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
   input [31:0] data_writeReg;
	
	wire [31:0] r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31;
	wire w0, w1, w2, w3, w4, w5, w6, w7, w8, w9, w10, w11, w12, w13, w14, w15, w16, w17, w18, w19, w20, w21, w22, w23, w24, w25, w26, w27, w28, w29, w30, w31;
	wire out0, out1, out2, out3, out4, out5, out6, out7, out8, out9, out10, out11, out12, out13, out14, out15, out16, out17, out18, out19, out20, out21, out22, out23, out24, out25, out26, out27, out28, out29, out30, out31;
	
   output [31:0] data_readRegA, data_readRegB;

   /* YOUR CODE HERE */
	
	decoder_32 decoder(ctrl_writeReg, 
	out0, out1, out2, out3, out4, out5, out6, out7, 
	out8, out9, out10, out11, out12, out13, out14, out15, 
	out16, out17, out18, out19, out20, out21, out22, out23,
	out24, out25, out26, out27, out28, out29, out30, out31);
	
	and a0(w0, 1'b0, out0);
	and a1(w1, ctrl_writeEnable, out1);
	and a2(w2, ctrl_writeEnable, out2);
	and a3(w3, ctrl_writeEnable, out3);
	and a4(w4, ctrl_writeEnable, out4);
	and a5(w5, ctrl_writeEnable, out5);
	and a6(w6, ctrl_writeEnable, out6);
	and a7(w7, ctrl_writeEnable, out7);
	and a8(w8, ctrl_writeEnable, out8);
	and a9(w9, ctrl_writeEnable, out9);
	and a10(w10, ctrl_writeEnable, out10);
	and a11(w11, ctrl_writeEnable, out11);
	and a12(w12, ctrl_writeEnable, out12);
	and a13(w13, ctrl_writeEnable, out13);
	and a14(w14, ctrl_writeEnable, out14);
	and a15(w15, ctrl_writeEnable, out15);
	and a16(w16, ctrl_writeEnable, out16);
	and a17(w17, ctrl_writeEnable, out17);
	and a18(w18, ctrl_writeEnable, out18);
	and a19(w19, ctrl_writeEnable, out19);
	and a20(w20, ctrl_writeEnable, out20);
	and a21(w21, ctrl_writeEnable, out21);
	and a22(w22, ctrl_writeEnable, out22);
	and a23(w23, ctrl_writeEnable, out23);
	and a24(w24, ctrl_writeEnable, out24);
	and a25(w25, ctrl_writeEnable, out25);
	and a26(w26, ctrl_writeEnable, out26);
	and a27(w27, ctrl_writeEnable, out27);
	and a28(w28, ctrl_writeEnable, out28);
	and a29(w29, ctrl_writeEnable, out29);
	and a30(w30, ctrl_writeEnable, out30);
	and a31(w31, ctrl_writeEnable, out31);
	
	register re0(r0, data_writeReg, clock, w0, ctrl_reset);
	register re1(r1, data_writeReg, clock, w1, ctrl_reset);
	register re2(r2, data_writeReg, clock, w2, ctrl_reset);
	register re3(r3, data_writeReg, clock, w3, ctrl_reset);
	register re4(r4, data_writeReg, clock, w4, ctrl_reset);
	register re5(r5, data_writeReg, clock, w5, ctrl_reset);
	register re6(r6, data_writeReg, clock, w6, ctrl_reset);
	register re7(r7, data_writeReg, clock, w7, ctrl_reset);
	register re8(r8, data_writeReg, clock, w8, ctrl_reset);
	register re9(r9, data_writeReg, clock, w9, ctrl_reset);
	register re10(r10, data_writeReg, clock, w10, ctrl_reset);
	register re11(r11, data_writeReg, clock, w11, ctrl_reset);
	register re12(r12, data_writeReg, clock, w12, ctrl_reset);
	register re13(r13, data_writeReg, clock, w13, ctrl_reset);
	register re14(r14, data_writeReg, clock, w14, ctrl_reset);
	register re15(r15, data_writeReg, clock, w15, ctrl_reset);
	register re16(r16, data_writeReg, clock, w16, ctrl_reset);
	register re17(r17, data_writeReg, clock, w17, ctrl_reset);
	register re18(r18, data_writeReg, clock, w18, ctrl_reset);
	register re19(r19, data_writeReg, clock, w19, ctrl_reset);
	register re20(r20, data_writeReg, clock, w20, ctrl_reset);
	register re21(r21, data_writeReg, clock, w21, ctrl_reset);
	register re22(r22, data_writeReg, clock, w22, ctrl_reset);
	register re23(r23, data_writeReg, clock, w23, ctrl_reset);
	register re24(r24, data_writeReg, clock, w24, ctrl_reset);
	register re25(r25, data_writeReg, clock, w25, ctrl_reset);
	register re26(r26, data_writeReg, clock, w26, ctrl_reset);
	register re27(r27, data_writeReg, clock, w27, ctrl_reset);
	register re28(r28, data_writeReg, clock, w28, ctrl_reset);
	register re29(r29, data_writeReg, clock, w29, ctrl_reset);
	register re30(r30, data_writeReg, clock, w30, ctrl_reset);
	register re31(r31, data_writeReg, clock, w31, ctrl_reset);
	
	mux_32 mux1(ctrl_readRegA, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, data_readRegA);
	mux_32 mux2(ctrl_readRegB, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28, r29, r30, r31, data_readRegB);
	

endmodule
