module two_iteration_test( 
    input logic [31:0] x_in,
    input logic [31:0] y_in,
    input logic [31:0] z_in,

    //X-Axis Format is FXP(32,24)
    //Y-Axis Format is FXP(32,24)
    //Angle Format is FXP(32,24)

    output logic [31:0] x_sum,
    output logic [31:0] x_carry,

    output logic [31:0] y_sum,
    output logic [31:0] y_carry,

    output logic [31:0] angle_sum,
    output logic [31:0] angle_carry
);

logic [31:0] angle_sum_pre;
logic [31:0] angle_carry_pre;

logic [31:0] x_sum_pre;
logic [31:0] x_carry_pre;

logic [31:0] y_sum_pre;
logic [31:0] y_carry_pre;

first_micro_rotation first_iteration(
    .x_in(x_in),
    .y_in(y_in),
    .z_in(z_in),

    .x_sum(x_sum_pre),
    .x_carry(x_carry_pre),

    .y_sum(y_sum_pre),
    .y_carry(y_carry_pre),

    .angle_sum(angle_sum_pre),
    .angle_carry(angle_carry_pre)
);

second_micro_rotation second_iteration(
   
    //Input Formats are the same as the output formats for each respective axis from the first micro-rotation module
  
    .x_sum_in(x_sum_pre),    //X-Axis Format is FXP(3,13)
    .x_carry_in(x_carry_pre),
   
    .y_sum_in(y_sum_pre), //Y-Axis Format is FXP(3,13)
    .y_carry_in(y_carry_pre),
   
    .z_sum_in(angle_sum_pre), //Angle Format is FXP(12,4)
    .z_carry_in(angle_carry_pre),
   
    //Output Formats are the same as the input formats for each respective axis 
 
    .x_sum_out(x_sum),
    .x_carry_out(x_carry),

    .y_sum_out(y_sum),
    .y_carry_out(y_carry),

    .z_sum_out(angle_sum),
    .z_carry_out(angle_carry)
);

endmodule