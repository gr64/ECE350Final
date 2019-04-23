module ServoTranslator(dmem_out,enable, clk, rst,
								//output to each servo
									//Back and forth
									servo1,servo2,servo3,servo4,
									//90 degree rotation
									servo_t,servo_l,servo_b,servo_r,
									//Dmem address to index into
									dmem_address);
								
	//2 counters; one every second, 
	//one coutning number of moves in each sequence and resets and moves to next dmem instruction when reaches that mov's total count

	input enable,clk,rst;
	input [3:0] dmem_out;
	output servo1,servo2,servo3,servo4,servo_t,servo_l,servo_b,servo_r;
	//addresses start at 25
	output reg [31:0] dmem_address;
	
	reg [26:0] global_count;
	reg [26:0] global_count_max;
	
	reg [5:0] local_count_1,local_count_2,local_count_3,local_count_4,local_count_5,local_count_6,local_count_7,local_count_8,local_count_9,local_count_10,local_count_11,local_count_12;
	
	reg forward,back,ccw,resting;
	
	reg s1,f1,s2,f2,s3,f3,s4,f4;
	
	reg left_servo_forward,left_servo_rotate,right_servo_forward,right_servo_rotate,bottom_servo_forward,
			bottom_servo_rotate,top_servo_forward,top_servo_rotate;
	//loops
	reg finished_move_flag;
	
	initial begin
		//flag begins at 0
		finished_move_flag <= 1'b0;
		
		//dmem_addresses begin at 25
		dmem_address <= 32'd25;
		
		//initializing counts
		global_count <= 27'b0;
		global_count_max <= 27'd50000000;
		local_count_1 <= 6'b0;
		local_count_2 <= 6'b0;
		local_count_3 <= 6'b0;
		local_count_4 <= 6'b0;
		local_count_5 <= 6'b0;
		local_count_6 <= 6'b0;
		local_count_7 <= 6'b0;
		local_count_8 <= 6'b0;
		local_count_9 <= 6'b0;
		local_count_10 <= 6'b0;
		local_count_11 <= 6'b0;
		local_count_12 <= 6'b0;
		
		//assign values to each servo state
		//outer servo states
		forward <= 1'b1;
		back <= 1'b0;
		//inner servo states
		ccw <= 1'b1;
		resting <= 1'b0;
		
		//all servos begin out
		left_servo_forward <= 1'b1;
		right_servo_forward <= 1'b1;
		bottom_servo_forward <= 1'b1;
		top_servo_forward <= 1'b1;
		//all rotating servos begin in resting position
		left_servo_rotate <= 1'b0;
		right_servo_rotate <= 1'b0;
		bottom_servo_rotate <= 1'b0;
		top_servo_rotate <= 1'b0;
	
	end
	
	
	always @(posedge clk) begin
	
		//LEFT SERVO IS 1, RIGHT SERVO IS 2, TOP SERVO IS 3, BOTTOM SERVO IS 4 (regs?)
//		s1 <= left_servo_forward;
//		f1 <= left_servo_rotate;
//		s2 <= right_servo_forward;
//		f2 <= right_servo_rotate;
//		s3 <= top_servo_forward;
//	   f3 <= top_servo_rotate;
//		s4 <= bottom_servo_forward;
//		f4 <= bottom_servo_rotate;

		if(finished_move_flag == 1'b1) begin
			//reset all counters
			global_count <= 27'b0;
			local_count_1 <= 6'b0;
			local_count_2 <= 6'b0;
			local_count_3 <= 6'b0;
			local_count_4 <= 6'b0;
			local_count_5 <= 6'b0;
			local_count_6 <= 6'b0;
			local_count_7 <= 6'b0;
			local_count_8 <= 6'b0;
			local_count_9 <= 6'b0;
			local_count_10 <= 6'b0;
			local_count_11 <= 6'b0;
			local_count_12 <= 6'b0;
			//reset flag
			finished_move_flag <= 1'b0;
			//move to next dmem_address
			dmem_address = dmem_address + 32'b1;
			
		end
		
		//MOVE: DONE
		if(dmem_out == 4'b1111) begin
			top_servo_forward <= back;
			bottom_servo_forward <= back;
		end
	
		// MOVE: L
		if(dmem_out == 4'b0000) begin
			if((global_count == global_count_max) & (local_count_1 == 0)) begin
				//Retract Up and Down
				top_servo_forward <= back;
				bottom_servo_forward <= back;
				
				global_count <= 0;
				local_count_1 <= 6'd1;
			end			
			else if((global_count == global_count_max) & (local_count_1 == 1)) begin
				//Rotate Left Servo 90 cc
				left_servo_rotate <= ccw;
				
				global_count <= 0;
				local_count_1 <= 6'd2;
					
			end
			else if((global_count == global_count_max) & (local_count_1 == 2)) begin
				//Extend upper and lower servos
				top_servo_forward <= forward;
				bottom_servo_forward <= forward;
				
				global_count <= 0;
				local_count_1 <= 6'd3;
					
			end
			else if((global_count == global_count_max) & (local_count_1 == 3)) begin
				//restore Left servo to resting position so first move it back
				left_servo_forward <= back;
				
				global_count <= 0;
				local_count_1 <= 6'd4;
					
			end
			else if((global_count == global_count_max) & (local_count_1 == 4)) begin
				//restore Left servo to resting position so next rotate it back
				left_servo_rotate <= resting;
				
				global_count <= 0;
				local_count_1 <= 6'd5;
					
			end
			else if((global_count == global_count_max) & (local_count_1 == 5)) begin
				//restore Left servo to resting position so next move it forward
				left_servo_forward <= forward;
				
				global_count <= 0;
				local_count_1 <= 6'd6;
				finished_move_flag <= 1'b1;
					
			end
			
		end
		
		// MOVE: L'
		else if(dmem_out == 4'b0001) begin
			//ONE
				if((global_count == global_count_max) & (local_count_2 === 0)) begin
					//Retract Up and Down
					top_servo_forward <= back;
					bottom_servo_forward <= back;
					
					global_count <= 0;
					local_count_2 <= 6'd1;
				end			
				else if((global_count == global_count_max) & (local_count_2 === 1)) begin
					//Rotate Left Servo 90 cc
					left_servo_rotate <= ccw;
					
					global_count <= 0;
					local_count_2 <= 6'd2;
						
				end
				else if((global_count == global_count_max) & (local_count_2 == 2)) begin
					//Extend upper and lower servos
					top_servo_forward <= forward;
					bottom_servo_forward <= forward;
					
					global_count <= 0;
					local_count_2 <= 6'd3;
						
				end
				else if((global_count == global_count_max) & (local_count_2 == 3)) begin
					//restore Left servo to resting position so first move it back
					left_servo_forward <= back;
					
					global_count <= 0;
					local_count_2 <= 6'd4;
						
				end
				else if((global_count == global_count_max) & (local_count_2 == 4)) begin
					//restore Left servo to resting position so next rotate it back
					left_servo_rotate <= resting;
					
					global_count <= 0;
					local_count_2 <= 6'd5;
						
				end
				else if((global_count == global_count_max) & (local_count_2 == 5)) begin
					//restore Left servo to resting position so next move it forward
					left_servo_forward <= forward;
					
					global_count <= 0;
					local_count_2 <= 6'd6;
						
				end
				//TWO
				if((global_count == global_count_max) & (local_count_2 === 6)) begin
					//Retract Up and Down
					top_servo_forward <= back;
					bottom_servo_forward <= back;
					
					global_count <= 0;
					local_count_2 <= 6'd7;
				end			
				else if((global_count == global_count_max) & (local_count_2 === 7)) begin
					//Rotate Left Servo 90 cc
					left_servo_rotate <= ccw;
					
					global_count <= 0;
					local_count_2 <= 6'd8;
						
				end
				else if((global_count == global_count_max) & (local_count_2 == 8)) begin
					//Extend upper and lower servos
					top_servo_forward <= forward;
					bottom_servo_forward <= forward;
					
					global_count <= 0;
					local_count_2 <= 6'd9;
						
				end
				else if((global_count == global_count_max) & (local_count_2 == 9)) begin
					//restore Left servo to resting position so first move it back
					left_servo_forward <= back;
					
					global_count <= 0;
					local_count_2 <= 6'd10;
						
				end
				else if((global_count == global_count_max) & (local_count_2 == 10)) begin
					//restore Left servo to resting position so next rotate it back
					left_servo_rotate <= resting;
					
					global_count <= 0;
					local_count_2 <= 6'd11;
						
				end
				else if((global_count == global_count_max) & (local_count_2 == 11)) begin
					//restore Left servo to resting position so next move it forward
					left_servo_forward <= forward;
					
					global_count <= 0;
					local_count_2 <= 6'd12;
						
				end
				//THREE
				if((global_count == global_count_max) & (local_count_2 === 12)) begin
					//Retract Up and Down
					top_servo_forward <= back;
					bottom_servo_forward <= back;
					
					global_count <= 0;
					local_count_2 <= 6'd13;
				end			
				else if((global_count == global_count_max) & (local_count_2 === 13)) begin
					//Rotate Left Servo 90 cc
					left_servo_rotate <= ccw;
					
					global_count <= 0;
					local_count_2 <= 6'd14;
						
				end
				else if((global_count == global_count_max) & (local_count_2 == 14)) begin
					//Extend upper and lower servos
					top_servo_forward <= forward;
					bottom_servo_forward <= forward;
					
					global_count <= 0;
					local_count_2 <= 6'd15;
						
				end
				else if((global_count == global_count_max) & (local_count_2 == 15)) begin
					//restore Left servo to resting position so first move it back
					left_servo_forward <= back;
					
					global_count <= 0;
					local_count_2 <= 6'd16;
						
				end
				else if((global_count == global_count_max) & (local_count_2 == 16)) begin
					//restore Left servo to resting position so next rotate it back
					left_servo_rotate <= resting;
					
					global_count <= 0;
					local_count_2 <= 6'd17;
						
				end
				else if((global_count == global_count_max) & (local_count_2 == 17)) begin
					//restore Left servo to resting position so next move it forward
					left_servo_forward <= forward;
					
					global_count <= 0;
					local_count_2 <= 6'd18;
					finished_move_flag <= 1'b1;
						
				end
		end	
		
		// MOVE: R
		else if(dmem_out == 4'b0010) begin
			if((global_count == global_count_max) & (local_count_3 == 0)) begin
				//retract up and down
				top_servo_forward <= back;
				bottom_servo_forward <= back;
				
				local_count_3 <= 6'd1;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_3 == 1)) begin
				//rotate right counter clockwise
				right_servo_rotate <= ccw;
				
				local_count_3 <= 6'd2;
				global_count <=0 ;
			end
			else if((global_count == global_count_max) & (local_count_3 == 2)) begin
				//extend up and down
				top_servo_forward <= forward;
				bottom_servo_forward <= forward;
				
				local_count_3 <= 6'd3;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_3 == 3)) begin
				//retract right servo
				right_servo_forward <= back;
				
				local_count_3 <= 6'd4;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_3 == 4)) begin
				//turn right servo back
				right_servo_rotate <= resting;
				
				local_count_3 <= 6'd5;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_3 == 5)) begin
				//go back to resting position by extending right servo back
				right_servo_forward <= forward;
				
				local_count_3 <= 6'd6;
				global_count <= 0;
				finished_move_flag <= 1'b1;
			end
		end
		
		// MOVE: R'
		else if(dmem_out == 4'b0011) begin
			//ONE
				if((global_count == global_count_max) & (local_count_4 == 0)) begin
					//retract up and down
					top_servo_forward <= back;
					bottom_servo_forward <= back;
					
					local_count_4 <= 6'd1;
					global_count <= 0;
				end
				else if((global_count == global_count_max) & (local_count_4 == 1)) begin
					//rotate right counter clockwise
					right_servo_rotate <= ccw;
					
					local_count_4 <= 6'd2;
					global_count <=0 ;
				end
				else if((global_count == global_count_max) & (local_count_4 == 2)) begin
					//extend up and down
					top_servo_forward <= forward;
					bottom_servo_forward <= forward;
					
					local_count_4 <= 6'd3;
					global_count <= 0;
				end
				else if((global_count == global_count_max) & (local_count_4 == 3)) begin
					//retract right servo
					right_servo_forward <= back;
					
					local_count_4 <= 6'd4;
					global_count <= 0;
				end
				else if((global_count == global_count_max) & (local_count_4 == 4)) begin
					//turn right servo back
					right_servo_rotate <= resting;
					
					local_count_4 <= 6'd5;
					global_count <= 0;
				end
				else if((global_count == global_count_max) & (local_count_4 == 5)) begin
					//go back to resting position by extending right servo back
					right_servo_forward <= forward;
					
					local_count_4 <= 6'd6;
					global_count <= 0;
				end
				//TWO
				if((global_count == global_count_max) & (local_count_4 == 6)) begin
					//retract up and down
					top_servo_forward <= back;
					bottom_servo_forward <= back;
					
					local_count_4 <= 6'd7;
					global_count <= 0;
				end
				else if((global_count == global_count_max) & (local_count_4 == 7)) begin
					//rotate right counter clockwise
					right_servo_rotate <= ccw;
					
					local_count_4 <= 6'd8;
					global_count <=0 ;
				end
				else if((global_count == global_count_max) & (local_count_4 == 8)) begin
					//extend up and down
					top_servo_forward <= forward;
					bottom_servo_forward <= forward;
					
					local_count_4 <= 6'd9;
					global_count <= 0;
				end
				else if((global_count == global_count_max) & (local_count_4 == 9)) begin
					//retract right servo
					right_servo_forward <= back;
					
					local_count_4 <= 6'd10;
					global_count <= 0;
				end
				else if((global_count == global_count_max) & (local_count_4 == 10)) begin
					//turn right servo back
					right_servo_rotate <= resting;
					
					local_count_4 <= 6'd11;
					global_count <= 0;
				end
				else if((global_count == global_count_max) & (local_count_4 == 11)) begin
					//go back to resting position by extending right servo back
					right_servo_forward <= forward;
					
					local_count_4 <= 6'd12;
					global_count <= 0;
				end
				//THREE
				if((global_count == global_count_max) & (local_count_4 == 12)) begin
					//retract up and down
					top_servo_forward <= back;
					bottom_servo_forward <= back;
					
					local_count_4 <= 6'd13;
					global_count <= 0;
				end
				else if((global_count == global_count_max) & (local_count_4 == 13)) begin
					//rotate right counter clockwise
					right_servo_rotate <= ccw;
					
					local_count_4 <= 6'd14;
					global_count <=0 ;
				end
				else if((global_count == global_count_max) & (local_count_4 == 14)) begin
					//extend up and down
					top_servo_forward <= forward;
					bottom_servo_forward <= forward;
					
					local_count_4 <= 6'd15;
					global_count <= 0;
				end
				else if((global_count == global_count_max) & (local_count_4 == 15)) begin
					//retract right servo
					right_servo_forward <= back;
					
					local_count_4 <= 6'd16;
					global_count <= 0;
				end
				else if((global_count == global_count_max) & (local_count_4 == 16)) begin
					//turn right servo back
					right_servo_rotate <= resting;
					
					local_count_4 <= 6'd17;
					global_count <= 0;
				end
				else if((global_count == global_count_max) & (local_count_4 == 17)) begin
					//go back to resting position by extending right servo back
					right_servo_forward <= forward;
					
					local_count_4 <= 6'd18;
					global_count <= 0;
					finished_move_flag <= 1'b1;
				end
		end
		//MOVE: D
		else if(dmem_out == 4'b0100) begin
			if((global_count == global_count_max) & (local_count_5 == 0)) begin
				//retract left and right
				left_servo_forward <= back;
				right_servo_forward <= back;
				
				local_count_5 <= 6'd1;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_5 == 1)) begin
				//rotate down counter clockwise
				bottom_servo_rotate <= ccw;
				
				local_count_5 <= 6'd2;
				global_count <=0 ;
			end
			else if((global_count == global_count_max) & (local_count_5 == 2)) begin
				//extend left and right
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_5 <= 6'd3;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_5 == 3)) begin
				//retract bottom servo
				bottom_servo_forward <= back;
				
				local_count_5 <= 6'd4;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_5 == 4)) begin
				//turn bottom servo back
				bottom_servo_rotate <= resting;
				
				local_count_5 <= 6'd5;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_5 == 5)) begin
				//go back to resting position by extending bottom servo back
				bottom_servo_forward <= forward;
				
				local_count_5 <= 6'd6;
				global_count <= 0;
				finished_move_flag <= 1'b1;
			end
		end
		//MOVE: D'
		else if(dmem_out == 4'b0101) begin
			//ONE
				if((global_count == global_count_max) & (local_count_6 == 0)) begin
					//retract left and right
					left_servo_forward <= back;
					right_servo_forward <= back;
					
					local_count_6 <= 6'd1;
					global_count <= 0;
				end
				else if((global_count == global_count_max) & (local_count_6 == 1)) begin
					//rotate down counter clockwise
					bottom_servo_rotate <= ccw;
					
					local_count_6 <= 6'd2;
					global_count <=0 ;
				end
				else if((global_count == global_count_max) & (local_count_6 == 2)) begin
					//extend left and right
					left_servo_forward <= forward;
					right_servo_forward <= forward;
					
					local_count_6 <= 6'd3;
					global_count <= 0;
				end
				else if((global_count == global_count_max) & (local_count_6 == 3)) begin
					//retract bottom servo
					bottom_servo_forward <= back;
					
					local_count_6 <= 6'd4;
					global_count <= 0;
				end
				else if((global_count == global_count_max) & (local_count_6 == 4)) begin
					//turn bottom servo back
					bottom_servo_rotate <= resting;
					
					local_count_6 <= 6'd5;
					global_count <= 0;
				end
				else if((global_count == global_count_max) & (local_count_6 == 5)) begin
					//go back to resting position by extending bottom servo back
					bottom_servo_forward <= forward;
					
					local_count_6 <= 6'd6;
					global_count <= 0;
				end
			//TWO
				if((global_count == global_count_max) & (local_count_6 == 6)) begin
					//retract left and right
					left_servo_forward <= back;
					right_servo_forward <= back;
					
					local_count_6 <= 6'd7;
					global_count <= 0;
				end
				else if((global_count == global_count_max) & (local_count_6 == 7)) begin
					//rotate down counter clockwise
					bottom_servo_rotate <= ccw;
					
					local_count_6 <= 6'd8;
					global_count <=0 ;
				end
				else if((global_count == global_count_max) & (local_count_6 == 8)) begin
					//extend left and right
					left_servo_forward <= forward;
					right_servo_forward <= forward;
					
					local_count_6 <= 6'd9;
					global_count <= 0;
				end
				else if((global_count == global_count_max) & (local_count_6 == 9)) begin
					//retract bottom servo
					bottom_servo_forward <= back;
					
					local_count_6 <= 6'd10;
					global_count <= 0;
				end
				else if((global_count == global_count_max) & (local_count_6 == 10)) begin
					//turn bottom servo back
					bottom_servo_rotate <= resting;
					
					local_count_6 <= 6'd11;
					global_count <= 0;
				end
				else if((global_count == global_count_max) & (local_count_6 == 11)) begin
					//go back to resting position by extending bottom servo back
					bottom_servo_forward <= forward;
					
					local_count_6 <= 6'd12;
					global_count <= 0;
				end
				//THREE
				if((global_count == global_count_max) & (local_count_6 == 12)) begin
					//retract left and right
					left_servo_forward <= back;
					right_servo_forward <= back;
					
					local_count_6 <= 6'd13;
					global_count <= 0;
				end
				else if((global_count == global_count_max) & (local_count_6 == 13)) begin
					//rotate down counter clockwise
					bottom_servo_rotate <= ccw;
					
					local_count_6 <= 6'd14;
					global_count <=0 ;
				end
				else if((global_count == global_count_max) & (local_count_6 == 14)) begin
					//extend left and right
					left_servo_forward <= forward;
					right_servo_forward <= forward;
					
					local_count_6 <= 6'd15;
					global_count <= 0;
				end
				else if((global_count == global_count_max) & (local_count_6 == 15)) begin
					//retract bottom servo
					bottom_servo_forward <= back;
					
					local_count_6 <= 6'd16;
					global_count <= 0;
				end
				else if((global_count == global_count_max) & (local_count_6 == 16)) begin
					//turn bottom servo back
					bottom_servo_rotate <= resting;
					
					local_count_6 <= 6'd17;
					global_count <= 0;
				end
				else if((global_count == global_count_max) & (local_count_6 == 17)) begin
					//go back to resting position by extending bottom servo back
					bottom_servo_forward <= forward;
					
					local_count_6 <= 6'd18;
					global_count <= 0;
					finished_move_flag <= 1'b1;
				end
		end
		//MOVE: U
		else if(dmem_out == 4'b0110) begin
			if((global_count == global_count_max) & (local_count_7 == 0)) begin
				//retract left and right
				left_servo_forward <= back;
				right_servo_forward <= back;
				
				local_count_7 <= 6'd1;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_7 == 1)) begin
				//rotate up counter clockwise
				top_servo_rotate <= ccw;
				
				local_count_7 <= 6'd2;
				global_count <=0 ;
			end
			else if((global_count == global_count_max) & (local_count_7 == 2)) begin
				//extend left and right
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_7 <= 6'd3;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_7 == 3)) begin
				//retract top servo
				top_servo_forward <= back;
				
				local_count_7 <= 6'd4;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_7 == 4)) begin
				//turn top servo back
				top_servo_rotate <= resting;
				
				local_count_7 <= 6'd5;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_7 == 5)) begin
				//go back to resting position by extending top servo back
				top_servo_forward <= forward;
				
				local_count_7 <= 6'd6;
				global_count <= 0;
				finished_move_flag <= 1'b1;
			end
		end
		//MOVE: U'
		else if(dmem_out == 4'b0111) begin
			// ONE
			if((global_count == global_count_max) & (local_count_8 == 0)) begin
				//retract left and right
				left_servo_forward <= back;
				right_servo_forward <= back;
				
				local_count_8 <= 6'd1;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_8 == 1)) begin
				//rotate down counter clockwise
				top_servo_rotate <= ccw;
				
				local_count_8 <= 6'd2;
				global_count <=0 ;
			end
			else if((global_count == global_count_max) & (local_count_8 == 2)) begin
				//extend left and right
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_8 <= 6'd3;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_8 == 3)) begin
				//retract bottom servo
				top_servo_forward <= back;
				
				local_count_8 <= 6'd4;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_8 == 4)) begin
				//turn bottom servo back
				top_servo_rotate <= resting;
				
				local_count_8 <= 6'd5;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_8 == 5)) begin
				//go back to resting position by extending bottom servo back
				top_servo_forward <= forward;
				
				local_count_8 <= 6'd6;
				global_count <= 0;
			end
			// TWO
			if((global_count == global_count_max) & (local_count_8 == 6)) begin
				//retract left and right
				left_servo_forward <= back;
				right_servo_forward <= back;
				
				local_count_8 <= 6'd7;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_8 == 7)) begin
				//rotate down counter clockwise
				top_servo_rotate <= ccw;
				
				local_count_8 <= 6'd8;
				global_count <=0 ;
			end
			else if((global_count == global_count_max) & (local_count_8 == 8)) begin
				//extend left and right
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_8 <= 6'd9;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_8 == 9)) begin
				//retract bottom servo
				top_servo_forward <= back;
				
				local_count_8 <= 6'd10;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_8 == 10)) begin
				//turn bottom servo back
				top_servo_rotate <= resting;
				
				local_count_8 <= 6'd11;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_8 == 11)) begin
				//go back to resting position by extending bottom servo back
				top_servo_forward <= forward;
				
				local_count_8 <= 6'd12;
				global_count <= 0;
			end
			// THREE
			if((global_count == global_count_max) & (local_count_8 == 12)) begin
				//retract left and right
				left_servo_forward <= back;
				right_servo_forward <= back;
				
				local_count_8 <= 6'd13;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_8 == 13)) begin
				//rotate down counter clockwise
				top_servo_rotate <= ccw;
				
				local_count_8 <= 6'd14;
				global_count <=0 ;
			end
			else if((global_count == global_count_max) & (local_count_8 == 14)) begin
				//extend left and right
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_8 <= 6'd15;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_8 == 15)) begin
				//retract bottom servo
				top_servo_forward <= back;
				
				local_count_8 <= 6'd16;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_8 == 16)) begin
				//turn bottom servo back
				top_servo_rotate <= resting;
				
				local_count_8 <= 6'd17;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_8 == 17)) begin
				//go back to resting position by extending bottom servo back
				top_servo_forward <= forward;
				
				local_count_8 <= 6'd18;
				global_count <= 0;
				finished_move_flag <= 1'b1;
			end
		end
		
		
		//MOVE: F
		else if(dmem_out == 4'b1000) begin
			//rotate down clockwise
			if((global_count == global_count_max) & (local_count_9 == 0)) begin
				//retract left and right
				left_servo_forward <= back;
				right_servo_forward <= back;
				
				local_count_9 <= 6'd1;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 1)) begin
				//rotate down counter clockwise
				bottom_servo_rotate <= ccw;
				
				local_count_9 <= 6'd2;
				global_count <=0 ;
			end
			else if((global_count == global_count_max) & (local_count_9 == 2)) begin
				//extend left and right 
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_9 <= 6'd3;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 3)) begin
				//retract bottom servo
				bottom_servo_forward <= back;
				
				local_count_9 <= 6'd4;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 4)) begin
				//turn bottom servo back
				bottom_servo_rotate <= resting;
				
				local_count_9 <= 6'd5;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 5)) begin
				//go back to resting position by extending bottom servo back
				bottom_servo_forward <= forward;
				
				local_count_9 <= 6'd6;
				global_count <= 0;
			end
			//local_count_in1 <= 6'd0;
			else if((global_count == global_count_max) & (local_count_9 == 6)) begin
				//retract left and right
				left_servo_forward <= back;
				right_servo_forward <= back;
				
				local_count_9 <= 6'd7;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 7)) begin
				//rotate down counter clockwise
				bottom_servo_rotate <= ccw;
				
				local_count_9 <= 6'd8;
				global_count <=0 ;
			end
			else if((global_count == global_count_max) & (local_count_9 == 8)) begin
				//extend left and right 
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_9 <= 6'd9;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 9)) begin
				//retract bottom servo
				bottom_servo_forward <= back;
				
				local_count_9 <= 6'd10;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 10)) begin
				//turn bottom servo back
				bottom_servo_rotate <= resting;
				
				local_count_9 <= 6'd11;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 11)) begin
				//go back to resting position by extending bottom servo back
				bottom_servo_forward <= forward;
				
				local_count_9 <= 6'd12;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 12)) begin
				//retract left and right
				left_servo_forward <= back;
				right_servo_forward <= back;
				
				local_count_9 <= 6'd13;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 13)) begin
				//rotate down counter clockwise
				bottom_servo_rotate <= ccw;
				
				local_count_9 <= 6'd14;
				global_count <=0 ;
			end
			else if((global_count == global_count_max) & (local_count_9 == 14)) begin
				//extend left and right 
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_9 <= 6'd15;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 15)) begin
				//retract bottom servo
				bottom_servo_forward <= back;
				
				local_count_9 <= 6'd16;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 16)) begin
				//turn bottom servo back
				bottom_servo_rotate <= resting;
				
				local_count_9 <= 6'd17;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 17)) begin
				//go back to resting position by extending bottom servo back
				bottom_servo_forward <= forward;
				
				local_count_9 <= 6'd18;
				global_count <= 0;
			end
	///NEW
			else if((global_count == global_count_max) & (local_count_9 == 18)) begin
				//retract left and right to turn top servo counterclockwise
				left_servo_forward <= back;
				right_servo_forward <= back;
				
				local_count_9 <= 6'd19;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 19)) begin
				//turn top ccw
				top_servo_rotate <= ccw;
				
				local_count_9 <= 6'd20;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 20)) begin
				//bring left and right in
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_9 <= 6'd21;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 21)) begin
				//move top backward
				top_servo_forward <= back;
				
				local_count_9 <= 6'd22;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 22)) begin
				//turn top back
				top_servo_rotate <= resting;
				
				local_count_9 <= 6'd23;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 23)) begin
				//bring top back in
				top_servo_forward <= forward;
				
				local_count_9 <= 6'd24;
				global_count <= 0;
			end
			//END OF TOP ROTATION
			else if((global_count == global_count_max) & (local_count_9 == 24)) begin
				//extend left and right
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_9 <= 6'd25;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 25)) begin
				//retract top and bottom
				top_servo_forward <= back;
				bottom_servo_forward <= back;
				
				local_count_9 <= 6'd26;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 26)) begin
				//left cw
				left_servo_rotate <= ccw;
				
				local_count_9 <= 6'd27;
				global_count <= 0;
			end
			
			else if((global_count == global_count_max) & (local_count_9 == 27)) begin
				//extend top and bottom
				top_servo_forward <= forward;
				bottom_servo_forward <= forward;
				
				local_count_9 <= 6'd28;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 28)) begin
				//retract left and right
				left_servo_forward <= back;
				right_servo_forward <= back;
				
				local_count_9 <= 6'd29;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 29)) begin
				//left bring back to resting
				left_servo_rotate <= resting;
				
				local_count_9 <= 6'd30;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 30)) begin
				//down ccw
				bottom_servo_rotate <= ccw;
				
				local_count_9 <= 6'd31;
				global_count <= 0;
			end
			//UP CLOCKWISE
			else if((global_count == global_count_max) & (local_count_9 == 31)) begin
				//rotate up counter clockwise
				top_servo_rotate <= ccw;
				
				local_count_9 <= 6'd33;
				global_count <=0 ;
			end
			else if((global_count == global_count_max) & (local_count_9 == 33)) begin
				//extend left and right
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_9 <= 6'd34;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 34)) begin
				//retract top servo
				top_servo_forward <= back;
				
				local_count_9 <= 6'd35;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 35)) begin
				//turn top servo back
				top_servo_rotate <= resting;
				
				local_count_9 <= 6'd36;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 36)) begin
				//go back to resting position by extending top servo back
				top_servo_forward <= forward;
				
				local_count_9 <= 6'd37;
				global_count <= 0;
			end
			if((global_count == global_count_max) & (local_count_9 == 37)) begin
				//retract left and right
				left_servo_forward <= back;
				right_servo_forward <= back;
				
				local_count_9 <= 6'd38;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 38)) begin
				//rotate up counter clockwise
				top_servo_rotate <= ccw;
				
				local_count_9 <= 6'd39;
				global_count <=0 ;
			end
			else if((global_count == global_count_max) & (local_count_9 == 39)) begin
				//extend left and right
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_9 <= 6'd40;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 40)) begin
				//retract top servo
				top_servo_forward <= back;
				
				local_count_9 <= 6'd41;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 41)) begin
				//turn top servo back
				top_servo_rotate <= resting;
				
				local_count_9 <= 6'd42;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 42)) begin
				//go back to resting position by extending top servo back
				top_servo_forward <= forward;
				
				local_count_9 <= 6'd43;
				global_count <= 0;
			end
			if((global_count == global_count_max) & (local_count_9 == 43)) begin
				//retract left and right
				left_servo_forward <= back;
				right_servo_forward <= back;
				
				local_count_9 <= 6'd44;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 44)) begin
				//rotate up counter clockwise
				top_servo_rotate <= ccw;
				
				local_count_9 <= 6'd45;
				global_count <=0 ;
			end
			else if((global_count == global_count_max) & (local_count_9 == 45)) begin
				//extend left and right
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_9 <= 6'd46;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 46)) begin
				//retract top and bottom servo
				top_servo_forward <= back;
				bottom_servo_forward <= back;
				
				local_count_9 <= 6'd47;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 47)) begin
				//turn top and bottom servo back
				top_servo_rotate <= resting;
				bottom_servo_rotate <= resting;
				
				local_count_9 <= 6'd48;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 48)) begin
				//go back to resting position by extending top and bottom servo back
				top_servo_forward <= forward;
				bottom_servo_forward <= forward;
				
				local_count_9 <= 6'd49;
				global_count <= 0;
				finished_move_flag <= 1'b1;
			end
			
			
		end
		
		
		
		//MOVE: F'
		else if(dmem_out == 4'b1001) begin
			//rotate down clockwise
			if((global_count == global_count_max) & (local_count_10 == 0)) begin
				//retract left and right
				left_servo_forward <= back;
				right_servo_forward <= back;
				
				local_count_10 <= 6'd1;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_10 == 1)) begin
				//rotate down counter clockwise
				bottom_servo_rotate <= ccw;
				
				local_count_10 <= 6'd2;
				global_count <=0 ;
			end
			else if((global_count == global_count_max) & (local_count_10 == 2)) begin
				//extend left and right 
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_10 <= 6'd3;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_10 == 3)) begin
				//retract bottom servo
				bottom_servo_forward <= back;
				
				local_count_10 <= 6'd4;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_10 == 4)) begin
				//turn bottom servo back
				bottom_servo_rotate <= resting;
				
				local_count_10 <= 6'd5;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_10 == 5)) begin
				//go back to resting position by extending bottom servo back
				bottom_servo_forward <= forward;
				
				local_count_10 <= 6'd6;
				global_count <= 0;
			end
			//local_count_in1 <= 6'd0;
			else if((global_count == global_count_max) & (local_count_10 == 6)) begin
				//retract left and right
				left_servo_forward <= back;
				right_servo_forward <= back;
				
				local_count_10 <= 6'd7;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_10 == 7)) begin
				//rotate down counter clockwise
				bottom_servo_rotate <= ccw;
				
				local_count_10 <= 6'd8;
				global_count <=0 ;
			end
			else if((global_count == global_count_max) & (local_count_10 == 8)) begin
				//extend left and right 
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_10 <= 6'd9;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_10 == 9)) begin
				//retract bottom servo
				bottom_servo_forward <= back;
				
				local_count_10 <= 6'd10;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_10 == 10)) begin
				//turn bottom servo back
				bottom_servo_rotate <= resting;
				
				local_count_10 <= 6'd11;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_10 == 11)) begin
				//go back to resting position by extending bottom servo back
				bottom_servo_forward <= forward;
				
				local_count_10 <= 6'd12;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_10 == 12)) begin
				//retract left and right
				left_servo_forward <= back;
				right_servo_forward <= back;
				
				local_count_10 <= 6'd13;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_10 == 13)) begin
				//rotate down counter clockwise
				bottom_servo_rotate <= ccw;
				
				local_count_10 <= 6'd14;
				global_count <=0 ;
			end
			else if((global_count == global_count_max) & (local_count_10 == 14)) begin
				//extend left and right 
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_10 <= 6'd15;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_10 == 15)) begin
				//retract bottom servo
				bottom_servo_forward <= back;
				
				local_count_10 <= 6'd16;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_10 == 16)) begin
				//turn bottom servo back
				bottom_servo_rotate <= resting;
				
				local_count_10 <= 6'd17;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_10 == 17)) begin
				//go back to resting position by extending bottom servo back
				bottom_servo_forward <= forward;
				
				local_count_10 <= 6'd18;
				global_count <= 0;
			end
	///NEW
			else if((global_count == global_count_max) & (local_count_10 == 18)) begin
				//retract left and right to turn top servo counterclockwise
				left_servo_forward <= back;
				right_servo_forward <= back;
				
				local_count_10 <= 6'd19;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_10 == 19)) begin
				//turn top ccw
				top_servo_rotate <= ccw;
				
				local_count_10 <= 6'd20;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_10 == 20)) begin
				//bring left and right in
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_10 <= 6'd21;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_10 == 21)) begin
				//move top backward
				top_servo_forward <= back;
				
				local_count_10 <= 6'd22;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_10 == 22)) begin
				//turn top back
				top_servo_rotate <= resting;
				
				local_count_10 <= 6'd23;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_10 == 23)) begin
				//bring top back in
				top_servo_forward <= forward;
				
				local_count_10 <= 6'd24;
				global_count <= 0;
			end
			//END OF TOP ROTATION
			else if((global_count == global_count_max) & (local_count_10 == 24)) begin
				//extend left and right
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_10 <= 6'd25;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_10 == 25)) begin
				//retract top and bottom
				top_servo_forward <= back;
				bottom_servo_forward <= back;
				
				local_count_10 <= 6'd26;
				global_count <= 0;
			end
			//CHANGES HERE
			//LEFT CLOCKWISE
				//ONE
				if((global_count == global_count_max) & (local_count_10 === 26)) begin
					//Retract Up and Down
					top_servo_forward <= back;
					bottom_servo_forward <= back;
					
					global_count <= 0;
					local_count_10 <= 6'd27;
				end			
				else if((global_count == global_count_max) & (local_count_10 === 27)) begin
					//Rotate Left Servo 90 cc
					left_servo_rotate <= ccw;
					
					global_count <= 0;
					local_count_10 <= 6'd28;
						
				end
				else if((global_count == global_count_max) & (local_count_10 == 28)) begin
					//Extend upper and lower servos
					top_servo_forward <= forward;
					bottom_servo_forward <= forward;
					
					global_count <= 0;
					local_count_10 <= 6'd29;
						
				end
				else if((global_count == global_count_max) & (local_count_10 == 29)) begin
					//restore Left servo to resting position so first move it back
					left_servo_forward <= back;
					
					global_count <= 0;
					local_count_10 <= 6'd30;
						
				end
				else if((global_count == global_count_max) & (local_count_10 == 30)) begin
					//restore Left servo to resting position so next rotate it back
					left_servo_rotate <= resting;
					
					global_count <= 0;
					local_count_10 <= 6'd31;
						
				end
				else if((global_count == global_count_max) & (local_count_10 == 31)) begin
					//restore Left servo to resting position so next move it forward
					left_servo_forward <= forward;
					
					global_count <= 0;
					local_count_10 <= 6'd32;
						
				end
				//TWO
				if((global_count == global_count_max) & (local_count_10 === 32)) begin
					//Retract Up and Down
					top_servo_forward <= back;
					bottom_servo_forward <= back;
					
					global_count <= 0;
					local_count_10 <= 6'd33;
				end			
				else if((global_count == global_count_max) & (local_count_10 === 33)) begin
					//Rotate Left Servo 90 cc
					left_servo_rotate <= ccw;
					
					global_count <= 0;
					local_count_10 <= 6'd34;
						
				end
				else if((global_count == global_count_max) & (local_count_10 == 34)) begin
					//Extend upper and lower servos
					top_servo_forward <= forward;
					bottom_servo_forward <= forward;
					
					global_count <= 0;
					local_count_10 <= 6'd35;
						
				end
				else if((global_count == global_count_max) & (local_count_10 == 35)) begin
					//restore Left servo to resting position so first move it back
					left_servo_forward <= back;
					
					global_count <= 0;
					local_count_10 <= 6'd36;
						
				end
				else if((global_count == global_count_max) & (local_count_10 == 36)) begin
					//restore Left servo to resting position so next rotate it back
					left_servo_rotate <= resting;
					
					global_count <= 0;
					local_count_10 <= 6'd37;
						
				end
				else if((global_count == global_count_max) & (local_count_10 == 37)) begin
					//restore Left servo to resting position so next move it forward
					left_servo_forward <= forward;
					
					global_count <= 0;
					local_count_10 <= 6'd38;
						
				end
				//THREE
				if((global_count == global_count_max) & (local_count_10 === 38)) begin
					//Retract Up and Down
					top_servo_forward <= back;
					bottom_servo_forward <= back;
					
					global_count <= 0;
					local_count_10 <= 6'd39;
				end			
				else if((global_count == global_count_max) & (local_count_10 === 39)) begin
					//Rotate Left Servo 90 cc
					left_servo_rotate <= ccw;
					
					global_count <= 0;
					local_count_10 <= 6'd40;
						
				end
				else if((global_count == global_count_max) & (local_count_10 == 40)) begin
					//Extend upper and lower servos
					top_servo_forward <= forward;
					bottom_servo_forward <= forward;
					
					global_count <= 0;
					local_count_10 <= 6'd41;
						
				end
				else if((global_count == global_count_max) & (local_count_10 == 41)) begin
					//restore Left servo to resting position so first move it back
					left_servo_forward <= back;
					
					global_count <= 0;
					local_count_10 <= 6'd42;
						
				end
				else if((global_count == global_count_max) & (local_count_10 == 42)) begin
					//restore Left servo to resting position so next rotate it back
					left_servo_rotate <= resting;
					
					global_count <= 0;
					local_count_10 <= 6'd43;
						
				end
				else if((global_count == global_count_max) & (local_count_10 == 43)) begin
					//restore Left servo to resting position so next move it forward
					left_servo_forward <= forward;
					
					global_count <= 0;
					local_count_10 <= 6'd44;
						
				end
			else if((global_count == global_count_max) & (local_count_12 == 44)) begin
				//retract left and right
				left_servo_forward <= back;
				right_servo_forward <= back;
				
				local_count_12 <= 6'd45;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_10 == 45)) begin
				//down ccw
				bottom_servo_rotate <= ccw;
				
				local_count_10 <= 6'd46;
				global_count <= 0;
			end
			//UP CLOCKWISE
			else if((global_count == global_count_max) & (local_count_10 == 46)) begin
				//rotate up counter clockwise
				top_servo_rotate <= ccw;
				
				local_count_10 <= 6'd47;
				global_count <=0 ;
			end
			else if((global_count == global_count_max) & (local_count_10 == 47)) begin
				//extend left and right
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_10 <= 6'd48;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_10 == 48)) begin
				//retract top servo
				top_servo_forward <= back;
				
				local_count_10 <= 6'd49;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_10 == 49)) begin
				//turn top servo back
				top_servo_rotate <= resting;
				
				local_count_10 <= 6'd50;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_10 == 50)) begin
				//go back to resting position by extending top servo back
				top_servo_forward <= forward;
				
				local_count_10 <= 6'd51;
				global_count <= 0;
			end
			if((global_count == global_count_max) & (local_count_10 == 51)) begin
				//retract left and right
				left_servo_forward <= back;
				right_servo_forward <= back;
				
				local_count_10 <= 6'd52;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_10 == 52)) begin
				//rotate up counter clockwise
				top_servo_rotate <= ccw;
				
				local_count_10 <= 6'd53;
				global_count <=0 ;
			end
			else if((global_count == global_count_max) & (local_count_10 == 53)) begin
				//extend left and right
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_10 <= 6'd54;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_10 == 54)) begin
				//retract top servo
				top_servo_forward <= back;
				
				local_count_10 <= 6'd55;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_10 == 55)) begin
				//turn top servo back
				top_servo_rotate <= resting;
				
				local_count_10 <= 6'd56;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_10 == 56)) begin
				//go back to resting position by extending top servo back
				top_servo_forward <= forward;
				
				local_count_10 <= 6'd57;
				global_count <= 0;
			end
			if((global_count == global_count_max) & (local_count_10 == 57)) begin
				//retract left and right
				left_servo_forward <= back;
				right_servo_forward <= back;
				
				local_count_10 <= 6'd58;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_10 == 58)) begin
				//rotate up counter clockwise
				top_servo_rotate <= ccw;
				
				local_count_10 <= 6'd59;
				global_count <=0 ;
			end
			else if((global_count == global_count_max) & (local_count_10 == 59)) begin
				//extend left and right
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_10 <= 6'd60;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_10 == 60)) begin
				//retract top and bottom servo
				top_servo_forward <= back;
				bottom_servo_forward <= back;
				
				local_count_10 <= 6'd61;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_10 == 61)) begin
				//turn top and bottom servo back
				top_servo_rotate <= resting;
				bottom_servo_rotate <= resting;
				
				local_count_10 <= 6'd62;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_10 == 62)) begin
				//go back to resting position by extending top and bottom servo back
				top_servo_forward <= forward;
				bottom_servo_forward <= forward;
				
				local_count_10 <= 6'd63;
				global_count <= 0;
				finished_move_flag <= 1'b1;
			end
		end
			
			
			
		//MOVE: B 
		else if(dmem_out == 4'b1010) begin
			//rotate down clockwise
			if((global_count == global_count_max) & (local_count_11 == 0)) begin
				//retract left and right
				left_servo_forward <= back;
				right_servo_forward <= back;
				
				local_count_11 <= 6'd1;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_11 == 1)) begin
				//rotate down counter clockwise
				bottom_servo_rotate <= ccw;
				
				local_count_11 <= 6'd2;
				global_count <=0 ;
			end
			else if((global_count == global_count_max) & (local_count_11 == 2)) begin
				//extend left and right 
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_11 <= 6'd3;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_11 == 3)) begin
				//retract bottom servo
				bottom_servo_forward <= back;
				
				local_count_11 <= 6'd4;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_11 == 4)) begin
				//turn bottom servo back
				bottom_servo_rotate <= resting;
				
				local_count_11 <= 6'd5;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_11 == 5)) begin
				//go back to resting position by extending bottom servo back
				bottom_servo_forward <= forward;
				
				local_count_11 <= 6'd6;
				global_count <= 0;
			end
			//local_count_in1 <= 6'd0;
			else if((global_count == global_count_max) & (local_count_11 == 6)) begin
				//retract left and right
				left_servo_forward <= back;
				right_servo_forward <= back;
				
				local_count_11 <= 6'd7;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_11 == 7)) begin
				//rotate down counter clockwise
				bottom_servo_rotate <= ccw;
				
				local_count_11 <= 6'd8;
				global_count <=0 ;
			end
			else if((global_count == global_count_max) & (local_count_11 == 8)) begin
				//extend left and right 
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_11 <= 6'd9;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_11 == 9)) begin
				//retract bottom servo
				bottom_servo_forward <= back;
				
				local_count_11 <= 6'd10;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_11 == 10)) begin
				//turn bottom servo back
				bottom_servo_rotate <= resting;
				
				local_count_11 <= 6'd11;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_11 == 11)) begin
				//go back to resting position by extending bottom servo back
				bottom_servo_forward <= forward;
				
				local_count_11 <= 6'd12;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_11 == 12)) begin
				//retract left and right
				left_servo_forward <= back;
				right_servo_forward <= back;
				
				local_count_11 <= 6'd13;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_11 == 13)) begin
				//rotate down counter clockwise
				bottom_servo_rotate <= ccw;
				
				local_count_11 <= 6'd14;
				global_count <=0 ;
			end
			else if((global_count == global_count_max) & (local_count_11 == 14)) begin
				//extend left and right 
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_11 <= 6'd15;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_11 == 15)) begin
				//retract bottom servo
				bottom_servo_forward <= back;
				
				local_count_11 <= 6'd16;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_11 == 16)) begin
				//turn bottom servo back
				bottom_servo_rotate <= resting;
				
				local_count_11 <= 6'd17;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_11 == 17)) begin
				//go back to resting position by extending bottom servo back
				bottom_servo_forward <= forward;
				
				local_count_11 <= 6'd18;
				global_count <= 0;
			end
	///NEW
			else if((global_count == global_count_max) & (local_count_11 == 18)) begin
				//retract left and right to turn top servo counterclockwise
				left_servo_forward <= back;
				right_servo_forward <= back;
				
				local_count_11 <= 6'd19;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_11 == 19)) begin
				//turn top ccw
				top_servo_rotate <= ccw;
				
				local_count_11 <= 6'd20;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_11 == 20)) begin
				//bring left and right in
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_11 <= 6'd21;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_11 == 21)) begin
				//move top backward
				top_servo_forward <= back;
				
				local_count_11 <= 6'd22;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_11 == 22)) begin
				//turn top back
				top_servo_rotate <= resting;
				
				local_count_11 <= 6'd23;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_11 == 23)) begin
				//bring top back in
				top_servo_forward <= forward;
				
				local_count_11 <= 6'd24;
				global_count <= 0;
			end
			//END OF TOP ROTATION
			else if((global_count == global_count_max) & (local_count_11 == 24)) begin
				//extend left and right
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_11 <= 6'd25;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_11 == 25)) begin
				//retract top and bottom
				top_servo_forward <= back;
				bottom_servo_forward <= back;
				
				local_count_11 <= 6'd26;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_11 == 26)) begin
				//right ccw
				right_servo_rotate <= ccw;
				
				local_count_11 <= 6'd27;
				global_count <= 0;
			end
			
			else if((global_count == global_count_max) & (local_count_11 == 27)) begin
				//extend top and bottom
				top_servo_forward <= forward;
				bottom_servo_forward <= forward;
				
				local_count_11 <= 6'd28;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_11 == 28)) begin
				//retract left and right
				left_servo_forward <= back;
				right_servo_forward <= back;
				
				local_count_11 <= 6'd29;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_11 == 29)) begin
				//right bring back to resting
				right_servo_rotate <= resting;
				
				local_count_11 <= 6'd30;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_12 == 30)) begin
				//retract left and right
				left_servo_forward <= back;
				right_servo_forward <= back;
				
				local_count_12 <= 6'd31;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_11 == 31)) begin
				//down ccw
				bottom_servo_rotate <= ccw;
				
				local_count_11 <= 6'd32;
				global_count <= 0;
			end
			//UP CLOCKWISE
			else if((global_count == global_count_max) & (local_count_11 == 32)) begin
				//rotate up counter clockwise
				top_servo_rotate <= ccw;
				
				local_count_11 <= 6'd33;
				global_count <=0 ;
			end
			else if((global_count == global_count_max) & (local_count_11 == 33)) begin
				//extend left and right
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_11 <= 6'd34;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_11 == 34)) begin
				//retract top servo
				top_servo_forward <= back;
				
				local_count_11 <= 6'd35;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_11 == 35)) begin
				//turn top servo back
				top_servo_rotate <= resting;
				
				local_count_11 <= 6'd36;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_11 == 36)) begin
				//go back to resting position by extending top servo back
				top_servo_forward <= forward;
				
				local_count_11 <= 6'd37;
				global_count <= 0;
			end
			if((global_count == global_count_max) & (local_count_11 == 37)) begin
				//retract left and right
				left_servo_forward <= back;
				right_servo_forward <= back;
				
				local_count_11 <= 6'd38;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_11 == 38)) begin
				//rotate up counter clockwise
				top_servo_rotate <= ccw;
				
				local_count_11 <= 6'd39;
				global_count <=0 ;
			end
			else if((global_count == global_count_max) & (local_count_11 == 39)) begin
				//extend left and right
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_11 <= 6'd40;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_11 == 40)) begin
				//retract top servo
				top_servo_forward <= back;
				
				local_count_11 <= 6'd41;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_11 == 41)) begin
				//turn top servo back
				top_servo_rotate <= resting;
				
				local_count_11 <= 6'd42;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_11 == 42)) begin
				//go back to resting position by extending top servo back
				top_servo_forward <= forward;
				
				local_count_11 <= 6'd43;
				global_count <= 0;
			end
			if((global_count == global_count_max) & (local_count_11 == 43)) begin
				//retract left and right
				left_servo_forward <= back;
				right_servo_forward <= back;
				
				local_count_11 <= 6'd44;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_11 == 44)) begin
				//rotate up counter clockwise
				top_servo_rotate <= ccw;
				
				local_count_11 <= 6'd45;
				global_count <=0 ;
			end
			else if((global_count == global_count_max) & (local_count_11 == 45)) begin
				//extend left and right
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_11 <= 6'd46;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_11 == 46)) begin
				//retract top and bottom servo
				top_servo_forward <= back;
				bottom_servo_forward <= back;
				
				local_count_11 <= 6'd47;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_11 == 47)) begin
				//turn top and bottom servo back
				top_servo_rotate <= resting;
				bottom_servo_rotate <= resting;
				
				local_count_11 <= 6'd48;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_11 == 48)) begin
				//go back to resting position by extending top and bottom servo back
				top_servo_forward <= forward;
				bottom_servo_forward <= forward;
				
				local_count_11 <= 6'd49;
				global_count <= 0;
				finished_move_flag <= 1'b1;
			end
		end
			
			
		//MOVE: B'
		else if(dmem_out == 4'b1011) begin
			//rotate down clockwise
			if((global_count == global_count_max) & (local_count_12 == 0)) begin
				//retract left and right
				left_servo_forward <= back;
				right_servo_forward <= back;
				
				local_count_12 <= 6'd1;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_12 == 1)) begin
				//rotate down counter clockwise
				bottom_servo_rotate <= ccw;
				
				local_count_12 <= 6'd2;
				global_count <=0 ;
			end
			else if((global_count == global_count_max) & (local_count_12 == 2)) begin
				//extend left and right 
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_12 <= 6'd3;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_12 == 3)) begin
				//retract bottom servo
				bottom_servo_forward <= back;
				
				local_count_12 <= 6'd4;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_12 == 4)) begin
				//turn bottom servo back
				bottom_servo_rotate <= resting;
				
				local_count_12 <= 6'd5;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_12 == 5)) begin
				//go back to resting position by extending bottom servo back
				bottom_servo_forward <= forward;
				
				local_count_12 <= 6'd6;
				global_count <= 0;
			end
			//local_count_in1 <= 6'd0;
			else if((global_count == global_count_max) & (local_count_12 == 6)) begin
				//retract left and right
				left_servo_forward <= back;
				right_servo_forward <= back;
				
				local_count_12 <= 6'd7;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_12 == 7)) begin
				//rotate down counter clockwise
				bottom_servo_rotate <= ccw;
				
				local_count_12 <= 6'd8;
				global_count <=0 ;
			end
			else if((global_count == global_count_max) & (local_count_12 == 8)) begin
				//extend left and right 
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_12 <= 6'd9;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_12 == 9)) begin
				//retract bottom servo
				bottom_servo_forward <= back;
				
				local_count_12 <= 6'd10;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_12 == 10)) begin
				//turn bottom servo back
				bottom_servo_rotate <= resting;
				
				local_count_12 <= 6'd11;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_12 == 11)) begin
				//go back to resting position by extending bottom servo back
				bottom_servo_forward <= forward;
				
				local_count_12 <= 6'd12;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_12 == 12)) begin
				//retract left and right
				left_servo_forward <= back;
				right_servo_forward <= back;
				
				local_count_12 <= 6'd13;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_12 == 13)) begin
				//rotate down counter clockwise
				bottom_servo_rotate <= ccw;
				
				local_count_12 <= 6'd14;
				global_count <=0 ;
			end
			else if((global_count == global_count_max) & (local_count_12 == 14)) begin
				//extend left and right 
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_12 <= 6'd15;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_12 == 15)) begin
				//retract bottom servo
				bottom_servo_forward <= back;
				
				local_count_12 <= 6'd16;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_12 == 16)) begin
				//turn bottom servo back
				bottom_servo_rotate <= resting;
				
				local_count_12 <= 6'd17;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_12 == 17)) begin
				//go back to resting position by extending bottom servo back
				bottom_servo_forward <= forward;
				
				local_count_12 <= 6'd18;
				global_count <= 0;
			end
	///NEW
			else if((global_count == global_count_max) & (local_count_12 == 18)) begin
				//retract left and right to turn top servo counterclockwise
				left_servo_forward <= back;
				right_servo_forward <= back;
				
				local_count_12 <= 6'd19;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_12 == 19)) begin
				//turn top ccw
				top_servo_rotate <= ccw;
				
				local_count_12 <= 6'd20;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_12 == 20)) begin
				//bring left and right in
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_12 <= 6'd21;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_12 == 21)) begin
				//move top backward
				top_servo_forward <= back;
				
				local_count_12 <= 6'd22;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_12 == 22)) begin
				//turn top back
				top_servo_rotate <= resting;
				
				local_count_12 <= 6'd23;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_12 == 23)) begin
				//bring top back in
				top_servo_forward <= forward;
				
				local_count_12 <= 6'd24;
				global_count <= 0;
			end
			//END OF TOP ROTATION
			else if((global_count == global_count_max) & (local_count_12 == 24)) begin
				//extend left and right
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_12 <= 6'd25;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_12 == 25)) begin
				//retract top and bottom
				top_servo_forward <= back;
				bottom_servo_forward <= back;
				
				local_count_12 <= 6'd26;
				global_count <= 0;
			end
			//CHANGES HERE
			//RIGHT CLOCKWISE
				//ONE
				if((global_count == global_count_max) & (local_count_12 === 26)) begin
					//Retract Up and Down
					top_servo_forward <= back;
					bottom_servo_forward <= back;
					
					global_count <= 0;
					local_count_12 <= 6'd27;
				end			
				else if((global_count == global_count_max) & (local_count_12 === 27)) begin
					//Rotate Right Servo 90 cc
					right_servo_rotate <= ccw;
					
					global_count <= 0;
					local_count_12 <= 6'd28;
						
				end
				else if((global_count == global_count_max) & (local_count_12 == 28)) begin
					//Extend upper and lower servos
					top_servo_forward <= forward;
					bottom_servo_forward <= forward;
					
					global_count <= 0;
					local_count_12 <= 6'd29;
						
				end
				else if((global_count == global_count_max) & (local_count_12 == 29)) begin
					//restore Right servo to resting position so first move it back
					right_servo_forward <= back;
					
					global_count <= 0;
					local_count_12 <= 6'd30;
						
				end
				else if((global_count == global_count_max) & (local_count_12 == 30)) begin
					//restore Right servo to resting position so next rotate it back
					right_servo_rotate <= resting;
					
					global_count <= 0;
					local_count_12 <= 6'd31;
						
				end
				else if((global_count == global_count_max) & (local_count_12 == 31)) begin
					//restore Right servo to resting position so next move it forward
					right_servo_forward <= forward;
					
					global_count <= 0;
					local_count_12 <= 6'd32;
						
				end
				//TWO
				if((global_count == global_count_max) & (local_count_12 === 32)) begin
					//Retract Up and Down
					top_servo_forward <= back;
					bottom_servo_forward <= back;
					
					global_count <= 0;
					local_count_12 <= 6'd33;
				end			
				else if((global_count == global_count_max) & (local_count_12 === 33)) begin
					//Rotate Right Servo 90 cc
					right_servo_rotate <= ccw;
					
					global_count <= 0;
					local_count_12 <= 6'd34;
						
				end
				else if((global_count == global_count_max) & (local_count_12 == 34)) begin
					//Extend upper and lower servos
					top_servo_forward <= forward;
					bottom_servo_forward <= forward;
					
					global_count <= 0;
					local_count_12 <= 6'd35;
						
				end
				else if((global_count == global_count_max) & (local_count_12 == 35)) begin
					//restore Right servo to resting position so first move it back
					right_servo_forward <= back;
					
					global_count <= 0;
					local_count_12 <= 6'd36;
						
				end
				else if((global_count == global_count_max) & (local_count_12 == 36)) begin
					//restore Right servo to resting position so next rotate it back
					right_servo_rotate <= resting;
					
					global_count <= 0;
					local_count_12 <= 6'd37;
						
				end
				else if((global_count == global_count_max) & (local_count_12 == 37)) begin
					//restore Right servo to resting position so next move it forward
					right_servo_forward <= forward;
					
					global_count <= 0;
					local_count_12 <= 6'd38;
						
				end
				//THREE
				if((global_count == global_count_max) & (local_count_12 === 38)) begin
					//Retract Up and Down
					top_servo_forward <= back;
					bottom_servo_forward <= back;
					
					global_count <= 0;
					local_count_12 <= 6'd39;
				end			
				else if((global_count == global_count_max) & (local_count_12 === 39)) begin
					//Rotate Right Servo 90 cc
					right_servo_rotate <= ccw;
					
					global_count <= 0;
					local_count_12 <= 6'd40;
						
				end
				else if((global_count == global_count_max) & (local_count_12 == 40)) begin
					//Extend upper and lower servos
					top_servo_forward <= forward;
					bottom_servo_forward <= forward;
					
					global_count <= 0;
					local_count_12 <= 6'd41;
						
				end
				else if((global_count == global_count_max) & (local_count_12 == 41)) begin
					//restore Right servo to resting position so first move it back
					right_servo_forward <= back;
					
					global_count <= 0;
					local_count_12 <= 6'd42;
						
				end
				else if((global_count == global_count_max) & (local_count_12 == 42)) begin
					//restore Right servo to resting position so next rotate it back
					right_servo_rotate <= resting;
					
					global_count <= 0;
					local_count_12 <= 6'd43;
						
				end
				else if((global_count == global_count_max) & (local_count_12 == 43)) begin
					//restore Right servo to resting position so next move it forward
					right_servo_forward <= forward;
					
					global_count <= 0;
					local_count_12 <= 6'd44;
						
				end
			
			else if((global_count == global_count_max) & (local_count_12 == 44)) begin
				//retract left and right
				left_servo_forward <= back;
				right_servo_forward <= back;
				
				local_count_12 <= 6'd45;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_12 == 45)) begin
				//down ccw
				bottom_servo_rotate <= ccw;
				
				local_count_12 <= 6'd46;
				global_count <= 0;
			end
			//UP CLOCKWISE
			else if((global_count == global_count_max) & (local_count_12 == 46)) begin
				//rotate up counter clockwise
				top_servo_rotate <= ccw;
				
				local_count_12 <= 6'd47;
				global_count <=0 ;
			end
			else if((global_count == global_count_max) & (local_count_12 == 47)) begin
				//extend left and right
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_12 <= 6'd48;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_12 == 48)) begin
				//retract top servo
				top_servo_forward <= back;
				
				local_count_12 <= 6'd49;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_12 == 49)) begin
				//turn top servo back
				top_servo_rotate <= resting;
				
				local_count_12 <= 6'd50;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_12 == 50)) begin
				//go back to resting position by extending top servo back
				top_servo_forward <= forward;
				
				local_count_12 <= 6'd51;
				global_count <= 0;
			end
			if((global_count == global_count_max) & (local_count_12 == 51)) begin
				//retract left and right
				left_servo_forward <= back;
				right_servo_forward <= back;
				
				local_count_12 <= 6'd52;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_12 == 52)) begin
				//rotate up counter clockwise
				top_servo_rotate <= ccw;
				
				local_count_12 <= 6'd53;
				global_count <=0 ;
			end
			else if((global_count == global_count_max) & (local_count_12 == 53)) begin
				//extend left and right
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_12 <= 6'd54;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_12 == 54)) begin
				//retract top servo
				top_servo_forward <= back;
				
				local_count_12 <= 6'd55;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_12 == 55)) begin
				//turn top servo back
				top_servo_rotate <= resting;
				
				local_count_12 <= 6'd56;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_12 == 56)) begin
				//go back to resting position by extending top servo back
				top_servo_forward <= forward;
				
				local_count_12 <= 6'd57;
				global_count <= 0;
			end
			if((global_count == global_count_max) & (local_count_12 == 57)) begin
				//retract left and right
				left_servo_forward <= back;
				right_servo_forward <= back;
				
				local_count_12 <= 6'd58;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_12 == 58)) begin
				//rotate up counter clockwise
				top_servo_rotate <= ccw;
				
				local_count_12 <= 6'd59;
				global_count <=0 ;
			end
			else if((global_count == global_count_max) & (local_count_12 == 59)) begin
				//extend left and right
				left_servo_forward <= forward;
				right_servo_forward <= forward;
				
				local_count_12 <= 6'd60;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_12 == 60)) begin
				//retract top and bottom servo
				top_servo_forward <= back;
				bottom_servo_forward <= back;
				
				local_count_12 <= 6'd61;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_12 == 61)) begin
				//turn top and bottom servo back
				top_servo_rotate <= resting;
				bottom_servo_rotate <= resting;
				
				local_count_12 <= 6'd62;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_12 == 62)) begin
				//go back to resting position by extending top and bottom servo back
				top_servo_forward <= forward;
				bottom_servo_forward <= forward;
				
				local_count_12 <= 6'd63;
				global_count <= 0;
				finished_move_flag <= 1'b1;
			end
			
		end
		
		global_count <= global_count + 27'b1;
		
	end
	
	// Instantiating servo control module
		ServoControl myservocontrol(left_servo_forward,right_servo_forward,top_servo_forward,bottom_servo_forward,
								left_servo_rotate,right_servo_rotate,top_servo_rotate,bottom_servo_rotate,
								rst,clk,
								//Back and forth
								servo1,servo2,servo3,servo4,
								//90 degree rotation
								servo_t,servo_l,servo_b,servo_r);

endmodule
