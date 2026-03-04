module angle_table_four(
    input logic [2:0] select_function,
    output logic [31:0] angle_four
);

parameter SELECT__FUNC_4 = 3'b100;
parameter SELECT__FUNC_3 = 3'b011;
parameter SELECT__FUNC_2 = 3'b010;
parameter SELECT__FUNC_1 = 3'b001;
parameter SELECT__FUNC_0 = 3'b000;

//**Angle Table Values (Radian) ----8^4 . arctan(select_function . 8^-4)---**//
parameter POS_4 = 32'h03ffffeb;    //3.999998728
parameter POS_3 = 32'h02fffff7;    //2.999999464
parameter POS_2 = 32'h01fffffd;    //1.999999841
parameter POS_1 = 32'h00ffffff;    //0.9999999801
parameter ZERO  = 32'h0;  //0

always_comb begin
   case(select_function)
        SELECT__FUNC_4: angle_four = POS_4;
        SELECT__FUNC_3: angle_four = POS_3;
        SELECT__FUNC_2: angle_four = POS_2;
        SELECT__FUNC_1: angle_four = POS_1;
        SELECT__FUNC_0: angle_four = ZERO;
       default: angle_four = ZERO;
    endcase
end

endmodule
