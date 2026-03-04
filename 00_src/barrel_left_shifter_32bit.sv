module barrel_left_shifter_32bit(
    input logic [31:0] data_in,
    input logic [4:0] sh_amt,           //The number of positions to shift

    output logic [31:0] data_out
);

logic [31:0] out_pre0;
logic [31:0] out_pre1;
logic [31:0] out_pre2;
logic [31:0] out_pre3;

assign out_pre3 = sh_amt[4] ? {data_in[15:0],16'b0} : data_in;
assign out_pre2 = sh_amt[3] ? {out_pre3[23:0],8'b0} : out_pre3;
assign out_pre1 = sh_amt[2] ? {out_pre2[27:0],4'b0} : out_pre2;
assign out_pre0 = sh_amt[1] ? {out_pre1[29:0],2'b0} : out_pre1;
assign data_out = sh_amt[0] ? {out_pre0[30:0],1'b0} : out_pre0;

endmodule