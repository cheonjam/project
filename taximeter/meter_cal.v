module meter_cal(clk, reset, normal, premium, meter, one_meter, ten_meter, baek_meter);
	input clk, reset, normal, premium;
	output reg meter;
	output reg [3:0] one_meter, ten_meter, baek_meter;
	
	reg clk_out;
	reg [7:0] count;
	reg [1:0] status;
	
	
	always @(posedge clk)begin
		count <= count + 1;
		if(count==5)begin
			clk_out <= 1;
		end
		if(count==10)begin
			clk_out <= 0;
			count <= 0;
		end
	end
	
	always @(posedge clk) begin
		if(reset==1)
			status <= 2'b00;
		else if(normal==1)
			status <= 2'b01;
		else if(premium==1)
			status <= 2'b10;
	end
	
	always @(posedge clk_out) begin
		case(status)
			2'b00 : begin
			//	if(meter==1) begin
			//		meter<=0;
			//	end
				meter<=1;
				one_meter<=0;
				ten_meter<=0;
				baek_meter<=0;
				
			end
			
			2'b01 : begin
				if(meter==1) begin
					meter<=0;
				end
				one_meter<=one_meter-1;
				if(one_meter==0) begin
					one_meter <= 9;
					ten_meter <= ten_meter-1;
					if(ten_meter == 0) begin
						ten_meter <= 9;
						baek_meter <= baek_meter-1;
						if(baek_meter==0 && ten_meter==0 && one_meter==0) begin
							meter <= 1;
							one_meter <= 0;
							ten_meter <= 4;
							baek_meter <= 1;
						end
					end
				end
			end
				
			2'b10 : begin
				if(meter==1) begin
					meter<=0;
				end
				
				one_meter<=one_meter-1;
				if(one_meter==0) begin
					one_meter <= 9;
					ten_meter <= ten_meter-1;
					if(ten_meter == 0) begin
						ten_meter <= 9;
						baek_meter <= baek_meter-1;
						if(baek_meter==0 && ten_meter==0 && one_meter==0) begin
							meter <= 1;
							one_meter <= 0;
							ten_meter <= 2;
							baek_meter <= 1;
						end
					end
				end
			end
		endcase
	end
	
endmodule
