# Hoa Hồng — `bush_roses`

[Danh mục](../../README.md) · [Bản xem ảnh](../../index.html) · [Hồ sơ JSON](crop.json)

**Thư mục nguồn không được runtime nạp trực tiếp.** Nhãn khảo sát gốc: C6 — hoa và chuỗi trang trí.

![Icon](icon.png)

| Thuộc tính | Dữ liệu nguồn |
| --- | --- |
| Nhóm | Bụi hoa |
| Sản phẩm | Hoa Hồng (`rose`, source ID 133) |
| Thu mỗi đợt nguồn | 1 |
| Thời gian nguồn | 1800 giây |
| Cấp công thức / item nguồn | 16 / 16 |
| Chi phí mỗi lượt nguồn | Không có nguyên liệu mỗi lượt; mua cây qua cửa hàng là giao dịch riêng |
| `BasicPrice` / `ExpOnUse` nguồn | 40 / 5 — chưa khẳng định là giá bán/XP thu hoạch Farm |
| Tệp PNG riêng trong thư mục | 18 |
| Số lượt bắt đầu mọc nguồn | 5 |
| Dụng cụ dọn cây | 1 Dao Cắt |
| Drop bảo đảm khi dọn | 1 Dây Thừng |

Thời gian ở đây là **giây nguồn APK**, không phải giờ mô phỏng Farm. Cấp mở còn phụ thuộc công trình/shop/điều kiện. Với cây lâu năm, nhận hết đợt cuối mới chuyển sang cây cạn lượt; không mất quả khi số lượt bắt đầu mọc đã về 0.

**Ảnh theo role / giai đoạn nguồn**

Ảnh nằm trong `images/`, được dùng chung giữa các role khi nguồn trỏ cùng sprite. Một dòng có nhiều PNG là nhiều mảnh tham chiếu, không phải nhiều cây hoàn chỉnh. Chưa có thông tin ghép transform/hierarchy đầy đủ trong bộ ảnh này.

| Role nguồn | Clip | Các mảnh PNG |
| --- | --- | --- |
| Gán sẵn trong prefab | — | [ảnh 1](images/0_rose_zem_0--e16545d450.png), [ảnh 2](images/0_rose_0--8aa7fb4e50.png), [ảnh 3](images/1_rose_0--6af43823de.png), [ảnh 4](images/3_rose_dop_1_0--1d78417081.png), [ảnh 5](images/2_rose__dop_0--b7748150a9.png), [ảnh 6](images/3_rose_dop_2_0--4d67b7538a.png) |
| `dead` | `rose_end` | [mảnh 1](images/4_rose_0--07294cfb87.png) |
| `idle` | `rose_1` | [mảnh 1](images/1_rose_0--6af43823de.png), [mảnh 2](images/0_rose_0--8aa7fb4e50.png), [mảnh 3](images/3_rose_dop_2_0--4d67b7538a.png), [mảnh 4](images/2_rose__dop_0--b7748150a9.png), [mảnh 5](images/3_rose_dop_1_0--1d78417081.png) |
| `grow0` | `rose_1` | [mảnh 1](images/1_rose_0--6af43823de.png), [mảnh 2](images/0_rose_0--8aa7fb4e50.png), [mảnh 3](images/3_rose_dop_2_0--4d67b7538a.png), [mảnh 4](images/2_rose__dop_0--b7748150a9.png), [mảnh 5](images/3_rose_dop_1_0--1d78417081.png) |
| `grow1` | `rose_2` | [mảnh 1](images/2_rose_0--3a9889eebc.png) |
| `grow2` | `rose_2` | [mảnh 1](images/2_rose_0--3a9889eebc.png) |
| `grow3` | `rose_2` | [mảnh 1](images/2_rose_0--3a9889eebc.png) |
| `grow0` | `grow0` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `ready2` | `rose_3` | [mảnh 1](images/3_rose_1_0--728c0bc369.png), [mảnh 2](images/3_rose_2_0--171ada3aa5.png), [mảnh 3](images/3_rose_3_0--50be15ab87.png), [mảnh 4](images/3_rose_4_0--99b9859d7a.png), [mảnh 5](images/3_rose_5_0--092a2b17d4.png), [mảnh 6](images/3_rose_6_0--c40a8c3925.png), [mảnh 7](images/3_rose_7_0--2738d9c78f.png), [mảnh 8](images/3_rose_8_0--d3ab618ce4.png) |
| `ready3` | `rose_3` | [mảnh 1](images/3_rose_1_0--728c0bc369.png), [mảnh 2](images/3_rose_2_0--171ada3aa5.png), [mảnh 3](images/3_rose_3_0--50be15ab87.png), [mảnh 4](images/3_rose_4_0--99b9859d7a.png), [mảnh 5](images/3_rose_5_0--092a2b17d4.png), [mảnh 6](images/3_rose_6_0--c40a8c3925.png), [mảnh 7](images/3_rose_7_0--2738d9c78f.png), [mảnh 8](images/3_rose_8_0--d3ab618ce4.png) |
| `ready4` | `rose_3` | [mảnh 1](images/3_rose_1_0--728c0bc369.png), [mảnh 2](images/3_rose_2_0--171ada3aa5.png), [mảnh 3](images/3_rose_3_0--50be15ab87.png), [mảnh 4](images/3_rose_4_0--99b9859d7a.png), [mảnh 5](images/3_rose_5_0--092a2b17d4.png), [mảnh 6](images/3_rose_6_0--c40a8c3925.png), [mảnh 7](images/3_rose_7_0--2738d9c78f.png), [mảnh 8](images/3_rose_8_0--d3ab618ce4.png) |
| `ready5` | `rose_3` | [mảnh 1](images/3_rose_1_0--728c0bc369.png), [mảnh 2](images/3_rose_2_0--171ada3aa5.png), [mảnh 3](images/3_rose_3_0--50be15ab87.png), [mảnh 4](images/3_rose_4_0--99b9859d7a.png), [mảnh 5](images/3_rose_5_0--092a2b17d4.png), [mảnh 6](images/3_rose_6_0--c40a8c3925.png), [mảnh 7](images/3_rose_7_0--2738d9c78f.png), [mảnh 8](images/3_rose_8_0--d3ab618ce4.png) |
| `ready1` | `rose_3` | [mảnh 1](images/3_rose_1_0--728c0bc369.png), [mảnh 2](images/3_rose_2_0--171ada3aa5.png), [mảnh 3](images/3_rose_3_0--50be15ab87.png), [mảnh 4](images/3_rose_4_0--99b9859d7a.png), [mảnh 5](images/3_rose_5_0--092a2b17d4.png), [mảnh 6](images/3_rose_6_0--c40a8c3925.png), [mảnh 7](images/3_rose_7_0--2738d9c78f.png), [mảnh 8](images/3_rose_8_0--d3ab618ce4.png) |
| `harvest2` | `rose_1` | [mảnh 1](images/1_rose_0--6af43823de.png), [mảnh 2](images/0_rose_0--8aa7fb4e50.png), [mảnh 3](images/3_rose_dop_2_0--4d67b7538a.png), [mảnh 4](images/2_rose__dop_0--b7748150a9.png), [mảnh 5](images/3_rose_dop_1_0--1d78417081.png) |
| `harvest3` | `rose_1` | [mảnh 1](images/1_rose_0--6af43823de.png), [mảnh 2](images/0_rose_0--8aa7fb4e50.png), [mảnh 3](images/3_rose_dop_2_0--4d67b7538a.png), [mảnh 4](images/2_rose__dop_0--b7748150a9.png), [mảnh 5](images/3_rose_dop_1_0--1d78417081.png) |
| `harvest4` | `rose_1` | [mảnh 1](images/1_rose_0--6af43823de.png), [mảnh 2](images/0_rose_0--8aa7fb4e50.png), [mảnh 3](images/3_rose_dop_2_0--4d67b7538a.png), [mảnh 4](images/2_rose__dop_0--b7748150a9.png), [mảnh 5](images/3_rose_dop_1_0--1d78417081.png) |
| `harvest1` | `rose_1` | [mảnh 1](images/1_rose_0--6af43823de.png), [mảnh 2](images/0_rose_0--8aa7fb4e50.png), [mảnh 3](images/3_rose_dop_2_0--4d67b7538a.png), [mảnh 4](images/2_rose__dop_0--b7748150a9.png), [mảnh 5](images/3_rose_dop_1_0--1d78417081.png) |
| `harvest0` | `rose_1` | [mảnh 1](images/1_rose_0--6af43823de.png), [mảnh 2](images/0_rose_0--8aa7fb4e50.png), [mảnh 3](images/3_rose_dop_2_0--4d67b7538a.png), [mảnh 4](images/2_rose__dop_0--b7748150a9.png), [mảnh 5](images/3_rose_dop_1_0--1d78417081.png) |

**Công thức nguồn dùng sản phẩm này**

| Cơ sở | Sản phẩm làm ra | Cần mỗi mẻ | Điều kiện bundle nguồn |
| --- | --- | ---: | --- |
| Mũ (`hats_prod`) | Mũ Mùa Hè | 1 | Không có nhãn bundle |
| Nhà Máy Hoa (`flower_factory`) | Hoa Cưới | 7 | Không có nhãn bundle |

**Trước khi đưa vào game**

Dựng prefab đúng pivot/tỉ lệ và thứ tự vẽ, kiểm tra các pose trên map; chốt giá/thời lượng/sản lượng Farm; nối catalog, kho, save và UI; thử gieo/thu/reload hoặc chu kỳ cây lâu năm. Không dùng source ID số làm ID Farm tự động.

Nguồn APK/hash, object ID, pivot, pixels-per-unit, clip và công thức được ghi trong `crop.json`. README và hồ sơ được tạo bởi `cocos/tools/prepare-crop-sources.py`.
