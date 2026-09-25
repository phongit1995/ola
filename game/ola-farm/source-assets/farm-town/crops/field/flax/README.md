# Cây Lanh — `flax`

[Danh mục](../../README.md) · [Bản xem ảnh](../../index.html) · [Hồ sơ JSON](crop.json)

**Thư mục nguồn không được runtime nạp trực tiếp.** Nhãn khảo sát gốc: C3 — dệt may và đường mía.

![Icon](icon.png)

| Thuộc tính | Dữ liệu nguồn |
| --- | --- |
| Nhóm | Cây ruộng |
| Sản phẩm | Cây Lanh (`flax`, source ID 71) |
| Thu mỗi đợt nguồn | 1 |
| Thời gian nguồn | 4500 giây |
| Cấp công thức / item nguồn | 14 / 14 |
| Chi phí mỗi lượt nguồn | 6 Xu |
| `BasicPrice` / `ExpOnUse` nguồn | 26 / 13 — chưa khẳng định là giá bán/XP thu hoạch Farm |
| Tệp PNG riêng trong thư mục | 10 |

Thời gian ở đây là **giây nguồn APK**, không phải giờ mô phỏng Farm. Cấp mở còn phụ thuộc công trình/shop/điều kiện. Với cây lâu năm, nhận hết đợt cuối mới chuyển sang cây cạn lượt; không mất quả khi số lượt bắt đầu mọc đã về 0.

**Ảnh theo role / giai đoạn nguồn**

Ảnh nằm trong `images/`, được dùng chung giữa các role khi nguồn trỏ cùng sprite. Một dòng có nhiều PNG là nhiều mảnh tham chiếu, không phải nhiều cây hoàn chỉnh. Chưa có thông tin ghép transform/hierarchy đầy đủ trong bộ ảnh này.

| Role nguồn | Clip | Các mảnh PNG |
| --- | --- | --- |
| `dead` | `idle` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `idle` | `idle` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `grow0` | `len_1` | [mảnh 1](images/len_1_0--538c448071.png) |
| `grow1` | `len_2` | [mảnh 1](images/len_2_0--aa4d009222.png) |
| `grow2` | `len_2` | [mảnh 1](images/len_2_0--aa4d009222.png) |
| `grow3` | `len_2` | [mảnh 1](images/len_2_0--aa4d009222.png) |
| `grow0` | `grow0` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `ready2` | `len_3` | [mảnh 1](images/len_3ten_0--52d4ef0e0c.png), [mảnh 2](images/len_33_0--7cff0803e9.png), [mảnh 3](images/len_32_0--36df65d3bb.png), [mảnh 4](images/len_31_0--657561b609.png) |
| `ready3` | `len_3` | [mảnh 1](images/len_3ten_0--52d4ef0e0c.png), [mảnh 2](images/len_33_0--7cff0803e9.png), [mảnh 3](images/len_32_0--36df65d3bb.png), [mảnh 4](images/len_31_0--657561b609.png) |
| `ready4` | `len_3` | [mảnh 1](images/len_3ten_0--52d4ef0e0c.png), [mảnh 2](images/len_33_0--7cff0803e9.png), [mảnh 3](images/len_32_0--36df65d3bb.png), [mảnh 4](images/len_31_0--657561b609.png) |
| `ready5` | `len_3` | [mảnh 1](images/len_3ten_0--52d4ef0e0c.png), [mảnh 2](images/len_33_0--7cff0803e9.png), [mảnh 3](images/len_32_0--36df65d3bb.png), [mảnh 4](images/len_31_0--657561b609.png) |
| `ready1` | `len_3` | [mảnh 1](images/len_3ten_0--52d4ef0e0c.png), [mảnh 2](images/len_33_0--7cff0803e9.png), [mảnh 3](images/len_32_0--36df65d3bb.png), [mảnh 4](images/len_31_0--657561b609.png) |
| `harvest2` | `len_end` | [mảnh 1](images/4_len_korz_0--f303ff6341.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/4_len_1_0--ef203e7f22.png) |
| `harvest3` | `len_end` | [mảnh 1](images/4_len_korz_0--f303ff6341.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/4_len_1_0--ef203e7f22.png) |
| `harvest4` | `len_end` | [mảnh 1](images/4_len_korz_0--f303ff6341.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/4_len_1_0--ef203e7f22.png) |
| `harvest1` | `len_end` | [mảnh 1](images/4_len_korz_0--f303ff6341.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/4_len_1_0--ef203e7f22.png) |
| `harvest0` | `len_end` | [mảnh 1](images/4_len_korz_0--f303ff6341.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/4_len_1_0--ef203e7f22.png) |

**Công thức nguồn dùng sản phẩm này**

| Cơ sở | Sản phẩm làm ra | Cần mỗi mẻ | Điều kiện bundle nguồn |
| --- | --- | ---: | --- |
| Bàn May (`sewing`) | Áo Sơ Mi | 2 | Không có nhãn bundle |
| Bàn May (`sewing`) | Quần | 2 | Không có nhãn bundle |
| Mũ (`hats_prod`) | Khăn Xếp (Turban) | 2 | Không có nhãn bundle |
| Mũ (`hats_prod`) | Mũ Ích Kỷ | 2 | Không có nhãn bundle |
| Mũ (`hats_prod`) | Mũ Dạ Hội | 2 | Không có nhãn bundle |
| Phụ Kiện (`accessories`) | Quạt Sang Trọng | 1 | Không có nhãn bundle |
| Phụ Kiện (`accessories`) | Túi Lông Vũ | 1 | Không có nhãn bundle |
| Xưởng Mộc (`carpentry`) | Ghế | 1 | Không có nhãn bundle |

**Trước khi đưa vào game**

Dựng prefab đúng pivot/tỉ lệ và thứ tự vẽ, kiểm tra các pose trên map; chốt giá/thời lượng/sản lượng Farm; nối catalog, kho, save và UI; thử gieo/thu/reload hoặc chu kỳ cây lâu năm. Không dùng source ID số làm ID Farm tự động.

Nguồn APK/hash, object ID, pivot, pixels-per-unit, clip và công thức được ghi trong `crop.json`. README và hồ sơ được tạo bởi `cocos/tools/prepare-crop-sources.py`.
