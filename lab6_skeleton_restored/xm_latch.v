module xm_latch(
	input clock, reset,
	input [31:0] prev_inst, //the instruction data to be parsed from imem
	input [31:0] pc_in,
	input [31:0] alu_output_in, data_readRegB, branch_alu_in,
	input alu_ine, alu_ilt,
	input excep_in,
	
	output [31:0] curr_inst,
	output [31:0] alu_output_out, dataB_out,
	output [4:0] opcode, rd, rs,
	output [4:0] rt_R, shamt_R, aluop_R,
	output [16:0] immed_I,
	output [26:0] target_JI,
	output [31:0] pc_out, branch_alu_out,
	output alu_ine_out, alu_ilt_out,
	output excep_out
);

	wire pc_en, inst_en, branch_en, data_en;

	//put all the stuff from imem into a register and assign the output of that register to all the outputs
	//then those outputs will hold until the next clock cycle when the input of imem changes
	
	assign pc_en = 1'b1;
	assign inst_en = 1'b1;
	assign branch_en = 1'b1;
	assign data_en = 1'b1;	//these are 1 until stalls are implemented
	
	dffe_ref alu_ine_dff(alu_ine_out, alu_ine, clock, 1'b1, reset);
	dffe_ref alu_ilt_dff(alu_ilt_out, alu_ilt, clock, 1'b1, reset);
	
	register pc_reg(pc_out, pc_in, clock, pc_en, reset);
	register branch_reg(branch_alu_out, branch_alu_in, clock, branch_en, reset);
	register inst_reg(curr_inst, prev_inst, clock, inst_en, reset);
	
	register aluout_reg(alu_output_out, alu_output_in, clock, data_en, reset);
	register dataB_reg(dataB_out, data_readRegB, clock, data_en, reset);
	dffe_ref excep_dff(excep_out, excep_in, clock, pc_en, reset);
	
	assign opcode = curr_inst[31:27];
	assign rd = curr_inst[26:22];
	assign rs = curr_inst[21:17];
	assign rt_R = curr_inst[16:12];
	assign shamt_R = curr_inst[11:7];
	assign aluop_R = curr_inst[6:2];
	assign immed_I = curr_inst[16:0];
	assign target_JI = curr_inst[26:0];
	
endmodule 