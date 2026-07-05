module complex_clock
	#(parameter BIN_WIDTH=7, BCD_CNT=2) ( //unify to 7,need to be the same
	input clk50,
	input rst_all, rst_local,
	input en_alarm,
	input press0, press1, press2, press3,
	input makesure,
	output [6:0] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0,
	output alarm
	);
	wire mod1_en, mod2_en, mod3_en, mod4_en;
	wire [3:0] mod_num;
	wire rst2, rst3, rst4;
	wire [BIN_WIDTH-1:0] mod1_sec, mod1_min, mod1_hour;
	wire [BIN_WIDTH-1:0] mod2_sec, mod2_min, mod2_hour;
	wire [BIN_WIDTH-1:0] mod3_sec, mod3_min, mod3_hour;
	wire [BIN_WIDTH-1:0] mod4_sec, mod4_min, mod4_hour;
	mod_shift4
	inst_mod (
		.press(press0), //KEY[0] controll mod shift
		.rst(rst_all),
		.mod1(mod1_en),
		.mod2(mod2_en),
		.mod3(mod3_en),
		.mod4(mod4_en),
		.num(mod_num)
	);
	//mod1
	wire load1; //it's easy to forget definition
	assign load1 = mod2_en & makesure;
	simple_clock
	#(.BIN_WIDTH(BIN_WIDTH))
    inst_simple (
		.clk50(clk50),
		.rst(rst_all),
		.load(load1),
		.in_sec(mod2_sec),
		.in_min(mod2_min),
		.in_hour(mod2_hour),
		.sec(mod1_sec),
		.min(mod1_min),
		.hour(mod1_hour)
	);
	//mod2
	assign rst2 = rst_all | (rst_local&mod2_en);
	counter_set
	#(.BIN_WIDTH(BIN_WIDTH))
	inst_count_reset(
		.en(mod2_en),
		.rst(rst2),
		.press_sel(press1), //KEY[1] move the bit
		.press_add(press2), //KEY[2] add numbers
		.press_sub(press3), //KEY[3] substract numbers
		.sec(mod2_sec),
		.min(mod2_min),
		.hour(mod2_hour)
	);
	//mod3
	assign rst3 = rst_all | (rst_local&mod3_en);
	wire en3;
	assign en3 = mod3_en & makesure;
	stopwatch
	#(.BIN_WIDTH(BIN_WIDTH))
    inst_stopwatch (
		.en(en3), //have a swich
		.clk50(clk50),
		.rst(rst3),
		.sec(mod3_sec),
		.min(mod3_min),
		.hour(mod3_hour)
	);
	//mod4
	assign rst4 = rst_all | (rst_local&mod4_en);
	alarm_clock
	#(.BIN_WIDTH(BIN_WIDTH))
	inst_alarm (
		.clk(clk50),
		.en_mod(mod4_en),
		.en_alarm(en_alarm), //display in HEX0
		.rst(rst4), 
		.press_sel(press1),
		.press_add(press2),
		.press_sub(press3),
		.sec1(mod1_sec),
		.min1(mod1_min),
		.hour1(mod1_hour),
		.sec2(mod4_sec),
		.min2(mod4_min),
		.hour2(mod4_hour),
		.out(alarm)
	);
	//display
	mod_display
	#(.BIN_WIDTH(BIN_WIDTH), .BCD_CNT(BCD_CNT))
    inst_display (
		.mod1(mod1_en),
		.mod2(mod2_en),
		.mod3(mod3_en),
		.mod4(mod4_en),
		.mod1_sec(mod1_sec),
		.mod1_min(mod1_min),
		.mod1_hour(mod1_hour),
		.mod2_sec(mod2_sec),
		.mod2_min(mod2_min),
		.mod2_hour(mod2_hour),
		.mod3_sec(mod3_sec),
		.mod3_min(mod3_min),
		.mod3_hour(mod3_hour),
		.mod4_sec(mod4_sec),
		.mod4_min(mod4_min),
		.mod4_hour(mod4_hour),
		.HEX7(HEX7), 
		.HEX6(HEX6),
		.HEX5(HEX5), 
		.HEX4(HEX4), 
		.HEX3(HEX3), 
		.HEX2(HEX2)
	);
	//alarm_display
	segment
	alarm_display (
		.en(1'b1),
		.num(en_alarm),
		.HEX(HEX0)
	);
	//mod_num_display
	segment
	mod_num_display (
		.en(1'b1),
		.num(mod_num),
		.HEX(HEX1)
	);
endmodule