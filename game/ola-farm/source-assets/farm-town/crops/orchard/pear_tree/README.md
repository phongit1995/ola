# Quả Lê — `pear_tree`

[Danh mục](../../README.md) · [Bản xem ảnh](../../index.html) · [Hồ sơ JSON](crop.json)

**Thư mục nguồn không được runtime nạp trực tiếp.** Nhãn khảo sát gốc: C5 — mở rộng vườn quả.

![Icon](icon.png)

| Thuộc tính | Dữ liệu nguồn |
| --- | --- |
| Nhóm | Cây / bụi ăn quả |
| Sản phẩm | Quả Lê (`pear`, source ID 190) |
| Thu mỗi đợt nguồn | 5 |
| Thời gian nguồn | 9000 giây |
| Cấp công thức / item nguồn | 52 / 52 |
| Chi phí mỗi lượt nguồn | Không có nguyên liệu mỗi lượt; mua cây qua cửa hàng là giao dịch riêng |
| `BasicPrice` / `ExpOnUse` nguồn | 30 / 2 — chưa khẳng định là giá bán/XP thu hoạch Farm |
| Tệp PNG riêng trong thư mục | 10 |
| Số lượt bắt đầu mọc nguồn | 1 |
| Dụng cụ dọn cây | 1 Cưa |
| Drop bảo đảm khi dọn | Không có |

Thời gian ở đây là **giây nguồn APK**, không phải giờ mô phỏng Farm. Cấp mở còn phụ thuộc công trình/shop/điều kiện. Với cây lâu năm, nhận hết đợt cuối mới chuyển sang cây cạn lượt; không mất quả khi số lượt bắt đầu mọc đã về 0.

**Ảnh theo role / giai đoạn nguồn**

Ảnh nằm trong `images/`, được dùng chung giữa các role khi nguồn trỏ cùng sprite. Một dòng có nhiều PNG là nhiều mảnh tham chiếu, không phải nhiều cây hoàn chỉnh. Chưa có thông tin ghép transform/hierarchy đầy đủ trong bộ ảnh này.

| Role nguồn | Clip | Các mảnh PNG |
| --- | --- | --- |
| Gán sẵn trong prefab | — | [ảnh 1](images/grusha_0_0--db94f40f0a.png), [ảnh 2](images/kust_3_0--afef416234.png), [ảnh 3](images/kust_12_0--8fc984ef3f.png), [ảnh 4](images/kust_4_0--63fdd134dc.png) |
| `dead` | `field_pear_4` | [mảnh 1](images/grusha_4_0--5bee3782a4.png) |
| `idle` | `field_pear_1` | [mảnh 1](images/gr_1_0--38656efde4.png) |
| `grow0` | `field_pear_1` | [mảnh 1](images/gr_1_0--38656efde4.png) |
| `grow1` | `field_pear_2` | [mảnh 1](images/gl_2_0--a0a20911f5.png) |
| `grow2` | `grow2` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `grow3` | `grow3` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `grow0` | `grow0` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `ready2` | `field_pear_3_2` | [mảnh 1](images/gr_3_0--1d45dfb3ae.png) |
| `ready3` | `field_pear_3_3` | [mảnh 1](images/gr_3_0--1d45dfb3ae.png) |
| `ready4` | `field_pear_3_4` | [mảnh 1](images/gr_3_0--1d45dfb3ae.png) |
| `ready5` | `field_pear_3_5` | [mảnh 1](images/gr_3_0--1d45dfb3ae.png) |
| `ready1` | `field_pear_3_1` | [mảnh 1](images/gr_3_0--1d45dfb3ae.png) |
| `harvest2` | `field_pear_3_3` | [mảnh 1](images/gr_3_0--1d45dfb3ae.png) |
| `harvest3` | `field_pear_3_4` | [mảnh 1](images/gr_3_0--1d45dfb3ae.png) |
| `harvest4` | `field_pear_3_5` | [mảnh 1](images/gr_3_0--1d45dfb3ae.png) |
| `harvest1` | `field_pear_3_2` | [mảnh 1](images/gr_3_0--1d45dfb3ae.png) |
| `harvest0` | `field_pear_3_1` | [mảnh 1](images/gr_3_0--1d45dfb3ae.png) |

**Công thức nguồn dùng sản phẩm này**

| Cơ sở | Sản phẩm làm ra | Cần mỗi mẻ | Điều kiện bundle nguồn |
| --- | --- | ---: | --- |
| Lò Pizza (`pizza_bakery`) | Pizza Tráng Miệng | 2 | Không có nhãn bundle |

**Trước khi đưa vào game**

Dựng prefab đúng pivot/tỉ lệ và thứ tự vẽ, kiểm tra các pose trên map; chốt giá/thời lượng/sản lượng Farm; nối catalog, kho, save và UI; thử gieo/thu/reload hoặc chu kỳ cây lâu năm. Không dùng source ID số làm ID Farm tự động.

Nguồn APK/hash, object ID, pivot, pixels-per-unit, clip và công thức được ghi trong `crop.json`. README và hồ sơ được tạo bởi `cocos/tools/prepare-crop-sources.py`.
