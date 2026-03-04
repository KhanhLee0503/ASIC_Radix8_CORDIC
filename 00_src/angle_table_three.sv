module angle_table_three(
    input logic [2:0] select_function,
    output logic [31:0] angle_three
);

parameter SELECT__FUNC_4 = 3'b100;
parameter SELECT__FUNC_3 = 3'b011;
parameter SELECT__FUNC_2 = 3'b010;
parameter SELECT__FUNC_1 = 3'b001;
parameter SELECT__FUNC_0 = 3'b000;


//**Angle Table Values (Radian) ----8^3 . arctan(select_function . 8^-3)---**//

parameter POS_4 = 32'h03fffaab;     //3.999918623
parameter POS_3 = 32'h02fffdc0;     //2.999965668
parameter POS_2 = 32'h01ffff55;     //1.999989828
parameter POS_1 = 32'h00ffffeb;     //0.9999987284
parameter ZERO  = 32'h0;            //0

/*
parameter POS_4 = 32'h1FFFD556;     //31.99934898
parameter POS_3 = 32'h17FFEE00;     //23.99972535
parameter POS_2 = 32'h0FFFFAAB;     //15.99991862
parameter POS_1 = 32'h07FFF955;     //7.999989827
parameter ZERO  = 32'h0;
*/

always_comb begin
   case(select_function)
        SELECT__FUNC_4: angle_three = POS_4;
        SELECT__FUNC_3: angle_three = POS_3;
        SELECT__FUNC_2: angle_three = POS_2;
        SELECT__FUNC_1: angle_three = POS_1;
        SELECT__FUNC_0: angle_three = ZERO;
       default: angle_three = ZERO;
    endcase
end

endmodule
