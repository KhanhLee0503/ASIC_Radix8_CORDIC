module full_adder_32bit(
    input logic [31:0] a_in,
    input logic [31:0] b_in,
    input logic [31:0] c_in,

    output logic [31:0] sum_out,
    output logic [31:0] c_out
);

assign sum_out = a_in ^ b_in ^ c_in; // Sum is XOR of inputs
assign c_out = (a_in & b_in) | (b_in & c_in) | (a_in & c_in); // Carry is generated if at least two inputs are 1

endmodule