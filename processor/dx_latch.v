module dx_latch(
	input clock, reset,
	input [31:0] prev_inst, //the instruction data to be parsed from imem
	input [31:0] pc_in,
	input [31:0] data_readRegA, data_readRegB,
	
	output [31:0] curr_inst,
	output [31:0] dataA_out, dataB_out,
	output [4:0] opcode, rd, rs,
	output [4:0] rt_R, shamt_R, aluop_R,
	output [16:0] immed_I,
	output [26:0] target_JI,
	output [31:0] pc_out
);

	wire pc_en, inst_en, data_en, is_aluinst;

	//put all the stuff from imem into a register and assign the output of that register to all the outputs
	//then those outputs will hold until the next clock cycle when the input of imem changes
	
	assign pc_en = 1'b1;
	assign inst_en = 1'b1;
	assign data_en = 1'b1;	//these are 1 until stalls are implemented
	
	register pc_reg(pc_out, pc_in, clock, pc_en, reset);
	register inst_reg(curr_inst, prev_inst, clock, inst_en, reset);
	
	register dataA_reg(dataA_out, data_readRegA, clock, data_en, reset);
	register dataB_reg(dataB_out, data_readRegB, clock, data_en, reset);
	
	assign opcode = curr_inst[31:27];
	assign rd = curr_inst[26:22];
	assign rs = curr_inst[21:17];
	assign rt_R = curr_inst[16:12];
	assign shamt_R = curr_inst[11:7];
	assign immed_I = curr_inst[16:0];
	assign target_JI = curr_inst[26:0];
	
	//alu op is only nonzero for alu instructions with opcode of 00000
	
	nor nor_op(is_aluinst, opcode[0], opcode[1], opcode[2], opcode[3], opcode[4]); //checks for all zero
	and a0(aluop_R[0], is_aluinst, curr_inst[2]);
	and a1(aluop_R[1], is_aluinst, curr_inst[3]);
	and a2(aluop_R[2], is_aluinst, curr_inst[4]);
	and a3(aluop_R[3], is_aluinst, curr_inst[5]);
	and a4(aluop_R[4], is_aluinst, curr_inst[6]);

endmodule 