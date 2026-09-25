# Đậu — `beans`

[Danh mục](../../README.md) · [Bản xem ảnh](../../index.html) · [Hồ sơ JSON](crop.json)

**Thư mục nguồn không được runtime nạp trực tiếp.** Nhãn khảo sát gốc: C5 — món ăn mở rộng.

![Icon](icon.png)

| Thuộc tính | Dữ liệu nguồn |
| --- | --- |
| Nhóm | Cây ruộng |
| Sản phẩm | Đậu (`beans`, source ID 169) |
| Thu mỗi đợt nguồn | 1 |
| Thời gian nguồn | 4200 giây |
| Cấp công thức / item nguồn | 27 / 27 |
| Chi phí mỗi lượt nguồn | 4 Xu |
| `BasicPrice` / `ExpOnUse` nguồn | 20 / 10 — chưa khẳng định là giá bán/XP thu hoạch Farm |
| Tệp PNG riêng trong thư mục | 18 |

Thời gian ở đây là **giây nguồn APK**, không phải giờ mô phỏng Farm. Cấp mở còn phụ thuộc công trình/shop/điều kiện. Với cây lâu năm, nhận hết đợt cuối mới chuyển sang cây cạn lượt; không mất quả khi số lượt bắt đầu mọc đã về 0.

**Ảnh theo role / giai đoạn nguồn**

Ảnh nằm trong `images/`, được dùng chung giữa các role khi nguồn trỏ cùng sprite. Một dòng có nhiều PNG là nhiều mảnh tham chiếu, không phải nhiều cây hoàn chỉnh. Chưa có thông tin ghép transform/hierarchy đầy đủ trong bộ ảnh này.

| Role nguồn | Clip | Các mảnh PNG |
| --- | --- | --- |
| `dead` | `idle` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `idle` | `idle` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `grow0` | `fasol_1` | [mảnh 1](images/fasol_1_0--0bb62998cc.png) |
| `grow1` | `fasol_2` | [mảnh 1](images/fasol_2_0--12d9a7699c.png) |
| `grow2` | `fasol_2` | [mảnh 1](images/fasol_2_0--12d9a7699c.png) |
| `grow3` | `fasol_2` | [mảnh 1](images/fasol_2_0--12d9a7699c.png) |
| `grow0` | `grow0` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `ready2` | `fasol_3` | [mảnh 1](images/fasol_3ten1_0--8ad409fe31.png), [mảnh 2](images/fasol_34_0--746b778e6c.png), [mảnh 3](images/fasol_33_0--1d37ab2c8d.png), [mảnh 4](images/fasol_32_0--822862b67a.png), [mảnh 5](images/fasol_31_0--47bc8bfc35.png) |
| `ready3` | `fasol_3` | [mảnh 1](images/fasol_3ten1_0--8ad409fe31.png), [mảnh 2](images/fasol_34_0--746b778e6c.png), [mảnh 3](images/fasol_33_0--1d37ab2c8d.png), [mảnh 4](images/fasol_32_0--822862b67a.png), [mảnh 5](images/fasol_31_0--47bc8bfc35.png) |
| `ready4` | `fasol_3` | [mảnh 1](images/fasol_3ten1_0--8ad409fe31.png), [mảnh 2](images/fasol_34_0--746b778e6c.png), [mảnh 3](images/fasol_33_0--1d37ab2c8d.png), [mảnh 4](images/fasol_32_0--822862b67a.png), [mảnh 5](images/fasol_31_0--47bc8bfc35.png) |
| `ready5` | `fasol_3` | [mảnh 1](images/fasol_3ten1_0--8ad409fe31.png), [mảnh 2](images/fasol_34_0--746b778e6c.png), [mảnh 3](images/fasol_33_0--1d37ab2c8d.png), [mảnh 4](images/fasol_32_0--822862b67a.png), [mảnh 5](images/fasol_31_0--47bc8bfc35.png) |
| `ready1` | `fasol_3` | [mảnh 1](images/fasol_3ten1_0--8ad409fe31.png), [mảnh 2](images/fasol_34_0--746b778e6c.png), [mảnh 3](images/fasol_33_0--1d37ab2c8d.png), [mảnh 4](images/fasol_32_0--822862b67a.png), [mảnh 5](images/fasol_31_0--47bc8bfc35.png) |
| `harvest2` | `fasol_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/4_goroh_nutr_3_0--4450115805.png), [mảnh 4](images/4_goroh_nutr_2_0--f02b7aa83b.png), [mảnh 5](images/4_goroh_nutr_1_0--8abb3c4961.png), [mảnh 6](images/korzina_p_0--7f793edf56.png), [mảnh 7](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 8](images/4_goroh_ten_1_0--d716232743.png), [mảnh 9](images/4_goroh_2_0--d795db9be8.png), [mảnh 10](images/4_goroh_1_0--815b56e01d.png) |
| `harvest3` | `fasol_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/4_goroh_nutr_3_0--4450115805.png), [mảnh 4](images/4_goroh_nutr_2_0--f02b7aa83b.png), [mảnh 5](images/4_goroh_nutr_1_0--8abb3c4961.png), [mảnh 6](images/korzina_p_0--7f793edf56.png), [mảnh 7](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 8](images/4_goroh_ten_1_0--d716232743.png), [mảnh 9](images/4_goroh_2_0--d795db9be8.png), [mảnh 10](images/4_goroh_1_0--815b56e01d.png) |
| `harvest4` | `fasol_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/4_goroh_nutr_3_0--4450115805.png), [mảnh 4](images/4_goroh_nutr_2_0--f02b7aa83b.png), [mảnh 5](images/4_goroh_nutr_1_0--8abb3c4961.png), [mảnh 6](images/korzina_p_0--7f793edf56.png), [mảnh 7](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 8](images/4_goroh_ten_1_0--d716232743.png), [mảnh 9](images/4_goroh_2_0--d795db9be8.png), [mảnh 10](images/4_goroh_1_0--815b56e01d.png) |
| `harvest1` | `fasol_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/4_goroh_nutr_3_0--4450115805.png), [mảnh 4](images/4_goroh_nutr_2_0--f02b7aa83b.png), [mảnh 5](images/4_goroh_nutr_1_0--8abb3c4961.png), [mảnh 6](images/korzina_p_0--7f793edf56.png), [mảnh 7](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 8](images/4_goroh_ten_1_0--d716232743.png), [mảnh 9](images/4_goroh_2_0--d795db9be8.png), [mảnh 10](images/4_goroh_1_0--815b56e01d.png) |
| `harvest0` | `fasol_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/4_goroh_nutr_3_0--4450115805.png), [mảnh 4](images/4_goroh_nutr_2_0--f02b7aa83b.png), [mảnh 5](images/4_goroh_nutr_1_0--8abb3c4961.png), [mảnh 6](images/korzina_p_0--7f793edf56.png), [mảnh 7](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 8](images/4_goroh_ten_1_0--d716232743.png), [mảnh 9](images/4_goroh_2_0--d795db9be8.png), [mảnh 10](images/4_goroh_1_0--815b56e01d.png) |

**Công thức nguồn dùng sản phẩm này**

| Cơ sở | Sản phẩm làm ra | Cần mỗi mẻ | Điều kiện bundle nguồn |
| --- | --- | ---: | --- |
| Cửa hàng Sushi (`sushi_bar`) | Nước Tương (Xì Dầu) | 4 | Không có nhãn bundle |
| Cửa hàng Sushi (`sushi_bar`) | Đậu Hũ | 4 | Không có nhãn bundle |
| Đồ Ăn Mexico (`mexico`) | Bánh Burrito | 1 | Không có nhãn bundle |

**Trước khi đưa vào game**

Dựng prefab đúng pivot/tỉ lệ và thứ tự vẽ, kiểm tra các pose trên map; chốt giá/thời lượng/sản lượng Farm; nối catalog, kho, save và UI; thử gieo/thu/reload hoặc chu kỳ cây lâu năm. Không dùng source ID số làm ID Farm tự động.

Nguồn APK/hash, object ID, pivot, pixels-per-unit, clip và công thức được ghi trong `crop.json`. README và hồ sơ được tạo bởi `cocos/tools/prepare-crop-sources.py`.
