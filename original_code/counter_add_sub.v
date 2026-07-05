module counter_add_sub //use for key
	#(parameter M=17, BIN_WIDTH=8)( //M means T
	input clk_add,
	input clk_sub,
	input en,
	input rst,
	input load,
	input [BIN_WIDTH-1:0] in,
	output reg [BIN_WIDTH-1:0] count,
	output reg carry
	);
	reg op;
	reg clk;
	always @(posedge clk_add, posedge clk_sub) begin //divide posedge and negedge
		if(clk_add)
			op <= 1'b1;
		else
			op <= 1'b0;
	end
	always @(clk_add, clk_sub)
		clk = clk_add | clk_sub;
	always @(negedge clk, posedge rst, posedge load) begin
		if(rst) begin
			count <= 1'b0;
			carry <= 1'b0;
		end
		else if(load) begin //asynchronous
			count <= in;
			carry <= 1'b0;
		end
		else begin
			if(en) begin
				if(op) begin
					if(count == M-1)
						count <= 1'b0;
					else
						count <= count+1'b1;
					if(count == M-2)
						carry <= 1'b1;
					else
						carry <= 1'b0;
				end
				else begin
					carry <= 1'b0;
					if(count == 1'b0)
						count <= M-1'b1;
					else
						count <= count-1'b1;
				end
			end
		end
	end
endmodule