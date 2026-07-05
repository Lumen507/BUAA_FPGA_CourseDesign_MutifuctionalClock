module segment(
	input en,
	input [3:0] num,
	output reg [6:0] HEX
	);
	localparam NUM_0 = 7'b1000000;
	localparam NUM_1 = 7'b1111001;
	localparam NUM_2 = 7'b0100100;
	localparam NUM_3 = 7'b0110000;
	localparam NUM_4 = 7'b0011001;
	localparam NUM_5 = 7'b0010010;
	localparam NUM_6 = 7'b0000010;
	localparam NUM_7 = 7'b1111000;
	localparam NUM_8 = 7'b0000000;
	localparam NUM_9 = 7'b0010000;
	localparam CHAR_A = 7'b0001000; 
	localparam CHAR_b = 7'b0000011;
	localparam CHAR_C = 7'b1000110;
	localparam CHAR_d = 7'b0100001;
	localparam CHAR_E = 7'b0000110;
	localparam CHAR_F = 7'b0001110;
	localparam OFF = 7'b1111111;
	always @(*)
		if(en)
			case(num)
				4'b0000:HEX = NUM_0;
				4'b0001:HEX = NUM_1;
				4'b0010:HEX = NUM_2;
				4'b0011:HEX = NUM_3;
				4'b0100:HEX = NUM_4;
				4'b0101:HEX = NUM_5;
				4'b0110:HEX = NUM_6;
				4'b0111:HEX = NUM_7;
				4'b1000:HEX = NUM_8;
				4'b1001:HEX = NUM_9;
				4'b1010:HEX = CHAR_A;
				4'b1011:HEX = CHAR_b;
				4'b1100:HEX = CHAR_C;
				4'b1101:HEX = CHAR_d;
				4'b1110:HEX = CHAR_E;
				4'b1111:HEX = CHAR_F;
			endcase
		else
			HEX=OFF;
endmodule