module clock_tb (
	input CLOCK_50,
	input [17:14] SW,
	input [3:0] KEY,
	output [6:0] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0,
	output [1:0] LEDR
	);
	complex_clock_debounce
    inst (
		.press0(KEY[0]), //KEY[0] controll mod shift
		.press1(KEY[1]), //KEY[1] move the bit
		.press2(KEY[2]), //KEY[2] add numbers
		.press3(KEY[3]), //KEY[3] substract numbers
		.clk50(CLOCK_50),
		.rst_all(SW[17]), //SW[17] reset all
		.makesure(SW[15]), //SW[15] to ensure
		.rst_local(SW[16]), //SW[16] reset mod234
		.en_alarm(SW[14]), //SW[14] open the alarm
		.HEX7(HEX7), 
		.HEX6(HEX6),
		.HEX5(HEX5), 
		.HEX4(HEX4), 
		.HEX3(HEX3), 
		.HEX2(HEX2), 
		.HEX1(HEX1),
		.HEX0(HEX0),
		.alarm(LEDR[0])
	);
endmodule