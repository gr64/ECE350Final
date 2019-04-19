module fd_latch(
	input clock, reset,
	input [31:0] q_imem, //the instruction data to be parsed from imem
	input [31:0] pc_in,
	input reg_en,
	
	output [31:0] inst_data, //data to be parsed
	output [4:0] opcode, rd, rs,
	output [4:0] rt_R, shamt_R, aluop_R,
	output [16:0] immed_I,
	output [26:0] target_JI,
	output [31:0] pc_out
);
	
	wire pc_en, inst_en;

	//put all the stuff from imem into a register and assign the output of that register to all the outputs
	//then those outputs will hold until the next clock cycle when the input of imem changes
	
	assign pc_en = reg_en;
	assign inst_en = reg_en;
	
	register pc_reg(pc_out, pc_in, clock, pc_en, reset);
	register inst_reg(inst_data, q_imem, clock, inst_en, reset);
	
	assign opcode = inst_data[31:27];
	assign rd = inst_data[26:22];
	assign rs = inst_data[21:17];
	assign rt_R = inst_data[16:12];
	assign shamt_R = inst_data[11:7];
	assign aluop_R = inst_data[6:2];
	assign immed_I = inst_data[16:0];
	assign target_JI = inst_data[26:0];
	
endmodule 