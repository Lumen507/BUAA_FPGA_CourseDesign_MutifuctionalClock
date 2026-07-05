module clk_div 
    #(parameter N = 3) ( //N >= 2
    input clk,        
    input rst,      
    output reg clk_out);
	localparam M = (N-1)/2;
	localparam odd = N%2;
	localparam N2 = N/2;
	integer count1;
	integer count2;
	reg clk1;
	reg clk2;
	always @(posedge clk) begin
		if(rst) begin
			count1 <= 0;
			clk1 <= 0;
		end
		else begin
			if(odd) begin
				if(count1 == M || count1 == 0)
					clk1 <= ~clk1;
				if(count1 == N-1)
					count1 <= 0;
				else
					count1 <=  count1+1;
			end
			else begin
				if(count1 == N2 || count1 == N)
					clk1 <= ~clk1;
				if(count1 == N)
					count1 <= 0;
				else
					count1 <= count1+1;
			end
		end
	end
	always @(negedge clk) begin	
		if(rst) begin
			count2 <= 0;
			clk2 <= 0;
		end
		else begin
			if(odd) begin	
				if(count2 == M || count2 == 0) 
					clk2 <= ~clk2;
				if(count2 == N-1) 
					count2 <= 0;
				else
					count2 <=  count2+1;
			end
			else
				clk2 <= 0;
		end
	end
	always @(clk1, clk2, rst) begin
		if(rst) clk_out = 0;
		else clk_out = clk1|clk2;
	end
endmodule

/* another methon:FSM+relationship
`timescale 1ns/1ns

module clk_divider
    #(parameter dividor = 5, BIN_WIDTH = 3)
( 	input clk_in,
	input rst_n,
	output clk_out
);
	reg 				clk1, clk2;
	//reg [BIN_WIDTH-1:0] cnt1, cnt2;
	integer				cnt1, cnt2;
    always @(posedge clk_in, negedge rst_n) begin
		if(!rst_n) begin
			cnt1 <= 1'b0;
		end
		else begin
			if(cnt1==dividor-1)
				cnt1 <= 1'b0;
			else
				cnt1 <= cnt1+1'b1;
		end
	end
	always @(negedge clk_in, negedge rst_n) begin
		if(!rst_n) begin
			cnt2 <= 1'b0;
		end
		else begin
			cnt2 <= cnt1;
		end
	end
	always @(cnt1) begin
		if(0<cnt1 && cnt1<((dividor+1)/2))
			clk1 = 1'b1;
		else
			clk1 = 1'b0;
	end
	always @(cnt2) begin
		if(0<cnt2 && cnt2<((dividor+1)/2))
			clk2 = 1'b1;
		else
			clk2 = 1'b0;
	end
	assign clk_out = clk1 | clk2;
endmodule
*/