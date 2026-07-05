module alarm (
	input clk,
	input trigger,
	input en,
	input rst,
	output reg out
	);
	reg [1:0] state;
	localparam OPEN=2'b00, ALARM=2'b01, CLOSE=2'b10;
	always @(posedge clk, posedge rst) begin
		if(rst)
			state <= CLOSE;
		else begin
			case(state)
				CLOSE: 
					state <= en ? OPEN : CLOSE;
				OPEN:
					state <= trigger ? ALARM : OPEN;
				ALARM:
					state <= (!en) ? CLOSE : ALARM;
				default:
					state <= CLOSE;
			endcase
		end
	end
	always @(state)
		out = (state==ALARM) ? 1'b1 : 1'b0;
endmodule