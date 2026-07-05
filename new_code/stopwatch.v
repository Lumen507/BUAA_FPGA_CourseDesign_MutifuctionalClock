module stopwatch //it is similar to simple_clock
	#(parameter BIN_WIDTH=7) ( //not more than 100
	input clk50,
	input en,
	input rst,
	output [BIN_WIDTH-1:0] sec, min, hour
	);
	wire clk;
	wire sec_carry, min_carry;
	wire min_en, hour_en;
	clk_div
	#(.N(500_000)) //10ms
	inst0(
		.clk_in(clk50),
		.rst(rst),
		.clk_out(clk));
	//sec
	counter
	#(.M(100), .BIN_WIDTH(BIN_WIDTH))
	inst11(
		.clk(clk),
		.en(en),
		.rst(rst),
		.load(0),
		.in(),
		.count(sec),
		.carry(sec_carry));
	//min
	assign min_en = sec_carry;
	counter
	#(.M(100), .BIN_WIDTH(BIN_WIDTH))
	inst21(
		.clk(clk),
		.en(min_en),
		.rst(rst),
		.load(0),
		.in(),
		.count(min),
		.carry(min_carry));
	//hour
	assign hour_en = sec_carry & min_carry; 
	counter
	#(.M(100), .BIN_WIDTH(BIN_WIDTH))
	inst31(
		.clk(clk),
		.en(hour_en),
		.rst(rst),
		.load(0),
		.in(),
		.count(hour),
		.carry());
endmodule