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
	
	reg [5:0] local_count_1,local_count_2;
	
	reg forward,back,ccw,resting;
	
	reg s1,f1,s2,f2,s3,f3,s4,f4;
	
	reg left_servo_forward,left_servo_rotate,right_servo_forward,right_servo_rotate,bottom_servo_forward,
			bottom_servo_rotate,top_servo_forward,top_servo_rotate;
	
	initial begin
		
		//initializing counts
		global_count <= 27'b0;
		global_count_max <= 27'd100000000;
		local_count_1 <= 6'b0;
		local_count_2 <= 6'b0;
		local_count_3 <= 6'b0;
		
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
		if(dmem_out <= 4'b0000) begin
			if((global_count >= global_count_max) & (local_count_1 == 0)) begin
				//Retract Up and Down
				top_servo_forward <= back;
				bottom_servo_forward <= back;
				
				global_count <= 0;
				local_count_1 <= 6'd1;
			end
				
			else if((global_count >= global_count_max) & (local_count_1 == 1)) begin
				//Rotate Left Servo 90 cc
				left_servo_rotate <= 1'b1;
				
				global_count <= 0;
				local_count_1 <= 6'd2;
					
			end
			
			else if((global_count >= global_count_max) & (local_count_1 == 2)) begin
				//Extend upper and lower servos
				top_servo_forward <= forward;
				bottom_servo_forward <= forward;
				
				global_count <= 0;
				local_count_1 <= 6'd3;
					
			end
			
			
			else if((global_count >= global_count_max) & (local_count_1 == 3)) begin
				//restore Left servo to resting position so first move it back
				left_servo_forward <= back;
				
				global_count <= 0;
				local_count_1 <= 6'd4;
					
			end
			
			else if((global_count >= global_count_max) & (local_count_1 == 4)) begin
				//restore Left servo to resting position so next rotate it back
				left_servo_rotate <= resting;
				
				global_count <= 0;
				local_count_1 <= 6'd5;
					
			end
			
			else if((global_count >= global_count_max) & (local_count_1 == 5)) begin
				//restore Left servo to resting position so next move it forward
				left_servo_forward <= forward;
				
				global_count <= 0;
				local_count_1 <= 6'd0;
					
			end
			
		end
		
		// MOVE: L'
		else if(dmem_out >= 4'b0001) begin
			if((global_count >= global_count_max) & (local_count_2 == 0)) begin
				//Retract Up and Down
				top_servo_forward <= back;
				bottom_servo_forward <= back;
				
				global_count <= 0;
				local_count_2 <= local_count_2 + 6'b1;
			end
			else if((global_count >= global_count_max) & (local_count_2 == 1)) begin
				//Rotate Left Servo 90 c --> 270 cc (1)
				left_servo_rotate <= ccw;	
				
				global_count <= 0;
				local_count_2 <= local_count_2 + 6'b1;	
			end
			else if((global_count >= global_count_max) & (local_count_2 == 2)) begin
				//Extend upper and lower servos
				top_servo_forward <= forward;
				bottom_servo_forward <= forward;
				
				global_count <= 0;
				local_count_2 <= local_count_2 + 6'b1;
			end
			else if((global_count >= global_count_max) & (local_count_2 == 3)) begin
				//restore Left servo to resting position so first move it back
				left_servo_forward <= back;
				
				global_count <= 0;
				local_count_2 <= local_count_2 + 6'b1;
			end
			else if((global_count >= global_count_max) & (local_count_2 == 4)) begin
				//restore Left servo to resting position so next rotate it back
				left_servo_rotate <= resting;
				
				global_count <= 0;
				local_count_2 <= local_count_2 + 6'b1;	
			end
			else if((global_count >= global_count_max) & (local_count_2 == 5)) begin
				//move left servo back in
				left_servo_forward <= forward;
				
				global_count <= 0;
				local_count_2 <= local_count_2 + 6'b1;
			end
			else if((global_count >= global_count_max) & (local_count_2 == 6)) begin
				//move left servo back in
				top_servo_forward <= back;
				bottom_servo_forward <= back;
				
				global_count <= 0;
				local_count_2 <= local_count_2 + 6'b1;
			end
			else if((global_count >= global_count_max) & (local_count_2 == 7)) begin
				//Rotate Left Servo 90 c --> 270 cc (2)
				left_servo_rotate <= ccw;	
				
				global_count <= 0;
				local_count_2 <= local_count_2 + 6'b1;	
			end
			else if((global_count >= global_count_max) & (local_count_2 == 8)) begin
				//restore Left servo to resting position so first move it back
				left_servo_forward <= back;
				
				global_count <= 0;
				local_count_2 <= local_count_2 + 6'b1;
			end
			else if((global_count >= global_count_max) & (local_count_2 == 9)) begin
				//restore Left servo to resting position so next rotate it back
				left_servo_rotate <= resting;
				
				global_count <= 0;
				local_count_2 <= local_count_2 + 6'b1;	
			end
			else if((global_count >= global_count_max) & (local_count_2 == 10)) begin
				//move left servo back in
				left_servo_forward <= forward;
				
				global_count <= 0;
				local_count_2 <= local_count_2 + 6'b1;
			end
			else if((global_count >= global_count_max) & (local_count_2 == 11)) begin
				//move left servo back in
				top_servo_forward <= back;
				bottom_servo_forward <= back;
				
				global_count <= 0;
				local_count_2 <= local_count_2 + 6'b1;
			end
			else if((global_count >= global_count_max) & (local_count_2 == 12)) begin
				//Rotate Left Servo 90 c --> 270 cc (4)
				left_servo_rotate <= ccw;	
				
				global_count <= 0;
				local_count_2 <= local_count_2 + 6'b1;
					
			end
			else if((global_count >= global_count_max) & (local_count_2 == 13)) begin
				//restore Left servo to resting position so first move it back
				left_servo_forward <= back;
				
				global_count <= 0;
				local_count_2 <= local_count_2 + 6'b1;
			end
			else if((global_count >= global_count_max) & (local_count_2 == 14)) begin
				//restore Left servo to resting position so next rotate it back
				left_servo_rotate <= resting;
				
				global_count <= 0;
				local_count_2 <= 13;	
			end
			else if((global_count >= global_count_max) & (local_count_2 == 15)) begin
				//restore Left servo to resting position so next move it back forward
				left_servo_forward <= forward;
				
				global_count <= 0;
				local_count_2 <= 0;	
			end
			
		end
		// MOVE: R
		else if(dmem_out >= 4'b0010) begin
			if((global_count >= global_count_max) & (local_count_3 == 0)) begin
				//retract up and down
				top_servo_forward <= back;
				bottom_servo_forward <= back;
				
				local_count_3 <= 6'd1;
				global_count <= 0;
			end
			else if((global_count >= global_count_max) & (local_count_3 == 1)) begin
				//rotate right counter clockwise
				right_servo_rotate = ccw;
				
				local_count_3 <= 6'd2;
				global_count <=0 ;
			end
			else if((global_count >= global_count_max) & (local_count_3 == 2)) begin
				//extend up and down
				top_servo_forward <= forward;
				bottom_servo_forward <= forward;
				
				local_count_3 <= 6'b3;
				global_count <= 0;
			end
			else if((global_count >= global_count_max) & (local_count_3 == 3)) begin
				//retract right servo
				right_servo_forward <= back;
				
				local_count_3 <= 6'b4;
				global_count <= 0;
			end
			else if((global_count >= global_count_max) & (local_count_3 == 4)) begin
				//turn right servo back
				right_servo_rotate <= resting;
				
				local_count_3 <= 6'b5;
				global_count <= 0;
			end
			else if((global_count >= global_count_max) & (local_count_3 == 5)) begin
				//go back to resting position by extending right servo back
				right_servo_forward <= forward;
				
				local_count_3 <= 6'b0;
				global_count <= 0;
			end
		end
		
		// Move R'
		else if(dmem_out >= 4'b0011) begin
			if((global_count >= global_count_max) & (local_count_4 == 0)) begin
				//Retract Up and Down
				top_servo_forward <= back;
				bottom_servo_forward <= back;
				
				global_count <= 0;
				local_count_4 <= 6'd1;
			end
			else if((global_count >= global_count_max) & (local_count_4 == 1)) begin
				//Rotate Right Servo 90 c --> 270 cc (1)
				right_servo_rotate <= ccw;	
				
				global_count <= 0;
				local_count_4 <= 6'd2;	
			end
			else if((global_count >= global_count_max) & (local_count_4 == 2)) begin
				//Extend upper and lower servos
				top_servo_forward <= forward;
				bottom_servo_forward <= forward;
				
				global_count <= 0;
				local_count_4 <= 6'd3;	
			end
			else if((global_count >= global_count_max) & (local_count_4 == 3)) begin
				//restore Right servo to resting position so first move it back
				right_servo_forward <= back;
				
				global_count <= 0;
				local_count_4 <= 6'd4;
			end
			else if((global_count >= global_count_max) & (local_count_4 == 4)) begin
				//restore right servo to resting position so next rotate it back
				left_servo_rotate <= resting;
				
				global_count <= 0;
				local_count_4 <= 6'd5;
			end
			else if((global_count >= global_count_max) & (local_count_4 == 5)) begin
				//move right servo back in
				right_servo_forward <= forward;
				
				global_count <= 0;
				local_count_4 <= 6'd6;	
			end
			else if((global_count >= global_count_max) & (local_count_4 == 6)) begin
				//move top and bottom servos out
				top_servo_forward <= back;
				bottom_servo_forward <= back;
				
				global_count <= 0;
				local_count_4 <= 6'd7;	
			end
			else if((global_count >= global_count_max) & (local_count_4 == 7)) begin
				//Rotate Right Servo 90 c --> 270 cc (2)
				right_servo_rotate <= ccw;	
				
				global_count <= 0;
				local_count_2 <= 6'd8;
					
			end
			else if((global_count >= global_count_max) & (local_count_4 == 8)) begin
				//Extend upper and lower servos to hold cube
				top_servo_forward <= forward;
				bottom_servo_forward <= forward;
				
				global_count <= 0;
				local_count_4 <= 6'd9;	
			end
			else if((global_count >= global_count_max) & (local_count_4 == 9)) begin
				//restore right servo to resting position so first move it back
				right_servo_forward <= back;
				
				global_count <= 0;
				local_count_4 <= 1'd10;
					
			end
			else if((global_count >= global_count_max) & (local_count_4 == 10)) begin
				//restore Right servo to resting position so next rotate it back
				right_servo_rotate <= resting;
				
				global_count <= 0;
				local_count_4 <= 6'd11;
					
			end
			else if((global_count >= global_count_max) & (local_count_4 == 11)) begin
				//move right servo back in
				right_servo_forward <= forward;
				
				global_count <= 0;
				local_count_4 <= 6'd12;		
			end
			else if((global_count >= global_count_max) & (local_count_4 == 12)) begin
				//move up and down out
				top_servo_forward <= back;
				bottom_servo_forward <= back;
				
				global_count <= 0;
				local_count_4 <= 6'd13;
			end
			else if((global_count >= global_count_max) & (local_count_4 == 13)) begin
				//Rotate right Servo 90 c --> 270 cc (3)
				right_servo_rotate <= ccw;	
				
				global_count <= 0;
				local_count_4 <= 6'd14;
			end
			else if((global_count >= global_count_max) & (local_count_4 == 14)) begin
				//Extend upper and lower servos
				top_servo_forward <= forward;
				bottom_servo_forward <= forward;
				
				global_count <= 0;
				local_count_4 <= 6'd15;	
			end
			else if((global_count >= global_count_max) & (local_count_4 == 15)) begin
				//restore right servo to resting position so first move it back
				right_servo_forward <= back;
				
				global_count <= 0;
				local_count_4 <= 6'd16;
			end
			else if((global_count >= global_count_max) & (local_count_4 == 16)) begin
				//restore right servo to resting position so next rotate it back
				right_servo_rotate <= resting;
				
				global_count <= 0;
				local_count_4 <= 6'd17;
			end
			else if((global_count >= global_count_max) & (local_count_4 == 17)) begin
				//restore Left servo to resting position so next move it back forward
				right_servo_forward <= forward;
				
				global_count <= 0;
				local_count_4 <= 0;
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
