# Bụi Dâu Tây — `strawberry_bush`

[Danh mục](../../README.md) · [Bản xem ảnh](../../index.html) · [Hồ sơ JSON](crop.json)

**Thư mục nguồn không được runtime nạp trực tiếp.** Nhãn khảo sát gốc: C5 — mở rộng vườn quả.

![Icon](icon.png)

| Thuộc tính | Dữ liệu nguồn |
| --- | --- |
| Nhóm | Cây / bụi ăn quả |
| Sản phẩm | Dâu Tây (`strawbery`, source ID 143) |
| Thu mỗi đợt nguồn | 5 |
| Thời gian nguồn | 2400 giây |
| Cấp công thức / item nguồn | 6 / 6 |
| Chi phí mỗi lượt nguồn | Không có nguyên liệu mỗi lượt; mua cây qua cửa hàng là giao dịch riêng |
| `BasicPrice` / `ExpOnUse` nguồn | 7 / 4 — chưa khẳng định là giá bán/XP thu hoạch Farm |
| Tệp PNG riêng trong thư mục | 14 |
| Số lượt bắt đầu mọc nguồn | 4 |
| Dụng cụ dọn cây | 1 Xẻng |
| Drop bảo đảm khi dọn | 1 Dây Thừng |

Thời gian ở đây là **giây nguồn APK**, không phải giờ mô phỏng Farm. Cấp mở còn phụ thuộc công trình/shop/điều kiện. Với cây lâu năm, nhận hết đợt cuối mới chuyển sang cây cạn lượt; không mất quả khi số lượt bắt đầu mọc đã về 0.

**Ảnh theo role / giai đoạn nguồn**

Ảnh nằm trong `images/`, được dùng chung giữa các role khi nguồn trỏ cùng sprite. Một dòng có nhiều PNG là nhiều mảnh tham chiếu, không phải nhiều cây hoàn chỉnh. Chưa có thông tin ghép transform/hierarchy đầy đủ trong bộ ảnh này.

| Role nguồn | Clip | Các mảnh PNG |
| --- | --- | --- |
| `dead` | `strawberry_4` | [mảnh 1](images/0_klub_1_0--f461a341b6.png), [mảnh 2](images/4_klub_2_0--4c018620ee.png), [mảnh 3](images/0_klub_3_0--c9a809d72c.png), [mảnh 4](images/4_klub_1_0--97f12b3110.png) |
| `idle` | `strawberry_3_0` | [mảnh 1](images/0_klub_1_0--f461a341b6.png), [mảnh 2](images/0_klub_2_0--9bfd33f14a.png), [mảnh 3](images/0_klub_3_0--c9a809d72c.png), [mảnh 4](images/3_klub_2_0--515892eacd.png), [mảnh 5](images/3_klub_1_0--14a7ee6f91.png), [mảnh 6](images/3_klub_3_0--e437f63e1a.png), [mảnh 7](images/3_klub_4_0--a8a3601cb9.png), [mảnh 8](images/3_klub_5_0--c6d0ab965d.png) |
| `grow0` | `strawberry_3_0` | [mảnh 1](images/0_klub_1_0--f461a341b6.png), [mảnh 2](images/0_klub_2_0--9bfd33f14a.png), [mảnh 3](images/0_klub_3_0--c9a809d72c.png), [mảnh 4](images/3_klub_2_0--515892eacd.png), [mảnh 5](images/3_klub_1_0--14a7ee6f91.png), [mảnh 6](images/3_klub_3_0--e437f63e1a.png), [mảnh 7](images/3_klub_4_0--a8a3601cb9.png), [mảnh 8](images/3_klub_5_0--c6d0ab965d.png) |
| `grow1` | `strawberry_1` | [mảnh 1](images/0_klub_1_0--f461a341b6.png), [mảnh 2](images/0_klub_2_0--9bfd33f14a.png), [mảnh 3](images/0_klub_3_0--c9a809d72c.png), [mảnh 4](images/1_klub_0--50ed31f88f.png) |
| `grow2` | `strawberry_2` | [mảnh 1](images/0_klub_1_0--f461a341b6.png), [mảnh 2](images/0_klub_2_0--9bfd33f14a.png), [mảnh 3](images/0_klub_3_0--c9a809d72c.png), [mảnh 4](images/2_klub_0--afd06ad060.png) |
| `grow3` | `strawberry_2` | [mảnh 1](images/0_klub_1_0--f461a341b6.png), [mảnh 2](images/0_klub_2_0--9bfd33f14a.png), [mảnh 3](images/0_klub_3_0--c9a809d72c.png), [mảnh 4](images/2_klub_0--afd06ad060.png) |
| `grow0` | `grow0` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `ready2` | `strawberry_3_2` | [mảnh 1](images/0_klub_1_0--f461a341b6.png), [mảnh 2](images/0_klub_2_0--9bfd33f14a.png), [mảnh 3](images/0_klub_3_0--c9a809d72c.png), [mảnh 4](images/3_klub_2_0--515892eacd.png), [mảnh 5](images/3_klub_1_0--14a7ee6f91.png), [mảnh 6](images/3_klub_3_0--e437f63e1a.png), [mảnh 7](images/3_klub_4_0--a8a3601cb9.png), [mảnh 8](images/3_klub_5_0--c6d0ab965d.png) |
| `ready3` | `strawberry_3_3` | [mảnh 1](images/0_klub_1_0--f461a341b6.png), [mảnh 2](images/0_klub_2_0--9bfd33f14a.png), [mảnh 3](images/0_klub_3_0--c9a809d72c.png), [mảnh 4](images/3_klub_2_0--515892eacd.png), [mảnh 5](images/3_klub_1_0--14a7ee6f91.png), [mảnh 6](images/3_klub_3_0--e437f63e1a.png), [mảnh 7](images/3_klub_4_0--a8a3601cb9.png), [mảnh 8](images/3_klub_5_0--c6d0ab965d.png) |
| `ready4` | `strawberry_3_4` | [mảnh 1](images/0_klub_1_0--f461a341b6.png), [mảnh 2](images/0_klub_2_0--9bfd33f14a.png), [mảnh 3](images/0_klub_3_0--c9a809d72c.png), [mảnh 4](images/3_klub_2_0--515892eacd.png), [mảnh 5](images/3_klub_1_0--14a7ee6f91.png), [mảnh 6](images/3_klub_3_0--e437f63e1a.png), [mảnh 7](images/3_klub_4_0--a8a3601cb9.png), [mảnh 8](images/3_klub_5_0--c6d0ab965d.png) |
| `ready5` | `strawberry_3_5` | [mảnh 1](images/0_klub_1_0--f461a341b6.png), [mảnh 2](images/0_klub_2_0--9bfd33f14a.png), [mảnh 3](images/0_klub_3_0--c9a809d72c.png), [mảnh 4](images/3_klub_2_0--515892eacd.png), [mảnh 5](images/3_klub_1_0--14a7ee6f91.png), [mảnh 6](images/3_klub_3_0--e437f63e1a.png), [mảnh 7](images/3_klub_4_0--a8a3601cb9.png), [mảnh 8](images/3_klub_5_0--c6d0ab965d.png) |
| `ready1` | `strawberry_3_1` | [mảnh 1](images/0_klub_1_0--f461a341b6.png), [mảnh 2](images/0_klub_2_0--9bfd33f14a.png), [mảnh 3](images/0_klub_3_0--c9a809d72c.png), [mảnh 4](images/3_klub_2_0--515892eacd.png), [mảnh 5](images/3_klub_1_0--14a7ee6f91.png), [mảnh 6](images/3_klub_3_0--e437f63e1a.png), [mảnh 7](images/3_klub_4_0--a8a3601cb9.png), [mảnh 8](images/3_klub_5_0--c6d0ab965d.png) |
| `harvest2` | `strawberry_3_2` | [mảnh 1](images/0_klub_1_0--f461a341b6.png), [mảnh 2](images/0_klub_2_0--9bfd33f14a.png), [mảnh 3](images/0_klub_3_0--c9a809d72c.png), [mảnh 4](images/3_klub_2_0--515892eacd.png), [mảnh 5](images/3_klub_1_0--14a7ee6f91.png), [mảnh 6](images/3_klub_3_0--e437f63e1a.png), [mảnh 7](images/3_klub_4_0--a8a3601cb9.png), [mảnh 8](images/3_klub_5_0--c6d0ab965d.png) |
| `harvest3` | `strawberry_3_3` | [mảnh 1](images/0_klub_1_0--f461a341b6.png), [mảnh 2](images/0_klub_2_0--9bfd33f14a.png), [mảnh 3](images/0_klub_3_0--c9a809d72c.png), [mảnh 4](images/3_klub_2_0--515892eacd.png), [mảnh 5](images/3_klub_1_0--14a7ee6f91.png), [mảnh 6](images/3_klub_3_0--e437f63e1a.png), [mảnh 7](images/3_klub_4_0--a8a3601cb9.png), [mảnh 8](images/3_klub_5_0--c6d0ab965d.png) |
| `harvest4` | `strawberry_3_4` | [mảnh 1](images/0_klub_1_0--f461a341b6.png), [mảnh 2](images/0_klub_2_0--9bfd33f14a.png), [mảnh 3](images/0_klub_3_0--c9a809d72c.png), [mảnh 4](images/3_klub_2_0--515892eacd.png), [mảnh 5](images/3_klub_1_0--14a7ee6f91.png), [mảnh 6](images/3_klub_3_0--e437f63e1a.png), [mảnh 7](images/3_klub_4_0--a8a3601cb9.png), [mảnh 8](images/3_klub_5_0--c6d0ab965d.png) |
| `harvest1` | `strawberry_3_1` | [mảnh 1](images/0_klub_1_0--f461a341b6.png), [mảnh 2](images/0_klub_2_0--9bfd33f14a.png), [mảnh 3](images/0_klub_3_0--c9a809d72c.png), [mảnh 4](images/3_klub_2_0--515892eacd.png), [mảnh 5](images/3_klub_1_0--14a7ee6f91.png), [mảnh 6](images/3_klub_3_0--e437f63e1a.png), [mảnh 7](images/3_klub_4_0--a8a3601cb9.png), [mảnh 8](images/3_klub_5_0--c6d0ab965d.png) |
| `harvest0` | `strawberry_3_0` | [mảnh 1](images/0_klub_1_0--f461a341b6.png), [mảnh 2](images/0_klub_2_0--9bfd33f14a.png), [mảnh 3](images/0_klub_3_0--c9a809d72c.png), [mảnh 4](images/3_klub_2_0--515892eacd.png), [mảnh 5](images/3_klub_1_0--14a7ee6f91.png), [mảnh 6](images/3_klub_3_0--e437f63e1a.png), [mảnh 7](images/3_klub_4_0--a8a3601cb9.png), [mảnh 8](images/3_klub_5_0--c6d0ab965d.png) |

**Công thức nguồn dùng sản phẩm này**

| Cơ sở | Sản phẩm làm ra | Cần mỗi mẻ | Điều kiện bundle nguồn |
| --- | --- | ---: | --- |
| Máy Chế Biến Đường (`sugar_processor`) | Kẹo Dẻo Hình Giun | 1 | halloween |
| Máy Xay Sinh Tố (`blender`) | Sinh Tố Dâu Tây | 3 | Không có nhãn bundle |
| Nhà Sản Xuất Sữa (`milk_factory`) | Cocktail Hình Con Mắt | 1 | halloween |
| Nhà Sản Xuất Sữa (`milk_factory`) | Sữa Chua Dâu Tây | 2 | Không có nhãn bundle |
| Nhà Sản Xuất Sữa (`milk_factory`) | Kem Dâu Tây | 2 | Không có nhãn bundle |
| Nhà Máy Mứt (`jam_factory`) | Mứt Dâu Tây | 3 | Không có nhãn bundle |
| Tiệm Bánh Kem (`cake_bakery`) | Bánh Phô Mai | 2 | Không có nhãn bundle |

**Trước khi đưa vào game**

Dựng prefab đúng pivot/tỉ lệ và thứ tự vẽ, kiểm tra các pose trên map; chốt giá/thời lượng/sản lượng Farm; nối catalog, kho, save và UI; thử gieo/thu/reload hoặc chu kỳ cây lâu năm. Không dùng source ID số làm ID Farm tự động.

Nguồn APK/hash, object ID, pivot, pixels-per-unit, clip và công thức được ghi trong `crop.json`. README và hồ sơ được tạo bởi `cocos/tools/prepare-crop-sources.py`.
