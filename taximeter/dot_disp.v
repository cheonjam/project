module dot_disp(clk, reset, dot_data0, dot_data1, dot_data2, dot_data3, 
				dot_data4, dot_data5, dot_data6, dot_data7, dot_data8,
				dot_data9, dot_d, dot_scan);

	input clk, reset;
	input [13:0] dot_data0, dot_data1, dot_data2, dot_data3,dot_data4;
	input [13:0]dot_data5, dot_data6, dot_data7, dot_data8,	dot_data9;
	
	output reg [13:0] dot_d;
	output reg [9:0] dot_scan;
	
	reg [4:0] cnt_clk;
	
	always @(posedge reset or posedge clk) begin
		if(reset == 1) begin
			cnt_clk <= 0;
		end
		else begin
			if(cnt_clk == 9) begin
				cnt_clk<=0;
			end
			else begin
				cnt_clk<=cnt_clk +1;
			end
		end
	end
	
	always @(reset, cnt_clk) begin
		if(reset ==1) begin
			dot_d <= 14'b1110000_0000111;
			dot_scan <= 10'b11110_11111;
		end
		else begin
			case(cnt_clk)
				4'b0000 : begin
							dot_d <= dot_data0;
							dot_scan <= 10'b11111_11110;
					end
				4'b0001 : begin
							dot_d <= dot_data1;
							dot_scan <= 10'b11111_11101;
					end
				4'b0010 : begin
							dot_d <= dot_data2;
							dot_scan <= 10'b11111_11011;
					end	
				4'b0011 : begin
							dot_d <= dot_data3;
							dot_scan <= 10'b11111_10111;
					end
				4'b0100 : begin
							dot_d <= dot_data4;
							dot_scan <= 10'b11111_01111;
					end
				4'b0101 : begin
							dot_d <= dot_data5;
							dot_scan <= 10'b11110_11111;
					end
				4'b0110 : begin
							dot_d <= dot_data6;
							dot_scan <= 10'b11101_11111;
					end
				4'b0111 : begin
							dot_d <= dot_data7;
							dot_scan <= 10'b11011_11111;
					end
				4'b1000 : begin
							dot_d <= dot_data8;
							dot_scan <= 10'b10111_11111;
					end
				4'b1001 : begin
							dot_d <= dot_data9;
							dot_scan <= 10'b01111_11111;
					end
				default : begin
							dot_d <= 14'b0000000_0000000;
							dot_scan <= 10'b11111_11111;
					end
			endcase
		end
	end
endmodule 