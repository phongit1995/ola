# Cà Rốt — `carrot`

[Danh mục](../../README.md) · [Bản xem ảnh](../../index.html) · [Hồ sơ JSON](crop.json)

**Thư mục nguồn không được runtime nạp trực tiếp.** Nhãn khảo sát gốc: C2 — đường và thức ăn heo/cừu.

![Icon](icon.png)

| Thuộc tính | Dữ liệu nguồn |
| --- | --- |
| Nhóm | Cây ruộng |
| Sản phẩm | Cà Rốt (`carrot`, source ID 29) |
| Thu mỗi đợt nguồn | 1 |
| Thời gian nguồn | 1800 giây |
| Cấp công thức / item nguồn | 8 / 8 |
| Chi phí mỗi lượt nguồn | 3 Xu |
| `BasicPrice` / `ExpOnUse` nguồn | 12 / 6 — chưa khẳng định là giá bán/XP thu hoạch Farm |
| Tệp PNG riêng trong thư mục | 13 |

Thời gian ở đây là **giây nguồn APK**, không phải giờ mô phỏng Farm. Cấp mở còn phụ thuộc công trình/shop/điều kiện. Với cây lâu năm, nhận hết đợt cuối mới chuyển sang cây cạn lượt; không mất quả khi số lượt bắt đầu mọc đã về 0.

**Ảnh theo role / giai đoạn nguồn**

Ảnh nằm trong `images/`, được dùng chung giữa các role khi nguồn trỏ cùng sprite. Một dòng có nhiều PNG là nhiều mảnh tham chiếu, không phải nhiều cây hoàn chỉnh. Chưa có thông tin ghép transform/hierarchy đầy đủ trong bộ ảnh này.

| Role nguồn | Clip | Các mảnh PNG |
| --- | --- | --- |
| `dead` | `idle` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `idle` | `idle` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `grow0` | `morkov_1` | [mảnh 1](images/mork_1_0--b7b0239d00.png) |
| `grow1` | `morkov_2` | [mảnh 1](images/mork_2_0--48fcb22a60.png) |
| `grow2` | `morkov_2` | [mảnh 1](images/mork_2_0--48fcb22a60.png) |
| `grow3` | `morkov_2` | [mảnh 1](images/mork_2_0--48fcb22a60.png) |
| `grow0` | `grow0` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `ready2` | `morkov_3` | [mảnh 1](images/mork_3ten_0--44efd39cf2.png), [mảnh 2](images/mork_3_0--c65b56eb8b.png) |
| `ready3` | `morkov_3` | [mảnh 1](images/mork_3ten_0--44efd39cf2.png), [mảnh 2](images/mork_3_0--c65b56eb8b.png) |
| `ready4` | `morkov_3` | [mảnh 1](images/mork_3ten_0--44efd39cf2.png), [mảnh 2](images/mork_3_0--c65b56eb8b.png) |
| `ready5` | `morkov_3` | [mảnh 1](images/mork_3ten_0--44efd39cf2.png), [mảnh 2](images/mork_3_0--c65b56eb8b.png) |
| `ready1` | `morkov_3` | [mảnh 1](images/mork_3ten_0--44efd39cf2.png), [mảnh 2](images/mork_3_0--c65b56eb8b.png) |
| `harvest2` | `morkov_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_mor_nutr_2_0--0c3c7b9d80.png), [mảnh 6](images/4_mor_2_0--ba82bfe63a.png), [mảnh 7](images/4_mor_1_0--445eea10fe.png), [mảnh 8](images/4_mor_ten_0--cb628d9095.png) |
| `harvest3` | `morkov_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_mor_nutr_2_0--0c3c7b9d80.png), [mảnh 6](images/4_mor_2_0--ba82bfe63a.png), [mảnh 7](images/4_mor_1_0--445eea10fe.png), [mảnh 8](images/4_mor_ten_0--cb628d9095.png) |
| `harvest4` | `morkov_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_mor_nutr_2_0--0c3c7b9d80.png), [mảnh 6](images/4_mor_2_0--ba82bfe63a.png), [mảnh 7](images/4_mor_1_0--445eea10fe.png), [mảnh 8](images/4_mor_ten_0--cb628d9095.png) |
| `harvest1` | `morkov_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_mor_nutr_2_0--0c3c7b9d80.png), [mảnh 6](images/4_mor_2_0--ba82bfe63a.png), [mảnh 7](images/4_mor_1_0--445eea10fe.png), [mảnh 8](images/4_mor_ten_0--cb628d9095.png) |
| `harvest0` | `morkov_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_mor_nutr_2_0--0c3c7b9d80.png), [mảnh 6](images/4_mor_2_0--ba82bfe63a.png), [mảnh 7](images/4_mor_1_0--445eea10fe.png), [mảnh 8](images/4_mor_ten_0--cb628d9095.png) |

**Công thức nguồn dùng sản phẩm này**

| Cơ sở | Sản phẩm làm ra | Cần mỗi mẻ | Điều kiện bundle nguồn |
| --- | --- | ---: | --- |
| Lò Ngô (`popcorn_factory`) | Khoai Mandrake Chiên | 1 | halloween |
| Máy Chế Biến Thực Phẩm (`food_processor`) | Thức Ăn Heo | 2 | Không có nhãn bundle |
| Sản Xuất Súp (`soup_manufacture`) | Súp Cà Chua | 1 | Không có nhãn bundle |
| Tiệm Bánh Kem (`cake_bakery`) | Bánh Cà Rốt | 2 | Không có nhãn bundle |

**Trước khi đưa vào game**

Dựng prefab đúng pivot/tỉ lệ và thứ tự vẽ, kiểm tra các pose trên map; chốt giá/thời lượng/sản lượng Farm; nối catalog, kho, save và UI; thử gieo/thu/reload hoặc chu kỳ cây lâu năm. Không dùng source ID số làm ID Farm tự động.

Nguồn APK/hash, object ID, pivot, pixels-per-unit, clip và công thức được ghi trong `crop.json`. README và hồ sơ được tạo bởi `cocos/tools/prepare-crop-sources.py`.
