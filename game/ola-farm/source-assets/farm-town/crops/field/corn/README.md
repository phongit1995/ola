# Ngô — `corn`

[Danh mục](../../README.md) · [Bản xem ảnh](../../index.html) · [Hồ sơ JSON](crop.json)

**Thư mục nguồn không được runtime nạp trực tiếp.** Nhãn khảo sát gốc: C1 — ngô và bắp cải.

![Icon](icon.png)

| Thuộc tính | Dữ liệu nguồn |
| --- | --- |
| Nhóm | Cây ruộng |
| Sản phẩm | Ngô (`corn`, source ID 42) |
| Thu mỗi đợt nguồn | 1 |
| Thời gian nguồn | 90 giây |
| Cấp công thức / item nguồn | 2 / 2 |
| Chi phí mỗi lượt nguồn | 1 Xu |
| `BasicPrice` / `ExpOnUse` nguồn | 4 / 2 — chưa khẳng định là giá bán/XP thu hoạch Farm |
| Tệp PNG riêng trong thư mục | 16 |

Thời gian ở đây là **giây nguồn APK**, không phải giờ mô phỏng Farm. Cấp mở còn phụ thuộc công trình/shop/điều kiện. Với cây lâu năm, nhận hết đợt cuối mới chuyển sang cây cạn lượt; không mất quả khi số lượt bắt đầu mọc đã về 0.

**Ảnh theo role / giai đoạn nguồn**

Ảnh nằm trong `images/`, được dùng chung giữa các role khi nguồn trỏ cùng sprite. Một dòng có nhiều PNG là nhiều mảnh tham chiếu, không phải nhiều cây hoàn chỉnh. Chưa có thông tin ghép transform/hierarchy đầy đủ trong bộ ảnh này.

| Role nguồn | Clip | Các mảnh PNG |
| --- | --- | --- |
| `dead` | `idle` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `idle` | `idle` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `grow0` | `kukuruza_1` | [mảnh 1](images/kuk_1_0--d0aa206b85.png) |
| `grow1` | `kukuruza_2` | [mảnh 1](images/kuk_2_0--13e0737399.png) |
| `grow2` | `kukuruza_2` | [mảnh 1](images/kuk_2_0--13e0737399.png) |
| `grow3` | `kukuruza_2` | [mảnh 1](images/kuk_2_0--13e0737399.png) |
| `grow0` | `grow0` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `ready2` | `kukuruza_3` | [mảnh 1](images/kuk_3ten_0--bd258771b4.png), [mảnh 2](images/kuk_33_0--4d371294da.png), [mảnh 3](images/kuk_32_0--03e321c40b.png), [mảnh 4](images/kuk_31_0--630f2d04d1.png) |
| `ready3` | `kukuruza_3` | [mảnh 1](images/kuk_3ten_0--bd258771b4.png), [mảnh 2](images/kuk_33_0--4d371294da.png), [mảnh 3](images/kuk_32_0--03e321c40b.png), [mảnh 4](images/kuk_31_0--630f2d04d1.png) |
| `ready4` | `kukuruza_3` | [mảnh 1](images/kuk_3ten_0--bd258771b4.png), [mảnh 2](images/kuk_33_0--4d371294da.png), [mảnh 3](images/kuk_32_0--03e321c40b.png), [mảnh 4](images/kuk_31_0--630f2d04d1.png) |
| `ready5` | `kukuruza_3` | [mảnh 1](images/kuk_3ten_0--bd258771b4.png), [mảnh 2](images/kuk_33_0--4d371294da.png), [mảnh 3](images/kuk_32_0--03e321c40b.png), [mảnh 4](images/kuk_31_0--630f2d04d1.png) |
| `ready1` | `kukuruza_3` | [mảnh 1](images/kuk_3ten_0--bd258771b4.png), [mảnh 2](images/kuk_33_0--4d371294da.png), [mảnh 3](images/kuk_32_0--03e321c40b.png), [mảnh 4](images/kuk_31_0--630f2d04d1.png) |
| `harvest2` | `kukuruza_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_kuk_nutr_3_0--4d837393a6.png), [mảnh 6](images/4_kuk_nutr_2_0--3737568ae9.png), [mảnh 7](images/4_kuk_nutr_1_0--a1489e3a45.png), [mảnh 8](images/4_kuk_2_0--842c94c576.png), [mảnh 9](images/4_kuk_1_0--fb971f08ad.png) |
| `harvest3` | `kukuruza_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_kuk_nutr_3_0--4d837393a6.png), [mảnh 6](images/4_kuk_nutr_2_0--3737568ae9.png), [mảnh 7](images/4_kuk_nutr_1_0--a1489e3a45.png), [mảnh 8](images/4_kuk_2_0--842c94c576.png), [mảnh 9](images/4_kuk_1_0--fb971f08ad.png) |
| `harvest4` | `kukuruza_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_kuk_nutr_3_0--4d837393a6.png), [mảnh 6](images/4_kuk_nutr_2_0--3737568ae9.png), [mảnh 7](images/4_kuk_nutr_1_0--a1489e3a45.png), [mảnh 8](images/4_kuk_2_0--842c94c576.png), [mảnh 9](images/4_kuk_1_0--fb971f08ad.png) |
| `harvest1` | `kukuruza_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_kuk_nutr_3_0--4d837393a6.png), [mảnh 6](images/4_kuk_nutr_2_0--3737568ae9.png), [mảnh 7](images/4_kuk_nutr_1_0--a1489e3a45.png), [mảnh 8](images/4_kuk_2_0--842c94c576.png), [mảnh 9](images/4_kuk_1_0--fb971f08ad.png) |
| `harvest0` | `kukuruza_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_kuk_nutr_3_0--4d837393a6.png), [mảnh 6](images/4_kuk_nutr_2_0--3737568ae9.png), [mảnh 7](images/4_kuk_nutr_1_0--a1489e3a45.png), [mảnh 8](images/4_kuk_2_0--842c94c576.png), [mảnh 9](images/4_kuk_1_0--fb971f08ad.png) |

**Công thức nguồn dùng sản phẩm này**

| Cơ sở | Sản phẩm làm ra | Cần mỗi mẻ | Điều kiện bundle nguồn |
| --- | --- | ---: | --- |
| Tiệm Bánh (`bakery`) | Bánh Ngô | 2 | Không có nhãn bundle |
| Tiệm Bánh (`bakery`) | Bánh Tortilla | 2 | Không có nhãn bundle |
| Tiệm Bánh (`bakery`) | Bánh Quế (Waffle) | 1 | Không có nhãn bundle |
| Lò Ngô (`popcorn_factory`) | Bỏng Ngô | 3 | Không có nhãn bundle |
| Lò Ngô (`popcorn_factory`) | Ngũ Cốc Ngô | 2 | Không có nhãn bundle |
| Lò Ngô (`popcorn_factory`) | Khoai Mandrake Chiên | 3 | halloween |
| Lò Ngô (`popcorn_factory`) | Ngũ Cốc Ngô Anh Đào | 2 | Không có nhãn bundle |
| Lò Ngô (`popcorn_factory`) | Mảnh Sôcôla | 2 | Không có nhãn bundle |
| Máy Chế Biến Thực Phẩm (`food_processor`) | Thức Ăn Chim | 1 | Không có nhãn bundle |
| Máy Chế Biến Thực Phẩm (`food_processor`) | Thức Ăn Bò | 2 | Không có nhãn bundle |

**Trước khi đưa vào game**

Dựng prefab đúng pivot/tỉ lệ và thứ tự vẽ, kiểm tra các pose trên map; chốt giá/thời lượng/sản lượng Farm; nối catalog, kho, save và UI; thử gieo/thu/reload hoặc chu kỳ cây lâu năm. Không dùng source ID số làm ID Farm tự động.

Nguồn APK/hash, object ID, pivot, pixels-per-unit, clip và công thức được ghi trong `crop.json`. README và hồ sơ được tạo bởi `cocos/tools/prepare-crop-sources.py`.
