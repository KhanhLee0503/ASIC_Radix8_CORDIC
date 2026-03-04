module comparator_zero(
    input logic [4:0] data_in,
    output logic [3:0] select_function
);

parameter DATA_WIDTH = 5;

parameter pos_1     = 5'b01_000;
parameter pos_0875  = 5'b00_111;
parameter pos_075   = 5'b00_110;
parameter pos_0375  = 5'b00_011;

parameter neg_1     = 5'b11_000;
parameter neg_0875  = 5'b11_001;
parameter neg_075   = 5'b11_010;
parameter neg_0375  = 5'b11_101;

//**Comparator_1 Signals**//
logic gt_1_pre;
logic lt_1_pre;
logic eq_1_pre;

logic sign_gt_1_pre;
logic sign_lt_1_pre;
logic sign_eq_1_pre;


//**Comparator_0875 Signals**//
logic gt_0875_pre;
logic lt_0875_pre;
logic eq_0875_pre;

logic sign_gt_0875_pre;
logic sign_lt_0875_pre;
logic sign_eq_0875_pre;


//**Comparator_075 Signals**//
logic gt_075_pre;
logic lt_075_pre;
logic eq_075_pre;

logic sign_gt_075_pre;
logic sign_lt_075_pre;
logic sign_eq_075_pre;


//**Comparator_0375 Signals**//
logic gt_0375_pre;
logic lt_0375_pre;
logic eq_0375_pre;

logic sign_gt_0375_pre;
logic sign_lt_0375_pre;
logic sign_eq_0375_pre;


//**Comparator_neg_1 Signals**//
logic gt_neg_1_pre;
logic lt_neg_1_pre;
logic eq_neg_1_pre;

logic sign_gt_neg_1_pre;
logic sign_lt_neg_1_pre;
logic sign_eq_neg_1_pre;


//**Comparator_neg_0875 Signals**//
logic gt_neg_0875_pre;
logic lt_neg_0875_pre;
logic eq_neg_0875_pre;

logic sign_gt_neg_0875_pre;
logic sign_lt_neg_0875_pre;
logic sign_eq_neg_0875_pre;


//**Comparator_neg_075 Signals**//
logic gt_neg_075_pre;
logic lt_neg_075_pre;
logic eq_neg_075_pre;

logic sign_gt_neg_075_pre;
logic sign_lt_neg_075_pre;  
logic sign_eq_neg_075_pre;


//**Comparator_neg_0375 Signals**//
logic gt_neg_0375_pre;
logic lt_neg_0375_pre;
logic eq_neg_0375_pre;

logic sign_gt_neg_0375_pre;
logic sign_lt_neg_0375_pre;
logic sign_eq_neg_0375_pre;


//**Selection Function Signals**//
logic select_function_4;
logic select_function_3;
logic select_function_2;
logic select_function_1;

logic select_function_neg_3;
logic select_function_neg_2;
logic select_function_neg_1;

logic select_function_0;

comparator_nbit #(DATA_WIDTH) cmp_1 (
    .data_in_1(data_in),
    .data_in_2(pos_1),
    .o_eq(eq_1_pre),
    .o_gt(gt_1_pre),
    .o_lt(lt_1_pre)
);

assign sign_gt_1_pre = (data_in[DATA_WIDTH-1]) ? 1'b0 : gt_1_pre;
assign sign_lt_1_pre = (data_in[DATA_WIDTH-1]) ? 1'b1 : lt_1_pre;
assign sign_eq_1_pre = (data_in[DATA_WIDTH-1]) ? 1'b0 : eq_1_pre;

comparator_nbit #(DATA_WIDTH) cmp_0875 (
    .data_in_1(data_in),
    .data_in_2(pos_0875),
    .o_eq(eq_0875_pre),
    .o_gt(gt_0875_pre),
    .o_lt(lt_0875_pre)
);
 
assign sign_gt_0875_pre = (data_in[DATA_WIDTH-1]) ? 1'b0 : gt_0875_pre;
assign sign_lt_0875_pre = (data_in[DATA_WIDTH-1]) ? 1'b1 : lt_0875_pre;
assign sign_eq_0875_pre = (data_in[DATA_WIDTH-1]) ? 1'b0 : eq_0875_pre;

   
comparator_nbit #(DATA_WIDTH) cmp_075 (
    .data_in_1(data_in),
    .data_in_2(pos_075),
    .o_eq(eq_075_pre),
    .o_gt(gt_075_pre),
    .o_lt(lt_075_pre)
);

assign sign_gt_075_pre = (data_in[DATA_WIDTH-1]) ? 1'b0 : gt_075_pre;
assign sign_lt_075_pre = (data_in[DATA_WIDTH-1]) ? 1'b1 : lt_075_pre;
assign sign_eq_075_pre = (data_in[DATA_WIDTH-1]) ? 1'b0 : eq_075_pre;


comparator_nbit #(DATA_WIDTH) cmp_0375 (
    .data_in_1(data_in),
    .data_in_2(pos_0375),
    .o_eq(eq_0375_pre),
    .o_gt(gt_0375_pre),
    .o_lt(lt_0375_pre)
);

assign sign_gt_0375_pre = (data_in[DATA_WIDTH-1]) ? 1'b0 : gt_0375_pre;
assign sign_lt_0375_pre = (data_in[DATA_WIDTH-1]) ? 1'b1 : lt_0375_pre;
assign sign_eq_0375_pre = (data_in[DATA_WIDTH-1]) ? 1'b0 : eq_0375_pre;


comparator_nbit #(DATA_WIDTH) cmp_neg_1 (
    .data_in_1(data_in),
    .data_in_2(neg_1),
    .o_eq(eq_neg_1_pre),
    .o_gt(gt_neg_1_pre),
    .o_lt(lt_neg_1_pre)
);

assign sign_gt_neg_1_pre = (data_in[DATA_WIDTH-1]) ? gt_neg_1_pre : 1'b1;
assign sign_lt_neg_1_pre = (data_in[DATA_WIDTH-1]) ? lt_neg_1_pre : 1'b0;
assign sign_eq_neg_1_pre = (data_in[DATA_WIDTH-1]) ? eq_neg_1_pre : 1'b0;


comparator_nbit #(DATA_WIDTH) cmp_neg_0875 (
    .data_in_1(data_in),
    .data_in_2(neg_0875),
    .o_eq(eq_neg_0875_pre),
    .o_gt(gt_neg_0875_pre),
    .o_lt(lt_neg_0875_pre)
);

assign sign_gt_neg_0875_pre = (data_in[DATA_WIDTH-1]) ? gt_neg_0875_pre : 1'b1;
assign sign_lt_neg_0875_pre = (data_in[DATA_WIDTH-1]) ? lt_neg_0875_pre : 1'b0;
assign sign_eq_neg_0875_pre = (data_in[DATA_WIDTH-1]) ? eq_neg_0875_pre : 1'b0;


comparator_nbit #(DATA_WIDTH) cmp_neg_075 (
    .data_in_1(data_in),
    .data_in_2(neg_075),
    .o_eq(eq_neg_075_pre),
    .o_gt(gt_neg_075_pre),
    .o_lt(lt_neg_075_pre)
);
    
assign sign_gt_neg_075_pre = (data_in[DATA_WIDTH-1]) ? gt_neg_075_pre : 1'b1;
assign sign_lt_neg_075_pre = (data_in[DATA_WIDTH-1]) ? lt_neg_075_pre : 1'b0;
assign sign_eq_neg_075_pre = (data_in[DATA_WIDTH-1]) ? eq_neg_075_pre : 1'b0;


comparator_nbit #(DATA_WIDTH) cmp_neg_0375 (
    .data_in_1(data_in),
    .data_in_2(neg_0375),
    .o_eq(eq_neg_0375_pre),
    .o_gt(gt_neg_0375_pre),
    .o_lt(lt_neg_0375_pre)
);

assign sign_gt_neg_0375_pre = (data_in[DATA_WIDTH-1]) ? gt_neg_0375_pre : 1'b1;
assign sign_lt_neg_0375_pre = (data_in[DATA_WIDTH-1]) ? lt_neg_0375_pre : 1'b0;
assign sign_eq_neg_0375_pre = (data_in[DATA_WIDTH-1]) ? eq_neg_0375_pre : 1'b0;


//**Selection Function Logic**//
assign select_function_4        = sign_gt_1_pre | sign_eq_1_pre;
assign select_function_3        = (sign_gt_0875_pre | sign_eq_0875_pre);
assign select_function_2        = (sign_gt_075_pre | sign_eq_075_pre);
assign select_function_1        = (sign_gt_0375_pre | sign_eq_0375_pre);

assign select_function_neg_3    = (sign_gt_neg_1_pre | sign_eq_neg_1_pre);
assign select_function_neg_2    = (sign_gt_neg_0875_pre | sign_eq_neg_0875_pre);
assign select_function_neg_1    = (sign_gt_neg_075_pre | sign_eq_neg_075_pre);
assign select_function_0        = (sign_gt_neg_0375_pre | sign_eq_neg_0375_pre);

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
