module CLA_64bit(
    input logic [63:0] a_in,
    input logic [63:0] b_in,
    input logic c_in,

    output logic [63:0] sum,
    output logic c_out
);

logic c_mid;


CLA_32bit CLA_block1(
    .a_in(a_in[31:0]),
    .b_in(b_in[31:0]),
    .c_in(c_in),

    .sum(sum[31:0]),
    .c_out(c_mid)
);

CLA_32bit CLA_block2(
    .a_in(a_in[63:32]),
    .b_in(b_in[63:32]),
    .c_in(c_mid),

    .sum(sum[63:32]),
    .c_out(c_out)
);

endmodule