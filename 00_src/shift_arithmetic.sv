//////////////////////////
//Shift Right Arithmetic//
//////////////////////////
module shiftright_arithmetic(
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
						.In2({{32{In[63]}}, In[63:32]}), 
						.sel(ShAm[5]),
						.out(stage_4)
);


mux2to1_64bit mux5(
						.In1(stage_4),
						.In2({{16{stage_4[63]}}, stage_4[63:16]}), 
						.sel(ShAm[4]),
						.out(stage_3)
);

mux2to1_64bit mux4(
						.In1(stage_3),
						.In2({{8{stage_3[63]}},stage_3[63:8]}),
						.sel(ShAm[3]),
						.out(stage_2)
);

mux2to1_64bit mux3(
						.In1(stage_2),
						.In2({{4{stage_2[63]}},stage_2[63:4]}),
						.sel(ShAm[2]),
						.out(stage_1)
);
mux2to1_64bit mux2(
						.In1(stage_1),
						.In2({{2{stage_1[63]}},stage_1[63:2]}),
						.sel(ShAm[1]),
						.out(stage_0)
);
mux2to1_64bit mux1(
						.In1(stage_0),
						.In2({stage_0[63],stage_0[63:1]}),
						.sel(ShAm[0]),
						.out(OUT)
);
									 
endmodule
