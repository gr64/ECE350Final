module ServoTranslator(dmem_out,enable, clk,
								//output to each servo
									//Back and forth
									servo1,servo2,servo3,servo4,
									//90 degree rotation
									servo_t,servo_l,servo_b,servo_r);
								
//2 counters; one every second, one coutning number of moves in each sequence and resets and moves to next dmem instruction when reaches that mov's total count

	input enable;
	input [3:0] dmem_out;
	output sevocontrol_in;
	
	wire [25:0] global_count;
	wire [25:0] global_count_max;
	
	wire [5:0] local_count_1;
	
	initial begin
	
		global_count = 26'b0;
		global_count_max = 26'b50000000
		local_count_1 = 6'b0;
	
	end
	
	// MOVE: L
	if(dmem_out <= 4'b0) begin
		if((global_count >= global_count_max) & (local_count_1 >= 0)) begin
			//Retract Up and Down
			s3 <= 1'b0;
			s4 <= 1'b0;
			
			global_count <= 0;
			local_count_1 <= 1;
		end
			
		if((global_count >= global_count_max) & (local_count_1 >= 1)) begin
			//Rotate Left Servo 90 cc
			f2 <= 1'b1;
			
			global_count <= 0;
			local_count_1 <= 2;
				
		end
		
		if((global_count >= global_count_max) & (local_count_1 >= 2)) begin
			//Extend upper and lower servos
			s3 <= 1'b1;
			s4 <= 1'b1;
			
			global_count <= 0;
			local_count_1 <= 3;
				
		end
		
		
		if((global_count >= global_count_max) & (local_count_1 >= 3)) begin
			//restore Left servo to resting position so first move it back
			s2 <= 1'b0;
			
			global_count <= 0;
			local_count_1 <= 4;
				
		end
		
		if((global_count >= global_count_max) & (local_count_1 >= 4)) begin
			//restore Left servo to resting position so next rotate it back
			f2 <= 1'b0;
			
			global_count <= 0;
			local_count_1 <= 0;
				
		end
		
	end
	
	// MOVE: L'
	else if(dmem_out <= 4'b0001) begin
		if((global_count >= global_count_max) & (local_count_2 >= 0) begin
			//Retract Up and Down
			s3 <= 1'b0;
			s4 <= 1'b0;
			
			global_count <= 0;
			local_count_2 <= 1;
		end
			
		if((global_count >= global_count_max) & (local_count_2 >= 1)) begin
			//Rotate Left Servo 90 c --> 270 cc (1)
			f2 <= 1'b1;	
			
			global_count <= 0;
			local_count_2 <= 2;
				
		end
		
		if((global_count >= global_count_max) & (local_count_1 >= 2)) begin
			//Extend upper and lower servos
			s3 <= 1'b1;
			s4 <= 1'b1;
			
			global_count <= 0;
			local_count_1 <= 3;
				
		end
		
		
		if((global_count >= global_count_max) & (local_count_1 >= 3)) begin
			//restore Left servo to resting position so first move it back
			s2 <= 1'b0;
			
			global_count <= 0;
			local_count_1 <= 4;
				
		end
		
		if((global_count >= global_count_max) & (local_count_1 >= 4)) begin
			//restore Left servo to resting position so next rotate it back
			f2 <= 1'b0;
			
			global_count <= 0;
			local_count_1 <= 5;
				
		end
		
		if((global_count >= global_count_max) & (local_count_1 >= 5)) begin
			//move left servo back in
			s2 <= 1'b1;
			
			global_count <= 0;
			local_count_1 <= 6;
				
		end
		
		if((global_count >= global_count_max) & (local_count_2 >= 6)) begin
			//Rotate Left Servo 90 c --> 270 cc (2)
			f2 <= 1'b1;	
			
			global_count <= 0;
			local_count_2 <= 7;
				
		end
		
		
		if((global_count >= global_count_max) & (local_count_2 >= 7)) begin
			//restore Left servo to resting position so first move it back
			s2 <= 1'b0;
			
			global_count <= 0;
			local_count_2 <= 8;
				
		end
		
		if((global_count >= global_count_max) & (local_count_2 >= 8)) begin
			//restore Left servo to resting position so next rotate it back
			f2 <= 1'b0;
			
			global_count <= 0;
			local_count_2 <= 0;
				
		end
		
	end
	
	
	// Instantiating servo control module
	ServoControl servocontrol0(s1,s2,s3,s4,
							f1,f2,f3,f4,
							rst,clk,
							//Back and forth
							servo1,servo2,servo3,servo4,
							//90 degree rotation
							servo_t,servo_l,servo_b,servo_r);
							
	global_count <= global_count + 26'd1;

endmodule
