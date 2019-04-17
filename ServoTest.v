module ServoTest(s1,s2,s3,s4,rst,clk,servo1,servo2,servo3,servo4); 
	
	input rst,s1,s2,s3,s4;
	input clk;
	output reg servo1,servo2,servo3,servo4;
	reg [19:0] counter;
	
	initial begin
		servo1 <= 1'b1;
		servo2 <= 1'b1;
		servo3 <= 1'b1;
		servo4 <= 1'b1;
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
		end
		else begin
		
			//SERVO 1
			if(~s1) begin
				if(counter >= 70000) begin
					servo1 <= 1'b0;
				end
			end
			else if(s1) begin
				if(counter >= 5000) begin
					servo1 <= 1'b0;
				end
			end
			//SERVO 2
			if(~s2) begin
				if(counter >= 70000) begin
					servo2 <= 1'b0;
				end
			end
			else if(s2) begin
				if(counter >= 5000) begin
					servo2 <= 1'b0;
				end
			end
			//SERVO 3
			if(~s3) begin
				if(counter >= 70000) begin
					servo3 <= 1'b0;
				end
			end
			else if(s3) begin
				if(counter >= 5000) begin
					servo3 <= 1'b0;
				end
			end
			//SERVO 4
			if(~s4) begin
				if(counter >= 70000) begin
					servo4 <= 1'b0;
				end
			end
			else if(s4) begin
				if(counter >= 5000) begin
					servo4 <= 1'b0;
				end
			end                      
			counter <= counter + 20'd1;
		end
   end
	
endmodule      
	                                                    
