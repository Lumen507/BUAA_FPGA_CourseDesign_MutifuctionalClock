module debounce
	#(parameter T=1_000_000, BIN_WIDTH=20) ( //20ms
		input clk,
		input in, 
		output reg out
	);
	reg [1:0] state;
	localparam IDLE=2'b00, FALL=2'b01, HOLD=2'b10, RISE=2'b11;
	reg [BIN_WIDTH-1:0] count;
	always @(posedge clk) begin
		case(state)
			IDLE:
				if(in==0) begin
					state <= FALL;
					count <= 0;
				end
			FALL:
				if(in==0) begin
					if(count==T) begin
						state <= HOLD;
						count <= 0;
					end
					else begin
						state <= FALL;
						count <= count+1'b1;
					end
				end
				else begin
					state <= IDLE;
					count <= 1'b0;
				end
			HOLD:
				if(in==1) begin
					state <= RISE;
					count <= 1'b0;
				end
			RISE:
				if(in==1) begin
					if(count==T) begin
						state <= IDLE;
						count <= 1'b0;
					end
					else begin
						state <= RISE;
						count <= count+1'b1;
					end
				end
				else begin
					state <= HOLD;
					count <= 1'b0;
				end
			endcase
	end
	//moore out
	always @(state) begin
		out = (state==HOLD || state==RISE) ? 1'b0 : 1'b1;
	end
endmodule