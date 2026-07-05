module mod_shift4 ( //this module use to enable other
	input press,
	input rst,
	output reg mod1, mod2, mod3, mod4,
	output reg [3:0] num
	);
	always @(negedge press, posedge rst) begin
		if(rst==1) begin
			{mod1, mod2, mod3, mod4} <= 4'b1000;
			num <= 1;
		end
		else begin
			case({mod1, mod2, mod3, mod4})
				4'b1000: begin {mod1, mod2, mod3, mod4} <= 4'b0100; num <= 2; end
				4'b0100: begin {mod1, mod2, mod3, mod4} <= 4'b0010; num <= 3; end
				4'b0010: begin {mod1, mod2, mod3, mod4} <= 4'b0001; num <= 4; end
				4'b0001: begin {mod1, mod2, mod3, mod4} <= 4'b1000; num <= 1; end
				default: begin {mod1, mod2, mod3, mod4} <= 4'b1000; num <= 1; end
			endcase
		end
	end
endmodule