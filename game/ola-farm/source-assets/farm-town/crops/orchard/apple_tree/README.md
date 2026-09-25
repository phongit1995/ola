# Cây Táo — `apple_tree`

[Danh mục](../../README.md) · [Bản xem ảnh](../../index.html) · [Hồ sơ JSON](crop.json)

**Thư mục nguồn không được runtime nạp trực tiếp.** Nhãn khảo sát gốc: C4 — vườn táo đầu tiên.

![Icon](icon.png)

| Thuộc tính | Dữ liệu nguồn |
| --- | --- |
| Nhóm | Cây / bụi ăn quả |
| Sản phẩm | Táo (`apple`, source ID 1) |
| Thu mỗi đợt nguồn | 5 |
| Thời gian nguồn | 5400 giây |
| Cấp công thức / item nguồn | 6 / 6 |
| Chi phí mỗi lượt nguồn | Không có nguyên liệu mỗi lượt; mua cây qua cửa hàng là giao dịch riêng |
| `BasicPrice` / `ExpOnUse` nguồn | 11 / 6 — chưa khẳng định là giá bán/XP thu hoạch Farm |
| Tệp PNG riêng trong thư mục | 9 |
| Số lượt bắt đầu mọc nguồn | 3 |
| Dụng cụ dọn cây | 1 Cưa |
| Drop bảo đảm khi dọn | 1 Ván Gỗ |

Thời gian ở đây là **giây nguồn APK**, không phải giờ mô phỏng Farm. Cấp mở còn phụ thuộc công trình/shop/điều kiện. Với cây lâu năm, nhận hết đợt cuối mới chuyển sang cây cạn lượt; không mất quả khi số lượt bắt đầu mọc đã về 0.

**Ảnh theo role / giai đoạn nguồn**

Ảnh nằm trong `images/`, được dùng chung giữa các role khi nguồn trỏ cùng sprite. Một dòng có nhiều PNG là nhiều mảnh tham chiếu, không phải nhiều cây hoàn chỉnh. Chưa có thông tin ghép transform/hierarchy đầy đủ trong bộ ảnh này.

| Role nguồn | Clip | Các mảnh PNG |
| --- | --- | --- |
| `dead` | `apple_4` | [mảnh 1](images/yablonya_off2_0--ddf32e5a05.png), [mảnh 2](images/yablonya_off_0--818e1dae18.png) |
| `idle` | `apple_3_0` | [mảnh 1](images/yablonya_on_0--8769d28273.png), [mảnh 2](images/apple_3_0--70a7044a9b.png), [mảnh 3](images/yablonya_dop_3_0--35a70b9169.png) |
| `grow0` | `apple_3_0` | [mảnh 1](images/yablonya_on_0--8769d28273.png), [mảnh 2](images/apple_3_0--70a7044a9b.png), [mảnh 3](images/yablonya_dop_3_0--35a70b9169.png) |
| `grow1` | `apple_1` | [mảnh 1](images/yablonya_on_0--8769d28273.png), [mảnh 2](images/yablonya_1_0--5750105b05.png), [mảnh 3](images/yablonya_dop_3_0--35a70b9169.png) |
| `grow2` | `apple_2` | [mảnh 1](images/apple_2_0--85e45083a4.png), [mảnh 2](images/yablonya_on_0--8769d28273.png), [mảnh 3](images/yablonya_dop_3_0--35a70b9169.png) |
| `grow3` | `apple_2` | [mảnh 1](images/apple_2_0--85e45083a4.png), [mảnh 2](images/yablonya_on_0--8769d28273.png), [mảnh 3](images/yablonya_dop_3_0--35a70b9169.png) |
| `grow0` | `grow0` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `ready2` | `apple_3_2` | [mảnh 1](images/yablonya_on_0--8769d28273.png), [mảnh 2](images/apple_3_0--70a7044a9b.png), [mảnh 3](images/yablonya_dop_3_0--35a70b9169.png) |
| `ready3` | `apple_3_3` | [mảnh 1](images/yablonya_on_0--8769d28273.png), [mảnh 2](images/apple_3_0--70a7044a9b.png), [mảnh 3](images/yablonya_dop_3_0--35a70b9169.png) |
| `ready4` | `apple_3_4` | [mảnh 1](images/yablonya_on_0--8769d28273.png), [mảnh 2](images/apple_3_0--70a7044a9b.png), [mảnh 3](images/yablonya_dop_3_0--35a70b9169.png) |
| `ready5` | `apple_3_5` | [mảnh 1](images/yablonya_on_0--8769d28273.png), [mảnh 2](images/apple_3_0--70a7044a9b.png), [mảnh 3](images/yablonya_dop_3_0--35a70b9169.png) |
| `ready1` | `apple_3_1` | [mảnh 1](images/yablonya_on_0--8769d28273.png), [mảnh 2](images/apple_3_0--70a7044a9b.png), [mảnh 3](images/yablonya_dop_3_0--35a70b9169.png) |
| `harvest2` | `apple_3_2` | [mảnh 1](images/yablonya_on_0--8769d28273.png), [mảnh 2](images/apple_3_0--70a7044a9b.png), [mảnh 3](images/yablonya_dop_3_0--35a70b9169.png) |
| `harvest3` | `apple_3_3` | [mảnh 1](images/yablonya_on_0--8769d28273.png), [mảnh 2](images/apple_3_0--70a7044a9b.png), [mảnh 3](images/yablonya_dop_3_0--35a70b9169.png) |
| `harvest4` | `apple_3_4` | [mảnh 1](images/yablonya_on_0--8769d28273.png), [mảnh 2](images/apple_3_0--70a7044a9b.png), [mảnh 3](images/yablonya_dop_3_0--35a70b9169.png) |
| `harvest1` | `apple_3_1` | [mảnh 1](images/yablonya_on_0--8769d28273.png), [mảnh 2](images/apple_3_0--70a7044a9b.png), [mảnh 3](images/yablonya_dop_3_0--35a70b9169.png) |
| `harvest0` | `apple_3_0` | [mảnh 1](images/yablonya_on_0--8769d28273.png), [mảnh 2](images/apple_3_0--70a7044a9b.png), [mảnh 3](images/yablonya_dop_3_0--35a70b9169.png) |

**Công thức nguồn dùng sản phẩm này**

| Cơ sở | Sản phẩm làm ra | Cần mỗi mẻ | Điều kiện bundle nguồn |
| --- | --- | ---: | --- |
| Máy Chế Biến Đường (`sugar_processor`) | Kẹo Dẻo Hình Giun | 1 | halloween |
| Tiệm Bánh (`bakery`) | Bánh Quy Táo | 1 | halloween |
| Máy Ép Nước (`drinks`) | Nước Táo | 2 | Không có nhãn bundle |
| Lò Nướng (`oven`) | Táo Caramen | 2 | halloween |
| Tiệm Bánh Pie (`pie_bakery`) | Bánh Táo | 1 | Không có nhãn bundle |
| Nhà Máy Mứt (`jam_factory`) | Mứt Táo | 3 | Không có nhãn bundle |

**Trước khi đưa vào game**

Dựng prefab đúng pivot/tỉ lệ và thứ tự vẽ, kiểm tra các pose trên map; chốt giá/thời lượng/sản lượng Farm; nối catalog, kho, save và UI; thử gieo/thu/reload hoặc chu kỳ cây lâu năm. Không dùng source ID số làm ID Farm tự động.

Nguồn APK/hash, object ID, pivot, pixels-per-unit, clip và công thức được ghi trong `crop.json`. README và hồ sơ được tạo bởi `cocos/tools/prepare-crop-sources.py`.
