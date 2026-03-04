module partial_product_gen(
    input logic [7:0] scale_factor,
    input logic [31:0] data_in,

    output logic [31:0] partial_1,
    output logic [31:0] partial_2,
    output logic [31:0] partial_3,
    output logic [31:0] partial_4,
    output logic [31:0] partial_5,
    output logic [31:0] partial_6,
    output logic [31:0] partial_7,
    output logic [31:0] partial_8
   
);

assign partial_1 = scale_factor[7] ? {data_in[31],data_in[31:1]} : 32'b0;
assign partial_2 = scale_factor[6] ? {{2{data_in[31]}},data_in[31:2]} : 32'b0;
assign partial_3 = scale_factor[5] ? {{3{data_in[31]}},data_in[31:3]} : 32'b0;
assign partial_4 = scale_factor[4] ? {{4{data_in[31]}},data_in[31:4]} : 32'b0;
assign partial_5 = scale_factor[3] ? {{5{data_in[31]}},data_in[31:5]} : 32'b0;
assign partial_6 = scale_factor[2] ? {{6{data_in[31]}},data_in[31:6]} : 32'b0;
assign partial_7 = scale_factor[1] ? {{7{data_in[31]}},data_in[31:7]} : 32'b0;
assign partial_8 = scale_factor[0] ? {{8{data_in[31]}},data_in[31:8]} : 32'b0;

endmodule