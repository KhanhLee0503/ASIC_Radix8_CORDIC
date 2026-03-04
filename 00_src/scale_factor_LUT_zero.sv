module scale_factor_LUT(
    input logic [2:0] select_function,
    input logic 
    output logic [31:0] scale_factor
);

always_comb begin
       case(select_function)
       3'b100:
            case(iteration_num)
            3'b100: scale_factor = 32'h041f83da;
            3'b011: scale_factor = 32'h03298b07;
            3'b010: scale_factor = 32'h023c6ef3;
            3'b001: scale_factor = 32'h016a09e6;
            3'b000: scale_factor = 32'h01000000;
       default: scale_factor = 31'h01000000;
    endcase
end
endmodule