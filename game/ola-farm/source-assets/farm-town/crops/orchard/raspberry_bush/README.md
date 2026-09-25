# Bụi Mâm Xôi — `raspberry_bush`

[Danh mục](../../README.md) · [Bản xem ảnh](../../index.html) · [Hồ sơ JSON](crop.json)

**Thư mục nguồn không được runtime nạp trực tiếp.** Nhãn khảo sát gốc: C5 — mở rộng vườn quả.

![Icon](icon.png)

| Thuộc tính | Dữ liệu nguồn |
| --- | --- |
| Nhóm | Cây / bụi ăn quả |
| Sản phẩm | Mâm Xôi (`raspbery`, source ID 131) |
| Thu mỗi đợt nguồn | 3 |
| Thời gian nguồn | 3600 giây |
| Cấp công thức / item nguồn | 21 / 21 |
| Chi phí mỗi lượt nguồn | Không có nguyên liệu mỗi lượt; mua cây qua cửa hàng là giao dịch riêng |
| `BasicPrice` / `ExpOnUse` nguồn | 7 / 4 — chưa khẳng định là giá bán/XP thu hoạch Farm |
| Tệp PNG riêng trong thư mục | 5 |
| Số lượt bắt đầu mọc nguồn | 4 |
| Dụng cụ dọn cây | 1 Xẻng |
| Drop bảo đảm khi dọn | 1 Dây Thừng |

Thời gian ở đây là **giây nguồn APK**, không phải giờ mô phỏng Farm. Cấp mở còn phụ thuộc công trình/shop/điều kiện. Với cây lâu năm, nhận hết đợt cuối mới chuyển sang cây cạn lượt; không mất quả khi số lượt bắt đầu mọc đã về 0.

**Ảnh theo role / giai đoạn nguồn**

Ảnh nằm trong `images/`, được dùng chung giữa các role khi nguồn trỏ cùng sprite. Một dòng có nhiều PNG là nhiều mảnh tham chiếu, không phải nhiều cây hoàn chỉnh. Chưa có thông tin ghép transform/hierarchy đầy đủ trong bộ ảnh này.

| Role nguồn | Clip | Các mảnh PNG |
| --- | --- | --- |
| Gán sẵn trong prefab | — | [ảnh 1](images/raspberry_bg--3b1b46e9a2.png), [ảnh 2](images/raspberry_top--ae30389da1.png), [ảnh 3](images/raspberry_ready--708a84852c.png) |
| `Idle (default)` | `Idle (default)` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `Dead` | `Dead` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `Harvest (default)` | `Harvest (default)` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `Ready (default)` | `Ready (default)` | Không có Sprite PPtr trong clip; xem ghi chú JSON |

**Công thức nguồn dùng sản phẩm này**

| Cơ sở | Sản phẩm làm ra | Cần mỗi mẻ | Điều kiện bundle nguồn |
| --- | --- | ---: | --- |
| Máy Xay Sinh Tố (`blender`) | Cocktail Mâm Xôi | 2 | Không có nhãn bundle |
| Nhà Máy Kẹo (`candy_factory`) | Kẹo Bông | 2 | Không có nhãn bundle |
| Tiệm Bánh Kem (`cake_bakery`) | Bánh Cà Rốt | 2 | Không có nhãn bundle |

**Trước khi đưa vào game**

Dựng prefab đúng pivot/tỉ lệ và thứ tự vẽ, kiểm tra các pose trên map; chốt giá/thời lượng/sản lượng Farm; nối catalog, kho, save và UI; thử gieo/thu/reload hoặc chu kỳ cây lâu năm. Không dùng source ID số làm ID Farm tự động.

Nguồn APK/hash, object ID, pivot, pixels-per-unit, clip và công thức được ghi trong `crop.json`. README và hồ sơ được tạo bởi `cocos/tools/prepare-crop-sources.py`.
