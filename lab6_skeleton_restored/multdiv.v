module multdiv(//data_operandA, data_operandB, ctrl_MULT, ctrl_DIV, clock, data_result, data_exception, data_resultRDY);
    input [31:0] data_operandA, data_operandB,
    input ctrl_MULT, ctrl_DIV, clock,
    output [31:0] data_result, mult_out, div_out, m_reg_in, m_reg_out, m_shift_out, d_reg_in, d_reg_out, d_shift_out, d_reg_in_2, d_reg_out_2, d_shift_out_2,
    output data_exception, data_resultRDY// isMult, isDiv
	 );
	 
	 //wire [31:0] mult_out, div_out, m_reg_in, m_reg_out, m_shift_out, d_reg_in, d_reg_out, d_shift_out, d_reg_in_2, d_reg_out_2, d_shift_out_2;
	 wire mult_ovf, div_0, isMult, isDiv, cleardiv;
	
	 //assign reg_in[0] = ctrl_MULT;
	 mux_2_1 m_init(ctrl_MULT, 1'b0, ctrl_MULT, m_reg_in[0]);
	 mux_2_1 d_init(ctrl_DIV, 1'b0, ctrl_DIV, d_reg_in[0]);
	 
	 dffe_ref isM(isMult, ctrl_MULT, clock, ctrl_MULT, ctrl_DIV);
	 dffe_ref isD(isDiv, ctrl_DIV, clock, ctrl_DIV, ctrl_MULT);

	 //will be disabled when not doing a multiplication operation
	 register shift_reg_mult(m_reg_out, m_reg_in, clock, 1'b1, m_reg_out[5]);
	 
	 left_shift_1 lsm(m_reg_out, m_shift_out);
	 assign m_reg_in[31:1] = m_shift_out[31:1];
	 
	 //will be disabled when not doing a division operation
	 register shift_reg_div(d_reg_out, d_reg_in, clock, 1'b1, d_reg_out_2[1]);
	 register shift_reg_div_2(d_reg_out_2, d_reg_in_2, clock, 1'b1, d_reg_out_2[1]);
	 left_shift_1 lsd_1(d_reg_out, d_shift_out);
	 left_shift_1 lsd_2(d_reg_out_2, d_shift_out_2);
	 assign d_reg_in[31:1] = d_shift_out[31:1];
	 assign d_reg_in_2[31:1] = d_shift_out_2[31:1];
	 assign d_reg_in_2[0] = d_reg_out[31];
	 
	 mux_2_1 choose_RDY(isMult, d_reg_out_2[1], m_reg_out[4], data_resultRDY);
	 //assign data_resultRDY = reg_out[4];
	 //assign data_result = mult_out; //temporary, before divider is implemented
	 mux_2 choose_out(isMult, div_out, mult_out, data_result);
	 assign data_exception = mult_ovf; //also temporary
	 
	 wallace_mult_32s wm32(data_operandA, data_operandB, mult_out, mult_ovf);
	 divider div(data_operandA, data_operandB, ctrl_DIV, clock, div_out, div_0);

	 	 
endmodule
