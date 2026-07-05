module simple_clock
	#(parameter BIN_WIDTH=4) (
	input clk50,
	input rst,
	input load,
	input [BIN_WIDTH-1:0] in_sec,
	input [BIN_WIDTH-1:0] in_min,
	input [BIN_WIDTH-1:0] in_hour,
	output [BIN_WIDTH-1:0] sec, min, hour
	);
	wire clk;
	wire sec_carry, min_carry;
	wire min_en, hour_en;
	clk_div
	#(.N(50_000_000))
	inst0(
		.clk_in(clk50),
		.rst(rst),
		.clk_out(clk));
	//sec
	counter
	#(.M(60), .BIN_WIDTH(BIN_WIDTH), .RESET(3))
	inst11(
		.clk(clk),
		.en(~load),
		.rst(rst),
		.load(load),
		.in(in_sec),
		.count(sec),
		.carry(sec_carry));
	//min
	assign min_en = sec_carry;
	counter
	#(.M(60), .BIN_WIDTH(BIN_WIDTH), .RESET(2))
	inst21(
		.clk(clk),
		.en(min_en),
		.rst(rst),
		.load(load),
		.in(in_min),
		.count(min),
		.carry(min_carry));
	//hour
	assign hour_en = sec_carry & min_carry;
	counter
	#(.M(24), .BIN_WIDTH(BIN_WIDTH), .RESET(1))
	inst31(
		.clk(clk),
		.en(hour_en),
		.rst(rst),
		.load(load),
		.in(in_hour),
		.count(hour),
		.carry());
endmodule