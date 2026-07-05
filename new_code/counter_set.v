module counter_set
	#(parameter BIN_WIDTH=4)(
	input en,
	input rst, 
	input press_sel,
	input press_add,
	input press_sub,
	output [BIN_WIDTH-1:0] sec, min, hour
	);
	wire en_sec, en_min, en_hour;
	mod_shift3
	inst_mod (
		.press(press_sel),
		.rst(rst),
		.mod1(en_hour),
		.mod2(en_min),
		.mod3(en_sec)
	);
	//sec
	counter_add_sub
	#(.M(60), .BIN_WIDTH(BIN_WIDTH))
	inst_sec (
		.clk_add(!press_add),
		.clk_sub(!press_sub),
		.en(en_sec&en),
		.rst(rst),
		.load(1'b0),
		.in(),
		.count(sec),
		.carry()
	);
	//min
	counter_add_sub
	#(.M(60), .BIN_WIDTH(BIN_WIDTH))
	inst_min (
		.clk_add(!press_add),
		.clk_sub(!press_sub),
		.en(en_min&en),
		.rst(rst),
		.load(1'b0),
		.in(),
		.count(min),
		.carry()
	);
	//hour
	counter_add_sub
	#(.M(24), .BIN_WIDTH(BIN_WIDTH))
	inst_hour (
		.clk_add(!press_add),
		.clk_sub(!press_sub),
		.en(en_hour&en),
		.rst(rst),
		.load(1'b0),
		.in(),
		.count(hour),
		.carry()
	);
endmodule