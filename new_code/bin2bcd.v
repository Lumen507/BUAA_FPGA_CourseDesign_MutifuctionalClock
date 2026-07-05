module bin2bcd
#(parameter BIN_WIDTH=8, BCD_CNT=3) (
    input [BIN_WIDTH-1:0] bin_code,
    output reg [BCD_CNT*4-1:0] bcd_code
);
    integer i, j, k;
    always @(bin_code) begin  
        bcd_code = 0;
        for(i=BIN_WIDTH-1; i>=0; i=i-1) begin
            for(j=BCD_CNT; j>0; j=j-1) begin
                k = 4*(j-1);
                if(bcd_code[k +: 4]>=5)
                    bcd_code[k +: 4] = bcd_code[k +: 4]+3;
            end
            bcd_code = bcd_code << 1;
            bcd_code[0] = bin_code[i];        
        end
    end
endmodule