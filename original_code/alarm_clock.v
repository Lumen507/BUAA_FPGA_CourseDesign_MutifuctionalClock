module alarm_clock
	#(parameter BIN_WIDTH=4)(
	input clk,
	input en_mod,
	input en_alarm,
	input rst, 
	input press_sel,
	input press_add,
	input press_sub,
	input [BIN_WIDTH-1:0] sec1, min1, hour1,
	output [BIN_WIDTH-1:0] sec2, min2, hour2,
	output out 
	);
	counter_set_reset
	#(.BIN_WIDTH(BIN_WIDTH))
	alarm_set (
		.en(en_mod),
		.rst(rst), 
		.press_sel(press_sel),
		.press_add(press_add),
		.press_sub(press_sub),
		.sec(sec2),
		.min(min2),
		.hour(hour2)
	);
	wire equal;
	comparer 
	#(.BIN_WIDTH(BIN_WIDTH))
	inst_comparer(
		.sec1(sec1),
		.min1(min1),
		.hour1(hour1),
		.sec2(sec2),
		.min2(min2),
		.hour2(hour2),
		.out(equal)
	);
	alarm 
	inst_alarm (
		.clk(clk),
		.trigger(equal),
		.en(en_alarm),
		.rst(rst),
		.out(out)
	);
endmodule