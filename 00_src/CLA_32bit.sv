module CLA_32bit(
    input logic [31:0] a_in,
    input logic [31:0] b_in,
    input logic c_in,

    output logic [31:0] sum,
    output logic c_out
);

logic P_High, G_High;
logic P_Low, G_Low;
logic c_in_high;

CLA_16bit CLA_Low(
    .a_in(a_in[15:0]),
    .b_in(b_in[15:0]),
    .c_in(c_in),

    .sum(sum[15:0]),
    .P_out(P_Low),
    .G_out(G_Low)
);

assign c_in_high = G_Low | (P_Low & c_in);

CLA_16bit CLA_High(
    .a_in(a_in[31:16]),
    .b_in(b_in[31:16]),
    .c_in(c_in_high),

    .sum(sum[31:16]),
    .P_out(P_High),
    .G_out(G_High)
);

assign c_out = G_High | (P_High & c_in_high);

endmodule
 