module comparator_multi_iteration #(parameter DATA_WIDTH = 4)
(
    input logic [3:0] data_in,
    output logic [3:0] select_function 
);

parameter VAL_THREE_POINT_FIVE      = 4'b011_1; //FXP(3,1)
parameter VAL_TWO_POINT_FIVE        = 4'b010_1; //FXP(3,1)
parameter VAL_ONE_POINT_FIVE        = 4'b001_1; //FXP(3,1)
parameter VAL_ZERO_POINT_FIVE       = 4'b000_1; //FXP(3,1)
parameter VAL_NEG_ZERO_POINT_FIVE   = 4'b111_1; //FXP(3,1)
parameter VAL_NEG_ONE_POINT_FIVE    = 4'b110_1; //FXP(3,1)
parameter VAL_NEG_TWO_POINT_FIVE    = 4'b101_1; //FXP(3,1)
parameter VAL_NEG_THREE_POINT_FIVE  = 4'b100_1; //FXP(3,1)

logic eq_three_point_five;
logic gt_three_point_five;
logic lt_three_point_five;

logic eq_two_point_five;
logic gt_two_point_five;
logic lt_two_point_five;

logic eq_one_point_five;
logic gt_one_point_five;
logic lt_one_point_five;

logic eq_zero_point_five;
logic gt_zero_point_five;
logic lt_zero_point_five;

logic eq_neg_zero_point_five;
logic gt_neg_zero_point_five;
logic lt_neg_zero_point_five;

logic eq_neg_one_point_five;
logic gt_neg_one_point_five;
logic lt_neg_one_point_five;

logic eq_neg_two_point_five;
logic gt_neg_two_point_five;
logic lt_neg_two_point_five;

logic eq_neg_three_point_five;
logic gt_neg_three_point_five;
logic lt_neg_three_point_five;

//***Sign Compare Signals***/
logic sign_eq_three_point_five;
logic sign_gt_three_point_five;
logic sign_lt_three_point_five;

logic sign_eq_two_point_five;
logic sign_gt_two_point_five;
logic sign_lt_two_point_five;

logic sign_eq_one_point_five;
logic sign_gt_one_point_five;
logic sign_lt_one_point_five;

logic sign_eq_zero_point_five;
logic sign_gt_zero_point_five;
logic sign_lt_zero_point_five;

logic sign_eq_neg_zero_point_five;
logic sign_gt_neg_zero_point_five;
logic sign_lt_neg_zero_point_five;

logic sign_eq_neg_one_point_five;
logic sign_gt_neg_one_point_five;
logic sign_lt_neg_one_point_five;

logic sign_eq_neg_two_point_five;
logic sign_gt_neg_two_point_five;
logic sign_lt_neg_two_point_five;

logic sign_eq_neg_three_point_five;
logic sign_gt_neg_three_point_five;
logic sign_lt_neg_three_point_five;

//**Selection Function Logic**//
logic select_function_4;
logic select_function_3;
logic select_function_2;            
logic select_function_1;
logic select_function_0;
logic select_function_neg_3;
logic select_function_neg_2;
logic select_function_neg_1;



comparator_nbit #(DATA_WIDTH) cmp_three_point_five (
    .data_in_1(data_in),
    .data_in_2(VAL_THREE_POINT_FIVE),
    .o_eq(eq_three_point_five),
    .o_gt(gt_three_point_five),
    .o_lt(lt_three_point_five)
);

assign sign_eq_three_point_five = (data_in[DATA_WIDTH-1]) ? 1'b0 : eq_three_point_five;
assign sign_gt_three_point_five = (data_in[DATA_WIDTH-1]) ? 1'b0 : gt_three_point_five;
assign sign_lt_three_point_five = (data_in[DATA_WIDTH-1]) ? 1'b1 : lt_three_point_five;

comparator_nbit #(DATA_WIDTH) cmp_two_point_five (
    .data_in_1(data_in),
    .data_in_2(VAL_TWO_POINT_FIVE),
    .o_eq(eq_two_point_five),
    .o_gt(gt_two_point_five),
    .o_lt(lt_two_point_five)
);

assign sign_eq_two_point_five = (data_in[DATA_WIDTH-1]) ? 1'b0 : eq_two_point_five;
assign sign_gt_two_point_five = (data_in[DATA_WIDTH-1]) ? 1'b0 : gt_two_point_five;
assign sign_lt_two_point_five = (data_in[DATA_WIDTH-1]) ? 1'b1 : lt_two_point_five;

comparator_nbit #(DATA_WIDTH) cmp_one_point_five (
    .data_in_1(data_in),
    .data_in_2(VAL_ONE_POINT_FIVE),
    .o_eq(eq_one_point_five),
    .o_gt(gt_one_point_five),
    .o_lt(lt_one_point_five)
);

assign sign_eq_one_point_five = (data_in[DATA_WIDTH-1]) ? 1'b0 : eq_one_point_five;
assign sign_gt_one_point_five = (data_in[DATA_WIDTH-1]) ? 1'b0 : gt_one_point_five;
assign sign_lt_one_point_five = (data_in[DATA_WIDTH-1]) ? 1'b1 : lt_one_point_five;



comparator_nbit #(DATA_WIDTH) cmp_zero_point_five (
    .data_in_1(data_in),
    .data_in_2(VAL_ZERO_POINT_FIVE),
    .o_eq(eq_zero_point_five),
    .o_gt(gt_zero_point_five),
    .o_lt(lt_zero_point_five)
);

assign sign_eq_zero_point_five = (data_in[DATA_WIDTH-1]) ? 1'b0 : eq_zero_point_five;
assign sign_gt_zero_point_five = (data_in[DATA_WIDTH-1]) ? 1'b0 : gt_zero_point_five;
assign sign_lt_zero_point_five = (data_in[DATA_WIDTH-1]) ? 1'b1 : lt_zero_point_five;




comparator_nbit #(DATA_WIDTH) cmp_neg_zero_point_five (
    .data_in_1(data_in),
    .data_in_2(VAL_NEG_ZERO_POINT_FIVE),
    .o_eq(eq_neg_zero_point_five),
    .o_gt(gt_neg_zero_point_five),
    .o_lt(lt_neg_zero_point_five)
);

assign sign_gt_neg_zero_point_five = (data_in[DATA_WIDTH-1]) ? gt_neg_zero_point_five : 1'b1;
assign sign_lt_neg_zero_point_five = (data_in[DATA_WIDTH-1]) ? lt_neg_zero_point_five : 1'b0;
assign sign_eq_neg_zero_point_five = (data_in[DATA_WIDTH-1]) ? eq_neg_zero_point_five : 1'b0;

comparator_nbit #(DATA_WIDTH) cmp_neg_one_point_five (
    .data_in_1(data_in),
    .data_in_2(VAL_NEG_ONE_POINT_FIVE),
    .o_eq(eq_neg_one_point_five),
    .o_gt(gt_neg_one_point_five),
    .o_lt(lt_neg_one_point_five)
);

assign sign_gt_neg_one_point_five = (data_in[DATA_WIDTH-1]) ? gt_neg_one_point_five : 1'b1;
assign sign_lt_neg_one_point_five = (data_in[DATA_WIDTH-1]) ? lt_neg_one_point_five : 1'b0;
assign sign_eq_neg_one_point_five = (data_in[DATA_WIDTH-1]) ? eq_neg_one_point_five : 1'b0;


comparator_nbit #(DATA_WIDTH) cmp_neg_two_point_five (
    .data_in_1(data_in),
    .data_in_2(VAL_NEG_TWO_POINT_FIVE),
    .o_eq(eq_neg_two_point_five),
    .o_gt(gt_neg_two_point_five),
    .o_lt(lt_neg_two_point_five)
);

assign sign_gt_neg_two_point_five = (data_in[DATA_WIDTH-1]) ? gt_neg_two_point_five : 1'b1;
assign sign_lt_neg_two_point_five = (data_in[DATA_WIDTH-1]) ? lt_neg_two_point_five : 1'b0;
assign sign_eq_neg_two_point_five = (data_in[DATA_WIDTH-1]) ? eq_neg_two_point_five : 1'b0;


comparator_nbit #(DATA_WIDTH) cmp_neg_three_point_five (
    .data_in_1(data_in),
    .data_in_2(VAL_NEG_THREE_POINT_FIVE),
    .o_eq(eq_neg_three_point_five),
    .o_gt(gt_neg_three_point_five),
    .o_lt(lt_neg_three_point_five)
);

assign sign_gt_neg_three_point_five = (data_in[DATA_WIDTH-1]) ? gt_neg_three_point_five : 1'b1;
assign sign_lt_neg_three_point_five = (data_in[DATA_WIDTH-1]) ? lt_neg_three_point_five : 1'b0;
assign sign_eq_neg_three_point_five = (data_in[DATA_WIDTH-1]) ? eq_neg_three_point_five : 1'b0;

//**Selection Function Logic**//
assign select_function_4        = sign_gt_three_point_five | sign_eq_three_point_five;
assign select_function_3        = (sign_gt_two_point_five | sign_eq_two_point_five);
assign select_function_2        = (sign_gt_one_point_five | sign_eq_one_point_five);
assign select_function_1        = (sign_gt_zero_point_five | sign_eq_zero_point_five);

assign select_function_neg_3    = (sign_gt_neg_three_point_five | sign_eq_neg_three_point_five);
assign select_function_neg_2    = (sign_gt_neg_two_point_five | sign_eq_neg_two_point_five);
assign select_function_neg_1    = (sign_gt_neg_one_point_five | sign_eq_neg_one_point_five);
assign select_function_0        = (sign_gt_neg_zero_point_five | sign_eq_neg_zero_point_five);


always_comb begin
    if(select_function_4)
        select_function = 4'b0100;
    else if(select_function_3)
        select_function = 4'b0011;
    else if(select_function_2)
        select_function = 4'b0010;
    else if(select_function_1)
        select_function = 4'b0001;
    else if(select_function_0)
        select_function = 4'b0000;   
    else if(select_function_neg_1)
        select_function = 4'b1_001;
    else if(select_function_neg_2)
        select_function = 4'b1_010;
    else if(select_function_neg_3)
        select_function = 4'b1_011;
    else
        select_function = 4'b1_100;
end    


endmodule