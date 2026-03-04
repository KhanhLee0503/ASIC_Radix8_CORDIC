module angle_table_seven(
    input logic [2:0] select_function,
    output logic [31:0] angle_seven
);

parameter SELECT__FUNC_4 = 3'b100;
parameter SELECT__FUNC_3 = 3'b011;
parameter SELECT__FUNC_2 = 3'b010;
parameter SELECT__FUNC_1 = 3'b001;
parameter SELECT__FUNC_0 = 3'b000;

//**Angle Table Values (Radian) ----8^6 . arctan(select_function . 8^-6)---**//
parameter POS_4 = 32'h04000000;     //3.99999998
parameter POS_3 = 32'h03000000;     //2.99999992
parameter POS_2 = 32'h02000000;     //1.999999998
parameter POS_1 = 32'h01000000;     //0.9999999997
parameter ZERO  = 32'h0;  //0

always_comb begin
   case(select_function)
        SELECT__FUNC_4: angle_seven = POS_4;
        SELECT__FUNC_3: angle_seven = POS_3;
        SELECT__FUNC_2: angle_seven = POS_2;
        SELECT__FUNC_1: angle_seven = POS_1;
        SELECT__FUNC_0: angle_seven = ZERO;
       default: angle_seven = ZERO;
    endcase
end

endmodule
