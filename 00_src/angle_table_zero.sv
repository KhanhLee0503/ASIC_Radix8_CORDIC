module angle_table_zero(
    input logic [2:0] select_function,      //4-bit input select function
    output logic [31:0] angle_zero          //32-bit output angle value
);

parameter SELECT__FUNC_4 = 3'b100;
parameter SELECT__FUNC_3 = 3'b011;
parameter SELECT__FUNC_2 = 3'b010;
parameter SELECT__FUNC_1 = 3'b001;
parameter SELECT__FUNC_0 = 3'b000;

//**Angle Table Values (Radian) ----arctan(select_function)---**//
parameter POS_4 = 32'h015368c9;  //1.325817664
parameter POS_3 = 32'h011ff9bf;  //1.1249045772
parameter POS_2 = 32'h011b6e19;  //1.107148718
parameter POS_1 = 32'h00c90fdb;  //0.7853981634
parameter ZERO  = 32'b0;  //0

always_comb begin
   case(select_function)
        SELECT__FUNC_4: angle_zero = POS_4;
        SELECT__FUNC_3: angle_zero = POS_3;
        SELECT__FUNC_2: angle_zero = POS_2;
        SELECT__FUNC_1: angle_zero = POS_1;
        SELECT__FUNC_0: angle_zero = ZERO;
       default: angle_zero = ZERO;
    endcase
end

endmodule