module shifter #(parameter DATA_WIDTH = 32)
(
    input logic [DATA_WIDTH-1:0] data_in,
    input logic [4:0] sh_amt,           //The number of iterations to shift
    input logic [2:0] select_function,

    output logic [DATA_WIDTH-1:0] sum_out,
    output logic [DATA_WIDTH-1:0] carry_out
);

logic mux2_select;
logic [1:0] mux1_select;
logic [DATA_WIDTH-1:0] mux1_out;
logic [DATA_WIDTH-1:0] mux2_out;

assign mux1_select[1] = (select_function[1] ^ select_function[2]); //S1 = B XOR A
assign mux1_select[0] = (~select_function[2] & ~select_function[1] & select_function[0]) | (select_function[2] & ~select_function[1]); //S0 = ~A & ~B & C | A & ~B

assign mux2_select = select_function[0] & select_function[1];

always_comb begin  
    case(mux1_select)
        2'b00: mux1_out = {DATA_WIDTH{1'b0}}; 
        2'b01: mux1_out = data_in;
        2'b10: mux1_out = {data_in[DATA_WIDTH-2:0], 1'b0};
        2'b11: mux1_out = {data_in[DATA_WIDTH-3:0], 2'b00};
        default: mux1_out = {DATA_WIDTH{1'b0}};
    endcase
end

always_comb begin 
   if(mux2_select) begin
        mux2_out = data_in;
   end else begin
        mux2_out = 15'b0;
   end
end

barrel_right_shifter_32bit shifter_sum (
    .data_in(mux1_out),
    .sh_amt(sh_amt),
    .shift_in(mux1_out[DATA_WIDTH-1]), // Shift in the sign bit for arithmetic right shift
    .data_out(sum_out)
);

barrel_right_shifter_32bit shifter_carry (
    .data_in(mux2_out),
    .sh_amt(sh_amt),
    .shift_in(mux2_out[DATA_WIDTH-1]), // Shift in the sign bit for arithmetic right shift
    .data_out(carry_out)
);

endmodule