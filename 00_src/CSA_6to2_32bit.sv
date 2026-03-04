module CSA_6to2_32bit(
    input logic [31:0] x1_in,
    input logic [31:0] x2_in,
    input logic [31:0] x3_in,
    input logic [31:0] x4_in,
    input logic [31:0] x5_in,
    input logic [31:0] x6_in,

    output logic [31:0] sum_out,
    output logic [31:0] c_out
);
logic [31:0] sum1;
logic [31:0] carry1;

logic [31:0] sum2;
logic [31:0] carry2;

logic [31:0] sum3;
logic [31:0] carry3;

logic [31:0] carry1_shifted;
logic [31:0] carry2_shifted;
logic [31:0] carry3_shifted;

logic [31:0] c_out_pre;

//First stage: 2 full adders produce 4 outputs (2 sums and 2 carry)
full_adder_32bit FA1(
    .a_in(x1_in),
    .b_in(x2_in),
    .c_in(x3_in),
    .sum_out(sum1),
    .c_out(carry1)
);

full_adder_32bit FA2(
    .a_in(x4_in),
    .b_in(x5_in),
    .c_in(x6_in),
    .sum_out(sum2),
    .c_out(carry2)
);

assign carry1_shifted = {carry1[30:0], 1'b0}; // Shift carry left by 1
assign carry2_shifted = {carry2[30:0], 1'b0}; // Shift carry left by 1

//Second stage: 1 full adders produce 2 outputs from first stage (1 sum and 1 carry)
full_adder_32bit FA3(
    .a_in(carry1_shifted),
    .b_in(sum2),
    .c_in(carry2_shifted),
    .sum_out(sum3),
    .c_out(carry3)
);

assign carry3_shifted = {carry3[30:0], 1'b0}; // Shift carry left by 1

full_adder_32bit FA4(
    .a_in(sum1),
    .b_in(sum3),
    .c_in(carry3_shifted),
    .sum_out(sum_out),
    .c_out(c_out_pre)
);

assign c_out = {c_out_pre[30:0], 1'b0}; // Final carry output

endmodule