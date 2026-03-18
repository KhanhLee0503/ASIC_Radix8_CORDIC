module scale_factor_LUT(
    input logic [2:0] select_function_0,
    input logic [2:0] select_function_1,
    input logic [2:0] select_function_2,
    output logic [31:0] scale_factor_comp
);

 always_comb begin
        case ({select_function_0, select_function_1, select_function_2})
            9'b000_000_000: scale_factor_comp = 32'h01000000; // d0=0, d1=0, d2=0 | C_float = 1.000000
            9'b000_000_001: scale_factor_comp = 32'h00FFF800; // d0=0, d1=0, d2=1 | C_float = 0.999878
            9'b000_000_010: scale_factor_comp = 32'h00FFE006; // d0=0, d1=0, d2=2 | C_float = 0.999512
            9'b000_000_011: scale_factor_comp = 32'h00FFB81E; // d0=0, d1=0, d2=3 | C_float = 0.998903
            9'b000_000_100: scale_factor_comp = 32'h00FF8060; // d0=0, d1=0, d2=4 | C_float = 0.998053
            9'b000_001_000: scale_factor_comp = 32'h00FE05EC; // d0=0, d1=1, d2=0 | C_float = 0.992278
            9'b000_001_001: scale_factor_comp = 32'h00FDFDFC; // d0=0, d1=1, d2=1 | C_float = 0.992157
            9'b000_001_010: scale_factor_comp = 32'h00FDE631; // d0=0, d1=1, d2=2 | C_float = 0.991794
            9'b000_001_011: scale_factor_comp = 32'h00FDBE99; // d0=0, d1=1, d2=3 | C_float = 0.991190
            9'b000_001_100: scale_factor_comp = 32'h00FD8748; // d0=0, d1=1, d2=4 | C_float = 0.990345
            9'b000_010_000: scale_factor_comp = 32'h00F85B42; // d0=0, d1=2, d2=0 | C_float = 0.970143
            9'b000_010_001: scale_factor_comp = 32'h00F85380; // d0=0, d1=2, d2=1 | C_float = 0.970024
            9'b000_010_010: scale_factor_comp = 32'h00F83C3D; // d0=0, d1=2, d2=2 | C_float = 0.969669
            9'b000_010_011: scale_factor_comp = 32'h00F81586; // d0=0, d1=2, d2=3 | C_float = 0.969078
            9'b000_010_100: scale_factor_comp = 32'h00F7DF71; // d0=0, d1=2, d2=4 | C_float = 0.968253
            9'b000_011_000: scale_factor_comp = 32'h00EFB345; // d0=0, d1=3, d2=0 | C_float = 0.936329
            9'b000_011_001: scale_factor_comp = 32'h00EFABC8; // d0=0, d1=3, d2=1 | C_float = 0.936215
            9'b000_011_010: scale_factor_comp = 32'h00EF9554; // d0=0, d1=3, d2=2 | C_float = 0.935872
            9'b000_011_011: scale_factor_comp = 32'h00EF6FF7; // d0=0, d1=3, d2=3 | C_float = 0.935302
            9'b000_011_100: scale_factor_comp = 32'h00EF3BC5; // d0=0, d1=3, d2=4 | C_float = 0.934506
            9'b000_100_000: scale_factor_comp = 32'h00E4F92E; // d0=0, d1=4, d2=0 | C_float = 0.894427
            9'b000_100_001: scale_factor_comp = 32'h00E4F207; // d0=0, d1=4, d2=1 | C_float = 0.894318
            9'b000_100_010: scale_factor_comp = 32'h00E4DC94; // d0=0, d1=4, d2=2 | C_float = 0.893991
            9'b000_100_011: scale_factor_comp = 32'h00E4B8E3; // d0=0, d1=4, d2=3 | C_float = 0.893446
            9'b000_100_100: scale_factor_comp = 32'h00E48707; // d0=0, d1=4, d2=4 | C_float = 0.892685
            9'b001_000_000: scale_factor_comp = 32'h00B504F3; // d0=1, d1=0, d2=0 | C_float = 0.707107
            9'b001_000_001: scale_factor_comp = 32'h00B4FF4B; // d0=1, d1=0, d2=1 | C_float = 0.707020
            9'b001_000_010: scale_factor_comp = 32'h00B4EE57; // d0=1, d1=0, d2=2 | C_float = 0.706762
            9'b001_000_011: scale_factor_comp = 32'h00B4D21F; // d0=1, d1=0, d2=3 | C_float = 0.706331
            9'b001_000_100: scale_factor_comp = 32'h00B4AAB4; // d0=1, d1=0, d2=4 | C_float = 0.705730
            9'b001_001_000: scale_factor_comp = 32'h00B39F19; // d0=1, d1=1, d2=0 | C_float = 0.701646
            9'b001_001_001: scale_factor_comp = 32'h00B3997D; // d0=1, d1=1, d2=1 | C_float = 0.701561
            9'b001_001_010: scale_factor_comp = 32'h00B388AA; // d0=1, d1=1, d2=2 | C_float = 0.701304
            9'b001_001_011: scale_factor_comp = 32'h00B36CAA; // d0=1, d1=1, d2=3 | C_float = 0.700877
            9'b001_001_100: scale_factor_comp = 32'h00B3458D; // d0=1, d1=1, d2=4 | C_float = 0.700280
            9'b001_010_000: scale_factor_comp = 32'h00AF9D53; // d0=1, d1=2, d2=0 | C_float = 0.685994
            9'b001_010_001: scale_factor_comp = 32'h00AF97D7; // d0=1, d1=2, d2=1 | C_float = 0.685911
            9'b001_010_010: scale_factor_comp = 32'h00AF8764; // d0=1, d1=2, d2=2 | C_float = 0.685660
            9'b001_010_011: scale_factor_comp = 32'h00AF6C04; // d0=1, d1=2, d2=3 | C_float = 0.685242
            9'b001_010_100: scale_factor_comp = 32'h00AF45C6; // d0=1, d1=2, d2=4 | C_float = 0.684658
            9'b001_011_000: scale_factor_comp = 32'h00A97E62; // d0=1, d1=3, d2=0 | C_float = 0.662085
            9'b001_011_001: scale_factor_comp = 32'h00A97917; // d0=1, d1=3, d2=1 | C_float = 0.662004
            9'b001_011_010: scale_factor_comp = 32'h00A96936; // d0=1, d1=3, d2=2 | C_float = 0.661762
            9'b001_011_011: scale_factor_comp = 32'h00A94ECB; // d0=1, d1=3, d2=3 | C_float = 0.661359
            9'b001_011_100: scale_factor_comp = 32'h00A929E2; // d0=1, d1=3, d2=4 | C_float = 0.660795
            9'b001_100_000: scale_factor_comp = 32'h00A1E89B; // d0=1, d1=4, d2=0 | C_float = 0.632456
            9'b001_100_001: scale_factor_comp = 32'h00A1E38C; // d0=1, d1=4, d2=1 | C_float = 0.632378
            9'b001_100_010: scale_factor_comp = 32'h00A1D462; // d0=1, d1=4, d2=2 | C_float = 0.632147
            9'b001_100_011: scale_factor_comp = 32'h00A1BB25; // d0=1, d1=4, d2=3 | C_float = 0.631762
            9'b001_100_100: scale_factor_comp = 32'h00A197E3; // d0=1, d1=4, d2=4 | C_float = 0.631224
            9'b010_000_000: scale_factor_comp = 32'h00727C97; // d0=2, d1=0, d2=0 | C_float = 0.447214
            9'b010_000_001: scale_factor_comp = 32'h00727903; // d0=2, d1=0, d2=1 | C_float = 0.447159
            9'b010_000_010: scale_factor_comp = 32'h00726E4A; // d0=2, d1=0, d2=2 | C_float = 0.446995
            9'b010_000_011: scale_factor_comp = 32'h00725C72; // d0=2, d1=0, d2=3 | C_float = 0.446723
            9'b010_000_100: scale_factor_comp = 32'h00724384; // d0=2, d1=0, d2=4 | C_float = 0.446343
            9'b010_001_000: scale_factor_comp = 32'h00719A44; // d0=2, d1=1, d2=0 | C_float = 0.443760
            9'b010_001_001: scale_factor_comp = 32'h007196B7; // d0=2, d1=1, d2=1 | C_float = 0.443706
            9'b010_001_010: scale_factor_comp = 32'h00718C13; // d0=2, d1=1, d2=2 | C_float = 0.443544
            9'b010_001_011: scale_factor_comp = 32'h00717A5E; // d0=2, d1=1, d2=3 | C_float = 0.443273
            9'b010_001_100: scale_factor_comp = 32'h007161A1; // d0=2, d1=1, d2=4 | C_float = 0.442896
            9'b010_010_000: scale_factor_comp = 32'h006F1182; // d0=2, d1=2, d2=0 | C_float = 0.433861
            9'b010_010_001: scale_factor_comp = 32'h006F0E0A; // d0=2, d1=2, d2=1 | C_float = 0.433808
            9'b010_010_010: scale_factor_comp = 32'h006F03A3; // d0=2, d1=2, d2=2 | C_float = 0.433649
            9'b010_010_011: scale_factor_comp = 32'h006EF253; // d0=2, d1=2, d2=3 | C_float = 0.433385
            9'b010_010_100: scale_factor_comp = 32'h006EDA23; // d0=2, d1=2, d2=4 | C_float = 0.433016
            9'b010_011_000: scale_factor_comp = 32'h006B327D; // d0=2, d1=3, d2=0 | C_float = 0.418739
            9'b010_011_001: scale_factor_comp = 32'h006B2F24; // d0=2, d1=3, d2=1 | C_float = 0.418688
            9'b010_011_010: scale_factor_comp = 32'h006B2519; // d0=2, d1=3, d2=2 | C_float = 0.418535
            9'b010_011_011: scale_factor_comp = 32'h006B1463; // d0=2, d1=3, d2=3 | C_float = 0.418280
            9'b010_011_100: scale_factor_comp = 32'h006AFD0C; // d0=2, d1=3, d2=4 | C_float = 0.417924
            9'b010_100_000: scale_factor_comp = 32'h00666666; // d0=2, d1=4, d2=0 | C_float = 0.400000
            9'b010_100_001: scale_factor_comp = 32'h00666333; // d0=2, d1=4, d2=1 | C_float = 0.399951
            9'b010_100_010: scale_factor_comp = 32'h0066599C; // d0=2, d1=4, d2=2 | C_float = 0.399805
            9'b010_100_011: scale_factor_comp = 32'h006649A6; // d0=2, d1=4, d2=3 | C_float = 0.399561
            9'b010_100_100: scale_factor_comp = 32'h00663359; // d0=2, d1=4, d2=4 | C_float = 0.399221
            9'b011_000_000: scale_factor_comp = 32'h0050F44E; // d0=3, d1=0, d2=0 | C_float = 0.316228
            9'b011_000_001: scale_factor_comp = 32'h0050F1C6; // d0=3, d1=0, d2=1 | C_float = 0.316189
            9'b011_000_010: scale_factor_comp = 32'h0050EA31; // d0=3, d1=0, d2=2 | C_float = 0.316073
            9'b011_000_011: scale_factor_comp = 32'h0050DD92; // d0=3, d1=0, d2=3 | C_float = 0.315881
            9'b011_000_100: scale_factor_comp = 32'h0050CBF2; // d0=3, d1=0, d2=4 | C_float = 0.315612
            9'b011_001_000: scale_factor_comp = 32'h00505444; // d0=3, d1=1, d2=0 | C_float = 0.313786
            9'b011_001_001: scale_factor_comp = 32'h005051C2; // d0=3, d1=1, d2=1 | C_float = 0.313748
            9'b011_001_010: scale_factor_comp = 32'h00504A3C; // d0=3, d1=1, d2=2 | C_float = 0.313633
            9'b011_001_011: scale_factor_comp = 32'h00503DB6; // d0=3, d1=1, d2=3 | C_float = 0.313442
            9'b011_001_100: scale_factor_comp = 32'h00502C38; // d0=3, d1=1, d2=4 | C_float = 0.313175
            9'b011_010_000: scale_factor_comp = 32'h004E8987; // d0=3, d1=2, d2=0 | C_float = 0.306786
            9'b011_010_001: scale_factor_comp = 32'h004E8713; // d0=3, d1=2, d2=1 | C_float = 0.306749
            9'b011_010_010: scale_factor_comp = 32'h004E7FB8; // d0=3, d1=2, d2=2 | C_float = 0.306636
            9'b011_010_011: scale_factor_comp = 32'h004E737A; // d0=3, d1=2, d2=3 | C_float = 0.306450
            9'b011_010_100: scale_factor_comp = 32'h004E6260; // d0=3, d1=2, d2=4 | C_float = 0.306189
            9'b011_011_000: scale_factor_comp = 32'h004BCCC5; // d0=3, d1=3, d2=0 | C_float = 0.296093
            9'b011_011_001: scale_factor_comp = 32'h004BCA67; // d0=3, d1=3, d2=1 | C_float = 0.296057
            9'b011_011_010: scale_factor_comp = 32'h004BC34D; // d0=3, d1=3, d2=2 | C_float = 0.295949
            9'b011_011_011: scale_factor_comp = 32'h004BB77C; // d0=3, d1=3, d2=3 | C_float = 0.295769
            9'b011_011_100: scale_factor_comp = 32'h004BA6FB; // d0=3, d1=3, d2=4 | C_float = 0.295517
            9'b011_100_000: scale_factor_comp = 32'h00486861; // d0=3, d1=4, d2=0 | C_float = 0.282843
            9'b011_100_001: scale_factor_comp = 32'h0048661E; // d0=3, d1=4, d2=1 | C_float = 0.282808
            9'b011_100_010: scale_factor_comp = 32'h00485F56; // d0=3, d1=4, d2=2 | C_float = 0.282705
            9'b011_100_011: scale_factor_comp = 32'h0048540C; // d0=3, d1=4, d2=3 | C_float = 0.282532
            9'b011_100_100: scale_factor_comp = 32'h00484448; // d0=3, d1=4, d2=4 | C_float = 0.282292
            9'b100_000_000: scale_factor_comp = 32'h003E16D1; // d0=4, d1=0, d2=0 | C_float = 0.242536
            9'b100_000_001: scale_factor_comp = 32'h003E14E0; // d0=4, d1=0, d2=1 | C_float = 0.242506
            9'b100_000_010: scale_factor_comp = 32'h003E0F0F; // d0=4, d1=0, d2=2 | C_float = 0.242417
            9'b100_000_011: scale_factor_comp = 32'h003E0562; // d0=4, d1=0, d2=3 | C_float = 0.242270
            9'b100_000_100: scale_factor_comp = 32'h003DF7DC; // d0=4, d1=0, d2=4 | C_float = 0.242063
            9'b100_001_000: scale_factor_comp = 32'h003D9C13; // d0=4, d1=1, d2=0 | C_float = 0.240663
            9'b100_001_001: scale_factor_comp = 32'h003d9a26; // d0=4, d1=1, d2=1 | C_float = 0.240633
            9'b100_001_010: scale_factor_comp = 32'h003D9461; // d0=4, d1=1, d2=2 | C_float = 0.240545
            9'b100_001_011: scale_factor_comp = 32'h003D8AC6; // d0=4, d1=1, d2=3 | C_float = 0.240399
            9'b100_001_100: scale_factor_comp = 32'h003D7D5C; // d0=4, d1=1, d2=4 | C_float = 0.240194
            9'b100_010_000: scale_factor_comp = 32'h003C3C3C; // d0=4, d1=2, d2=0 | C_float = 0.235294
            9'b100_010_001: scale_factor_comp = 32'h003C3A5A; // d0=4, d1=2, d2=1 | C_float = 0.235265
            9'b100_010_010: scale_factor_comp = 32'h003c34b6; // d0=4, d1=2, d2=2 | C_float = 0.235179
            9'b100_010_011: scale_factor_comp = 32'h003C2B52; // d0=4, d1=2, d2=3 | C_float = 0.235036
            9'b100_010_100: scale_factor_comp = 32'h003C1E35; // d0=4, d1=2, d2=4 | C_float = 0.234836
            9'b100_011_000: scale_factor_comp = 32'h003A22C7; // d0=4, d1=3, d2=0 | C_float = 0.227093
            9'b100_011_001: scale_factor_comp = 32'h003A20F6; // d0=4, d1=3, d2=1 | C_float = 0.227065
            9'b100_011_010: scale_factor_comp = 32'h003A1B84; // d0=4, d1=3, d2=2 | C_float = 0.226982
            9'b100_011_011: scale_factor_comp = 32'h003A1274; // d0=4, d1=3, d2=3 | C_float = 0.226844
            9'b100_011_100: scale_factor_comp = 32'h003A05CC; // d0=4, d1=3, d2=4 | C_float = 0.226651
            9'b100_100_000: scale_factor_comp = 32'h003788C1; // d0=4, d1=4, d2=0 | C_float = 0.216930
            9'b100_100_001: scale_factor_comp = 32'h00378705; // d0=4, d1=4, d2=1 | C_float = 0.216904
            9'b100_100_010: scale_factor_comp = 32'h003781D1; // d0=4, d1=4, d2=2 | C_float = 0.216825
            9'b100_100_011: scale_factor_comp = 32'h00377929; // d0=4, d1=4, d2=3 | C_float = 0.216693
            9'b100_100_100: scale_factor_comp = 32'h00376D12; // d0=4, d1=4, d2=4 | C_float = 0.216508
            default: scale_factor_comp = 32'h0;
        endcase
    end
endmodule