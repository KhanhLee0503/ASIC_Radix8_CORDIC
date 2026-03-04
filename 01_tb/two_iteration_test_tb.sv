module two_iteration_test_tb;
logic [31:0] x_in;
logic [31:0] y_in;
logic [31:0] z_in;

logic [31:0] x_sum;
logic [31:0] x_carry;

logic [31:0] y_sum;
logic [31:0] y_carry;

logic [31:0] angle_sum;
logic [31:0] angle_carry;

two_iteration_test DUT(.*);

real x_real;
real y_real;
real z_real;

reg [31:0] total_x;
reg [31:0] total_y;
reg [31:0] total_z;

initial begin
    x_in = 32'h0;
    y_in = 32'h0;
    z_in = 32'h0;
    #10;

    $display("-------------------Test 1: X = 0.5, Y = 0.5, Z = 60 degree------------------");
    #10;
    x_in = 32'h0080_0000; // 0.5 in Q8.24 format
    y_in = 32'h0080_0000; // 0.5 in Q8.24 format
    z_in = 32'h010C_1175; // 60 degrees in Q8.24 format

    #10; 
    $display("X Sum: %h, X Carry: %h", x_sum, x_carry);
    total_x = x_sum + x_carry;

        if(total_x[31] == 1'b1) begin
            total_x = ~total_x + 1; // Convert to positive for real conversion 
            x_real = -$itor(total_x) / (2.0**24); 
        end else begin
            total_x = total_x; // Keep as is for real conversion
            x_real = $itor(total_x) / (2.0**24); 
        end

    $display("==> Final X : %0.10f", x_real);


    $display("Y Sum: %h, Y Carry: %h", y_sum, y_carry);
    total_y = y_sum + y_carry;

        if(total_y[31] == 1'b1) begin
            total_y = ~total_y + 1; // Convert to positive for real conversion 
            y_real = -$itor(total_y) / (2.0**24); 
        end else begin
            total_y = total_y; // Keep as is for real conversion
            y_real = $itor(total_y) / (2.0**24); 
        end

    $display("==> Final Y : %0.10f", y_real);


    $display("Angle Sum: %h, Angle Carry: %h", angle_sum, angle_carry);
    total_z = angle_sum + angle_carry;

        if(total_z[31] == 1'b1) begin
            total_z = ~total_z + 1; // Convert to positive for real conversion 
            z_real = -$itor(total_z) / (2.0**24); 
        end else begin
            total_z = total_z; // Keep as is for real conversion
            z_real = $itor(total_z) / (2.0**24); 
        end
        
    $display("==> Final Angle : %0.10f", z_real);


    $display(" ");
    $display("-------------------Test 2: X = 6.3, Y = 7.7, Z = 45 degree------------------");
    #10;
    x_in = 32'h064CCCCD; // 6.3 in Q8.24 format
    y_in = 32'h07B33333; // 7.7 in Q8.24 format 
    z_in = 32'h00C90FDA; // 45 degrees in Q8.24 format
 
 
    #10; 
    $display("X Sum: %h, X Carry: %h", x_sum, x_carry);
    total_x = x_sum + x_carry;

        if(total_x[31] == 1'b1) begin
            total_x = ~total_x + 1; // Convert to positive for real conversion 
            x_real = -$itor(total_x) / (2.0**24); 
        end else begin
            total_x = total_x; // Keep as is for real conversion
            x_real = $itor(total_x) / (2.0**24); 
        end

    $display("==> Final X : %0.10f", x_real);


    $display("Y Sum: %h, Y Carry: %h", y_sum, y_carry);
    total_y = y_sum + y_carry;

        if(total_y[31] == 1'b1) begin
            total_y = ~total_y + 1; // Convert to positive for real conversion 
            y_real = -$itor(total_y) / (2.0**24); 
        end else begin
            total_y = total_y; // Keep as is for real conversion
            y_real = $itor(total_y) / (2.0**24); 
        end

    $display("==> Final Y : %0.10f", y_real);


    $display("Angle Sum: %h, Angle Carry: %h", angle_sum, angle_carry);
    total_z = angle_sum + angle_carry;

        if(total_z[31] == 1'b1) begin
            total_z = ~total_z + 1; // Convert to positive for real conversion 
            z_real = -$itor(total_z) / (2.0**24); 
        end else begin
            total_z = total_z; // Keep as is for real conversion
            z_real = $itor(total_z) / (2.0**24); 
        end
        
    $display("==> Final Angle : %0.10f", z_real);



    $display(" ");
    $display("-------------------Test 3: X = 2.99, Y = 4.342, Z = 75 degree------------------");
    #10;
    x_in = 32'h02FD70A4; // 2.99 in Q8.24 format
    y_in = 32'h04578D50; // 4.342 in Q8.24 format 
    z_in = 32'h014F1BB5; // 75 degrees in Q8.24 format
 
 
    #10; 
    $display("X Sum: %h, X Carry: %h", x_sum, x_carry);
    total_x = x_sum + x_carry;

        if(total_x[31] == 1'b1) begin
            total_x = ~total_x + 1; // Convert to positive for real conversion 
            x_real = -$itor(total_x) / (2.0**24); 
        end else begin
            total_x = total_x; // Keep as is for real conversion
            x_real = $itor(total_x) / (2.0**24); 
        end

    $display("==> Final X : %0.10f", x_real);


    $display("Y Sum: %h, Y Carry: %h", y_sum, y_carry);
    total_y = y_sum + y_carry;

        if(total_y[31] == 1'b1) begin
            total_y = ~total_y + 1; // Convert to positive for real conversion 
            y_real = -$itor(total_y) / (2.0**24); 
        end else begin
            total_y = total_y; // Keep as is for real conversion
            y_real = $itor(total_y) / (2.0**24); 
        end

    $display("==> Final Y : %0.10f", y_real);


    $display("Angle Sum: %h, Angle Carry: %h", angle_sum, angle_carry);
    total_z = angle_sum + angle_carry;

        if(total_z[31] == 1'b1) begin
            total_z = ~total_z + 1; // Convert to positive for real conversion 
            z_real = -$itor(total_z) / (2.0**24); 
        end else begin
            total_z = total_z; // Keep as is for real conversion
            z_real = $itor(total_z) / (2.0**24); 
        end
        
    $display("==> Final Angle : %0.10f", z_real);

  
end

endmodule