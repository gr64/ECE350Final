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
module backup(
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
	 select_pc, curr_pc1
	 
);

	 //extra outputs for testing
	 output [31:0] alu_inputA, alu_inputB, alu_output;
	 output[1:0] select_pc;
	 output[31:0] curr_pc1;
	 
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
	//wire select_pc;
	wire pc_en;
	wire pc_ine, pc_ilt, pc_ovf; //pretty sure these are useless
	//wire [31:0] curr_pc, curr_pc1, pc_jump, pc_branch, pc_rd, next_pc;
	wire [31:0] curr_pc, pc_jump, pc_branch, pc_rd, next_pc;
	wire flush_b, flush_j, flush_fd;
	
	//fd_latch wires
	
	wire[31:0] nop;
	
	wire [31:0] fd_pc_in;
	wire [31:0] fd_inst_in, fd_inst_out;
	wire [4:0] fd_opcode, fd_rd, fd_rs;
	wire [4:0] fd_rt_R, fd_shamt_R, fd_aluop_R;
	wire [16:0] fd_immed_I;
	wire [26:0] fd_target_JI;
	wire [31:0] fd_pc_out;
	
	//Decode wires
	
	wire d_reg_wren, d_dmem_wren, d_select_immed, d_select_writeval, d_select_readReg, d_j_or_jal;
	wire[1:0] d_select_pc;
	
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
	wire x_j_or_jal;
	wire eq_wx_bA, eq_mx_bA, sel_wx_bA, sel_mx_bA;
	wire eq_wx_bB, eq_mx_bB, sel_wx_bB, sel_mx_bB;
	wire [31:0] wx_bypassA_out, wx_bypassB_out, mx_bypassB_out;
	
	wire x_reg_wren, x_dmem_wren, x_select_immed, x_select_writeval, x_select_readReg; //control wires
	wire[1:0] x_select_pc; //control wires
	wire [31:0] ext_immed;
	//wire [31:0] alu_inputA, alu_inputB, alu_output; //comment this one for testing
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
	
	//Memory wires
	
	wire m_reg_wren, m_dmem_wren, m_select_immed, m_select_writeval, m_select_readReg;
	wire[1:0] m_select_pc;
	wire sel_wm_b, eq_wm_b;
	wire [31:0] pc_jump_m;
	
	//mw_latch wires
	
	wire [31:0] mw_inst;
	wire [31:0] mw_alu_out, mw_dataB_out;
	wire [31:0] mw_pc_in;
	wire [4:0] mw_opcode, mw_rd, mw_rs;
	wire [4:0] mw_rt_R, mw_shamt_R, mw_aluop_R;
	wire [16:0] mw_immed_I;
	wire [26:0] mw_target_JI;
	wire [31:0] mw_pc_out;
	
	//Writeback wires
	
	wire w_reg_wren, w_dmem_wren, w_select_immed, w_select_writeval, w_select_readReg;
	wire[1:0] w_select_pc;
	
	/********** 	      	**********/
	
	
	/**********		FETCH  	**********/

	assign pc_en = 1'b1; //always enable program counter writing for now; change this for stalls later
	
	mux_2 choose_select_pc(x_j_or_jal, m_select_pc, x_select_pc, select_pc); //I know this is a 32 bit mux but oh well
	//branches are computed in execute, written in memory stage; jumps are computed in decode? written in execute
	mux_2 choose_pc_jump(x_j_or_jal, pc_jump_m, pc_jump_x, pc_jump); //if j or jal, from x; if bex, from m
	mux_4 choose_PC(select_pc, curr_pc1, pc_jump, pc_rd, pc_branch, next_pc);
	
	register pc_reg(curr_pc, next_pc, clock, pc_en, reset); //curr_pc is output; next_pc is input
	alu pc_adder(curr_pc, 32'd1, 5'd0, 5'd0, curr_pc1, pc_ine, pc_ilt, pc_ovf); //adds 1 to current PC value
	
	assign address_imem = curr_pc[11:0];
	assign fd_pc_in = curr_pc1; //puts 1 added to pc into fd; see slides for this (slides add 4 though not 1)
	
	assign nop = 32'd0;
	
	and flush_b_and(flush_b, m_select_pc[0], m_select_pc[1]);
	assign flush_j = d_j_or_jal; //only flush fetch by itself if instruction is j or jal (NOT jr or bex)
	//^this would have to be x_j_or_jal because you don't want it to flush itself; it flushed fd when it gets to execute
	or flush_fd_or(flush_fd, flush_b, flush_j);
	mux_2 flush_fd_nop(flush_fd, q_imem, nop, fd_inst_in);
	
	fd_latch fd_latch(
		clock, flush_fd, // resets everything if flushing; might be more synchronous but idk?
		fd_inst_in, //the instruction data to be parsed from imem
		fd_pc_in,
		
		fd_inst_out,
		fd_opcode, fd_rd, fd_rs,
		fd_rt_R, fd_shamt_R, fd_aluop_R,
		fd_immed_I,
		fd_target_JI,
		fd_pc_out
	);
	 
	/**********		DECODE  	**********/
	
	d_control d_control(fd_opcode, fd_aluop_R, d_reg_wren, d_dmem_wren, d_select_immed, d_select_writeval, d_select_readReg, d_select_pc, d_j_or_jal);
	
	assign ctrl_readRegA = fd_rs;	
	mux_2 choose_readRegB(d_select_readReg, fd_rt_R, fd_rd, ctrl_readRegB); //d_select_readReg is 1 if inst is sw, bne, jr, blt
	
	//writeEnable and data_writeReg are both determined in later stages, depending on bypassing
	
	mux_2 flush_dx(flush_b, fd_inst_out, nop, dx_inst_in);
	
	assign dx_pc_in = fd_pc_out;
	dx_latch dx_latch(
		clock, flush_b, // resets everything if flushing; might be more synchronous but idk?
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
	
	x_control x_control(dx_opcode, dx_aluop_R, x_reg_wren, x_dmem_wren, x_select_immed, x_select_writeval, x_select_readReg, x_select_pc, x_j_or_jal);	
	
	assign pc_rd = dx_dataB_out; //for jr only
	assign pc_jump_x[26:0] = dx_target_JI;
	assign pc_jump_x[31:27] = 5'd0;
	
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
	
	reg_compare wx_bA_comp(mw_rd, dx_rs, eq_wx_bA);
	reg_compare mx_bA_comp(xm_rd, dx_rs, eq_mx_bA);
	
	and wx_bA_and(sel_wx_bA, w_reg_wren, eq_wx_bA); //only select to bypass if the previous instruction was actually writing to the register
	and mx_bA_and(sel_mx_bA, m_reg_wren, eq_mx_bA);
	
	mux_2 wx_bypass_A(sel_wx_bA, dx_dataA_out, data_writeReg, wx_bypassA_out);
	mux_2 mx_bypass_A(sel_mx_bA, wx_bypassA_out, xm_alu_out, alu_inputA); //mx after wx to choose most recent regval if 2 insts in a row use it
	
	//choosing alu_inputB
	
	reg_compare wx_bB_comp(mw_rd, dx_rt_R, eq_wx_bB);
	reg_compare mx_bB_comp(xm_rd, dx_rt_R, eq_mx_bB);
	
	and wx_bB_and(sel_wx_bB, w_reg_wren, eq_wx_bB); //only select to bypass if the previous instruction was actually writing to the register
	and mx_bB_and(sel_mx_bB, m_reg_wren, eq_mx_bB);
	
	mux_2 wx_bypass_B(sel_wx_bB, dx_dataB_out, data_writeReg, wx_bypassB_out);
	mux_2 mx_bypass_B(sel_mx_bB, wx_bypassB_out, xm_alu_out, mx_bypassB_out);
	mux_2 choose_immed(x_select_immed, dx_dataB_out, ext_immed, alu_inputB); 	//chooses register B value or immediate value
	
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
		alu_ine, alu_ilt,
		
		xm_inst,
		xm_alu_out, xm_dataB_out,
		xm_opcode, xm_rd, xm_rs,
		xm_rt_R, xm_shamt_R, xm_aluop_R,
		xm_immed_I,
		xm_target_JI,
		xm_pc_out,
		xm_b_alu_out,
		xm_alu_ine_out, xm_alu_ilt_out
	);
	
	/**********		MEMORY  	**********/
	
	m_control m_control(xm_opcode, xm_aluop_R, xm_alu_ine_out, xm_alu_ilt_out, m_reg_wren, m_dmem_wren, m_select_immed, m_select_writeval, m_select_readReg, m_select_pc);
	
	//choosing branches
	
	assign pc_jump_m[26:0] = xm_target_JI; // in case of bex
	assign pc_jump_m[31:27] = 5'd0;
	assign pc_branch = xm_b_alu_out; //should be PC+1+N
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
		
		mw_inst,
		mw_alu_out, mw_dataB_out,
		mw_opcode, mw_rd, mw_rs,
		mw_rt_R, mw_shamt_R, mw_aluop_R,
		mw_immed_I,
		mw_target_JI,
		mw_pc_out
	);
	
	/**********		WRITEBACK  	**********/
	
	w_control w_control(mw_opcode, mw_aluop_R, w_reg_wren, w_dmem_wren, w_select_immed, w_select_writeval, w_select_readReg, w_select_pc);
	
	mux_2 choose_writeval(w_select_writeval, mw_alu_out, q_dmem, data_writeReg);
	assign ctrl_writeReg = mw_rd; //or $r31 for jal, or $rstatus for exceptions and setx
	assign ctrl_writeEnable = w_reg_wren;
endmodule
