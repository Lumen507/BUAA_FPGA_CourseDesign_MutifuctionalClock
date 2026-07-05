module counter
	#(parameter M=17, BIN_WIDTH=8, RESET=0)(
	input clk,
	input en,
	input rst,
	input load,
	input [BIN_WIDTH-1:0] in,
	output reg [BIN_WIDTH-1:0] count,
	output reg carry);
	always @(posedge clk, posedge rst) begin 
		if(rst) begin
			count <= RESET;
		end
		else if(load) begin 
			count <= in;
		end
		else if(en) begin
			if(count == M-1)
				count <= 1'b0;
			else
				count <= count+1'b1;
    end
	end
  always @(negedge clk, posedge rst) begin
    if(rst) begin
			carry <= 1'b0;
		end
    else begin
      if(count == M-1)
        carry <= 1'b1;
      else
        carry <= 1'b0;
    end
  end
endmodule