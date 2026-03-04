module seventh_micro_rotation(
   
    //Input Formats are the same as the output formats for each respective axis from the first micro-rotation module
  
    input logic [31:0] x_sum_in,    //X-Axis Format is FXP(32,24)
    input logic [31:0] x_carry_in,
   
    input logic [31:0] y_sum_in, //Y-Axis Format is FXP(32,24)
    input logic [31:0] y_carry_in,
   
    input logic [31:0] z_sum_in, //Angle Format is FXP(32,24)
    input logic [31:0] z_carry_in,
   
    //Output Formats are the same as the input formats for each respective axis 
 
    output logic [31:0] x_sum_out,
    output logic [31:0] x_carry_out,

    output logic [31:0] y_sum_out,
    output logic [31:0] y_carry_out,

    output logic [31:0] z_sum_out,
    output logic [31:0] z_carry_out
);
//--------------------Internal Signals--------------------//
//*** CLA Angle Signals ***//
logic [31:0] z_sum_n;
logic [31:0] angle_six;

//*** Comparator Signals ***//
logic [3:0] select_function;
logic [31:0] angle_six_pre;

//*** Shifter Signals ***//
logic [31:0] z_sum_out_pre;
logic [31:0] z_carry_out_pre;

//*** Angle Complement Signals ***//
logic [31:0] angle_six_n;

//*** X-Axis Shifter Signals ***//
logic [31:0] x_sum_p1;
logic [31:0] x_sum_p2;
logic [31:0] x_carry_p1;
logic [31:0] x_carry_p2;

//*** Y-Axis Shifter Signals ***//
logic [31:0] y_sum_p1;
logic [31:0] y_sum_p2;
logic [31:0] y_carry_p1;
logic [31:0] y_carry_p2;

//*** Y-Axis Complement Signals ***//
logic [31:0] y_sum_p1_n;
logic [31:0] y_sum_p2_n;
logic [31:0] y_carry_p1_n;
logic [31:0] y_carry_p2_n;


//*** X-Axis Complement Signals ***//
logic [31:0] x_sum_p1_n;
logic [31:0] x_sum_p2_n;
logic [31:0] x_carry_p1_n;
logic [31:0] x_carry_p2_n;
//--------------------Computing Angle of Rotation--------------------//
CLA_32bit Angle_Adder(
    .a_in(z_sum_in),
    .b_in(z_carry_in),
    .c_in(1'b0),

    .sum(angle_six),
    .c_out()
);

comparator_multi_iteration Comparator_six(
    .data_in(angle_six[26:23]),
    .select_function(select_function)
);

angle_table_six Angle_Table_Six(
    .select_function(select_function[2:0]),
    .angle_six(angle_six_pre)
);

two_complementer Two_Complementer_Angle (
    .data_in(angle_six_pre),
    .enable(~select_function[3]), // Negate the carry input
    .data_out(angle_six_n)
);

CSA_3to2_32bit CSA_3to2(
    .a_in(angle_six_n),
    .b_in(z_sum_in),
    .c_in(z_carry_in),

    .sum_out(z_sum_out_pre),
    .c_out(z_carry_out_pre)
);

barrel_left_shifter_32bit Left_Shift_Sum(
    .data_in(z_sum_out_pre),
    .sh_amt(5'h3),           //The number of positions to shift

    .data_out(z_sum_out)
);

barrel_left_shifter_32bit Left_Shift_Carry(
    .data_in(z_carry_out_pre),
    .sh_amt(5'h3),           //The number of positions to shift

    .data_out(z_carry_out)
);

//---------------------Computing X Coordinate---------------------//
shifter Shifter_X_Sum (
    .data_in(x_sum_in),

    .sh_amt(5'h15),
    .select_function(select_function[2:0]),
 
    .sum_out(x_sum_p1),
    .carry_out(x_sum_p2)
);

shifter Shifter_X_Carry (
    .data_in(x_carry_in),

    .sh_amt(5'h15),
    .select_function(select_function[2:0]),
 
    .sum_out(x_carry_p1),
    .carry_out(x_carry_p2)
);

two_complementer Two_Complementer_X_Sum_P1 (
    .data_in(x_sum_p1),
    .enable(select_function[3]), // Negate the carry input 
    .data_out(x_sum_p1_n)
);

two_complementer Two_Complementer_X_Sum_P2 (
    .data_in(x_sum_p2),
    .enable(select_function[3]), // Negate the carry input 
    .data_out(x_sum_p2_n)
);

two_complementer Two_Complementer_X_Carry_P1 (
    .data_in(x_carry_p1),
    .enable(select_function[3]), // Negate the carry input 
    .data_out(x_carry_p1_n)
);

two_complementer Two_Complementer_X_Carry_P2 (
    .data_in(x_carry_p2),
    .enable(select_function[3]), // Negate the carry input 
    .data_out(x_carry_p2_n)
);


CSA_6to2_32bit CSA_6to2_X(
    .x1_in(x_sum_in),
    .x2_in(x_carry_in),
    .x3_in(y_sum_p1_n),
    .x4_in(y_sum_p2_n),
    .x5_in(y_carry_p1_n),
    .x6_in(y_carry_p2_n),

    .sum_out(x_sum_out),
    .c_out(x_carry_out)
);
//---------------------Computing Y Coordinate---------------------//
shifter Shifter_Y_Sum (
    .data_in(y_sum_in),

    .sh_amt(5'h15),
    .select_function(select_function[2:0]),
 
    .sum_out(y_sum_p1),
    .carry_out(y_sum_p2)
);

shifter Shifter_Y_Carry (
    .data_in(y_carry_in),

    .sh_amt(5'h15),
    .select_function(select_function[2:0]),
 
    .sum_out(y_carry_p1),
    .carry_out(y_carry_p2)
);

two_complementer Two_Complementer_Y_Sum_P1 (
    .data_in(y_sum_p1),
    .enable(~select_function[3]), // Negate the carry input 
    .data_out(y_sum_p1_n)
);


two_complementer Two_Complementer_Y_Sum_P2 (
    .data_in(y_sum_p2),
    .enable(~select_function[3]), // Negate the carry input
    .data_out(y_sum_p2_n)
);


two_complementer Two_Complementer_Y_Carry_P1 (
    .data_in(y_carry_p1),
    .enable(~select_function[3]), // Negate the carry input
    .data_out(y_carry_p1_n)
);


two_complementer Two_Complementer_Y_Carry_P2 (
    .data_in(y_carry_p2),
    .enable(~select_function[3]), // Negate the carry input
    .data_out(y_carry_p2_n)
); 
     

CSA_6to2_32bit CSA_6to2_Y(
    .x1_in(y_sum_in),
    .x2_in(y_carry_in),
    .x3_in(x_sum_p1_n),
    .x4_in(x_sum_p2_n),
    .x5_in(x_carry_p1_n),
    .x6_in(x_carry_p2_n),

    .sum_out(y_sum_out),
    .c_out(y_carry_out)
);

endmodule