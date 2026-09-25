# Mía — `cane`

[Danh mục](../../README.md) · [Bản xem ảnh](../../index.html) · [Hồ sơ JSON](crop.json)

**Thư mục nguồn không được runtime nạp trực tiếp.** Nhãn khảo sát gốc: C3 — dệt may và đường mía.

![Icon](icon.png)

| Thuộc tính | Dữ liệu nguồn |
| --- | --- |
| Nhóm | Cây ruộng |
| Sản phẩm | Mía (`cane`, source ID 26) |
| Thu mỗi đợt nguồn | 1 |
| Thời gian nguồn | 3600 giây |
| Cấp công thức / item nguồn | 17 / 17 |
| Chi phí mỗi lượt nguồn | 5 Xu |
| `BasicPrice` / `ExpOnUse` nguồn | 22 / 11 — chưa khẳng định là giá bán/XP thu hoạch Farm |
| Tệp PNG riêng trong thư mục | 24 |

Thời gian ở đây là **giây nguồn APK**, không phải giờ mô phỏng Farm. Cấp mở còn phụ thuộc công trình/shop/điều kiện. Với cây lâu năm, nhận hết đợt cuối mới chuyển sang cây cạn lượt; không mất quả khi số lượt bắt đầu mọc đã về 0.

**Ảnh theo role / giai đoạn nguồn**

Ảnh nằm trong `images/`, được dùng chung giữa các role khi nguồn trỏ cùng sprite. Một dòng có nhiều PNG là nhiều mảnh tham chiếu, không phải nhiều cây hoàn chỉnh. Chưa có thông tin ghép transform/hierarchy đầy đủ trong bộ ảnh này.

| Role nguồn | Clip | Các mảnh PNG |
| --- | --- | --- |
| `dead` | `idle` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `idle` | `idle` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `grow0` | `trosnik_1` | [mảnh 1](images/tros_1_0--a4b9dd5c02.png) |
| `grow1` | `trosnik_2` | [mảnh 1](images/tros_2_0--403ba94fff.png) |
| `grow2` | `trosnik_2` | [mảnh 1](images/tros_2_0--403ba94fff.png) |
| `grow3` | `trosnik_2` | [mảnh 1](images/tros_2_0--403ba94fff.png) |
| `grow0` | `grow0` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `ready2` | `trosnik_3` | [mảnh 1](images/tros_3ten2_0--3f3f15d3f9.png), [mảnh 2](images/tros_312_0--ef2df5841a.png), [mảnh 3](images/tros_311_0--7123d93b9a.png), [mảnh 4](images/tros_310_0--bdf711ed6d.png), [mảnh 5](images/tros_3ten1_0--dcd3248b23.png), [mảnh 6](images/tros_39_0--484cad070c.png), [mảnh 7](images/tros_38_0--f3443bbced.png), [mảnh 8](images/tros_37_0--93e86d8c14.png), [mảnh 9](images/tros_35_0--62fce29598.png), [mảnh 10](images/tros_36_0--5e45351ffa.png), [mảnh 11](images/tros_34_0--fb2b8f1d63.png), [mảnh 12](images/tros_33_0--bd414d39bf.png), [mảnh 13](images/tros_32_0--ec2ec4a4e7.png), [mảnh 14](images/tros_31_0--c89775b7ca.png) |
| `ready3` | `trosnik_3` | [mảnh 1](images/tros_3ten2_0--3f3f15d3f9.png), [mảnh 2](images/tros_312_0--ef2df5841a.png), [mảnh 3](images/tros_311_0--7123d93b9a.png), [mảnh 4](images/tros_310_0--bdf711ed6d.png), [mảnh 5](images/tros_3ten1_0--dcd3248b23.png), [mảnh 6](images/tros_39_0--484cad070c.png), [mảnh 7](images/tros_38_0--f3443bbced.png), [mảnh 8](images/tros_37_0--93e86d8c14.png), [mảnh 9](images/tros_35_0--62fce29598.png), [mảnh 10](images/tros_36_0--5e45351ffa.png), [mảnh 11](images/tros_34_0--fb2b8f1d63.png), [mảnh 12](images/tros_33_0--bd414d39bf.png), [mảnh 13](images/tros_32_0--ec2ec4a4e7.png), [mảnh 14](images/tros_31_0--c89775b7ca.png) |
| `ready4` | `trosnik_3` | [mảnh 1](images/tros_3ten2_0--3f3f15d3f9.png), [mảnh 2](images/tros_312_0--ef2df5841a.png), [mảnh 3](images/tros_311_0--7123d93b9a.png), [mảnh 4](images/tros_310_0--bdf711ed6d.png), [mảnh 5](images/tros_3ten1_0--dcd3248b23.png), [mảnh 6](images/tros_39_0--484cad070c.png), [mảnh 7](images/tros_38_0--f3443bbced.png), [mảnh 8](images/tros_37_0--93e86d8c14.png), [mảnh 9](images/tros_35_0--62fce29598.png), [mảnh 10](images/tros_36_0--5e45351ffa.png), [mảnh 11](images/tros_34_0--fb2b8f1d63.png), [mảnh 12](images/tros_33_0--bd414d39bf.png), [mảnh 13](images/tros_32_0--ec2ec4a4e7.png), [mảnh 14](images/tros_31_0--c89775b7ca.png) |
| `ready5` | `trosnik_3` | [mảnh 1](images/tros_3ten2_0--3f3f15d3f9.png), [mảnh 2](images/tros_312_0--ef2df5841a.png), [mảnh 3](images/tros_311_0--7123d93b9a.png), [mảnh 4](images/tros_310_0--bdf711ed6d.png), [mảnh 5](images/tros_3ten1_0--dcd3248b23.png), [mảnh 6](images/tros_39_0--484cad070c.png), [mảnh 7](images/tros_38_0--f3443bbced.png), [mảnh 8](images/tros_37_0--93e86d8c14.png), [mảnh 9](images/tros_35_0--62fce29598.png), [mảnh 10](images/tros_36_0--5e45351ffa.png), [mảnh 11](images/tros_34_0--fb2b8f1d63.png), [mảnh 12](images/tros_33_0--bd414d39bf.png), [mảnh 13](images/tros_32_0--ec2ec4a4e7.png), [mảnh 14](images/tros_31_0--c89775b7ca.png) |
| `ready1` | `trosnik_3` | [mảnh 1](images/tros_3ten2_0--3f3f15d3f9.png), [mảnh 2](images/tros_312_0--ef2df5841a.png), [mảnh 3](images/tros_311_0--7123d93b9a.png), [mảnh 4](images/tros_310_0--bdf711ed6d.png), [mảnh 5](images/tros_3ten1_0--dcd3248b23.png), [mảnh 6](images/tros_39_0--484cad070c.png), [mảnh 7](images/tros_38_0--f3443bbced.png), [mảnh 8](images/tros_37_0--93e86d8c14.png), [mảnh 9](images/tros_35_0--62fce29598.png), [mảnh 10](images/tros_36_0--5e45351ffa.png), [mảnh 11](images/tros_34_0--fb2b8f1d63.png), [mảnh 12](images/tros_33_0--bd414d39bf.png), [mảnh 13](images/tros_32_0--ec2ec4a4e7.png), [mảnh 14](images/tros_31_0--c89775b7ca.png) |
| `harvest2` | `trosnik_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_tros_nutr_2_0--cbb3d84b3e.png), [mảnh 6](images/4_tros_nutr_1_0--2d63851839.png), [mảnh 7](images/4_tros_1_0--8113c2c79f.png) |
| `harvest3` | `trosnik_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_tros_nutr_2_0--cbb3d84b3e.png), [mảnh 6](images/4_tros_nutr_1_0--2d63851839.png), [mảnh 7](images/4_tros_1_0--8113c2c79f.png) |
| `harvest4` | `trosnik_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_tros_nutr_2_0--cbb3d84b3e.png), [mảnh 6](images/4_tros_nutr_1_0--2d63851839.png), [mảnh 7](images/4_tros_1_0--8113c2c79f.png) |
| `harvest1` | `trosnik_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_tros_nutr_2_0--cbb3d84b3e.png), [mảnh 6](images/4_tros_nutr_1_0--2d63851839.png), [mảnh 7](images/4_tros_1_0--8113c2c79f.png) |
| `harvest0` | `trosnik_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_tros_nutr_2_0--cbb3d84b3e.png), [mảnh 6](images/4_tros_nutr_1_0--2d63851839.png), [mảnh 7](images/4_tros_1_0--8113c2c79f.png) |

**Công thức nguồn dùng sản phẩm này**

| Cơ sở | Sản phẩm làm ra | Cần mỗi mẻ | Điều kiện bundle nguồn |
| --- | --- | ---: | --- |
| Máy Chế Biến Đường (`sugar_processor`) | Đường Nâu | 2 | Không có nhãn bundle |

**Trước khi đưa vào game**

Dựng prefab đúng pivot/tỉ lệ và thứ tự vẽ, kiểm tra các pose trên map; chốt giá/thời lượng/sản lượng Farm; nối catalog, kho, save và UI; thử gieo/thu/reload hoặc chu kỳ cây lâu năm. Không dùng source ID số làm ID Farm tự động.

Nguồn APK/hash, object ID, pivot, pixels-per-unit, clip và công thức được ghi trong `crop.json`. README và hồ sơ được tạo bởi `cocos/tools/prepare-crop-sources.py`.
