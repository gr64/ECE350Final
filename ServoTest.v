module ServoTest(left,right,rst,clk,servoin); 
	
	input rst,left,right;
	input clk;
	output reg servoin;
	reg [19:0] counter;
	
	initial begin
	servoin <= 1'b1;
	counter <= 20'b0;
	end
	
	always @(posedge clk) begin
		if(rst) begin
			counter <= 0;
		end
		else if (counter >= 20'd1000000) begin
			counter <= 20'b0;
			servoin <= 1'b1;
		end
		else if((right & left) | (!right & !left)) begin
			if(counter >= 70000) begin
				servoin <= 1'b0;
			end
		end                                
		else if(right) begin
			if(counter >= 112500) begin
				servoin <= 1'b0;
			end
		end
		else if(left) begin
			if(counter >= 37500) begin
				servoin <= 1'b0;
			end
		end
		counter <= counter + 20'd1;
   end
	
endmodule
	                                                    
