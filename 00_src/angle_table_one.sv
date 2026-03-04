module angle_table_one(
    input logic [2:0] select_function,
    output logic [31:0] angle_one
);

parameter SELECT__FUNC_4 = 3'b100;
parameter SELECT__FUNC_3 = 3'b011;
parameter SELECT__FUNC_2 = 3'b010;
parameter SELECT__FUNC_1 = 3'b001;
parameter SELECT__FUNC_0 = 3'b000;

//**Angle Table Values (Radian) ----8 * arctan(select_function * (8^-1))---**//
parameter POS_4 = 32'h03b58ce1;    //3.709180872
parameter POS_3 = 32'h02dec328;    //2.870165362
parameter POS_2 = 32'h01f5b760;    //1.959829305 
parameter POS_1 = 32'h00feadd5;    //0.9948399564
parameter ZERO  = 32'h0;           //0

always_comb begin
   case(select_function)
        SELECT__FUNC_4: angle_one = POS_4;
        SELECT__FUNC_3: angle_one = POS_3;
        SELECT__FUNC_2: angle_one = POS_2;
        SELECT__FUNC_1: angle_one = POS_1;
        SELECT__FUNC_0: angle_one = ZERO;
       default: angle_one = ZERO;
    endcase
end

endmodule