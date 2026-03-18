`timescale 1ns/1ns
module radix_8_cordic_top_tb;

logic clk;
logic rst_n;

logic [31:0] x_in;
logic [31:0] y_in;
logic [31:0] z_in;

logic [31:0] x_out;
logic [31:0] y_out;
logic [31:0] angle_out;

radix_8_cordic_top DUT(.*);

real x_real;
real y_real;
real z_real;

reg [31:0] total_x;
reg [31:0] total_y;
reg [31:0] total_z;

//////////////////////////////////////////////////////
// Clock
//////////////////////////////////////////////////////

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

//////////////////////////////////////////////////////
// Q8.24 → REAL converter
//////////////////////////////////////////////////////

function real fxp_to_real(input [31:0] value);

    reg [31:0] tmp;

    begin
        if(value[31]) begin
            tmp = ~value + 1;
            fxp_to_real = -$itor(tmp) / (2.0**24);
        end
        else begin
            fxp_to_real = $itor(value) / (2.0**24);
        end
    end

endfunction


//////////////////////////////////////////////////////
// TEST TASK
//////////////////////////////////////////////////////

task run_test
(
    input string test_name,
    input [31:0] x_val,
    input [31:0] y_val,
    input [31:0] z_val
);

begin

    $display(" ");
    $display("---------------------------------------------------");
    $display("%s", test_name);
    $display("---------------------------------------------------");

    x_in = x_val;
    y_in = y_val;
    z_in = z_val;

    #100;

    x_real = fxp_to_real(x_out);
    y_real = fxp_to_real(y_out);
    z_real = fxp_to_real(angle_out);

    $display("X HEX : %h", x_out);
    $display("Y HEX : %h", y_out);
    $display("Z HEX : %h", angle_out);

    $display("X REAL : %0.10f", x_real);
    $display("Y REAL : %0.10f", y_real);
    $display("Z REAL : %0.10f", z_real);

end

endtask


//////////////////////////////////////////////////////
// TEST SEQUENCE
//////////////////////////////////////////////////////

initial begin

    x_in = 0;
    y_in = 0;
    z_in = 0;

    rst_n = 0;
    #10;
    rst_n = 1;

    #100;

    //////////////////////////////////////////////////////
    // BASIC TEST
    //////////////////////////////////////////////////////
    run_test("T1: (0.5,0.5) rotate 0 deg",
             32'h00800000,
             32'h00800000,
             32'h00000000);

    run_test("T2: (0.5,0.5) rotate 60 deg",
             32'h00800000,
             32'h00800000,
             32'h010C1523);

    run_test("T3: (0.5,0.5) rotate -60 deg",
             32'h00800000,
             32'h00800000,
             32'hFEF3EADC);

    //////////////////////////////////////////////////////
    // MEDIUM ANGLES (radix-8 stress)
    //////////////////////////////////////////////////////
    run_test("T4: (0.3,0.7) rotate 45 deg",
             32'h004CCCCD,
             32'h00B33333,
             32'h00C90FDB);

    run_test("T5: (0.3,0.7) rotate -45 deg",
             32'h004CCCCD,
             32'h00B33333,
             32'hFF36F025);

    run_test("T6: (0.8,0.2) rotate 30 deg",
             32'h00CCCCCD,
             32'h00333333,
             32'h00860A92);

    run_test("T7: (0.8,0.2) rotate -30 deg",
             32'h00CCCCCD,
             32'h00333333,
             32'hFF79F56E);

    //////////////////////////////////////////////////////
    // SMALL ANGLES (precision test)
    //////////////////////////////////////////////////////
    run_test("T8: (1,0) rotate 1 deg",
             32'h01000000,
             32'h00000000,
             32'h000477D1);

    run_test("T9: (1,0) rotate -1 deg",
             32'h01000000,
             32'h00000000,
             32'hFFFB882F);

    //////////////////////////////////////////////////////
    // EDGE CASE (near 90 deg)
    //////////////////////////////////////////////////////
    run_test("T10: (0.5,0.5) rotate 89 deg",
             32'h00800000,
             32'h00800000,
             32'h018DB6A0);

    run_test("T11: (0.5,0.5) rotate -89 deg",
             32'h00800000,
             32'h00800000,
             32'hFE724960);

    run_test("T12: (1,0) rotate 90 deg",
             32'h01000000,
             32'h00000000,
             32'h01921FB5);

    run_test("T13: (1,0) rotate -90 deg",
             32'h01000000,
             32'h00000000,
             32'hFE6DE04B);

    //////////////////////////////////////////////////////
    // RANDOM (realistic ASIC usage)
    //////////////////////////////////////////////////////
    run_test("T14: (0.6,-0.4) rotate 60 deg",
             32'h0099999A,
             32'hFF99999A,
             32'h010C1523);

    run_test("T15: (-0.5,0.5) rotate 30 deg",
             32'hFF800000,
             32'h00800000,
             32'h00860A92);

 
    run_test("T16: (0.6,-0.4) rotate 120 deg",
             32'h0099999A,
             32'hFF99999A,
             32'h02182a47);  
  
    run_test("T17: (-0.5,0.5) rotate -100 deg",
             32'hFF800000,
             32'h00800000,
             32'hfe41321a);  
    
    run_test("T18: (0.6, -0.4) rotate 180 deg",
             32'h0099999A,
             32'hFF99999A,
             32'h03243f6b);  
  
    run_test("T19: (0.6, -0.4) rotate -180 deg",
             32'h0099999A,
             32'hFF99999A,
             32'hfcdbc095);  
             
    #200;
    $finish;

end

endmodule