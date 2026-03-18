module first_micro_rotation(
    input logic [31:0] x_in,    //X-Axis Format is FXP(32,24)
    input logic [31:0] y_in,    //Y-Axis Format is FXP(32,24)
    input logic [31:0] z_in,    //Angle Format is FXP(32,24)

    output logic [2:0] select_function_0,

    output logic [31:0] x_sum,
    output logic [31:0] x_carry,

    output logic [31:0] y_sum,
    output logic [31:0] y_carry,

    output logic [31:0] angle_sum,
    output logic [31:0] angle_carry
    
);

logic [3:0] select_function_pre;
logic [31:0] angle_zero_out;
logic [31:0] angle_zero_out_n;

logic [31:0] x0p1;
logic [31:0] x0p2;
logic [31:0] x0p1_n;
logic [31:0] x0p2_n;

logic [31:0] y0p1;
logic [31:0] y0p2;
logic [31:0] y0p1_n;
logic [31:0] y0p2_n;

//--------------------Computing Angle of Rotation--------------------//
comparator_zero comparator_zero(
    .data_in(z_in[25:21]),
    .select_function(select_function_pre)
);

angle_table_zero angle_table_zero(
    .select_function(select_function_pre[2:0]),
    .angle_zero(angle_zero_out)
);

two_complementer two_complementer_angle (
    .data_in(angle_zero_out),
    .enable(~select_function_pre[3]), // Negate if select_function is negative
    .data_out(angle_zero_out_n)
);

barrel_left_shifter_32bit angle_sum_shift (
    .data_in(angle_zero_out_n),
    .sh_amt(5'h3),
    .data_out(angle_sum)
);

barrel_left_shifter_32bit angle_carry_shift (
    .data_in(z_in),
    .sh_amt(5'h3),
    .data_out(angle_carry)
);



//---------------------Computing X Coordinate---------------------//
shifter shifter_x (
    .data_in(x_in),

    .sh_amt(5'h0),
    .select_function(select_function_pre[2:0]),
 
    .sum_out(x0p1),
    .carry_out(x0p2)
);

two_complementer two_complementer_y0p1 (
    .data_in(y0p1),
    .enable(~select_function_pre[3]),
    .data_out(y0p1_n)
);

two_complementer two_complementer_y0p2 (
    .data_in(y0p2),
    .enable(~select_function_pre[3]),
    .data_out(y0p2_n)
);

CSA_3to2_32bit CSA_X (
    .a_in(y0p1_n),
    .b_in(y0p2_n),
    .c_in(x_in),

    .sum_out(x_sum),
    .c_out(x_carry)
);

//---------------------Computing Y Coordinate---------------------//
shifter shifter_y (
    .data_in(y_in),

    .sh_amt(5'h0),
    .select_function(select_function_pre[2:0]),
 
    .sum_out(y0p1),
    .carry_out(y0p2)
);

two_complementer two_complementer_x0p1 (
    .data_in(x0p1),
    .enable(select_function_pre[3]),
    .data_out(x0p1_n)
);

two_complementer two_complementer_x0p2 (
    .data_in(x0p2),
    .enable(select_function_pre[3]),
    .data_out(x0p2_n)
);

CSA_3to2_32bit CSA_Y (
    .a_in(x0p1_n),
    .b_in(x0p2_n),
    .c_in(y_in),

    .sum_out(y_sum),
    .c_out(y_carry)
);

assign select_function_0 = select_function_pre[2:0];

endmodule