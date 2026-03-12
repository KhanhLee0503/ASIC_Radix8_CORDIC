module booth_multiplier_32bit(
    input logic [31:0] multiplicand_in,
    input logic [31:0] multiplier_in,

    output logic [63:0] product_out
);

logic [32:0] multiplier_in_extended;
logic [63:0] partial_product_0;
logic [63:0] partial_product_1;
logic [63:0] partial_product_2;
logic [63:0] partial_product_3;
logic [63:0] partial_product_4;
logic [63:0] partial_product_5;
logic [63:0] partial_product_6;
logic [63:0] partial_product_7;
logic [63:0] partial_product_8;
logic [63:0] partial_product_9;
logic [63:0] partial_product_10;
logic [63:0] partial_product_11;
logic [63:0] partial_product_12;
logic [63:0] partial_product_13;
logic [63:0] partial_product_14;
logic [63:0] partial_product_15;


logic [63:0] adder_1_out;
logic [63:0] adder_2_out;
logic [63:0] adder_3_out;
logic [63:0] adder_4_out;
logic [63:0] adder_5_out;
logic [63:0] adder_6_out;
logic [63:0] adder_7_out;
logic [63:0] adder_8_out;

logic [63:0] adder_9_out;
logic [63:0] adder_10_out;
logic [63:0] adder_11_out;
logic [63:0] adder_12_out;

logic [63:0] adder_13_out;
logic [63:0] adder_14_out;
logic [63:0] adder_15_out;

assign multiplier_in_extended = {multiplier_in,1'b0};

partial_booth_multiplier Partial_Product_0( .multiplicand_in(multiplicand_in), .booth_encoder_in(multiplier_in_extended[2:0]), .ShAmt(6'd0), .partial_product_out(partial_product_0) );
partial_booth_multiplier Partial_Product_1( .multiplicand_in(multiplicand_in), .booth_encoder_in(multiplier_in_extended[4:2]), .ShAmt(6'd2), .partial_product_out(partial_product_1) );
partial_booth_multiplier Partial_Product_2( .multiplicand_in(multiplicand_in), .booth_encoder_in(multiplier_in_extended[6:4]), .ShAmt(6'd4), .partial_product_out(partial_product_2) );
partial_booth_multiplier Partial_Product_3( .multiplicand_in(multiplicand_in), .booth_encoder_in(multiplier_in_extended[8:6]), .ShAmt(6'd6), .partial_product_out(partial_product_3) );
partial_booth_multiplier Partial_Product_4( .multiplicand_in(multiplicand_in), .booth_encoder_in(multiplier_in_extended[10:8]), .ShAmt(6'd8), .partial_product_out(partial_product_4) );
partial_booth_multiplier Partial_Product_5( .multiplicand_in(multiplicand_in), .booth_encoder_in(multiplier_in_extended[12:10]), .ShAmt(6'd10), .partial_product_out(partial_product_5) );
partial_booth_multiplier Partial_Product_6( .multiplicand_in(multiplicand_in), .booth_encoder_in(multiplier_in_extended[14:12]), .ShAmt(6'd12), .partial_product_out(partial_product_6) );
partial_booth_multiplier Partial_Product_7( .multiplicand_in(multiplicand_in), .booth_encoder_in(multiplier_in_extended[16:14]), .ShAmt(6'd14), .partial_product_out(partial_product_7) );
partial_booth_multiplier Partial_Product_8( .multiplicand_in(multiplicand_in), .booth_encoder_in(multiplier_in_extended[18:16]), .ShAmt(6'd16), .partial_product_out(partial_product_8) );
partial_booth_multiplier Partial_Product_9( .multiplicand_in(multiplicand_in), .booth_encoder_in(multiplier_in_extended[20:18]), .ShAmt(6'd18), .partial_product_out(partial_product_9) );
partial_booth_multiplier Partial_Product_10( .multiplicand_in(multiplicand_in), .booth_encoder_in(multiplier_in_extended[22:20]), .ShAmt(6'd20), .partial_product_out(partial_product_10) );
partial_booth_multiplier Partial_Product_11( .multiplicand_in(multiplicand_in), .booth_encoder_in(multiplier_in_extended[24:22]), .ShAmt(6'd22), .partial_product_out(partial_product_11) );
partial_booth_multiplier Partial_Product_12( .multiplicand_in(multiplicand_in), .booth_encoder_in(multiplier_in_extended[26:24]), .ShAmt(6'd24), .partial_product_out(partial_product_12) );
partial_booth_multiplier Partial_Product_13( .multiplicand_in(multiplicand_in), .booth_encoder_in(multiplier_in_extended[28:26]), .ShAmt(6'd26), .partial_product_out(partial_product_13) );
partial_booth_multiplier Partial_Product_14( .multiplicand_in(multiplicand_in), .booth_encoder_in(multiplier_in_extended[30:28]), .ShAmt(6'd28), .partial_product_out(partial_product_14) );
partial_booth_multiplier Partial_Product_15( .multiplicand_in(multiplicand_in), .booth_encoder_in(multiplier_in_extended[32:30]), .ShAmt(6'd30), .partial_product_out(partial_product_15) );

//--------------Adders in the first stage----------------
CLA_64bit Adder_1( .a_in(partial_product_0), .b_in(partial_product_1), .c_in(1'b0), .sum(adder_1_out), .c_out() );
CLA_64bit Adder_2( .a_in(partial_product_2), .b_in(partial_product_3), .c_in(1'b0), .sum(adder_2_out), .c_out() );
CLA_64bit Adder_3( .a_in(partial_product_4), .b_in(partial_product_5), .c_in(1'b0), .sum(adder_3_out), .c_out() );
CLA_64bit Adder_4( .a_in(partial_product_6), .b_in(partial_product_7), .c_in(1'b0), .sum(adder_4_out), .c_out() );
CLA_64bit Adder_5( .a_in(partial_product_8), .b_in(partial_product_9), .c_in(1'b0), .sum(adder_5_out), .c_out() );
CLA_64bit Adder_6( .a_in(partial_product_10), .b_in(partial_product_11), .c_in(1'b0), .sum(adder_6_out), .c_out() );
CLA_64bit Adder_7( .a_in(partial_product_12), .b_in(partial_product_13), .c_in(1'b0), .sum(adder_7_out), .c_out() );
CLA_64bit Adder_8( .a_in(partial_product_14), .b_in(partial_product_15), .c_in(1'b0), .sum(adder_8_out), .c_out() );
    
//------------Adders in the second stage-------------
CLA_64bit Adder_9( .a_in(adder_1_out), .b_in(adder_2_out), .c_in(1'b0), .sum(adder_9_out), .c_out() );
CLA_64bit Adder_10( .a_in(adder_3_out), .b_in(adder_4_out), .c_in(1'b0), .sum(adder_10_out), .c_out() );
CLA_64bit Adder_11( .a_in(adder_5_out), .b_in(adder_6_out), .c_in(1'b0), .sum(adder_11_out), .c_out() );
CLA_64bit Adder_12( .a_in(adder_7_out), .b_in(adder_8_out), .c_in(1'b0), .sum(adder_12_out), .c_out() );

//------------Adders in the third stage-------------
CLA_64bit Adder_13( .a_in(adder_9_out), .b_in(adder_10_out), .c_in(1'b0), .sum(adder_13_out), .c_out() );
CLA_64bit Adder_14( .a_in(adder_11_out), .b_in(adder_12_out), .c_in(1'b0), .sum(adder_14_out), .c_out() );

//------------Adder in the last stage-------------
CLA_64bit Adder_15( .a_in(adder_13_out), .b_in(adder_14_out), .c_in(1'b0), .sum(adder_15_out), .c_out() );


assign product_out = adder_15_out;

endmodule