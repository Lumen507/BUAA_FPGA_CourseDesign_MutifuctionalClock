module comparer 
	#(parameter BIN_WIDTH=7) (
	input [BIN_WIDTH-1:0] sec1, min1, hour1,
	input [BIN_WIDTH-1:0] sec2, min2, hour2,
	output reg out
	);
	always @(*) begin
		if(sec1==sec2 && min1==min2 && hour1==hour2)
			out = 1'b1;
		else
			out = 1'b0;
	end
endmodule