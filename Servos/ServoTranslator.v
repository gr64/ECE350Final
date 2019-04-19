module ServoTranslator(dmem_out,enable, clk,
								//output to ea ch servo
								servo_t,servo_l,servo_b,servo_r,servo1,servo2,servo3);
								
								//2 counters; one every second, one coutning number of moves in each sequence and resets and moves to next dmem instruction when reaches that mov's total count

	input enable;
	input [3:0] dmem_out;
	output sevocontrol_in;
	
	//Need to set s1... and f1...
	if(dmem_out <= 4'b0) begin
		//Retract Up and Down
		s3 <= 1'b0;
		s4 <= 1'b0;
		
	end
	
	ServoControl servocontrol0(s1,s2,s3,s4,
							f1,f2,f3,f4,
							rst,clk,
							servo1,servo2,servo3,servo4,
							servo_t,servo_l,servo_b,servo_r);

endmodule
