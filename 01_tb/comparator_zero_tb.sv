module comaprator_zero_tb;
logic [5:0] data_in_1;
logic [3:0] select_function;

comparator_zero DUT(.*);

initial begin
    data_in_1 = 6'b000000;
    #10;

    $display("--------------Test 1: input is pi/2 (1.57)--------------");
    data_in_1 = 6'b01_1001;
    #10;
    $display("Select function: %h | Sign: %b", select_function[2:0], select_function[3]);
    if(select_function == 4'b0100) begin
        $display("Test 1 PASSED!");
    end else begin
        $display("==> Test 1 FAILED!");
    end

    $display("--------------Test 2: input is pi/3 (1.05)--------------");
    data_in_1 = 6'b01_0001;
    #10;
    $display("Select function: %h | Sign: %b", select_function[2:0], select_function[3]);
    if(select_function == 4'b0100) begin
        $display("Test 2 PASSED!");
    end else begin
        $display("==> Test 2 FAILED!");
    end



    $display("--------------Test 3: input is pi/4 (0.785)--------------");
    data_in_1 = 6'b00_1100;
    #10;
    $display("Select function: %h | Sign: %b", select_function[2:0], select_function[3]);
    if(select_function == 4'b0010) begin
        $display("Test 3 PASSED!");
    end else begin
        $display("==> Test 3 FAILED!");
    end



    $display("--------------Test 4: input is pi/5 (0.628)--------------");
    data_in_1 = 6'b00_1010;
    #10;
    $display("Select function: %h | Sign: %b", select_function[2:0], select_function[3]);
    if(select_function == 4'b0001) begin
        $display("Test 4 PASSED!");
    end else begin
        $display("==> Test 4 FAILED!");
    end



    $display("--------------Test 5: input is pi/6 (0.524)--------------");
    data_in_1 = 6'b00_1000;
    #10;
    $display("Select function: %h | Sign: %b", select_function[2:0], select_function[3]);
    if(select_function == 4'b0001) begin
        $display("Test 5 PASSED!");
    end else begin
        $display("==> Test 5 FAILED!");
    end



    $display("--------------Test 6: input is pi/12 (0.262)--------------");
    data_in_1 = 6'b00_0101;
    #10;
    $display("Select function: %h | Sign: %b", select_function[2:0], select_function[3]);
    if(select_function == 4'b0000) begin
        $display("Test 6 PASSED!");
    end else begin
        $display("==> Test 6 FAILED!");
    end



    $display("--------------test 7: input is pi/3.5 (0.898)--------------");
    data_in_1 = 6'b00_1110;
    #10;
    $display("select function: %h | sign: %b", select_function[2:0], select_function[3]);
    if(select_function == 4'b0011) begin
        $display("Test 7 PASSED!");
    end else begin
        $display("==> Test 7 FAILED!");
    end


    $display("--------------test 8: input is -pi/3.5 (-0.898)--------------");
    data_in_1 = 6'b11_0001;
    #10;
    $display("select function: %h | sign: %b", select_function[2:0], select_function[3]);
    if(select_function == 4'b1011) begin
        $display("Test 8 PASSED!");
    end else begin
        $display("==> Test 8 FAILED!");
    end



    $display("--------------Test 9: input is -pi/12 (-0.262)--------------");
    data_in_1 = 6'b11_1011;
    #10;
    $display("Select function: %h | Sign: %b", select_function[2:0], select_function[3]);
    if(select_function == 4'b0000) begin
        $display("Test 9 PASSED!");
    end else begin
        $display("==> Test 9 FAILED!");
    end


    $display("--------------Test 10: input is -pi/6 (-0.524)--------------");
    data_in_1 = 6'b11_1000;
    #10;
    $display("Select function: %h | Sign: %b", select_function[2:0], select_function[3]);
    if(select_function == 4'b1001) begin
        $display("Test 10 PASSED!");
    end else begin
        $display("==> Test 10 FAILED!");
    end


    $display("--------------Test 11: input is -pi/5 (-0.628)--------------");
    data_in_1 = 6'b11_0110;
    #10;
    $display("Select function: %h | Sign: %b", select_function[2:0], select_function[3]);
    if(select_function == 4'b1001) begin
        $display("Test 11 PASSED!");
    end else begin
        $display("==> Test 11 FAILED!");
    end


    $display("--------------Test 12: input is -pi/4 (-0.785)--------------");
    data_in_1 = 6'b11_0011;
    #10;
    $display("Select function: %h | Sign: %b", select_function[2:0], select_function[3]);
    if(select_function == 4'b1010) begin
        $display("Test 12 PASSED!");
    end else begin
        $display("==> Test 12 FAILED!");
    end

    $display("--------------Test 13: input is -pi/2 (-1.57)--------------");
    data_in_1 = 6'b10_0111;
    #10;
    $display("Select function: %h | Sign: %b", select_function[2:0], select_function[3]);
    if(select_function == 4'b1100) begin
        $display("Test 13 PASSED!");
    end else begin
        $display("==> Test 13 FAILED!");
    end


end

endmodule