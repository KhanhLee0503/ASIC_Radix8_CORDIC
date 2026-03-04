module CSA_3to2_32bit(
    input logic [31:0] a_in,
    input logic [31:0] b_in,
    input logic [31:0] c_in,

    output logic [31:0] sum_out,
    output logic [31:0] c_out
);

logic [31:0] c_out_pre;

genvar i;
generate
    for(i=0; i<32; i=i+1) begin
        assign sum_out[i] = a_in[i] ^ b_in[i] ^ c_in[i];
        assign c_out_pre[i] = (a_in[i] & b_in[i]) | (a_in[i] & c_in[i]) | (b_in[i] & c_in[i]); 
    end   
endgenerate 

assign c_out = {c_out_pre[30:0], 1'b0}; 

endmodule