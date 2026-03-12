`timescale 1ns/1ps

module booth_multiplier_tb;

    // Khai báo tín hiệu
    logic [31:0] multiplicand_in;
    logic [31:0] multiplier_in;
    logic [63:0] product_out;
    
    // Tín hiệu so sánh
    logic signed [63:0] expected_product;
    int error_count = 0;

    // Instance module DUT (Device Under Test)
    booth_multiplier_32bit DUT (
        .multiplicand_in(multiplicand_in),
        .multiplier_in(multiplier_in),
        .product_out(product_out)
    );

    // Task thực hiện kiểm tra tự động
    task run_test(input signed [31:0] A, input signed [31:0] B);
        begin
            multiplicand_in = A;
            multiplier_in = B;
            #20; // Đợi logic tổ hợp lan truyền qua 4 tầng CLA
            
            expected_product = A * B;
            
            if ($signed(product_out) !== expected_product) begin
                $display("FAILED: %d * %d = %d (Expected: %d)", A, B, $signed(product_out), expected_product);
                error_count++;
            end else begin
                $display("PASSED: %d * %d = %d", A, B, $signed(product_out));
            end
        end
    endtask

    initial begin
        $display("--- BAT DAU TESTBENCH ---");
        
        // 1. Các trường hợp cơ bản
        run_test(0, 5);
        run_test(5, 0);
        run_test(1, 10);
        run_test(-1, 10);
        run_test(10, -1);
        
        // 2. Các số nhỏ dễ quan sát
        run_test(2, 3);
        run_test(4, 4);
        run_test(10, 5);
        
        // 3. Số âm
        run_test(-2, 3);
        run_test(2, -3);
        run_test(-2, -3);
        
        // 4. Số lớn hơn một chút
        run_test(100, 200);
        run_test(-100, 200);
        run_test(100, -200);
        run_test(-100, -200);
        
        
        
        
        // --- Các test case phức tạp hơn ---

        // 1. Nhân số nguyên dương cực đại (Max Positive 32-bit: 2,147,483,647)
        run_test(32'h7FFFFFFF, 32'd1);  // Nhân với 1
        run_test(32'h7FFFFFFF, 32'd2);  // Nhân với 2 (xảy ra tràn 32-bit nhưng nằm trong 64-bit)

        // 2. Nhân số nguyên âm cực tiểu (Min Negative 32-bit: -2,147,483,648)
        // Chú ý: Đây là trường hợp kiểm tra khả năng xử lý bù 2 của bạn cực tốt
        run_test(-32'h80000000, 32'd1);  // -2,147,483,648
        run_test(-32'h80000000, -32'd1); // Phải ra 2,147,483,648

        // 3. Nhân số âm cực đại với số âm cực đại
        // Case này kiểm tra độ chính xác của cây cộng CLA 64-bit
        run_test(-32'h80000000, -32'h80000000); 

        // 4. Các số có nhiều bit '1' xen kẽ (Stress Test cho Encoder Booth)
        // Booth Radix-4 cực nhạy cảm với các chuỗi 010101...
        run_test(32'hAAAA_AAAA, 32'h5555_5555); // A * B
        run_test(32'h5555_5555, 32'hAAAA_AAAA); // B * A

        // 5. Test tính đối xứng (A*B == B*A)
        // Nếu module của bạn đúng, 2 kết quả này phải giống hệt nhau
        run_test(32'd12345678, 32'd87654321);
        run_test(32'd87654321, 32'd12345678);// --- Test các số hàng ngàn, hàng trăm ---
        run_test(32'd1234, 32'd5678);    // Số dương * số dương
        run_test(32'd9876, 32'd4321);    // Số dương * số dương
        run_test(-32'd4567, 32'd1234);   // Số âm * số dương
        run_test(32'd7890, -32'd2345);   // Số dương * số âm
        run_test(-32'd3333, -32'd4444);  // Số âm * số âm

        // --- Test ngẫu nhiên (Stress Testing) ---
               // --- Test các case "khó" (Số rất gần nhau hoặc gần ranh giới) ---
        run_test(32'd1024, 32'd1024);    // Lũy thừa của 2
        run_test(32'd32767, 32'd32767);  // Cận trên của 16-bit
        run_test(-32'd32768, 32'd32768); // Ranh giới số âm
                // 5. Kết luận
        if (error_count == 0)
            $display("--- TESTBENCH THANH CONG: TAT CA CASES DUNG! ---");
        else
            $display("--- TESTBENCH THAT BAI: CO %d LOI! ---", error_count);
            
        $finish;
    end
endmodule