module angle_table_two(
    input logic [2:0] select_function,
    output logic [31:0] angle_two
);

parameter SELECT__FUNC_4 = 3'b100;
parameter SELECT__FUNC_3 = 3'b011;
parameter SELECT__FUNC_2 = 3'b010;
parameter SELECT__FUNC_1 = 3'b001;
parameter SELECT__FUNC_0 = 3'b000;

//**Angle Table Values (Radian) ----8^2 .arctan(select_function . 8^(-2) )---**//
parameter POS_4 = 32'h03feab77;  //3.99480384
parameter POS_3 = 32'h02ff7031;  //2.997805627
parameter POS_2 = 32'h01ffd55c;  //1.99934934 
parameter POS_1 = 32'h00fffaab;  //0.9999186317
parameter ZERO  = 32'h00;  //0

always_comb begin
   case(select_function)
        SELECT__FUNC_4: angle_two = POS_4;
        SELECT__FUNC_3: angle_two = POS_3;
        SELECT__FUNC_2: angle_two = POS_2;
        SELECT__FUNC_1: angle_two = POS_1;
        SELECT__FUNC_0: angle_two = ZERO;
       default: angle_two = ZERO;
    endcase
end

endmodule