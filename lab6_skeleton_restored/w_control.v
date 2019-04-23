module w_control(
	input[4:0] opcode, aluop,
	input excep,
	
	output reg_wren, dmem_wren, select_immed, select_writeval, select_readReg,
	output[1:0] select_pc,
	output j_or_jal,
	output[2:0] sel_excep, //chooses 1 through 5 or T to write into $rstatus depending on instruction
	output is_setx,
	output is_div
);
	wire out0, out1, out2, out3, out4, out5, out6, out7, 
	out8, out9, out10, out11, out12, out13, out14, out15, 
	out16, out17, out18, out19, out20, out21, out22, out23,
	out24, out25, out26, out27, out28, out29, out30, out31;
	wire o0, o1, o2, o3, o4, o5, o6, o7, o8, o9, o10,
	o11, o12, o13, o14, o15, o16, o17, o18, o19, o20, 
	o21, o22, o23, o24, o25, o26, o27, o28, o29, o30, o31; 
	
	wire alu_inst, j, bne, jal, jr, addi, blt, sw, lw,  bex, setx;
	wire add, sub, _and, _or, sll, sra, mul, div;
	wire add_x, sub_x, addi_x, mul_x, div_x;

	
	decoder_32 opcode_decoder(opcode, 
	alu_inst, j, bne, jal, jr, addi, blt, sw, lw, 
	out9, out10, out11, out12, out13, out14, out15, 
	out16, out17, out18, out19, out20, setx, bex, out23,
	out24, out25, out26, out27, out28, out29, out30, out31);
	
	
	decoder_32 aluop_decoder(aluop, 
	o0, o1, o2, o3, o4, o5, o6, o7, o8, o9, o10,
	o11, o12, o13, o14, o15, o16, o17, o18, o19, o20, 
	o21, o22, o23, o24, o25, o26, o27, o28, o29, o30, o31);
	
	and a0(add, alu_inst, o0);
	and a1(sub, alu_inst, o1);
	and a2(_and, alu_inst, o2);
	and a3(_or, alu_inst, o3);
	and a4(sll, alu_inst, o4);
	and a5(sra, alu_inst, o5);
	and a6(mul, alu_inst, o6);
	and a7(div, alu_inst, o7);
	
	nor reg_wren_nor(reg_wren, sw, j, bne, jr, blt, bex);
	or select_immed_or(select_immed, addi, sw, lw);
	
	assign dmem_wren = sw; //only write to dmem with sw anyway
	assign select_writeval = lw; //only write value from memory when lw
	assign select_readReg = sw;
	
	or select_pc_or0(select_pc[0], j, jal, jr, bex);
	or select_pc_or1(select_pc[1], bne, jr, blt);

	or j_jal_or(j_or_jal, j, jal);
	
	and a0x(add_x, add, excep);
	and a1x(sub_x, sub, excep);
	and a2x(addi_x, addi, excep);
	and a3x(mul_x, mul, excep);
	and a4x(div_x, div, excep); //at most one of these should be 1 at a time
	
	or sel_excep_or0(sel_excep[0], add_x, sub_x, div_x);
	or sel_excep_or1(sel_excep[1], addi_x, sub_x, setx);
	or sel_excep_or2(sel_excep[2], mul_x, div_x, setx);
	
	assign is_setx = setx;
	assign is_div = div;
	
endmodule 