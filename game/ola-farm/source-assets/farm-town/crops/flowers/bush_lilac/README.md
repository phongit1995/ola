# Tử Đinh Hương — `bush_lilac`

[Danh mục](../../README.md) · [Bản xem ảnh](../../index.html) · [Hồ sơ JSON](crop.json)

**Thư mục nguồn không được runtime nạp trực tiếp.** Nhãn khảo sát gốc: C6 — hoa và chuỗi trang trí.

![Icon](icon.png)

| Thuộc tính | Dữ liệu nguồn |
| --- | --- |
| Nhóm | Bụi hoa |
| Sản phẩm | Tử Đinh Hương (`lilac`, source ID 102) |
| Thu mỗi đợt nguồn | 1 |
| Thời gian nguồn | 1500 giây |
| Cấp công thức / item nguồn | 13 / 13 |
| Chi phí mỗi lượt nguồn | Không có nguyên liệu mỗi lượt; mua cây qua cửa hàng là giao dịch riêng |
| `BasicPrice` / `ExpOnUse` nguồn | 18 / 5 — chưa khẳng định là giá bán/XP thu hoạch Farm |
| Tệp PNG riêng trong thư mục | 20 |
| Số lượt bắt đầu mọc nguồn | 5 |
| Dụng cụ dọn cây | 1 Dao Cắt |
| Drop bảo đảm khi dọn | 1 Dây Thừng |

Thời gian ở đây là **giây nguồn APK**, không phải giờ mô phỏng Farm. Cấp mở còn phụ thuộc công trình/shop/điều kiện. Với cây lâu năm, nhận hết đợt cuối mới chuyển sang cây cạn lượt; không mất quả khi số lượt bắt đầu mọc đã về 0.

**Ảnh theo role / giai đoạn nguồn**

Ảnh nằm trong `images/`, được dùng chung giữa các role khi nguồn trỏ cùng sprite. Một dòng có nhiều PNG là nhiều mảnh tham chiếu, không phải nhiều cây hoàn chỉnh. Chưa có thông tin ghép transform/hierarchy đầy đủ trong bộ ảnh này.

| Role nguồn | Clip | Các mảnh PNG |
| --- | --- | --- |
| Gán sẵn trong prefab | — | [ảnh 1](images/4_siren_zem_0--90a913f717.png), [ảnh 2](images/0_siren_2_0--2d01dc76b1.png), [ảnh 3](images/0_siren_1_0--d531ab69e5.png), [ảnh 4](images/1_siren_0--b37ebafd36.png), [ảnh 5](images/3_siren_dop_1_0--4af1fccd81.png) |
| `dead` | `lilac_end` | [mảnh 1](images/4_siren_listva_1--89b5a91f1b.png), [mảnh 2](images/4_siren_list_0--9bd785cd20.png), [mảnh 3](images/4_siren_0--08d0434485.png) |
| `idle` | `lilac_1` | [mảnh 1](images/1_siren_0--b37ebafd36.png), [mảnh 2](images/3_siren_dop_1_0--4af1fccd81.png), [mảnh 3](images/0_siren_2_0--2d01dc76b1.png), [mảnh 4](images/0_siren_1_0--d531ab69e5.png) |
| `grow0` | `lilac_1` | [mảnh 1](images/1_siren_0--b37ebafd36.png), [mảnh 2](images/3_siren_dop_1_0--4af1fccd81.png), [mảnh 3](images/0_siren_2_0--2d01dc76b1.png), [mảnh 4](images/0_siren_1_0--d531ab69e5.png) |
| `grow1` | `lilac_2` | [mảnh 1](images/3_siren_dop_2_0--ec86deb12d.png), [mảnh 2](images/2_siren_0--2383d239b9.png) |
| `grow2` | `lilac_2` | [mảnh 1](images/3_siren_dop_2_0--ec86deb12d.png), [mảnh 2](images/2_siren_0--2383d239b9.png) |
| `grow3` | `lilac_2` | [mảnh 1](images/3_siren_dop_2_0--ec86deb12d.png), [mảnh 2](images/2_siren_0--2383d239b9.png) |
| `grow0` | `grow0` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `ready2` | `lilac_3` | [mảnh 1](images/3_siren_dop_2_0--ec86deb12d.png), [mảnh 2](images/3_siren_dop_1_0--4af1fccd81.png), [mảnh 3](images/3_siren_1_0--3e8dec1cbb.png), [mảnh 4](images/3_siren_2_0--91501f2366.png), [mảnh 5](images/3_siren_3_0--800713d2df.png), [mảnh 6](images/3_siren_4_0--6861d556e9.png), [mảnh 7](images/3_siren_5_0--1c7a19a31c.png), [mảnh 8](images/3_siren_6_0--2c8dae3dd1.png), [mảnh 9](images/3_siren_7_0--b166887886.png), [mảnh 10](images/3_siren_8_0--b7a9f02c5b.png) |
| `ready3` | `lilac_3` | [mảnh 1](images/3_siren_dop_2_0--ec86deb12d.png), [mảnh 2](images/3_siren_dop_1_0--4af1fccd81.png), [mảnh 3](images/3_siren_1_0--3e8dec1cbb.png), [mảnh 4](images/3_siren_2_0--91501f2366.png), [mảnh 5](images/3_siren_3_0--800713d2df.png), [mảnh 6](images/3_siren_4_0--6861d556e9.png), [mảnh 7](images/3_siren_5_0--1c7a19a31c.png), [mảnh 8](images/3_siren_6_0--2c8dae3dd1.png), [mảnh 9](images/3_siren_7_0--b166887886.png), [mảnh 10](images/3_siren_8_0--b7a9f02c5b.png) |
| `ready4` | `lilac_3` | [mảnh 1](images/3_siren_dop_2_0--ec86deb12d.png), [mảnh 2](images/3_siren_dop_1_0--4af1fccd81.png), [mảnh 3](images/3_siren_1_0--3e8dec1cbb.png), [mảnh 4](images/3_siren_2_0--91501f2366.png), [mảnh 5](images/3_siren_3_0--800713d2df.png), [mảnh 6](images/3_siren_4_0--6861d556e9.png), [mảnh 7](images/3_siren_5_0--1c7a19a31c.png), [mảnh 8](images/3_siren_6_0--2c8dae3dd1.png), [mảnh 9](images/3_siren_7_0--b166887886.png), [mảnh 10](images/3_siren_8_0--b7a9f02c5b.png) |
| `ready5` | `lilac_3` | [mảnh 1](images/3_siren_dop_2_0--ec86deb12d.png), [mảnh 2](images/3_siren_dop_1_0--4af1fccd81.png), [mảnh 3](images/3_siren_1_0--3e8dec1cbb.png), [mảnh 4](images/3_siren_2_0--91501f2366.png), [mảnh 5](images/3_siren_3_0--800713d2df.png), [mảnh 6](images/3_siren_4_0--6861d556e9.png), [mảnh 7](images/3_siren_5_0--1c7a19a31c.png), [mảnh 8](images/3_siren_6_0--2c8dae3dd1.png), [mảnh 9](images/3_siren_7_0--b166887886.png), [mảnh 10](images/3_siren_8_0--b7a9f02c5b.png) |
| `ready1` | `lilac_3` | [mảnh 1](images/3_siren_dop_2_0--ec86deb12d.png), [mảnh 2](images/3_siren_dop_1_0--4af1fccd81.png), [mảnh 3](images/3_siren_1_0--3e8dec1cbb.png), [mảnh 4](images/3_siren_2_0--91501f2366.png), [mảnh 5](images/3_siren_3_0--800713d2df.png), [mảnh 6](images/3_siren_4_0--6861d556e9.png), [mảnh 7](images/3_siren_5_0--1c7a19a31c.png), [mảnh 8](images/3_siren_6_0--2c8dae3dd1.png), [mảnh 9](images/3_siren_7_0--b166887886.png), [mảnh 10](images/3_siren_8_0--b7a9f02c5b.png) |
| `harvest2` | `lilac_1` | [mảnh 1](images/1_siren_0--b37ebafd36.png), [mảnh 2](images/3_siren_dop_1_0--4af1fccd81.png), [mảnh 3](images/0_siren_2_0--2d01dc76b1.png), [mảnh 4](images/0_siren_1_0--d531ab69e5.png) |
| `harvest3` | `lilac_1` | [mảnh 1](images/1_siren_0--b37ebafd36.png), [mảnh 2](images/3_siren_dop_1_0--4af1fccd81.png), [mảnh 3](images/0_siren_2_0--2d01dc76b1.png), [mảnh 4](images/0_siren_1_0--d531ab69e5.png) |
| `harvest4` | `lilac_1` | [mảnh 1](images/1_siren_0--b37ebafd36.png), [mảnh 2](images/3_siren_dop_1_0--4af1fccd81.png), [mảnh 3](images/0_siren_2_0--2d01dc76b1.png), [mảnh 4](images/0_siren_1_0--d531ab69e5.png) |
| `harvest1` | `lilac_1` | [mảnh 1](images/1_siren_0--b37ebafd36.png), [mảnh 2](images/3_siren_dop_1_0--4af1fccd81.png), [mảnh 3](images/0_siren_2_0--2d01dc76b1.png), [mảnh 4](images/0_siren_1_0--d531ab69e5.png) |
| `harvest0` | `lilac_1` | [mảnh 1](images/1_siren_0--b37ebafd36.png), [mảnh 2](images/3_siren_dop_1_0--4af1fccd81.png), [mảnh 3](images/0_siren_2_0--2d01dc76b1.png), [mảnh 4](images/0_siren_1_0--d531ab69e5.png) |

**Công thức nguồn dùng sản phẩm này**

| Cơ sở | Sản phẩm làm ra | Cần mỗi mẻ | Điều kiện bundle nguồn |
| --- | --- | ---: | --- |
| Nhà Máy Sơn (`paint_factory`) | Sơn Hồng | 1 | Không có nhãn bundle |
| Nhà Máy Hoa (`flower_factory`) | Bó Hoa Tử Đinh Hương | 3 | Không có nhãn bundle |

**Trước khi đưa vào game**

Dựng prefab đúng pivot/tỉ lệ và thứ tự vẽ, kiểm tra các pose trên map; chốt giá/thời lượng/sản lượng Farm; nối catalog, kho, save và UI; thử gieo/thu/reload hoặc chu kỳ cây lâu năm. Không dùng source ID số làm ID Farm tự động.

Nguồn APK/hash, object ID, pivot, pixels-per-unit, clip và công thức được ghi trong `crop.json`. README và hồ sơ được tạo bởi `cocos/tools/prepare-crop-sources.py`.
