module ServoTranslator(dmem_out,enable, clk, rst,
								//output to each servo
									//Back and forth
									servo1,servo2,servo3,servo4,
									//90 degree rotation
									servo_t,servo_l,servo_b,servo_r,
									//Dmem address to index into
									address);
								
	//2 counters; one every second, 
	//one coutning number of moves in each sequence and resets and moves to next dmem instruction when reaches that mov's total count

	input enable,clk,rst;
	input [3:0] dmem_out;
	output servo1,servo2,servo3,servo4,servo_t,servo_l,servo_b,servo_r;
	//addresses start at 25
	output [31:0] address;
	
	reg [26:0] global_count;
	reg [26:0] global_count_max;
	
	reg [5:0] local_count_1,local_count_2,local_count_3,local_count_4,local_count_5,local_count_7,local_count_in1,local_count_9,local_count_in2;
	
	reg forward,back,ccw,resting;
	
	reg s1,f1,s2,f2,s3,f3,s4,f4;
	
	reg left_servo_forward,left_servo_rotate,right_servo_forward,right_servo_rotate,bottom_servo_forward,
			bottom_servo_rotate,top_servo_forward,top_servo_rotate;
	//loops
	reg [5:0] i;
	
	initial begin
		
		//initializing counts
		global_count <= 27'b0;
		global_count_max <= 27'd500000;
		local_count_1 <= 6'b0;
		local_count_2 <= 6'b0;
		local_count_3 <= 6'b0;
		local_count_4 <= 6'b0;
		local_count_5 <= 6'b0;
		local_count_7 <= 6'b0;
		local_count_9 <= 6'b0;
		local_count_in1 <= 6'b0;
		local_count_in2 <= 6'b0;
		
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
	
		// MOVE: L
		if(dmem_out == 4'b0000) begin
			if((global_count == global_count_max) & (local_count_1 === 0)) begin
				//Retract Up and Down
				top_servo_forward <= back;
				bottom_servo_forward <= back;
				
				global_count <= 0;
				local_count_1 <= 6'd1;
			end			
			else if((global_count == global_count_max) & (local_count_1 === 1)) begin
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
				local_count_1 <= 6'd0;
					
			end
			
		end
		
		// MOVE: L'
		else if(dmem_out == 4'b0001) begin
			for(i=0;i<3;i=i+1) begin
				if((global_count == global_count_max) & (local_count_1 === 0)) begin
					//Retract Up and Down
					top_servo_forward <= back;
					bottom_servo_forward <= back;
					
					global_count <= 0;
					local_count_1 <= 6'd1;
				end			
				else if((global_count == global_count_max) & (local_count_1 === 1)) begin
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
					local_count_1 <= 6'd0;
						
				end
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
				
				local_count_3 <= 6'd0;
				global_count <= 0;
			end
		end
		
		// MOVE: R'
		else if(dmem_out == 4'b0011) begin
			for(i=0;i<3;i=i+1) begin
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
					
					local_count_3 <= 6'd0;
					global_count <= 0;
				end
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
				
				local_count_5 <= 6'd0;
				global_count <= 0;
			end
		end
		//MOVE: D'
		else if(dmem_out == 4'b0101) begin
			for(i=0;i<3;i=i+1) begin
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
					
					local_count_5 <= 6'd0;
					global_count <= 0;
				end
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
				
				local_count_7 <= 6'd0;
				global_count <= 0;
			end
		end
		//MOVE: U'
		else if(dmem_out == 4'b0111) begin
			for(i=0;i<3;i=i+1) begin
				if((global_count == global_count_max) & (local_count_7 == 0)) begin
					//retract left and right
					left_servo_forward <= back;
					right_servo_forward <= back;
					
					local_count_7 <= 6'd1;
					global_count <= 0;
				end
				else if((global_count == global_count_max) & (local_count_7 == 1)) begin
					//rotate down counter clockwise
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
					//retract bottom servo
					top_servo_forward <= back;
					
					local_count_7 <= 6'd4;
					global_count <= 0;
				end
				else if((global_count == global_count_max) & (local_count_7 == 4)) begin
					//turn bottom servo back
					top_servo_rotate <= resting;
					
					local_count_7 <= 6'd5;
					global_count <= 0;
				end
				else if((global_count == global_count_max) & (local_count_7 == 5)) begin
					//go back to resting position by extending bottom servo back
					top_servo_forward <= forward;
					
					local_count_7 <= 6'd0;
					global_count <= 0;
				end
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
			if((global_count == global_count_max) & (local_count_9 == 31)) begin
				//retract left and right
				left_servo_forward <= back;
				right_servo_forward <= back;
				
				local_count_9 <= 6'd32;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 32)) begin
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
				//retract top servo
				top_servo_forward <= back;
				
				local_count_9 <= 6'd47;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 47)) begin
				//turn top servo back
				top_servo_rotate <= resting;
				
				local_count_9 <= 6'd48;
				global_count <= 0;
			end
			else if((global_count == global_count_max) & (local_count_9 == 48)) begin
				//go back to resting position by extending top servo back
				top_servo_forward <= forward;
				
				local_count_9 <= 6'd49;
				global_count <= 0;
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
