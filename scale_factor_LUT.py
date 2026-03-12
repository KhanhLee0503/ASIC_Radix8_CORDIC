import math

def generate_radix8_lut():
    print("    always_comb begin")
    print("        // Mặc định gán 'X' để Synthesizer (Design Compiler/Genus) tối ưu hóa cổng logic")
    print("        scale_factor_comp = 32'hX;")
    print("        case ({abs_d0, abs_d1, abs_d2})")
    
    for d0 in range(5):
        for d1 in range(5):
            for d2 in range(5):
                # Tính K cho từng stage
                k0 = math.sqrt(1 + d0**2)
                k1 = math.sqrt(1 + (d1 / 8.0)**2)
                k2 = math.sqrt(1 + (d2 / 64.0)**2)
                
                # Tính hệ số bù C
                c = 1.0 / (k0 * k1 * k2)
                
                # Chuyển đổi sang định dạng Fixed-Point fxp(32, 24)
                c_fxp = int(round(c * (2**24)))
                
                # Định dạng chuỗi nhị phân cho Address và chuỗi Hex cho Data
                addr_bin = f"9'b{d0:03b}_{d1:03b}_{d2:03b}"
                val_hex = f"32'h{c_fxp:08X}" # In ra 8 ký tự Hex (32 bit)
                
                print(f"            {addr_bin}: scale_factor_comp = {val_hex}; // d0={d0}, d1={d1}, d2={d2} | C_float = {c:.6f}")
                
    print("            default: scale_factor_comp = 32'hX;")
    print("        endcase")
    print("    end")

if __name__ == "__main__":
    generate_radix8_lut()