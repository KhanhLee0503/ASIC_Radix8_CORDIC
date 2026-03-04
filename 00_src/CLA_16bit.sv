module CLA_16bit(
    input logic [15:0] a_in,
    input logic [15:0] b_in,
    input logic c_in,

    output logic [15:0] sum,
    //output logic c_out,
    output logic P_out,
    output logic G_out
);

logic [3:0] P_internal;
logic [3:0] G_internal;
logic [3:0] c_internal;


LCU LCU_16bit(
    .P_Group(P_internal),
    .G_Group(G_internal),
    .c_in(c_in), // No carry-in for the first stage of addition

    .c_internal(c_internal[2:0]),
    .c_out(c_internal[3])
);

CLA_4bit CLA_1(
    .a(a_in[3:0]),
    .b(b_in[3:0]),
    .carry_in(c_in),

    .sum(sum[3:0]),
    
    .P_Out(P_internal[0]),
    .G_Out(G_internal[0])
);

CLA_4bit CLA_2(
    .a(a_in[7:4]),
    .b(b_in[7:4]),
    .carry_in(c_internal[0]),

    .sum(sum[7:4]),
    
    .P_Out(P_internal[1]),
    .G_Out(G_internal[1])
);

CLA_4bit CLA_3(
    .a(a_in[11:8]),
    .b(b_in[11:8]),
    .carry_in(c_internal[1]),

    .sum(sum[11:8]),
    
    .P_Out(P_internal[2]),
    .G_Out(G_internal[2])
);

CLA_4bit CLA_4(
    .a(a_in[15:12]),
    .b(b_in[15:12]),
    .carry_in(c_internal[2]),

    .sum(sum[15:12]),
    
    .P_Out(P_internal[3]),
    .G_Out(G_internal[3])
);

assign P_out = &P_internal;
assign G_out =  G_internal[3] |
               (P_internal[3] & G_internal[2]) | 
               (P_internal[3] & P_internal[2] & G_internal[1]) |
               (P_internal[3] & P_internal[2] & P_internal[1] & G_internal[0]);

//assign c_out = c_internal[3];

endmodule


module LCU(
    input logic [3:0] P_Group,
    input logic [3:0] G_Group,
    input logic c_in,

    output logic [2:0] c_internal,
    output logic c_out
);

always@(*) begin
    c_internal[0]   = G_Group[0] | (P_Group[0] & c_in);
    c_internal[1]   = G_Group[1] | (P_Group[1] & G_Group[0]) | (P_Group[1] & P_Group[0] & c_in);
    c_internal[2]   = G_Group[2] | (P_Group[2] & G_Group[1]) | (P_Group[2] & P_Group[1] & G_Group[0]) | (P_Group[2] & P_Group[1] & P_Group[0] & c_in);
    c_out           = G_Group[3] | (P_Group[3] & G_Group[2]) | (P_Group[3] & P_Group[2] & G_Group[1]) | (P_Group[3] & P_Group[2] & P_Group[1] & G_Group[0]) | (P_Group[3] & P_Group[2] & P_Group[1] & P_Group[0] & c_in);
end 

endmodule