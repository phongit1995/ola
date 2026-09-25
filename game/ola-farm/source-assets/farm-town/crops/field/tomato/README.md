# Cà Chua — `tomato`

[Danh mục](../../README.md) · [Bản xem ảnh](../../index.html) · [Hồ sơ JSON](crop.json)

**Thư mục nguồn không được runtime nạp trực tiếp.** Nhãn khảo sát gốc: REF — đối chiếu, giữ art Farm hiện có.

![Icon](icon.png)

| Thuộc tính | Dữ liệu nguồn |
| --- | --- |
| Nhóm | Cây ruộng |
| Sản phẩm | Cà Chua (`tomato`, source ID 150) |
| Thu mỗi đợt nguồn | 1 |
| Thời gian nguồn | 5100 giây |
| Cấp công thức / item nguồn | 31 / 31 |
| Chi phí mỗi lượt nguồn | 6 Xu |
| `BasicPrice` / `ExpOnUse` nguồn | 26 / 13 — chưa khẳng định là giá bán/XP thu hoạch Farm |
| Tệp PNG riêng trong thư mục | 17 |

Thời gian ở đây là **giây nguồn APK**, không phải giờ mô phỏng Farm. Cấp mở còn phụ thuộc công trình/shop/điều kiện. Với cây lâu năm, nhận hết đợt cuối mới chuyển sang cây cạn lượt; không mất quả khi số lượt bắt đầu mọc đã về 0.

**Ảnh theo role / giai đoạn nguồn**

Ảnh nằm trong `images/`, được dùng chung giữa các role khi nguồn trỏ cùng sprite. Một dòng có nhiều PNG là nhiều mảnh tham chiếu, không phải nhiều cây hoàn chỉnh. Chưa có thông tin ghép transform/hierarchy đầy đủ trong bộ ảnh này.

| Role nguồn | Clip | Các mảnh PNG |
| --- | --- | --- |
| `dead` | `idle` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `idle` | `idle` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `grow0` | `pomidor_1` | [mảnh 1](images/pom_1_0--55ac4dd69c.png) |
| `grow1` | `pomidor_2` | [mảnh 1](images/pom_2_0--ce1a60a800.png) |
| `grow2` | `pomidor_2` | [mảnh 1](images/pom_2_0--ce1a60a800.png) |
| `grow3` | `pomidor_2` | [mảnh 1](images/pom_2_0--ce1a60a800.png) |
| `grow0` | `grow0` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `ready2` | `pomidor_3` | [mảnh 1](images/pom_3ten_0--5ad064f56a.png), [mảnh 2](images/pom_334_0--6f21c53605.png), [mảnh 3](images/pom_33_0--7c556d71e6.png), [mảnh 4](images/pom_32_0--8993274f36.png), [mảnh 5](images/pom_31_0--3727ec9b37.png) |
| `ready3` | `pomidor_3` | [mảnh 1](images/pom_3ten_0--5ad064f56a.png), [mảnh 2](images/pom_334_0--6f21c53605.png), [mảnh 3](images/pom_33_0--7c556d71e6.png), [mảnh 4](images/pom_32_0--8993274f36.png), [mảnh 5](images/pom_31_0--3727ec9b37.png) |
| `ready4` | `pomidor_3` | [mảnh 1](images/pom_3ten_0--5ad064f56a.png), [mảnh 2](images/pom_334_0--6f21c53605.png), [mảnh 3](images/pom_33_0--7c556d71e6.png), [mảnh 4](images/pom_32_0--8993274f36.png), [mảnh 5](images/pom_31_0--3727ec9b37.png) |
| `ready5` | `pomidor_3` | [mảnh 1](images/pom_3ten_0--5ad064f56a.png), [mảnh 2](images/pom_334_0--6f21c53605.png), [mảnh 3](images/pom_33_0--7c556d71e6.png), [mảnh 4](images/pom_32_0--8993274f36.png), [mảnh 5](images/pom_31_0--3727ec9b37.png) |
| `ready1` | `pomidor_3` | [mảnh 1](images/pom_3ten_0--5ad064f56a.png), [mảnh 2](images/pom_334_0--6f21c53605.png), [mảnh 3](images/pom_33_0--7c556d71e6.png), [mảnh 4](images/pom_32_0--8993274f36.png), [mảnh 5](images/pom_31_0--3727ec9b37.png) |
| `harvest2` | `pomidor_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_pom_nutr_4_0--1d03ff4be3.png), [mảnh 6](images/4_pom_nutr_2_0--8221fd96bb.png), [mảnh 7](images/4_pom_nutr_1_0--f67471ebf5.png), [mảnh 8](images/4_pom_2_0--42a2192d98.png), [mảnh 9](images/4_pom_1_0--9ba628addf.png) |
| `harvest3` | `pomidor_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_pom_nutr_4_0--1d03ff4be3.png), [mảnh 6](images/4_pom_nutr_2_0--8221fd96bb.png), [mảnh 7](images/4_pom_nutr_1_0--f67471ebf5.png), [mảnh 8](images/4_pom_2_0--42a2192d98.png), [mảnh 9](images/4_pom_1_0--9ba628addf.png) |
| `harvest4` | `pomidor_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_pom_nutr_4_0--1d03ff4be3.png), [mảnh 6](images/4_pom_nutr_2_0--8221fd96bb.png), [mảnh 7](images/4_pom_nutr_1_0--f67471ebf5.png), [mảnh 8](images/4_pom_2_0--42a2192d98.png), [mảnh 9](images/4_pom_1_0--9ba628addf.png) |
| `harvest1` | `pomidor_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_pom_nutr_4_0--1d03ff4be3.png), [mảnh 6](images/4_pom_nutr_2_0--8221fd96bb.png), [mảnh 7](images/4_pom_nutr_1_0--f67471ebf5.png), [mảnh 8](images/4_pom_2_0--42a2192d98.png), [mảnh 9](images/4_pom_1_0--9ba628addf.png) |
| `harvest0` | `pomidor_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_pom_nutr_4_0--1d03ff4be3.png), [mảnh 6](images/4_pom_nutr_2_0--8221fd96bb.png), [mảnh 7](images/4_pom_nutr_1_0--f67471ebf5.png), [mảnh 8](images/4_pom_2_0--42a2192d98.png), [mảnh 9](images/4_pom_1_0--9ba628addf.png) |

**Công thức nguồn dùng sản phẩm này**

| Cơ sở | Sản phẩm làm ra | Cần mỗi mẻ | Điều kiện bundle nguồn |
| --- | --- | ---: | --- |
| Lò Pizza (`pizza_bakery`) | Pizza Margherita | 2 | Không có nhãn bundle |
| Chảo Wok (`noodle_factory`) | Mì Heo | 2 | Không có nhãn bundle |
| Máy Ép Nước (`drinks`) | Nước Cà Chua | 2 | Không có nhãn bundle |
| Sản Xuất Súp (`soup_manufacture`) | Súp Cà Chua | 1 | Không có nhãn bundle |
| Đồ Ăn Mexico (`mexico`) | Bánh Burrito | 2 | Không có nhãn bundle |
| Đồ Ăn Mexico (`mexico`) | Bánh Enchiladas | 1 | Không có nhãn bundle |
| Đồ Ăn Mexico (`mexico`) | Bánh Nachos | 2 | Không có nhãn bundle |
| Lò Nướng (`oven`) | Xúc Xích Hotdog | 3 | Không có nhãn bundle |

**Trước khi đưa vào game**

Dựng prefab đúng pivot/tỉ lệ và thứ tự vẽ, kiểm tra các pose trên map; chốt giá/thời lượng/sản lượng Farm; nối catalog, kho, save và UI; thử gieo/thu/reload hoặc chu kỳ cây lâu năm. Giữ hình và ID giống hiện tại, dùng bộ nguồn này để đối chiếu.

Nguồn APK/hash, object ID, pivot, pixels-per-unit, clip và công thức được ghi trong `crop.json`. README và hồ sơ được tạo bởi `cocos/tools/prepare-crop-sources.py`.
