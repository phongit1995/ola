# Việt Quất — `blueberry`

[Danh mục](../../README.md) · [Bản xem ảnh](../../index.html) · [Hồ sơ JSON](crop.json)

**Thư mục nguồn không được runtime nạp trực tiếp.** Nhãn khảo sát gốc: C5 — mở rộng vườn quả.

![Icon](icon.png)

| Thuộc tính | Dữ liệu nguồn |
| --- | --- |
| Nhóm | Cây / bụi ăn quả |
| Sản phẩm | Việt Quất (`blueberry`, source ID 73) |
| Thu mỗi đợt nguồn | 5 |
| Thời gian nguồn | 4500 giây |
| Cấp công thức / item nguồn | 23 / 23 |
| Chi phí mỗi lượt nguồn | Không có nguyên liệu mỗi lượt; mua cây qua cửa hàng là giao dịch riêng |
| `BasicPrice` / `ExpOnUse` nguồn | 9 / 5 — chưa khẳng định là giá bán/XP thu hoạch Farm |
| Tệp PNG riêng trong thư mục | 14 |
| Số lượt bắt đầu mọc nguồn | 4 |
| Dụng cụ dọn cây | 1 Xẻng |
| Drop bảo đảm khi dọn | 1 Dây Thừng |

Thời gian ở đây là **giây nguồn APK**, không phải giờ mô phỏng Farm. Cấp mở còn phụ thuộc công trình/shop/điều kiện. Với cây lâu năm, nhận hết đợt cuối mới chuyển sang cây cạn lượt; không mất quả khi số lượt bắt đầu mọc đã về 0.

**Ảnh theo role / giai đoạn nguồn**

Ảnh nằm trong `images/`, được dùng chung giữa các role khi nguồn trỏ cùng sprite. Một dòng có nhiều PNG là nhiều mảnh tham chiếu, không phải nhiều cây hoàn chỉnh. Chưa có thông tin ghép transform/hierarchy đầy đủ trong bộ ảnh này.

| Role nguồn | Clip | Các mảnh PNG |
| --- | --- | --- |
| `dead` | `blueberry_4` | [mảnh 1](images/4_chern_zem_2_0--12fe1d113e.png), [mảnh 2](images/4_chern_0--d9394b5498.png), [mảnh 3](images/4_chern_zem_1_0--2c06ada9d8.png) |
| `idle` | `blueberry_3_0` | [mảnh 1](images/4_chern_zem_2_0--12fe1d113e.png), [mảnh 2](images/0_chern_0--e2239ed5a2.png), [mảnh 3](images/4_chern_zem_1_0--2c06ada9d8.png), [mảnh 4](images/3_chern_5_0--600eb3aeae.png), [mảnh 5](images/3_chern_4_0--69f02aeb3b.png), [mảnh 6](images/3_chern_2_0--395f5a5bd3.png), [mảnh 7](images/3_chern_1_0--eb4e5a2695.png), [mảnh 8](images/3_chern_3_0--abcf877d9d.png), [mảnh 9](images/3_chern_dop_0--4767c0a6bd.png) |
| `grow0` | `blueberry_3_0` | [mảnh 1](images/4_chern_zem_2_0--12fe1d113e.png), [mảnh 2](images/0_chern_0--e2239ed5a2.png), [mảnh 3](images/4_chern_zem_1_0--2c06ada9d8.png), [mảnh 4](images/3_chern_5_0--600eb3aeae.png), [mảnh 5](images/3_chern_4_0--69f02aeb3b.png), [mảnh 6](images/3_chern_2_0--395f5a5bd3.png), [mảnh 7](images/3_chern_1_0--eb4e5a2695.png), [mảnh 8](images/3_chern_3_0--abcf877d9d.png), [mảnh 9](images/3_chern_dop_0--4767c0a6bd.png) |
| `grow1` | `blueberry_1` | [mảnh 1](images/4_chern_zem_2_0--12fe1d113e.png), [mảnh 2](images/0_chern_0--e2239ed5a2.png), [mảnh 3](images/4_chern_zem_1_0--2c06ada9d8.png), [mảnh 4](images/1_chern_0--9c5b565f8d.png) |
| `grow2` | `blueberry_2` | [mảnh 1](images/4_chern_zem_2_0--12fe1d113e.png), [mảnh 2](images/0_chern_0--e2239ed5a2.png), [mảnh 3](images/4_chern_zem_1_0--2c06ada9d8.png), [mảnh 4](images/2_chern_zem__0--c1035b9222.png) |
| `grow3` | `blueberry_2` | [mảnh 1](images/4_chern_zem_2_0--12fe1d113e.png), [mảnh 2](images/0_chern_0--e2239ed5a2.png), [mảnh 3](images/4_chern_zem_1_0--2c06ada9d8.png), [mảnh 4](images/2_chern_zem__0--c1035b9222.png) |
| `grow0` | `grow0` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `ready2` | `blueberry_3_2` | [mảnh 1](images/4_chern_zem_2_0--12fe1d113e.png), [mảnh 2](images/0_chern_0--e2239ed5a2.png), [mảnh 3](images/4_chern_zem_1_0--2c06ada9d8.png), [mảnh 4](images/3_chern_5_0--600eb3aeae.png), [mảnh 5](images/3_chern_4_0--69f02aeb3b.png), [mảnh 6](images/3_chern_2_0--395f5a5bd3.png), [mảnh 7](images/3_chern_1_0--eb4e5a2695.png), [mảnh 8](images/3_chern_3_0--abcf877d9d.png), [mảnh 9](images/3_chern_dop_0--4767c0a6bd.png) |
| `ready3` | `blueberry_3_3` | [mảnh 1](images/4_chern_zem_2_0--12fe1d113e.png), [mảnh 2](images/0_chern_0--e2239ed5a2.png), [mảnh 3](images/4_chern_zem_1_0--2c06ada9d8.png), [mảnh 4](images/3_chern_5_0--600eb3aeae.png), [mảnh 5](images/3_chern_4_0--69f02aeb3b.png), [mảnh 6](images/3_chern_2_0--395f5a5bd3.png), [mảnh 7](images/3_chern_1_0--eb4e5a2695.png), [mảnh 8](images/3_chern_3_0--abcf877d9d.png), [mảnh 9](images/3_chern_dop_0--4767c0a6bd.png) |
| `ready4` | `blueberry_3_4` | [mảnh 1](images/4_chern_zem_2_0--12fe1d113e.png), [mảnh 2](images/0_chern_0--e2239ed5a2.png), [mảnh 3](images/4_chern_zem_1_0--2c06ada9d8.png), [mảnh 4](images/3_chern_5_0--600eb3aeae.png), [mảnh 5](images/3_chern_4_0--69f02aeb3b.png), [mảnh 6](images/3_chern_2_0--395f5a5bd3.png), [mảnh 7](images/3_chern_1_0--eb4e5a2695.png), [mảnh 8](images/3_chern_3_0--abcf877d9d.png), [mảnh 9](images/3_chern_dop_0--4767c0a6bd.png) |
| `ready5` | `blueberry_3_5` | [mảnh 1](images/4_chern_zem_2_0--12fe1d113e.png), [mảnh 2](images/0_chern_0--e2239ed5a2.png), [mảnh 3](images/4_chern_zem_1_0--2c06ada9d8.png), [mảnh 4](images/3_chern_5_0--600eb3aeae.png), [mảnh 5](images/3_chern_4_0--69f02aeb3b.png), [mảnh 6](images/3_chern_2_0--395f5a5bd3.png), [mảnh 7](images/3_chern_1_0--eb4e5a2695.png), [mảnh 8](images/3_chern_3_0--abcf877d9d.png), [mảnh 9](images/3_chern_dop_0--4767c0a6bd.png) |
| `ready1` | `blueberry_3_1` | [mảnh 1](images/4_chern_zem_2_0--12fe1d113e.png), [mảnh 2](images/0_chern_0--e2239ed5a2.png), [mảnh 3](images/4_chern_zem_1_0--2c06ada9d8.png), [mảnh 4](images/3_chern_5_0--600eb3aeae.png), [mảnh 5](images/3_chern_4_0--69f02aeb3b.png), [mảnh 6](images/3_chern_2_0--395f5a5bd3.png), [mảnh 7](images/3_chern_1_0--eb4e5a2695.png), [mảnh 8](images/3_chern_3_0--abcf877d9d.png), [mảnh 9](images/3_chern_dop_0--4767c0a6bd.png) |
| `harvest2` | `blueberry_3_2` | [mảnh 1](images/4_chern_zem_2_0--12fe1d113e.png), [mảnh 2](images/0_chern_0--e2239ed5a2.png), [mảnh 3](images/4_chern_zem_1_0--2c06ada9d8.png), [mảnh 4](images/3_chern_5_0--600eb3aeae.png), [mảnh 5](images/3_chern_4_0--69f02aeb3b.png), [mảnh 6](images/3_chern_2_0--395f5a5bd3.png), [mảnh 7](images/3_chern_1_0--eb4e5a2695.png), [mảnh 8](images/3_chern_3_0--abcf877d9d.png), [mảnh 9](images/3_chern_dop_0--4767c0a6bd.png) |
| `harvest3` | `blueberry_3_3` | [mảnh 1](images/4_chern_zem_2_0--12fe1d113e.png), [mảnh 2](images/0_chern_0--e2239ed5a2.png), [mảnh 3](images/4_chern_zem_1_0--2c06ada9d8.png), [mảnh 4](images/3_chern_5_0--600eb3aeae.png), [mảnh 5](images/3_chern_4_0--69f02aeb3b.png), [mảnh 6](images/3_chern_2_0--395f5a5bd3.png), [mảnh 7](images/3_chern_1_0--eb4e5a2695.png), [mảnh 8](images/3_chern_3_0--abcf877d9d.png), [mảnh 9](images/3_chern_dop_0--4767c0a6bd.png) |
| `harvest4` | `blueberry_3_4` | [mảnh 1](images/4_chern_zem_2_0--12fe1d113e.png), [mảnh 2](images/0_chern_0--e2239ed5a2.png), [mảnh 3](images/4_chern_zem_1_0--2c06ada9d8.png), [mảnh 4](images/3_chern_5_0--600eb3aeae.png), [mảnh 5](images/3_chern_4_0--69f02aeb3b.png), [mảnh 6](images/3_chern_2_0--395f5a5bd3.png), [mảnh 7](images/3_chern_1_0--eb4e5a2695.png), [mảnh 8](images/3_chern_3_0--abcf877d9d.png), [mảnh 9](images/3_chern_dop_0--4767c0a6bd.png) |
| `harvest1` | `blueberry_3_1` | [mảnh 1](images/4_chern_zem_2_0--12fe1d113e.png), [mảnh 2](images/0_chern_0--e2239ed5a2.png), [mảnh 3](images/4_chern_zem_1_0--2c06ada9d8.png), [mảnh 4](images/3_chern_5_0--600eb3aeae.png), [mảnh 5](images/3_chern_4_0--69f02aeb3b.png), [mảnh 6](images/3_chern_2_0--395f5a5bd3.png), [mảnh 7](images/3_chern_1_0--eb4e5a2695.png), [mảnh 8](images/3_chern_3_0--abcf877d9d.png), [mảnh 9](images/3_chern_dop_0--4767c0a6bd.png) |
| `harvest0` | `blueberry_3_0` | [mảnh 1](images/4_chern_zem_2_0--12fe1d113e.png), [mảnh 2](images/0_chern_0--e2239ed5a2.png), [mảnh 3](images/4_chern_zem_1_0--2c06ada9d8.png), [mảnh 4](images/3_chern_5_0--600eb3aeae.png), [mảnh 5](images/3_chern_4_0--69f02aeb3b.png), [mảnh 6](images/3_chern_2_0--395f5a5bd3.png), [mảnh 7](images/3_chern_1_0--eb4e5a2695.png), [mảnh 8](images/3_chern_3_0--abcf877d9d.png), [mảnh 9](images/3_chern_dop_0--4767c0a6bd.png) |

**Công thức nguồn dùng sản phẩm này**

| Cơ sở | Sản phẩm làm ra | Cần mỗi mẻ | Điều kiện bundle nguồn |
| --- | --- | ---: | --- |
| Tiệm Bánh (`bakery`) | Bánh Sừng Bò (Croissant) | 2 | Không có nhãn bundle |
| Nhà Máy Kẹo (`candy_factory`) | Kẹo Que | 2 | Không có nhãn bundle |
| Tiệm Bánh Pie (`pie_bakery`) | Bánh Pie Việt Quất | 3 | Không có nhãn bundle |

**Trước khi đưa vào game**

Dựng prefab đúng pivot/tỉ lệ và thứ tự vẽ, kiểm tra các pose trên map; chốt giá/thời lượng/sản lượng Farm; nối catalog, kho, save và UI; thử gieo/thu/reload hoặc chu kỳ cây lâu năm. Không dùng source ID số làm ID Farm tự động.

Nguồn APK/hash, object ID, pivot, pixels-per-unit, clip và công thức được ghi trong `crop.json`. README và hồ sơ được tạo bởi `cocos/tools/prepare-crop-sources.py`.
