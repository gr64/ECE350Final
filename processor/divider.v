module divider(
	input[31:0] dividend, divisor,
	input ctrl_DIV, clock,
	output[31:0] quotient,// rem_reg_in, quo_reg_in, rem_reg_out, quo_reg_out, store_divisor, rem_div_out, quoplus_out,  quo_mux_out, rem_mux_out, quo_lshift, rem_lshift,
	output div_by_0);
	
	wire [31:0] store_divisor, quo_reg_in, quo_reg_out, rem_reg_in, rem_reg_out;
	wire[31:0]  quo_mux_out, rem_mux_out, quo_lshift, rem_lshift, rem_div_out, quoplus_out;
	wire clr, isNotEqual, isLessThan, overflow, iNE, iLT, add_ovf;
	
	assign clr = ctrl_DIV; //clears registers when new division operation starts
	//assign store_divisor = divisor;
	//not not_clock(n_clock, clock);
	
	mux_2 init_quo(ctrl_DIV, quo_lshift, dividend, quo_reg_in);
	register div_reg(store_divisor, divisor, clock, 1'b1, clr);	//hold the divisor in a register

	register rem_reg(rem_reg_out, rem_reg_in, clock, 1'b1, clr);
	register quo_reg(quo_reg_out, quo_reg_in, clock, 1'b1, 1'b0);
	
	alu subtractor(rem_reg_out, divisor, 4'b0001, 4'b000, rem_div_out, isNotEqual, isLessThan, overflow);
	alu adder(quo_reg_out, 32'd1, 4'b0000, 4'b0000, quoplus_out, iNE, iLT, add_ovf);

	//isLessThan is 1 when a is less th an b
	
	mux_2 choose_quo(isLessThan, quoplus_out, quo_reg_out, quo_mux_out);
	mux_2 choose_rem(isLessThan, rem_div_out, rem_reg_out, rem_mux_out);
	
	//left_shift_1 rem_ls(rem_mux_out, rem_lshift);
	//left_shift_1 quo_ls(quo_mux_out, quo_lshift);
	 assign rem_lshift = rem_mux_out << 1;
	 assign quo_lshift = quo_mux_out << 1;
	
	assign rem_reg_in[31:1] = rem_lshift[31:1];//left shifted rem reg out
	assign rem_reg_in[0] = quo_mux_out[31];//	
	
	assign quotient = quo_mux_out;

endmodule
