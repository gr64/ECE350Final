module alu(//data_operandA, data_operandB, ctrl_ALUopcode, ctrl_shiftamt, data_result, isNotEqual, isLessThan, overflow);

   input [31:0] data_operandA, data_operandB,//;
   input [4:0] ctrl_ALUopcode, ctrl_shiftamt,//;

   output [31:0] data_result,// notB, g, p, //;
   output isNotEqual, isLessThan, overflow);
	
	wire[31:0] notB, g, p, sub_g, sub_p, add_out, sub_out, sll_out, sra_out, mul_out, div_out;
	//wire[31:0] B, add_out, sub_out, sll_out, sra_out;
	wire cout_add, cout_sub, oxnA, oxA, overflow_add, oxnS, oxS, overflow_sub, w0, w1, w2, w3, w4, w5, w6, w7, oa1, oa2, overflow_as, overflow_mult, is_mult;
	
	//flip bits of B for subtraction
	genvar i;
	generate
	for(i = 0; i < 32; i = i + 1) begin: loop0
		not n0(notB[i], data_operandB[i]);
	end
	endgenerate
	
	//generate g
	genvar j;
	generate
	for(j = 0; j < 32; j = j + 1) begin: loop1
		and a0(g[j], data_operandA[j], data_operandB[j]);
	end
	endgenerate
	
	//generate p
	genvar k;
	generate
	for(k = 0; k < 32; k = k + 1) begin: loop2
		or o0(p[k], data_operandA[k], data_operandB[k]);
	end
	endgenerate
	
	//generate sub_g
	genvar l;
	generate
	for(l = 0; l < 32; l = l + 1) begin: loop3
		and a0(sub_g[l], data_operandA[l], notB[l]);
	end
	endgenerate
	
	//generate sub_p
	genvar m;
	generate
	for(m = 0; m < 32; m = m + 1) begin: loop4
		or o0(sub_p[m], data_operandA[m], notB[m]);
	end
	endgenerate
	
	//mux_2 chooseB(ctrl_ALUopcode[0], data_operandB, notB, B);
	
	//carry_select_32 adder(ctrl_ALUopcode[0], data_operandA, B, g, p, cout_add, add_out);
   carry_select_32_gpin adder(ctrl_ALUopcode[0], data_operandA, data_operandB, g, p, cout_add, add_out);
	carry_select_32_gpin subtractor(1'b1, data_operandA, notB, sub_g, sub_p, cout_sub, sub_out);
	
	//compute add overflow
	xnor xnA(oxnA, data_operandA[31], data_operandB[31]);
	xor xA(oxA, data_operandB[31], add_out[31]);
	and aA(overflow_add, oxnA, oxA);
	
	//compute sub overflow
	xnor xnS(oxnS, data_operandA[31], notB[31]);
	xor xS(oxS, notB[31], sub_out[31]);
	and aS(overflow_sub, oxnS, oxS);
	
	
	//computing isNotEqual
	or ne0(w0, sub_out[0], sub_out[1], sub_out[2], sub_out[3]);
	or ne1(w1, sub_out[4], sub_out[5], sub_out[6], sub_out[7]);
	or ne2(w2, sub_out[8], sub_out[9], sub_out[10], sub_out[11]);
	or ne3(w3, sub_out[12], sub_out[13], sub_out[14], sub_out[15]);
	or ne4(w4, sub_out[16], sub_out[17], sub_out[18], sub_out[19]);
	or ne5(w5, sub_out[20], sub_out[21], sub_out[22], sub_out[23]);
	or ne6(w6, sub_out[24], sub_out[25], sub_out[26], sub_out[27]);
	or ne7(w7, sub_out[28], sub_out[29], sub_out[30], sub_out[31]);
	
	or a1(oa1, w0, w1, w2, w3);
	or a2(oa2, w4, w5, w6, w7, overflow_sub);
	or a3(isNotEqual, oa1, oa2);
	
	//assigning isLessThan
	//assign isLessThan = sub_out[31];
	mux_2_1 chooseLess(overflow_sub, sub_out[31], data_operandA[31], isLessThan);
	
	shifter shift(data_operandA, ctrl_shiftamt, sll_out, sra_out);
	
	wallace_mult_32s multiplier(data_operandA, data_operandB, mul_out, overflow_mult);
	
	and choose_mult(is_mult, ctrl_ALUopcode[1], ctrl_ALUopcode[2]); //note for future reference: could also be div
	
	mux_2_1 oflow(ctrl_ALUopcode[0], overflow_add, overflow_sub, overflow_as);
	mux_2_1 oflow_m(is_mult, overflow_as, overflow_mult, overflow);

	
	mux_8 result(ctrl_ALUopcode[2:0], add_out, sub_out, g, p, sll_out, sra_out, mul_out, div_out, data_result);

endmodule
