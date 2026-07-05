module mod_display
	#(parameter BIN_WIDTH=7, BCD_CNT=2) ( //no more than 100
	input mod1, mod2, mod3, mod4,
	input [BIN_WIDTH-1:0] mod1_sec, mod1_min, mod1_hour,
	input [BIN_WIDTH-1:0] mod2_sec, mod2_min, mod2_hour,
	input [BIN_WIDTH-1:0] mod3_sec, mod3_min, mod3_hour,
	input [BIN_WIDTH-1:0] mod4_sec, mod4_min, mod4_hour,
	output [6:0] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2
	);
	reg [BIN_WIDTH-1:0] sec, min, hour;
	wire [BCD_CNT*4-1:0] sec_bcd, min_bcd, hour_bcd;
	always @(*) begin 
		case({mod1, mod2, mod3, mod4})
			4'b1000: begin
				sec = mod1_sec;
				min = mod1_min;
				hour = mod1_hour;
			end
			4'b0100: begin
				sec = mod2_sec;
				min = mod2_min;
				hour = mod2_hour;
			end
			4'b0010: begin
				sec = mod3_sec;
				min = mod3_min;
				hour = mod3_hour;
			end
			4'b0001: begin
				sec = mod4_sec;
				min = mod4_min;
				hour = mod4_hour;
			end
			default:  begin
				sec = mod1_sec;
				min = mod1_min;
				hour = mod1_hour;
			end
		endcase
	end
	//sec display
	bin2bcd
	#(.BIN_WIDTH(BIN_WIDTH), .BCD_CNT(BCD_CNT))
	inst12(
		.bin_code(sec),
		.bcd_code(sec_bcd));
	segment
	inst13(
		.en(1'b1),
		.num(sec_bcd[3:0]),
		.HEX(HEX2));
	segment
	inst14(
		.en(1'b1),
		.num(sec_bcd[7:4]),
		.HEX(HEX3));
	//min display
	bin2bcd
	#(.BIN_WIDTH(BIN_WIDTH), .BCD_CNT(BCD_CNT))
	inst22(
		.bin_code(min),
		.bcd_code(min_bcd));
	segment
	inst23(
		.en(1'b1),
		.num(min_bcd[3:0]),
		.HEX(HEX4));
	segment
	inst24(
		.en(1'b1),
		.num(min_bcd[7:4]),
		.HEX(HEX5));
	//hour display
	bin2bcd
	#(.BIN_WIDTH(BIN_WIDTH), .BCD_CNT(BCD_CNT))
	inst32(
		.bin_code(hour),
		.bcd_code(hour_bcd));
	segment
	inst33(
		.en(1'b1),
		.num(hour_bcd[3:0]),
		.HEX(HEX6));
	segment
	inst34(
		.en(1'b1),
		.num(hour_bcd[7:4]),
		.HEX(HEX7));
endmodule