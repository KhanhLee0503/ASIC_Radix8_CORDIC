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


initial begin
    clk = 1'b0;
    forever begin
        #5 clk = ~clk;
    end
end


initial begin
    x_in = 32'h0;
    y_in = 32'h0;
    z_in = 32'h0;
    rst_n = 1'b0;
    #10;
    rst_n = 1'b1;

    $display("-------------------Test 1: X = 0.5, Y = 0.5, Z = 60 degree (1.047197551)------------------");
    #10;
    x_in = 32'h0080_0000; // 0.5 in Q8.24 format
    y_in = 32'h0080_0000; // 0.5 in Q8.24 format
    z_in = 32'h010c1523; // 60 degrees in Q8.24 format


   #100; 
    
    $display("X Value: %h", x_out);
   
        if(x_out[31] == 1'b1) begin
            total_x = ~x_out + 1; // Convert to positive for real conversion 
            x_real = -$itor(total_x) / (2.0**24); 
        end else begin
            total_x = x_out; // Keep as is for real conversion
            x_real = $itor(total_x) / (2.0**24); 
        end

    $display("==> Final X : %0.10f", x_real); 
    
    $display("Y Value: %h", y_out);
   
        if(y_out[31] == 1'b1) begin
            total_y = ~y_out + 1; // Convert to positive for real conversion 
            y_real = -$itor(total_y) / (2.0**24); 
        end else begin
            total_y = y_out; // Keep as is for real conversion
            y_real = $itor(total_y) / (2.0**24); 
        end

    $display("==> Final Y : %0.10f", y_real);

    $display("Angle Value: %h", angle_out);
   
        if(angle_out[31] == 1'b1) begin
            total_z = ~angle_out + 1; // Convert to positive for real conversion 
            z_real = -$itor(total_z) / (2.0**24); 
        end else begin
            total_z = angle_out; // Keep as is for real conversion
            z_real = $itor(total_z) / (2.0**24); 
        end

    $display("==> Final Angle : %0.10f", z_real);


//---------------------------------------------------------------------------------
    $display(" ");
    $display("-------------------Test 2: X = 6.3, Y = 7.7, Z = 45 degree (0.7853981634)------------------");
    #10;
    x_in = 32'h064CCCCD; // 6.3 in Q8.24 format
    y_in = 32'h07B33333; // 7.7 in Q8.24 format 
    z_in = 32'h00C90FDB; // 45 degrees in Q8.24 format
  
    
    #100; 
    $display("X Value: %h", x_out);
   
        if(x_out[31] == 1'b1) begin
            total_x = ~x_out + 1; // Convert to positive for real conversion 
            x_real = -$itor(total_x) / (2.0**24); 
        end else begin
            total_x = x_out; // Keep as is for real conversion
            x_real = $itor(total_x) / (2.0**24); 
        end

    $display("==> Final X : %0.10f", x_real); 
    
    $display("Y Value: %h", y_out);
   
        if(y_out[31] == 1'b1) begin
            total_y = ~y_out + 1; // Convert to positive for real conversion 
            y_real = -$itor(total_y) / (2.0**24); 
        end else begin
            total_y = y_out; // Keep as is for real conversion
            y_real = $itor(total_y) / (2.0**24); 
        end

    $display("==> Final Y : %0.10f", y_real);
   
    $display("Angle Value: %h", angle_out);
   
        if(angle_out[31] == 1'b1) begin
            total_z = ~angle_out + 1; // Convert to positive for real conversion 
            z_real = -$itor(total_z) / (2.0**24); 
        end else begin
            total_z = angle_out; // Keep as is for real conversion
            z_real = $itor(total_z) / (2.0**24); 
        end

    $display("==> Final Angle : %0.10f", z_real);


//------------------------------------------------------------------------------------------------------------

    $display(" ");
    $display("-------------------Test 3: X = 2.99, Y = 4.342, Z = 30 degree (0.5235987756)------------------");
    #10;
    x_in = 32'h02FD70A4; // 2.99 in Q8.24 format
    y_in = 32'h04578D50; // 4.342 in Q8.24 format 
    z_in = 32'h00860a92; // 30 degrees in Q8.24 format

 
    #100; 
    $display("X Value: %h", x_out);
   
        if(x_out[31] == 1'b1) begin
            total_x = ~x_out + 1; // Convert to positive for real conversion 
            x_real = -$itor(total_x) / (2.0**24); 
        end else begin
            total_x = x_out; // Keep as is for real conversion
            x_real = $itor(total_x) / (2.0**24); 
        end

    $display("==> Final X : %0.10f", x_real); 
    
    $display("Y Value: %h", y_out);
   
        if(y_out[31] == 1'b1) begin
            total_y = ~y_out + 1; // Convert to positive for real conversion 
            y_real = -$itor(total_y) / (2.0**24); 
        end else begin
            total_y = y_out; // Keep as is for real conversion
            y_real = $itor(total_y) / (2.0**24); 
        end

    $display("==> Final Y : %0.10f", y_real);
 
    $display("Angle Value: %h", angle_out);
   
        if(angle_out[31] == 1'b1) begin
            total_z = ~angle_out + 1; // Convert to positive for real conversion 
            z_real = -$itor(total_z) / (2.0**24); 
        end else begin
            total_z = angle_out; // Keep as is for real conversion
            z_real = $itor(total_z) / (2.0**24); 
        end

    $display("==> Final Angle : %0.10f", z_real);

   end

endmodule