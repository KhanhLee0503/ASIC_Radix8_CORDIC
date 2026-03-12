import math

def cordic_radix8_fixed_point(z0_deg, iterations=12):
    # Thiết lập độ chính xác 24-bit sau dấu thập phân (fxp 32.24)
    PRECISION = 2**24 
    
    # Khởi tạo (Tính toán số thực rồi chuyển sang fixed-point để mô phỏng ASIC)
    x = int(0.5 * PRECISION)
    y = int(0.5 * PRECISION)
    w = int(math.radians(z0_deg) * PRECISION) # w ban đầu
    
    # Mảng lưu lại các giá trị sigma (digit) để dùng cho bộ LUT ở cuối
    sigmas = []
    
    print(f"{'i':<3} | {'sigma':<6} | {'x (float)':<12} | {'y (float)':<12} | {'w':<12}")
    print("-" * 65)

    for i in range(iterations):
        w_val = w / PRECISION
        
        # Selection Function (Bộ giải mã chọn góc)
        if i == 0:
            if w_val >= 1: sigma = 4
            elif w_val >= 0.875: sigma = 3
            elif w_val >= 0.75: sigma = 2
            elif w_val >= 0.375: sigma = 1
            elif w_val >= -0.375: sigma = 0
            elif w_val >= -0.75: sigma = -1
            elif w_val >= -0.875: sigma = -2
            elif w_val >= -1: sigma = -3
            else: sigma = -4
        else:
            if w_val >= 3.5: sigma = 4
            elif w_val >= 2.5: sigma = 3
            elif w_val >= 1.5: sigma = 2
            elif w_val >= 0.5: sigma = 1
            elif w_val >= -0.5: sigma = 0
            elif w_val >= -1.5: sigma = -1
            elif w_val >= -2.5: sigma = -2
            elif w_val >= -3.5: sigma = -3
            else: sigma = -4

        # Lưu lại sigma để lát nữa tra bảng LUT tính scale factor
        sigmas.append(sigma)

        # Tính toán bước lặp
        shift = 8**(-i)
        
        # Datapath: Dịch bit và cộng
        dx = int(sigma * (y * shift))
        dy = int(sigma * (x * shift))
        
        # P_i = 8^i * atan(sigma * 8^-i)
        angle_step = int((8**i) * math.atan(sigma * (8**-i)) * PRECISION)
        
        x = x - dx
        y = y + dy
        w = 8 * (w - angle_step)
        
        print(f"{i+1:<3} | {sigma:<6} | {x/PRECISION:<12.7f} | {y/PRECISION:<12.7f} | {w/PRECISION:<12.7f}")

    # =========================================================================
    # GIAI ĐOẠN 2: SCALE FACTOR COMPENSATION (BÙ HỆ SỐ TỶ LỆ K)
    # =========================================================================
    print("-" * 65)
    print(">>> KẾT QUẢ SAU KHI QUA BỘ NHÂN BÙ (SCALE FACTOR COMPENSATION)")
    
    # 1. Trích xuất giá trị tuyệt đối của d0, d1, d2 để đưa vào LUT
    d0 = abs(sigmas[0]) if iterations > 0 else 0
    d1 = abs(sigmas[1]) if iterations > 1 else 0
    d2 = abs(sigmas[2]) if iterations > 2 else 0

    # 2. Mô phỏng bảng LUT: Tính K và C dựa trên d0, d1, d2
    k0 = math.sqrt(1 + d0**2)
    k1 = math.sqrt(1 + (d1 / 8.0)**2)
    k2 = math.sqrt(1 + (d2 / 64.0)**2)
    C_float = 1.0 / (k0 * k1 * k2)

    # Chuyển hệ số bù C sang định dạng fixed-point fxp(32,24)
    C_fxp = int(round(C_float * PRECISION))

    # 3. Phép nhân phần cứng (Hardware Multiplier)
    # Trong RTL: x (32-bit) * C_fxp (32-bit) = x_mult (64-bit)
    x_mult = x * C_fxp
    y_mult = y * C_fxp

    # 4. Truncation / Dịch bit (Shift Right)
    # Bỏ đi 24 bit phân số thừa để ép kết quả 64-bit về lại 32-bit fxp(32,24)
    x_final = x_mult >> 24
    y_final = y_mult >> 24

    print(f"Các digit d0, d1, d2 : {d0}, {d1}, {d2}")
    print(f"Hệ số C (Float)      : {C_float:.7f}")
    print(f"Hệ số C (Fixed-point): 0x{C_fxp:08X}")
    print(f"X_final (Scaled)     : {x_final / PRECISION:.7f}")
    print(f"Y_final (Scaled)     : {y_final / PRECISION:.7f}")
    
    # Đánh giá sai số so với lý thuyết xoay vector chuẩn
    print("-" * 65)
    z_rad_th = math.radians(z0_deg)
    x_th = 0.5 * math.cos(z_rad_th) - 0.5 * math.sin(z_rad_th)
    y_th = 0.5 * math.sin(z_rad_th) + 0.5 * math.cos(z_rad_th)
    print(">>> KIỂM TRA ĐỐI CHIẾU VỚI LÝ THUYẾT (PYTHON MATH):")
    print(f"X lý thuyết          : {x_th:.7f}")
    print(f"Y lý thuyết          : {y_th:.7f}")

# Chạy thử với góc 60 độ, 8 vòng lặp
cordic_radix8_fixed_point(60, 8)