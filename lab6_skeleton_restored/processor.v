/**
 * READ THIS DESCRIPTION!
 *
 * The processor takes in several inputs from a skeleton file.
 *
 * Inputs
 * clock: this is the clock for your processor at 50 MHz
 * reset: we should be able to assert a reset to start your pc from 0 (sync or
 * async is fine)
 *
 * Imem: input data from imem
 * Dmem: input data from dmem
 * Regfile: input data from regfile
 *
 * Outputs
 * Imem: output control signals to interface with imem
 * Dmem: output control signals and data to interface with dmem
 * Regfile: output control signals and data to interface with regfile
 *
 * Notes
 *
 * Ultimately, your processor will be tested by subsituting a master skeleton, imem, dmem, so the
 * testbench can see which controls signal you active when. Therefore, there needs to be a way to
 * "inject" imem, dmem, and regfile interfaces from some external controller module. The skeleton
 * file acts as a small wrapper around your processor for this purpose.
 *
 * You will need to figure out how to instantiate two memory elements, called
 * "syncram," in Quartus: one for imem and one for dmem. Each should take in a
 * 12-bit address and allow for storing a 32-bit value at each address. Each
 * should have a single clock.
 *
 * Each memory element should have a corresponding .mif file that initializes
 * the memory element to certain value on start up. These should be named
 * imem.mif and dmem.mif respectively.
 *
 * Importantly, these .mif files should be placed at the top level, i.e. there
 * should be an imem.mif and a dmem.mif at the same level as process.v. You
 * should figure out how to point your generated imem.v and dmem.v files at
 * these MIF files.
 *
 * imem
 * Inputs:  12-bit address, 1-bit clock enable, and a clock
 * Outputs: 32-bit instruction
 *
 * dmem
 * Inputs:  12-bit address, 1-bit clock, 32-bit data, 1-bit write enable
 * Outputs: 32-bit data at the given address
 *
 */
module processor(
    // Control signals
    clock,                          // I: The master clock
    reset,                          // I: A reset signal

    // Imem
    address_imem,                   // O: The address of the data to get from imem
    q_imem,                         // I: The data from imem

    // Dmem
    address_dmem,                   // O: The address of the data to get or put from/to dmem
    data,                           // O: The data to write to dmem
    wren,                           // O: Write enable for dmem
    q_dmem,                         // I: The data from dmem

    // Regfile
    ctrl_writeEnable,               // O: Write enable for regfile
    ctrl_writeReg,                  // O: Register to write to in regfile
    ctrl_readRegA,                  // O: Register to read from port A of regfile
    ctrl_readRegB,                  // O: Register to read from port B of regfile
    data_writeReg,                  // O: Data to write to for regfile
    data_readRegA,                  // I: Data from port A of regfile
    data_readRegB,                   // I: Data from port B of regfile
	 
	 //extra outputs for testing
	 alu_inputA, alu_inputB, alu_output,
	 select_pc,
	 fd_inst_in, fd_inst_out,
	 assert_done
);

	 //extra outputs for testing
	 output [31:0] alu_inputA, alu_inputB, alu_output;
	 output[1:0] select_pc;
	 output [31:0] fd_inst_in, fd_inst_out;
	 output assert_done; //will be set when div reaches writeback, because we're not using div for anything else lol
	 
    // Control signals
    input clock, reset;

    // Imem
    output [11:0] address_imem;	// O: The address of the data to get from imem
    input [31:0] q_imem;			// I: The data from imem

    // Dmem
    output [11:0] address_dmem;	// O: The address of the data to get or put from/to dmem
    output [31:0] data;				// O: The data to write to dmem
    output wren;						// O: Write enable for dmem
    input [31:0] q_dmem;			// I: The data from dmem

    // Regfile
    output ctrl_writeEnable;		
    output [4:0] ctrl_writeReg, ctrl_readRegA, ctrl_readRegB;
    output [31:0] data_writeReg;
    input [31:0] data_readRegA, data_readRegB;

    /* YOUR CODE STARTS HERE */
	 //
	 //
	 //
	 //
	 //
	 
	 
	 
	 
	 
	/********** 	WIRES 	**********/
	
	
	//Fetch wires
	//wire select_pc;														//USED AS EXTRA OUTPUT!!!!!!!!!!!!!!!!!!!!
	wire pc_en, was_stall;
	wire pc_ine, pc_ilt, pc_ovf; //pretty sure these are useless
	wire [31:0] curr_pc, curr_pcn, curr_pc1, pc_jump, pc_branch, pc_rd, next_pc, fd_inst_in1;
	wire flush_b, flush_j, flush_fd, flush_b2, flush_j2, flush_fd2, flush_b_nx, flush_b2_nx;
	wire [31:0] q_imem_stall, q_imem_use;
	
	//fd_latch wires
	
	wire[31:0] nop;
	
	wire [31:0] fd_pc_in;
	//wire [31:0] fd_inst_in, fd_inst_out;													//USED AS EXTRA OUTPUT!!!!!!!!!!!!!!!!!!!!
	wire [4:0] fd_opcode, fd_rd, fd_rs;
	wire [4:0] fd_rt_R, fd_shamt_R, fd_aluop_R;
	wire [16:0] fd_immed_I;
	wire [26:0] fd_target_JI;
	wire [31:0] fd_pc_out;
	
	//Decode wires
	
	wire d_reg_wren, d_dmem_wren, d_select_immed, d_select_writeval, d_select_readReg, d_j_or_jal, d_bex;
	wire is_lw, is_sw, rs_haz, rt_haz, cond2, reg_match, stall, flush_dx;
	wire[1:0] d_select_pc;
	wire [4:0] ctrl_readRegB_bex;
	wire [31:0] pc_jump_d;

	
	//dx_latch wires
	
	wire [31:0] dx_inst_in, dx_inst_out;
	wire [31:0] dx_dataA_out, dx_dataB_out;
	wire [31:0] dx_pc_in;
	wire [4:0] dx_opcode, dx_rd, dx_rs;
	wire [4:0] dx_rt, dx_shamt_R, dx_aluop_R;
	wire [16:0] dx_immed_I;
	wire [26:0] dx_target_JI;
	wire [31:0] dx_pc_out;
	
	//Execute wires
	
	wire [4:0] dx_rt_R;
	wire x_j_or_jal, x_setx;
	wire eq_wx_bA0, eq_mx_bA0;
	wire eq_wx_bA, eq_mx_bA, sel_wx_bA, sel_mx_bA;
	wire eq_wx_bB, eq_mx_bB, sel_wx_bB, sel_mx_bB;
	wire [31:0] wx_bypassA_out, wx_bypassB_out, mx_bypassB_out;
	
	wire x_reg_wren, x_dmem_wren, x_select_immed, x_select_writeval, x_select_readReg, x_bex; //control wires
	wire[1:0] x_select_pc; //control wires
	wire [31:0] ext_immed, choose_setx_out;
	//wire [31:0] alu_inputA, alu_inputB, alu_output;										//USED AS EXTRA OUTPUT!!!!!!!!!!!!!!!!!!!!
	wire alu_ine, alu_ilt, alu_ovf;
	
	wire [31:0] branch_alu_output;
	wire b_alu_ine, b_alu_ilt, b_alu_ovf;
	
	wire [31:0] pc_jump_x;
	
	//xm_latch wires
	
	wire [31:0] xm_inst;
	wire [31:0] xm_alu_out, xm_dataB_out;
	wire [31:0] xm_pc_in, xm_b_alu_in;
	
	wire [4:0] xm_opcode, xm_rd, xm_rs;
	wire [4:0] xm_rt_R, xm_shamt_R, xm_aluop_R;
	wire [16:0] xm_immed_I;
	wire [26:0] xm_target_JI;
	wire [31:0] xm_pc_out, xm_b_alu_out;
	wire xm_alu_ine_out, xm_alu_ilt_out;
	wire xm_excep_out;
	
	//Memory wires
	
	wire m_reg_wren, m_dmem_wren, m_select_immed, m_select_writeval, m_select_readReg, m_bex;
	wire[1:0] m_select_pc;
	wire sel_wm_b, eq_wm_b;
	
	//mw_latch wires
	
	wire [31:0] mw_inst;
	wire [31:0] mw_alu_out, mw_dataB_out;
	wire [31:0] mw_pc_in;
	wire [4:0] mw_opcode, mw_rd, mw_rs;
	wire [4:0] mw_rt_R, mw_shamt_R, mw_aluop_R;
	wire [16:0] mw_immed_I;
	wire [26:0] mw_target_JI;
	wire [31:0] mw_pc_out, mw_jal_reg_out;
	
	//Writeback wires
	
	wire mw_excep_out, ex_or_setx, w_reg_wren, w_dmem_wren, w_select_immed, w_select_writeval, w_select_readReg, w_j_or_jal, w_setx;
	wire [2:0] w_sel_excep;
	wire [4:0] writeReg_ex_out;
	wire[31:0] data_writeReg_nj, data_writeReg_ex; // "not jump"
	wire[1:0] w_select_pc;
	
	/********** 	      	**********/
	
	
	/**********		FETCH  	**********/

	assign pc_en = ~stall; //always enable program counter writing for now; change this for stalls later
	
	mux_2 choose_select_pc(d_j_or_jal, x_select_pc, d_select_pc, select_pc); //I know this is a 32 bit mux but oh well
	//branches are computed in execute, written in memory stage; jumps are computed in decode? written in execute
	mux_2 choose_pc_stall(stall, curr_pc1, curr_pc, curr_pcn);
	mux_2 choose_pc_jump(d_j_or_jal, pc_jump_x, pc_jump_d, pc_jump); //if j or jal, from x; if bex, from m
	mux_4 choose_PC(select_pc, curr_pcn, pc_jump, pc_rd, pc_branch, next_pc);
	
	register pc_reg(curr_pc, next_pc, clock, pc_en, reset); //curr_pc is output; next_pc is input
	alu pc_adder(curr_pc, 32'd1, 5'd0, 5'd0, curr_pc1, pc_ine, pc_ilt, pc_ovf); //adds 1 to current PC value
	
	//if you're stalling, don't increment address imem
	assign address_imem = curr_pc[11:0];
	assign fd_pc_in = curr_pc1; //puts 1 added to pc into fd; see slides for this (slides add 4 though not 1)
	
	assign nop = 32'd0;
	
	dffe_ref was_stall_dff(was_stall, stall, clock, 1'b1, reset);
	register q_imem_reg(q_imem_stall, q_imem, clock, ~was_stall, reset);
	mux_2 choose_imem(was_stall, q_imem, q_imem_stall, q_imem_use);
	
	and flush_b_and(flush_b_nx, x_select_pc[0], x_select_pc[1]);
	and flush_b_and2(flush_b2_nx, m_select_pc[0], m_select_pc[1]);//nx is not bex; not the best abbreviation but oh well
	or flush_b_or(flush_b, flush_b_nx, x_bex);
	or flush_b_or2(flush_b2, flush_b2_nx, m_bex);
	
	assign flush_j = d_j_or_jal; //only flush fetch by itself if instruction is j or jal (NOT jr or bex)
	assign flush_j2 = x_j_or_jal; //only flush fetch by itself if instruction is j or jal (NOT jr or bex)
	//^this would have to be x_j_or_jal because you don't want it to flush itself; it flushed fd when it gets to execute
	or flush_fd_or(flush_fd, flush_b, flush_j);
	or flush_fd_or2(flush_fd2, flush_b2, flush_j2);
	mux_2 flush_fd_nop(flush_fd, q_imem_use, nop, fd_inst_in1);
	mux_2 flush_fd_nop2(flush_fd2, fd_inst_in1, nop, fd_inst_in);
	
	fd_latch fd_latch(
		clock, reset,
		fd_inst_in, //the instruction data to be parsed from imem
		fd_pc_in,
		~stall,
		
		fd_inst_out,
		fd_opcode, fd_rd, fd_rs,
		fd_rt_R, fd_shamt_R, fd_aluop_R,
		fd_immed_I,
		fd_target_JI,
		fd_pc_out
	);
	 
	/**********		DECODE  	**********/
	
	d_control d_control(fd_opcode, fd_aluop_R, d_reg_wren, d_dmem_wren, d_select_immed, d_select_writeval, d_select_readReg, d_select_pc, d_j_or_jal, d_bex);
	
	assign pc_rd = data_readRegB; //for jr only
	assign pc_jump_d[26:0] = fd_target_JI;
	assign pc_jump_d[31:27] = 5'd0;
	
	mux_2 choose_reagRegA(d_bex, fd_rs, 5'b0, ctrl_readRegA);
	//assign ctrl_readRegA = fd_rs;	
	mux_2 choose_readRegB_bex(d_bex, fd_rt_R, 5'd30, ctrl_readRegB_bex); //d_select_readReg is 1 if inst is sw, bne, jr, blt
	mux_2 choose_readRegB(d_select_readReg, ctrl_readRegB_bex, fd_rd, ctrl_readRegB);
	//writeEnable and data_writeReg are both determined in later stages, depending on bypassing
	
	reg_compare is_loadword(dx_opcode, 5'b01000, is_lw); //they're not registers but it compares two 5 bit numbers, checks if inst is lw
	reg_compare is_storeword(fd_opcode, 5'b00111, is_sw); //checks if inst is sw
	reg_compare lw_rs_haz(fd_rs, dx_rd, rs_haz);
	reg_compare lw_rt_haz(fd_rt_R, dx_rd, rt_haz);
	
	and rs_no_sw(cond2, rs_haz, ~is_sw);
	or haz(reg_match, cond2, rt_haz); //if either thing matches
	and should_stall(stall, is_lw, reg_match);
	
	//assign stall to register write enables for PC and fd latch and see how that goes
	
	or flush_dx_or(flush_dx, flush_b, stall);
	mux_2 flush_dx_nop(flush_dx, fd_inst_out, nop, dx_inst_in);
	
	assign dx_pc_in = fd_pc_out;
	dx_latch dx_latch(
		clock, reset,
		dx_inst_in, //the instruction data to be parsed from imem
		dx_pc_in,
		data_readRegA, data_readRegB,
		
		dx_inst_out,
		dx_dataA_out, dx_dataB_out,
		dx_opcode, dx_rd, dx_rs,
		dx_rt, dx_shamt_R, dx_aluop_R,
		dx_immed_I,
		dx_target_JI,
		dx_pc_out
	);
	
	/**********		EXECUTE  	**********/
	
	x_control x_control(dx_opcode, dx_aluop_R, alu_ine, alu_ilt, x_reg_wren, x_dmem_wren, x_select_immed, x_select_writeval, x_select_readReg, x_select_pc, x_j_or_jal, x_setx, x_bex);	
	
//	assign pc_rd = dx_dataB_out; //for jr only
//	assign pc_jump_x[26:0] = dx_target_JI;
//	assign pc_jump_x[31:27] = 5'd0;

	assign pc_jump_x[26:0] = dx_target_JI; // in case of bex
	assign pc_jump_x[31:27] = 5'd0;
	assign pc_branch = branch_alu_output;
	
	//sign extension
	assign ext_immed[16:0] = dx_immed_I;
	generate
		genvar i;
			for (i = 17; i < 32; i = i + 1) begin : sign_ext
				assign ext_immed[i] = dx_immed_I[16];
			end
	endgenerate
	
	mux_2 choose_rt(x_select_readReg, dx_rt, dx_rd, dx_rt_R); //if inst is sw, bne, jr, or blt, it now has bypassing? 
	
	//choosing alu_inputA
	
	reg_compare wx_bA_comp0(mw_rd, 5'd0, eq_wx_bA0);
	reg_compare mx_bA_comp0(xm_rd, 5'd0, eq_mx_bA0);
	
	reg_compare wx_bA_comp(mw_rd, dx_rs, eq_wx_bA);
	reg_compare mx_bA_comp(xm_rd, dx_rs, eq_mx_bA);
	
	and wx_bA_and(sel_wx_bA, w_reg_wren, eq_wx_bA, ~eq_wx_bA0); //only select to bypass if the previous instruction was actually writing to the register (and if it's not 0)
	and mx_bA_and(sel_mx_bA, m_reg_wren, eq_mx_bA, ~eq_mx_bA0);
	
	mux_2 wx_bypass_A(sel_wx_bA, dx_dataA_out, data_writeReg, wx_bypassA_out);
	mux_2 mx_bypass_A(sel_mx_bA, wx_bypassA_out, xm_alu_out, alu_inputA); //mx after wx to choose most recent regval if 2 insts in a row use it
	
	//choosing alu_inputB
	
	reg_compare wx_bB_comp(mw_rd, dx_rt_R, eq_wx_bB);
	reg_compare mx_bB_comp(xm_rd, dx_rt_R, eq_mx_bB);
	
	and wx_bB_and(sel_wx_bB, w_reg_wren, eq_wx_bB, ~eq_wx_bA0); //only select to bypass if the previous instruction was actually writing to the register
	and mx_bB_and(sel_mx_bB, m_reg_wren, eq_mx_bB, ~eq_mx_bA0); 
	
	mux_2 wx_bypass_B(sel_wx_bB, dx_dataB_out, data_writeReg, wx_bypassB_out);
	mux_2 mx_bypass_B(sel_mx_bB, wx_bypassB_out, xm_alu_out, mx_bypassB_out);
	mux_2 choose_setx(x_setx, mx_bypassB_out, dx_target_JI, choose_setx_out);
	mux_2 choose_immed(x_select_immed, choose_setx_out, ext_immed, alu_inputB); 	//chooses register B value or immediate value
	
	alu alu(alu_inputA, alu_inputB, dx_aluop_R, dx_shamt_R, alu_output, alu_ine, alu_ilt, alu_ovf);
	
	//computing branches
	
	alu branch_alu(ext_immed, xm_pc_out, 5'd0, 5'd0, branch_alu_output, b_alu_ine, b_alu_ilt, b_alu_ovf);
	
	assign xm_b_alu_in = branch_alu_output;
	assign xm_pc_in = dx_pc_out;
	xm_latch xm_latch(
		clock, reset,
		dx_inst_out, //the instruction data to be parsed from imem
		xm_pc_in,
		alu_output, mx_bypassB_out, xm_b_alu_in,
		alu_ine, alu_ilt, alu_ovf,
		
		xm_inst,
		xm_alu_out, xm_dataB_out,
		xm_opcode, xm_rd, xm_rs,
		xm_rt_R, xm_shamt_R, xm_aluop_R,
		xm_immed_I,
		xm_target_JI,
		xm_pc_out,
		xm_b_alu_out,
		xm_alu_ine_out, xm_alu_ilt_out,
		xm_excep_out
	);
	
	/**********		MEMORY  	**********/
	
	m_control m_control(xm_opcode, xm_aluop_R, xm_alu_ine_out, xm_alu_ilt_out, m_reg_wren, m_dmem_wren, m_select_immed, m_select_writeval, m_select_readReg, m_select_pc, m_bex);
	
	//choosing branches
	
//	assign pc_jump_m[26:0] = xm_target_JI; // in case of bex
//	assign pc_jump_m[31:27] = 5'd0;
//	assign pc_branch = xm_b_alu_out; //should be PC+1+N
	//assign pc_rd = xm_rd; // nooo no this has to be the CONTENTS of $rd fix this later
	
	assign address_dmem = xm_alu_out[11:0]; //result of adding $rs and N
	
	reg_compare wm_b_comp(xm_rd, mw_rd, eq_wm_b);
	and wm_b_and(sel_wm_b, eq_wm_b, m_dmem_wren);
	
	mux_2 wm_bypass(sel_wm_b, xm_dataB_out, data_writeReg, data);
   //assign data = xm_dataB_out; //data inside $rd
	assign wren = m_dmem_wren;
	
	assign mw_pc_in = xm_pc_out;
	mw_latch mw_latch(
		clock, reset,
		xm_inst, //the instruction data to be parsed from imem
		mw_pc_in,
		xm_alu_out, xm_dataB_out,
		xm_excep_out,
		
		mw_inst,
		mw_alu_out, mw_dataB_out,
		mw_opcode, mw_rd, mw_rs,
		mw_rt_R, mw_shamt_R, mw_aluop_R,
		mw_immed_I,
		mw_target_JI,
		mw_pc_out, mw_jal_reg_out,
		mw_excep_out
	);
	
	/**********		WRITEBACK  	**********/
	
	w_control w_control(mw_opcode, mw_aluop_R, mw_excep_out, w_reg_wren, w_dmem_wren, w_select_immed, w_select_writeval, w_select_readReg, w_select_pc, w_j_or_jal, w_sel_excep, w_setx, w_div);
	
	mux_2 choose_writeval(w_select_writeval, mw_alu_out, q_dmem, data_writeReg_nj);
	mux_8 choose_writeval_ex(w_sel_excep, data_writeReg_nj, 32'd1, 32'd2, 32'd3, 32'd4, 32'd5, mw_target_JI, 32'd0, data_writeReg_ex); //the 0 should never be chosen
	mux_2 choose_writeval_j(w_j_or_jal, data_writeReg_ex, mw_jal_reg_out, data_writeReg);
	
	or excep_setx_or(ex_or_setx, mw_excep_out, w_setx);
	mux_2 choose_writeReg_ex(ex_or_setx, mw_rd, 5'd30, writeReg_ex_out); //if there's an exception or inst is setxwrite to $r30 aka $rstatus
	mux_2 choose_writeReg(w_j_or_jal, writeReg_ex_out, 5'd31, ctrl_writeReg);
	//assign ctrl_writeReg = mw_rd; //or $r31 for jal, or $rstatus for exceptions and setx
	assign ctrl_writeEnable = w_reg_wren;
	
	//this is for project
	//assign assert_done = w_div; //using div as signal that cube calculation is done
	dffe_ref done(assert_done, w_div, ~clock, w_div, 1'b0);
	
endmodule
