
module ServoControl(s1,s2,s3,s4,
							f1,f2,f3,f4,
							rst,clk,
							servo1,servo2,servo3,servo4,
							servo_t,servo_l,servo_b,servo_r); 


	input rst,f1,f2,f3,f4;
	
	input s1,s2,s3,s4;

	input clk;

	output reg servo1,servo2,servo3,servo4,servo_t,servo_l,servo_b,servo_r;

	reg [19:0] counter;

	

	initial begin

		servo1 <= 1'b1;

		servo2 <= 1'b1;

		servo3 <= 1'b1;

		servo4 <= 1'b1;
		
		servo_l <= 1'b1;
			
		servo_r <= 1'b1;
			
		servo_b <= 1'b1;
			
		servo_t <= 1'b1;

		counter <= 20'b0;

	end

	

	always @(posedge clk) begin

		if(rst) begin

			counter <= 0;

		end

		else if (counter >= 20'd1000000) begin

			counter <= 20'b0;

			servo1 <= 1'b1;

			servo2 <= 1'b1;

			servo3 <= 1'b1;

			servo4 <= 1'b1;
			
			servo_l <= 1'b1;
			
			servo_r <= 1'b1;
			
			servo_b <= 1'b1;
			
			servo_t <= 1'b1;

		end

		else begin

		
			//SERVO 1

			if(~s1) begin

				if(counter >= 50000) begin

					servo1 <= 1'b0;

				end

			end

//			else if(~s1[0] & s1[1]) begin
//
//				if(counter >= 70000) begin
//
//					servo1 <= 1'b0;
//
//				end
//
//			end
			
			else if(s1) begin

				if(counter >= 1000) begin

					servo1 <= 1'b0;

				end

			end

			//SERVO 2

			if(~s2) begin
				if(counter >= 50000) begin

					servo2 <= 1'b0;

				end

			end

			else if(s2) begin

				if(counter >= 1000) begin

					servo2 <= 1'b0;

				end

			end

			//SERVO 3

			if(~s3) begin

				if(counter >= 50000) begin

					servo3 <= 1'b0;

				end

			end

			else if(s3) begin

				if(counter >= 1000) begin

					servo3 <= 1'b0;

				end

			end

			//SERVO 4

			if(~s4) begin

				if(counter >= 50000) begin

					servo4 <= 1'b0;

				end

			end

			else if(s4) begin

				if(counter >= 1000) begin

					servo4 <= 1'b0;

				end

			end
			
			//SERVO 1F
			if(~f1) begin

				if(counter >= 19000) begin

					servo_t <= 1'b0;

				end

			end

			else if(f1) begin

				if(counter >= 65000) begin

					servo_t <= 1'b0;

				end

			end
			
			//SERVO 2F
			if(~f2) begin

				if(counter >= 19000) begin

					servo_l <= 1'b0;

				end

			end

			else if(f2) begin

				if(counter >= 65000) begin

					servo_l <= 1'b0;

				end

			end
			
			//SERVO 3F
			if(~f3) begin

				if(counter >= 19000) begin

					servo_b <= 1'b0;

				end

			end

			else if(f3) begin

				if(counter >= 65000) begin

					servo_b <= 1'b0;

				end

			end

		
			//SERVO 4F
			if(~f4) begin

				if(counter >= 19000) begin
				
					servo_r <= 1'b0;

				end

			end

			else if(f4) begin

				if(counter >= 65000) begin

					servo_r <= 1'b0;

				end

			end

		end
		
		counter <= counter + 1;

   end


endmodule      

	            