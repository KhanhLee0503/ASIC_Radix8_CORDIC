module radix_8_cordic_top(
    input logic clk,
    input logic rst_n,

    input logic [31:0] x_in,    //X-Axis Format is FXP(32,24)
    input logic [31:0] y_in,    //Y-Axis Format is FXP(32,24)
    input logic [31:0] z_in,    //Angle Format is FXP(32,24)

    output logic [31:0] x_out,
    output logic [31:0] y_out,

    output logic [31:0] angle_out
);

//===============================================
//              Internal Signals
//==============================================
//---------------Pre Stage Signals----------------
logic [31:0] z_mapped; 
logic [31:0] x_in_pre;
logic [31:0] y_in_pre;
logic reverse;
logic eq_90;
logic eq_neg_90;
logic [31:0] x_in_sub;
logic [31:0] y_in_sub;

//---------------First Stage Signals--------------
logic [31:0] x_sum_1to2;
logic [31:0] x_carry_1to2;

logic [31:0] y_sum_1to2;
logic [31:0] y_carry_1to2;

logic [31:0] angle_sum_1to2;
logic [31:0] angle_carry_1to2;

//---------------Second Stage Signals--------------
logic [31:0] x_sum_2to3;
logic [31:0] x_carry_2to3;

logic [31:0] y_sum_2to3;
logic [31:0] y_carry_2to3;

logic [31:0] angle_sum_2to3;
logic [31:0] angle_carry_2to3;

//---------------Third Stage Signals--------------
logic [31:0] x_sum_3to4;
logic [31:0] x_carry_3to4;

logic [31:0] y_sum_3to4;
logic [31:0] y_carry_3to4;

logic [31:0] angle_sum_3to4;
logic [31:0] angle_carry_3to4;

//---------------Fourth Stage Signals--------------
logic [31:0] x_sum_4to5;
logic [31:0] x_carry_4to5;

logic [31:0] y_sum_4to5;
logic [31:0] y_carry_4to5;

logic [31:0] angle_sum_4to5;
logic [31:0] angle_carry_4to5;

//---------------Fifth Stage Signals--------------
logic [31:0] x_sum_5to6;
logic [31:0] x_carry_5to6;

logic [31:0] y_sum_5to6;
logic [31:0] y_carry_5to6;

logic [31:0] angle_sum_5to6;
logic [31:0] angle_carry_5to6;

//---------------Sixth Stage Signals--------------
logic [31:0] x_sum_6to7;
logic [31:0] x_carry_6to7;

logic [31:0] y_sum_6to7;
logic [31:0] y_carry_6to7;

logic [31:0] angle_sum_6to7;
logic [31:0] angle_carry_6to7;

//---------------Seventh Stage Signals--------------
logic [31:0] x_sum_7to8;
logic [31:0] x_carry_7to8;

logic [31:0] y_sum_7to8;
logic [31:0] y_carry_7to8;

logic [31:0] angle_sum_7to8;
logic [31:0] angle_carry_7to8;

//-------------Scale Factor Signals--------------------
logic [31:0] scale_factor;
logic [2:0] selection_function_0;
logic [2:0] selection_function_1;
logic [2:0] selection_function_2;

logic [31:0] x_sum;
logic [31:0] x_carry;
logic [31:0] y_sum;
logic [31:0] y_carry;
logic [31:0] angle_sum;
logic [31:0] angle_carry;

logic [63:0] x_out_product;
logic [63:0] y_out_product;

logic [31:0] x_out_pre;
logic [31:0] y_out_pre;

reg [95:0] stage_0_pre;
reg [194:0] stage_0_1;
reg [194:0] stage_1_2;
reg [194:0] stage_2_3;
reg [191:0] stage_3_4;
reg [191:0] stage_4_5;
reg [191:0] stage_5_6;
reg [191:0] stage_6_7;

//-----------------Delay Registers--------------------
// Delay register for select funtion (5 cycles)
logic [31:0] scale_factor_delay [0:4];


//===============================================
//              Internal Signals
//==============================================
//--------------Register Stage_0_pre---------------------
always_ff@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        stage_0_pre <= 96'b0;  
    else
        stage_0_pre <= {x_in_sub, y_in_sub, z_mapped};
end


//--------------Register Stage_0_1---------------------
always_ff@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        stage_0_1 <= 195'd0;  
    else
        stage_0_1 <= {selection_function_0, angle_carry_1to2, angle_sum_1to2, y_carry_1to2, y_sum_1to2, x_carry_1to2, x_sum_1to2};
end


//--------------Register Stage_1_2---------------------
always_ff@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        stage_1_2 <= 195'd0;  
    else
        stage_1_2 <= {selection_function_1, angle_carry_2to3, angle_sum_2to3, y_carry_2to3, y_sum_2to3, x_carry_2to3, x_sum_2to3};
end


//--------------Register Stage_2_3---------------------
always_ff@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        stage_2_3 <= 195'd0;  
    else
        stage_2_3 <= {selection_function_2, angle_carry_3to4, angle_sum_3to4, y_carry_3to4, y_sum_3to4, x_carry_3to4, x_sum_3to4};
end


//--------------Register Stage_3_4---------------------
always_ff@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        stage_3_4 <= 192'd0;  
    else
        stage_3_4 <= {angle_carry_3to4, angle_sum_3to4, y_carry_3to4, y_sum_3to4, x_carry_3to4, x_sum_3to4};
end


//--------------Register Stage_4_5---------------------
always_ff@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        stage_4_5 <= 192'd0;  
    else
        stage_4_5 <= {angle_carry_4to5, angle_sum_4to5, y_carry_4to5, y_sum_4to5, x_carry_4to5, x_sum_4to5};
end


//--------------Register Stage_5_6---------------------
always_ff@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        stage_5_6 <= 192'd0;  
    else
        stage_5_6 <= {angle_carry_5to6, angle_sum_5to6, y_carry_5to6, y_sum_5to6, x_carry_5to6, x_sum_5to6};
end


//--------------Register Stage_6_7---------------------
always_ff@(posedge clk or negedge rst_n) begin
    if(!rst_n)
        stage_6_7 <= 192'd0;  
    else
        stage_6_7 <= {angle_carry_6to7, angle_sum_6to7, y_carry_6to7, y_sum_6to7, x_carry_6to7, x_sum_6to7};
end


//===============================================
//                  Data Path
//==============================================
range_checking Range_Checking(
       .z_in(z_in),
       .eq_90_sign_sel(eq_90),
       .eq_neg_90_sign_sel(eq_neg_90),
       .reverse(reverse),
       .z_mapped(z_mapped)
);

two_complementer reverse_X (
    .data_in(x_in),
    .enable(reverse | eq_neg_90), 
    .data_out(x_in_pre)
);

two_complementer reverse_Y (
    .data_in(y_in),
    .enable(reverse | eq_90), 
    .data_out(y_in_pre)
);

assign x_in_sub = (eq_90 | eq_neg_90) ? y_in_pre : x_in_pre;
assign y_in_sub = (eq_90 | eq_neg_90) ? x_in_pre : y_in_pre;


first_micro_rotation first_iteration(
    .x_in(stage_0_pre[95:64]),
    .y_in(stage_0_pre[63:32]),
    .z_in(stage_0_pre[31:0]),

    .x_sum(x_sum_1to2),
    .x_carry(x_carry_1to2),

    .y_sum(y_sum_1to2),
    .y_carry(y_carry_1to2),

    .angle_sum(angle_sum_1to2),
    .angle_carry(angle_carry_1to2),

    .select_function_0(selection_function_0)
);

/*
assign x_out = x_sum_1to2 + x_carry_1to2;
assign y_out = y_sum_1to2 + y_carry_1to2;
assign angle_out = angle_sum_1to2 + angle_carry_1to2;
*/

second_micro_rotation second_iteration(
   
    //Input Formats are the same as the output formats for each respective axis from the first micro-rotation module
  
    .x_sum_in(stage_0_1[31:0]),    //X-Axis Format is FXP(32,24)
    .x_carry_in(stage_0_1[63:32]),
   
    .y_sum_in(stage_0_1[95:64]), //Y-Axis Format is FXP(32,24)
    .y_carry_in(stage_0_1[127:96]),
   
    .z_sum_in(stage_0_1[159:128]), //Angle Format is FXP(32,24)
    .z_carry_in(stage_0_1[191:160]),
   
    //Output Formats are the same as the input formats for each respective axis 
 
    .x_sum_out(x_sum_2to3),
    .x_carry_out(x_carry_2to3),

    .y_sum_out(y_sum_2to3),
    .y_carry_out(y_carry_2to3),

    .z_sum_out(angle_sum_2to3),
    .z_carry_out(angle_carry_2to3),

    .select_function_1(selection_function_1)    
);

/*
assign x_out = x_sum_2to3 + x_carry_2to3;
assign y_out = y_sum_2to3 + y_carry_2to3;
assign angle_out = angle_sum_2to3 + angle_carry_2to3;
*/


third_micro_rotation third_iteration(
   
    //Input Formats are the same as the output formats for each respective axis from the first micro-rotation module
  
    .x_sum_in(stage_1_2[31:0]),    //X-Axis Format is FXP(32,24)
    .x_carry_in(stage_1_2[63:32]),
   
    .y_sum_in(stage_1_2[95:64]), //Y-Axis Format is FXP(32,24)
    .y_carry_in(stage_1_2[127:96]),
   
    .z_sum_in(stage_1_2[159:128]), //Angle Format is FXP(32,24)
    .z_carry_in(stage_1_2[191:160]),
   
    //Output Formats are the same as the input formats for each respective axis 
 
    .x_sum_out(x_sum_3to4),
    .x_carry_out(x_carry_3to4),

    .y_sum_out(y_sum_3to4),
    .y_carry_out(y_carry_3to4),

    .z_sum_out(angle_sum_3to4),
    .z_carry_out(angle_carry_3to4),

    .select_function_2(selection_function_2)
);
/*
assign x_out = x_sum_3to4 + x_carry_3to4;
assign y_out = y_sum_3to4 + y_carry_3to4;
assign angle_out = angle_sum_3to4 + angle_carry_3to4;
*/
// =========================================================================
// MICRO-ROTATION STAGES (4 TO 8)
// =========================================================================

fourth_micro_rotation fourth_iteration(
    .x_sum_in   (stage_2_3[31:0]), 
    .x_carry_in (stage_2_3[63:32]),
    .y_sum_in   (stage_2_3[95:64]), 
    .y_carry_in (stage_2_3[127:96]),
    .z_sum_in   (stage_2_3[159:128]), 
    .z_carry_in (stage_2_3[191:160]),
    
    .x_sum_out  (x_sum_4to5),
    .x_carry_out(x_carry_4to5),
    .y_sum_out  (y_sum_4to5),
    .y_carry_out(y_carry_4to5),
    .z_sum_out  (angle_sum_4to5),
    .z_carry_out(angle_carry_4to5)
);

/*
assign x_out = x_sum_4to5 + x_carry_4to5;
assign y_out = y_sum_4to5 + y_carry_4to5;
assign angle_out = angle_sum_4to5 + angle_carry_4to5;
*/

fifth_micro_rotation fifth_iteration(
    .x_sum_in   (stage_3_4[31:0]), 
    .x_carry_in (stage_3_4[63:32]),
    .y_sum_in   (stage_3_4[95:64]), 
    .y_carry_in (stage_3_4[127:96]),
    .z_sum_in   (stage_3_4[159:128]), 
    .z_carry_in (stage_3_4[191:160]),
    
    .x_sum_out  (x_sum_5to6),
    .x_carry_out(x_carry_5to6),
    .y_sum_out  (y_sum_5to6),
    .y_carry_out(y_carry_5to6),
    .z_sum_out  (angle_sum_5to6),
    .z_carry_out(angle_carry_5to6)
);

/*
assign x_out = x_sum_5to6 + x_carry_5to6;
assign y_out = y_sum_5to6 + y_carry_5to6;
assign angle_out = angle_sum_5to6 + angle_carry_5to6;
*/

sixth_micro_rotation sixth_iteration(
    .x_sum_in   (stage_4_5[31:0]), 
    .x_carry_in (stage_4_5[63:32]),
    .y_sum_in   (stage_4_5[95:64]), 
    .y_carry_in (stage_4_5[127:96]),
    .z_sum_in   (stage_4_5[159:128]), 
    .z_carry_in (stage_4_5[191:160]),
    
    .x_sum_out  (x_sum_6to7),
    .x_carry_out(x_carry_6to7),
    .y_sum_out  (y_sum_6to7),
    .y_carry_out(y_carry_6to7),
    .z_sum_out  (angle_sum_6to7),
    .z_carry_out(angle_carry_6to7)
);

/*
assign x_out = x_sum_6to7 + x_carry_6to7;
assign y_out = y_sum_6to7 + y_carry_6to7;
assign angle_out = angle_sum_6to7 + angle_carry_6to7;
*/

seventh_micro_rotation seventh_iteration(
    .x_sum_in   (stage_5_6[31:0]), 
    .x_carry_in (stage_5_6[63:32]),
    .y_sum_in   (stage_5_6[95:64]), 
    .y_carry_in (stage_5_6[127:96]),
    .z_sum_in   (stage_5_6[159:128]), 
    .z_carry_in (stage_5_6[191:160]),
    
    .x_sum_out  (x_sum_7to8),
    .x_carry_out(x_carry_7to8),
    .y_sum_out  (y_sum_7to8),
    .y_carry_out(y_carry_7to8),
    .z_sum_out  (angle_sum_7to8),
    .z_carry_out(angle_carry_7to8)
);

/*
assign x_out = x_sum_7to8 + x_carry_7to8;
assign y_out = y_sum_7to8 + y_carry_7to8;
assign angle_out = angle_sum_7to8 + angle_carry_7to8;
*/

eighth_micro_rotation eighth_iteration(
    .x_sum_in   (stage_6_7[31:0]), 
    .x_carry_in (stage_6_7[63:32]),
    .y_sum_in   (stage_6_7[95:64]), 
    .y_carry_in (stage_6_7[127:96]),
    .z_sum_in   (stage_6_7[159:128]), 
    .z_carry_in (stage_6_7[191:160]),
    
    .x_sum_out  (x_sum),
    .x_carry_out(x_carry),
    .y_sum_out  (y_sum),
    .y_carry_out(y_carry),
    .z_sum_out  (angle_sum),
    .z_carry_out(angle_carry)
);

CLA_32bit CLA_x_out(
    .a_in(x_sum),
    .b_in(x_carry),
    .c_in(1'b0),

    .sum(x_out_pre),
    .c_out()
);

CLA_32bit CLA_y_out(
    .a_in(y_sum),
    .b_in(y_carry),
    .c_in(1'b0),

    .sum(y_out_pre),
    .c_out()
);

CLA_32bit CLA_angle_out(
    .a_in(angle_sum),
    .b_in(angle_carry),
    .c_in(1'b0),

    .sum(angle_out),
    .c_out()
);


scale_factor_LUT Scale_Factor_LUT(
    .select_function_0(stage_0_1[194:192]),
    .select_function_1(stage_1_2[194:192]),
    .select_function_2(stage_2_3[194:192]),
    .scale_factor_comp(scale_factor)
);

always_ff @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        scale_factor_delay[0] <= 32'd0;
        scale_factor_delay[1] <= 32'd0;
        scale_factor_delay[2] <= 32'd0;
        scale_factor_delay[3] <= 32'd0;
        scale_factor_delay[4] <= 32'd0;
    end else begin
        scale_factor_delay[0] <= scale_factor;          // Stage 3 -> 4
        scale_factor_delay[1] <= scale_factor_delay[0]; // Stage 4 -> 5
        scale_factor_delay[2] <= scale_factor_delay[1]; // Stage 5 -> 6
        scale_factor_delay[3] <= scale_factor_delay[2]; // Stage 6 -> 7
        scale_factor_delay[4] <= scale_factor_delay[3]; // Stage 7 -> 8 (Đồng bộ với x_out_pre)
    end
end

booth_multiplier_32bit scale_factor_X(
    .multiplicand_in(x_out_pre),
    .multiplier_in(scale_factor_delay[4]),

    .product_out(x_out_product)
);

assign x_out = x_out_product[55:24];

booth_multiplier_32bit scale_factor_Y(
    .multiplicand_in(y_out_pre),
    .multiplier_in(scale_factor_delay[4]),

    .product_out(y_out_product)
);

assign y_out = y_out_product[55:24];


endmodule