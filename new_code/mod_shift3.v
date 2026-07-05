module mod_shift3 ( 
	input press,
	input rst,
	output reg mod1, mod2, mod3
	);
	always @(negedge press, posedge rst) begin
		if(rst)
			{mod1, mod2, mod3} <= 3'b100;
		else begin
			case({mod1, mod2, mod3})
				3'b100: {mod1, mod2, mod3} <= 3'b010;
				3'b010: {mod1, mod2, mod3} <= 3'b001;
				3'b001: {mod1, mod2, mod3} <= 3'b100;
				default: {mod1, mod2, mod3} <= 3'b100;
			endcase
		end
	end
endmodule