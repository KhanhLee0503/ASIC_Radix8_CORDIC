module range_checking(
    input logic [31:0] z_in,
    
    output logic eq_90_sign_sel,
    output logic eq_neg_90_sign_sel,
    output logic reverse,
    output logic [31:0] z_mapped
);

logic eq_90;
logic eq_neg_90;
logic eq_90_sign;
logic eq_neg_90_sign;
logic eq_180;
logic eq_neg_180;
logic eq_180_sign;
logic eq_neg_180_sign;
logic gt_90;
logic lt_neg_90;
logic lt_neg_90_sign;
logic gt_90_sign;

logic mux_select;
logic [31:0] z_mapped_pre;
logic [31:0] z_mapped_sub;

comparator_nbit #(.DATA_WIDTH(32)) Check_Lower(
    .data_in_1(z_in),
    .data_in_2(32'hFE6DE04B),   //Compare -90

    .o_eq(eq_neg_90),
    .o_gt(),
    .o_lt(lt_neg_90)
);

assign lt_neg_90_sign = (z_in[31]) ? lt_neg_90 : 1'b0;
assign eq_neg_90_sign = (z_in[31]) ? eq_neg_90 : 1'b0;

comparator_nbit #(.DATA_WIDTH(32)) Check_Higher(
    .data_in_1(z_in),
    .data_in_2(32'h01921FB5),   //Compare 90

    .o_eq(eq_90),
    .o_gt(gt_90),
    .o_lt()
);

assign gt_90_sign = (z_in[31]) ? 1'b0 : gt_90;
assign eq_90_sign = (z_in[31]) ? 1'b0 : eq_90;

assign mux_select = lt_neg_90_sign | gt_90_sign;

CLA_32bit add_sub_block(
    .a_in(z_in),
    .b_in(32'h03243f6b ^ {32{gt_90_sign}}),  //Adding, Sutracting 180 degree
    .c_in(gt_90_sign),

    .sum(z_mapped_pre),
    .c_out()
);

comparator_nbit #(.DATA_WIDTH(32)) Check_180(
    .data_in_1(z_in),
    .data_in_2(32'h03243f6b),   //Compare 180

    .o_eq(eq_180),
    .o_gt(),
    .o_lt()
);
assign eq_180_sign = (z_in[31]) ? 1'b0 : eq_180;

comparator_nbit #(.DATA_WIDTH(32)) Check_neg_180(
    .data_in_1(z_in),
    .data_in_2(32'hfcdbc095),   //Compare -180

    .o_eq(eq_neg_180),
    .o_gt(),
    .o_lt()
);
assign eq_neg_180_sign = (z_in[31]) ? eq_neg_180 : 1'b0;

assign z_mapped_sub = mux_select ? z_mapped_pre : z_in;
assign z_mapped = (eq_180_sign | eq_neg_180_sign | eq_neg_90_sign | eq_90_sign) ? 32'b0 : z_mapped_sub;
assign reverse = mux_select | eq_180_sign | eq_neg_180_sign;

assign eq_90_sign_sel = eq_90_sign;
assign eq_neg_90_sign_sel = eq_neg_90_sign;

endmodule