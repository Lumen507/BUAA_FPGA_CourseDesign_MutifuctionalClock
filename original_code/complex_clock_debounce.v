module complex_clock_debounce ( //as a peripheral
	input clk50,
	input rst_all, rst_local,
	input en_alarm,
	input press0, press1, press2, press3,
	input makesure,
	output [6:0] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0,
	output alarm
	);
	wire press0_new, press1_new, press2_new, press3_new;
	wire clk1ms;
	clk_div
	 #(.N(50_000))
	inst_div (
		.clk(clk50),        
		.rst(0),      
		.clk_out(clk1ms)
	);
	debounce //debounce is really important!
	#(.T(), .BIN_WIDTH()) //20ms is good
	decounce0 (
		.clk(clk1ms),
		.in(press0),
		.out(press0_new)
	);
	debounce
	#(.T(), .BIN_WIDTH())
	decounce1 (
		.clk(clk1ms),
		.in(press1),
		.out(press1_new)
	);
	debounce
	#(.T(), .BIN_WIDTH())
	decounce2 (
		.clk(clk1ms),
		.in(press2),
		.out(press2_new)
	);
	debounce
	#(.T(), .BIN_WIDTH())
	decounce3 (
		.clk(clk1ms),
		.in(press3),
		.out(press3_new)
	);
	//original clock
	complex_clock
	#(.BIN_WIDTH(), .BCD_CNT())
	inst (
		.clk50(clk50),
		.rst_all(rst_all),
		.rst_local(rst_local),
		.en_alarm(en_alarm),
		.press0(press0_new),
		.press1(press1_new),
		.press2(press2_new),
		.press3(press3_new),
		.makesure(makesure),
		.HEX7(HEX7), 
		.HEX6(HEX6),
		.HEX5(HEX5), 
		.HEX4(HEX4), 
		.HEX3(HEX3), 
		.HEX2(HEX2), 
		.HEX1(HEX1),
		.HEX0(HEX0),
		.alarm(alarm)
	);
endmodule