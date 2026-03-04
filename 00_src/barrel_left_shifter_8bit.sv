module barrel_left_shifter_8bit(
    input logic [7:0] data_in,
    input logic [2:0] sh_amt,           //The number of positions to shift

    output logic [7:0] data_out
);

logic [7:0] out_pre0;
logic [7:0] out_pre1;

assign out_pre1 = sh_amt[2] ? {data_in[3:0],4'b0} : data_in;
assign out_pre0 = sh_amt[1] ? {out_pre1[5:0],2'b0} : out_pre1;
assign data_out = sh_amt[0] ? {out_pre0[6:0],1'b0} : out_pre0;

endmodule