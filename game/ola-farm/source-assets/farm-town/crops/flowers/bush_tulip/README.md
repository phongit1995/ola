# Hoa Tulip — `bush_tulip`

[Danh mục](../../README.md) · [Bản xem ảnh](../../index.html) · [Hồ sơ JSON](crop.json)

**Thư mục nguồn không được runtime nạp trực tiếp.** Nhãn khảo sát gốc: C6 — hoa và chuỗi trang trí.

![Icon](icon.png)

| Thuộc tính | Dữ liệu nguồn |
| --- | --- |
| Nhóm | Bụi hoa |
| Sản phẩm | Hoa Tulip (`tulip`, source ID 151) |
| Thu mỗi đợt nguồn | 1 |
| Thời gian nguồn | 120 giây |
| Cấp công thức / item nguồn | 14 / 14 |
| Chi phí mỗi lượt nguồn | Không có nguyên liệu mỗi lượt; mua cây qua cửa hàng là giao dịch riêng |
| `BasicPrice` / `ExpOnUse` nguồn | 20 / 3 — chưa khẳng định là giá bán/XP thu hoạch Farm |
| Tệp PNG riêng trong thư mục | 16 |
| Số lượt bắt đầu mọc nguồn | 5 |
| Dụng cụ dọn cây | 1 Dao Cắt |
| Drop bảo đảm khi dọn | 1 Dây Thừng |

Thời gian ở đây là **giây nguồn APK**, không phải giờ mô phỏng Farm. Cấp mở còn phụ thuộc công trình/shop/điều kiện. Với cây lâu năm, nhận hết đợt cuối mới chuyển sang cây cạn lượt; không mất quả khi số lượt bắt đầu mọc đã về 0.

**Ảnh theo role / giai đoạn nguồn**

Ảnh nằm trong `images/`, được dùng chung giữa các role khi nguồn trỏ cùng sprite. Một dòng có nhiều PNG là nhiều mảnh tham chiếu, không phải nhiều cây hoàn chỉnh. Chưa có thông tin ghép transform/hierarchy đầy đủ trong bộ ảnh này.

| Role nguồn | Clip | Các mảnh PNG |
| --- | --- | --- |
| Gán sẵn trong prefab | — | [ảnh 1](images/0_tulpan_zem_0--d82c46a7d5.png), [ảnh 2](images/0_tulpan_1_0--1c0a2b8d9a.png), [ảnh 3](images/1_tulpan_0--08237bcaf2.png), [ảnh 4](images/0_tulpan_2_0--6838ce6592.png) |
| `dead` | `tulpis_end` | [mảnh 1](images/4_tulpan_0--ae3735a5f3.png) |
| `idle` | `tulpis_1` | [mảnh 1](images/1_tulpan_0--08237bcaf2.png) |
| `grow0` | `tulpis_1` | [mảnh 1](images/1_tulpan_0--08237bcaf2.png) |
| `grow1` | `tulpis_2` | [mảnh 1](images/2_tulpan_0--d9f9ef66a3.png) |
| `grow2` | `tulpis_2` | [mảnh 1](images/2_tulpan_0--d9f9ef66a3.png) |
| `grow3` | `tulpis_2` | [mảnh 1](images/2_tulpan_0--d9f9ef66a3.png) |
| `grow0` | `grow0` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `ready2` | `tulpis_3` | [mảnh 1](images/3_tulpan_8_0--36d84b3875.png), [mảnh 2](images/3_tulpan_7_0--d55882c59c.png), [mảnh 3](images/3_tulpan_5_0--04f79e6466.png), [mảnh 4](images/3_tulpan_3_0--f3e7a3e3d8.png), [mảnh 5](images/3_tulpan_1_0--c6dfee5d56.png), [mảnh 6](images/3_tulpan_2_0--6992da4e47.png), [mảnh 7](images/3_tulpan_4_0--dfb8c78111.png), [mảnh 8](images/3_tulpan_6_0--ede73365a0.png) |
| `ready3` | `tulpis_3` | [mảnh 1](images/3_tulpan_8_0--36d84b3875.png), [mảnh 2](images/3_tulpan_7_0--d55882c59c.png), [mảnh 3](images/3_tulpan_5_0--04f79e6466.png), [mảnh 4](images/3_tulpan_3_0--f3e7a3e3d8.png), [mảnh 5](images/3_tulpan_1_0--c6dfee5d56.png), [mảnh 6](images/3_tulpan_2_0--6992da4e47.png), [mảnh 7](images/3_tulpan_4_0--dfb8c78111.png), [mảnh 8](images/3_tulpan_6_0--ede73365a0.png) |
| `ready4` | `tulpis_3` | [mảnh 1](images/3_tulpan_8_0--36d84b3875.png), [mảnh 2](images/3_tulpan_7_0--d55882c59c.png), [mảnh 3](images/3_tulpan_5_0--04f79e6466.png), [mảnh 4](images/3_tulpan_3_0--f3e7a3e3d8.png), [mảnh 5](images/3_tulpan_1_0--c6dfee5d56.png), [mảnh 6](images/3_tulpan_2_0--6992da4e47.png), [mảnh 7](images/3_tulpan_4_0--dfb8c78111.png), [mảnh 8](images/3_tulpan_6_0--ede73365a0.png) |
| `ready5` | `tulpis_3` | [mảnh 1](images/3_tulpan_8_0--36d84b3875.png), [mảnh 2](images/3_tulpan_7_0--d55882c59c.png), [mảnh 3](images/3_tulpan_5_0--04f79e6466.png), [mảnh 4](images/3_tulpan_3_0--f3e7a3e3d8.png), [mảnh 5](images/3_tulpan_1_0--c6dfee5d56.png), [mảnh 6](images/3_tulpan_2_0--6992da4e47.png), [mảnh 7](images/3_tulpan_4_0--dfb8c78111.png), [mảnh 8](images/3_tulpan_6_0--ede73365a0.png) |
| `ready1` | `tulpis_3` | [mảnh 1](images/3_tulpan_8_0--36d84b3875.png), [mảnh 2](images/3_tulpan_7_0--d55882c59c.png), [mảnh 3](images/3_tulpan_5_0--04f79e6466.png), [mảnh 4](images/3_tulpan_3_0--f3e7a3e3d8.png), [mảnh 5](images/3_tulpan_1_0--c6dfee5d56.png), [mảnh 6](images/3_tulpan_2_0--6992da4e47.png), [mảnh 7](images/3_tulpan_4_0--dfb8c78111.png), [mảnh 8](images/3_tulpan_6_0--ede73365a0.png) |
| `harvest2` | `tulpis_3` | [mảnh 1](images/3_tulpan_8_0--36d84b3875.png), [mảnh 2](images/3_tulpan_7_0--d55882c59c.png), [mảnh 3](images/3_tulpan_5_0--04f79e6466.png), [mảnh 4](images/3_tulpan_3_0--f3e7a3e3d8.png), [mảnh 5](images/3_tulpan_1_0--c6dfee5d56.png), [mảnh 6](images/3_tulpan_2_0--6992da4e47.png), [mảnh 7](images/3_tulpan_4_0--dfb8c78111.png), [mảnh 8](images/3_tulpan_6_0--ede73365a0.png) |
| `harvest3` | `tulpis_3` | [mảnh 1](images/3_tulpan_8_0--36d84b3875.png), [mảnh 2](images/3_tulpan_7_0--d55882c59c.png), [mảnh 3](images/3_tulpan_5_0--04f79e6466.png), [mảnh 4](images/3_tulpan_3_0--f3e7a3e3d8.png), [mảnh 5](images/3_tulpan_1_0--c6dfee5d56.png), [mảnh 6](images/3_tulpan_2_0--6992da4e47.png), [mảnh 7](images/3_tulpan_4_0--dfb8c78111.png), [mảnh 8](images/3_tulpan_6_0--ede73365a0.png) |
| `harvest4` | `tulpis_3` | [mảnh 1](images/3_tulpan_8_0--36d84b3875.png), [mảnh 2](images/3_tulpan_7_0--d55882c59c.png), [mảnh 3](images/3_tulpan_5_0--04f79e6466.png), [mảnh 4](images/3_tulpan_3_0--f3e7a3e3d8.png), [mảnh 5](images/3_tulpan_1_0--c6dfee5d56.png), [mảnh 6](images/3_tulpan_2_0--6992da4e47.png), [mảnh 7](images/3_tulpan_4_0--dfb8c78111.png), [mảnh 8](images/3_tulpan_6_0--ede73365a0.png) |
| `harvest1` | `tulpis_3` | [mảnh 1](images/3_tulpan_8_0--36d84b3875.png), [mảnh 2](images/3_tulpan_7_0--d55882c59c.png), [mảnh 3](images/3_tulpan_5_0--04f79e6466.png), [mảnh 4](images/3_tulpan_3_0--f3e7a3e3d8.png), [mảnh 5](images/3_tulpan_1_0--c6dfee5d56.png), [mảnh 6](images/3_tulpan_2_0--6992da4e47.png), [mảnh 7](images/3_tulpan_4_0--dfb8c78111.png), [mảnh 8](images/3_tulpan_6_0--ede73365a0.png) |
| `harvest0` | `tulpis_3` | [mảnh 1](images/3_tulpan_8_0--36d84b3875.png), [mảnh 2](images/3_tulpan_7_0--d55882c59c.png), [mảnh 3](images/3_tulpan_5_0--04f79e6466.png), [mảnh 4](images/3_tulpan_3_0--f3e7a3e3d8.png), [mảnh 5](images/3_tulpan_1_0--c6dfee5d56.png), [mảnh 6](images/3_tulpan_2_0--6992da4e47.png), [mảnh 7](images/3_tulpan_4_0--dfb8c78111.png), [mảnh 8](images/3_tulpan_6_0--ede73365a0.png) |

**Công thức nguồn dùng sản phẩm này**

| Cơ sở | Sản phẩm làm ra | Cần mỗi mẻ | Điều kiện bundle nguồn |
| --- | --- | ---: | --- |
| Nhà Máy Sơn (`paint_factory`) | Sơn Đỏ | 1 | Không có nhãn bundle |
| Nhà Máy Hoa (`flower_factory`) | Bó Hoa Lãng Mạn | 4 | Không có nhãn bundle |

**Trước khi đưa vào game**

Dựng prefab đúng pivot/tỉ lệ và thứ tự vẽ, kiểm tra các pose trên map; chốt giá/thời lượng/sản lượng Farm; nối catalog, kho, save và UI; thử gieo/thu/reload hoặc chu kỳ cây lâu năm. Không dùng source ID số làm ID Farm tự động.

Nguồn APK/hash, object ID, pivot, pixels-per-unit, clip và công thức được ghi trong `crop.json`. README và hồ sơ được tạo bởi `cocos/tools/prepare-crop-sources.py`.
