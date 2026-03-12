module partial_booth_multiplier(
    input logic [31:0] multiplicand_in,
    input logic [2:0] booth_encoder_in,
    input logic [5:0] ShAmt,

    output logic [63:0] partial_product_out
);

logic [1:0] encoded_num;
logic sub_ctrl;
logic [31:0] multiplicand_in_pre;
logic [31:0] partial_product_out_pre;
logic [63:0] partial_product_extended;

always_comb begin
    if(encoded_num[0])
        multiplicand_in_pre = multiplicand_in;
    else if(encoded_num[1])
        multiplicand_in_pre = multiplicand_in << 1;
    else 
        multiplicand_in_pre = 32'b0;
end

booth_encoder Booth_Encoder(
    .data_in(booth_encoder_in),
    .encoded_num(encoded_num),
    .sub_ctrl(sub_ctrl)
);

two_complementer Two_Complement(
    .data_in(multiplicand_in_pre),
    .enable(sub_ctrl),
    .data_out(partial_product_out_pre)
);

assign partial_product_extended = {{32{partial_product_out_pre[31]}}, partial_product_out_pre};

shift_left Shift_Left(
		.In(partial_product_extended),
		.ShAm(ShAmt),
		.OUT(partial_product_out)
);

endmodule



//=========================
//      Sub Module
//=========================

module booth_encoder(
    input logic [2:0] data_in,
    output logic [1:0] encoded_num,
    output logic sub_ctrl
);

assign sub_ctrl = data_in[2] & (~data_in[1] | ~data_in[0]);
assign encoded_num[1] = (~data_in[2] & data_in[1] & data_in[0]) | (data_in[2] & ~data_in[1] & ~data_in[0]);  
assign encoded_num[0] = (data_in[1] ^ data_in[0]);

endmodule