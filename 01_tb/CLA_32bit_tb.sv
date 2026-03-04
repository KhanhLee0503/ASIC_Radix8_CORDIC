`timescale 1ns/1ns
module CLA_32bit_tb;
logic [31:0] a_in;
logic [31:0] b_in;
logic c_in;
logic [31:0] sum;
logic c_out;

CLA_32bit DUT(
    .a_in(a_in),
    .b_in(b_in),
    .c_in(c_in),

    .sum(sum),
    .c_out(c_out)
);

integer i;

initial begin
    a_in = 32'h0;
    b_in = 32'h0;
    c_in = 1'b0;
    #10;

    $display("---------Testing Addition---------");
    for(i=0; i<50; i++) begin
        a_in = $urandom;
        b_in = $urandom;
        c_in = $urandom % 2; // Randomly set carry-in to 0 or 1
        #10;
        if(sum != a_in + b_in + c_in) begin
            $display("==> Test %0d Failed: a_in = %h, b_in = %h, c_in = %b => sum = %h, c_out = %b", i, a_in, b_in, c_in, sum, c_out);
        end else begin
            $display("Test %0d Passed: a_in = %h, b_in = %h, c_in = %b => sum = %h, c_out = %b", i, a_in, b_in, c_in, sum, c_out);
        end
    end

    
end


endmodule