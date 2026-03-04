module barrel_right_shifter_32bit(
    input logic [31:0] data_in,
    input logic [4:0] sh_amt,           //The number of positions to shift
    input logic shift_in,
    output logic [31:0] data_out
);

logic [31:0] out_pre0;
logic [31:0] out_pre1;
logic [31:0] out_pre2;
logic [31:0] out_pre3;

assign out_pre3 = sh_amt[4] ? {{16{shift_in}},data_in[31:16]} : data_in;
assign out_pre2 = sh_amt[3] ? {{8{shift_in}},out_pre3[31:8]} : out_pre3;
assign out_pre1 = sh_amt[2] ? {{4{shift_in}},out_pre2[31:4]} : out_pre2;
assign out_pre0 = sh_amt[1] ? {{2{shift_in}},out_pre1[31:2]} : out_pre1;
assign data_out = sh_amt[0] ? {{1{shift_in}},out_pre0[31:1]} : out_pre0;

endmodule