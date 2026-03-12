////////////////////
//Shift Left Logic//
////////////////////
module shift_left(
							input logic [63:0] In,
							input logic [5:0] ShAm,
							output logic [63:0] OUT
							);
wire [63:0] stage_0;
wire [63:0] stage_1;
wire [63:0] stage_2;
wire [63:0] stage_3;
wire [63:0] stage_4;

mux2to1_64bit mux6(
						.In1(In),
						.In2({In[31:0],32'b0}),
						.sel(ShAm[5]),
						.out(stage_4)
						);


mux2to1_64bit mux5(
						.In1(stage_4),
						.In2({stage_4[47:0],16'b0}),
						.sel(ShAm[4]),
						.out(stage_3)
						);

mux2to1_64bit mux4(
						.In1(stage_3),
						.In2({stage_3[55:0],8'b0}),
						.sel(ShAm[3]),
						.out(stage_2)
						);

mux2to1_64bit mux3(
						.In1(stage_2),
						.In2({stage_2[59:0],4'b0}),
						.sel(ShAm[2]),
						.out(stage_1)
						);
mux2to1_64bit mux2(
						.In1(stage_1),
						.In2({stage_1[61:0],2'b0}),
						.sel(ShAm[1]),
						.out(stage_0)
						);
mux2to1_64bit mux1(
						.In1(stage_0),
						.In2({stage_0[62:0],1'b0}),
						.sel(ShAm[0]),
						.out(OUT)
						);
endmodule
