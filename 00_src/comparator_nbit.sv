module comparator_nbit #(DATA_WIDTH = 5)
(
    input logic [DATA_WIDTH-1:0] data_in_1,
    input logic [DATA_WIDTH-1:0] data_in_2,

    output logic o_eq,
    output logic o_gt,
    output logic o_lt
);


logic [DATA_WIDTH:0] cmp_eq_pre;
logic [DATA_WIDTH:0] cmp_gt_pre;
logic [DATA_WIDTH:0] cmp_lt_pre;

assign cmp_eq_pre[DATA_WIDTH] = 1'b1;
assign cmp_gt_pre[DATA_WIDTH] = 1'b0;
assign cmp_lt_pre[DATA_WIDTH] = 1'b0;

genvar i; 
generate
    for(i=0; i<DATA_WIDTH; i=i+1) begin
        comparator_1bit comparator(
            .data_in_1(data_in_1[i]),
            .data_in_2(data_in_2[i]),
            .i_eq(cmp_eq_pre[i+1]),
            .i_gt(cmp_gt_pre[i+1]),
            .i_lt(cmp_lt_pre[i+1]),
            .o_eq(cmp_eq_pre[i]),
            .o_gt(cmp_gt_pre[i]),
            .o_lt(cmp_lt_pre[i]) 
        );
    end
endgenerate

assign o_eq = cmp_eq_pre[0];
assign o_gt = cmp_gt_pre[0];    
assign o_lt = cmp_lt_pre[0];

endmodule


module comparator_1bit(
    input logic data_in_1,
    input logic data_in_2,

    input logic i_eq,
    input logic i_gt,
    input logic i_lt,

    output logic o_eq,
    output logic o_gt,
    output logic o_lt
);

assign o_eq = ~(data_in_1 ^ data_in_2) & i_eq;
assign o_lt = i_lt | (~data_in_1 & data_in_2 & i_eq);
assign o_gt = i_gt | (data_in_1 & ~data_in_2 & i_eq); 

endmodule
