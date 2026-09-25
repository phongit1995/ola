# Hoa Ly — `bush_lily`

[Danh mục](../../README.md) · [Bản xem ảnh](../../index.html) · [Hồ sơ JSON](crop.json)

**Thư mục nguồn không được runtime nạp trực tiếp.** Nhãn khảo sát gốc: C6 — hoa và chuỗi trang trí.

![Icon](icon.png)

| Thuộc tính | Dữ liệu nguồn |
| --- | --- |
| Nhóm | Bụi hoa |
| Sản phẩm | Hoa Ly (`lily`, source ID 103) |
| Thu mỗi đợt nguồn | 1 |
| Thời gian nguồn | 3600 giây |
| Cấp công thức / item nguồn | 18 / 18 |
| Chi phí mỗi lượt nguồn | Không có nguyên liệu mỗi lượt; mua cây qua cửa hàng là giao dịch riêng |
| `BasicPrice` / `ExpOnUse` nguồn | 32 / 12 — chưa khẳng định là giá bán/XP thu hoạch Farm |
| Tệp PNG riêng trong thư mục | 14 |
| Số lượt bắt đầu mọc nguồn | 5 |
| Dụng cụ dọn cây | 1 Dao Cắt |
| Drop bảo đảm khi dọn | 1 Dây Thừng |

Thời gian ở đây là **giây nguồn APK**, không phải giờ mô phỏng Farm. Cấp mở còn phụ thuộc công trình/shop/điều kiện. Với cây lâu năm, nhận hết đợt cuối mới chuyển sang cây cạn lượt; không mất quả khi số lượt bắt đầu mọc đã về 0.

**Ảnh theo role / giai đoạn nguồn**

Ảnh nằm trong `images/`, được dùng chung giữa các role khi nguồn trỏ cùng sprite. Một dòng có nhiều PNG là nhiều mảnh tham chiếu, không phải nhiều cây hoàn chỉnh. Chưa có thông tin ghép transform/hierarchy đầy đủ trong bộ ảnh này.

| Role nguồn | Clip | Các mảnh PNG |
| --- | --- | --- |
| Gán sẵn trong prefab | — | [ảnh 1](images/0_lil_zem_0--a89c938b47.png), [ảnh 2](images/0_lil_0--4b6ac0c778.png), [ảnh 3](images/1_lil_0--54fd6b3e06.png) |
| `dead` | `field_lily_end` | [mảnh 1](images/4_lil_0--4c1e712345.png) |
| `idle` | `field_lily_1` | [mảnh 1](images/1_lil_0--54fd6b3e06.png), [mảnh 2](images/0_lil_0--4b6ac0c778.png) |
| `grow0` | `field_lily_1` | [mảnh 1](images/1_lil_0--54fd6b3e06.png), [mảnh 2](images/0_lil_0--4b6ac0c778.png) |
| `grow1` | `field_lily_2` | [mảnh 1](images/2_lil_0--416f6e34b8.png) |
| `grow2` | `field_lily_2` | [mảnh 1](images/2_lil_0--416f6e34b8.png) |
| `grow3` | `field_lily_2` | [mảnh 1](images/2_lil_0--416f6e34b8.png) |
| `grow0` | `grow0` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `ready2` | `field_lily_3` | [mảnh 1](images/3_lil_7_0--dd17df5346.png), [mảnh 2](images/3_lil_6_0--21ed9905cb.png), [mảnh 3](images/3_lil_3_0--fb5b9d7281.png), [mảnh 4](images/3_lil_2_0--d858dea0d0.png), [mảnh 5](images/3_lil_4_0--6aca0a4a1a.png), [mảnh 6](images/3_lil_5_0--2346e0f6d1.png), [mảnh 7](images/3_lil_1_0--1d412132c4.png) |
| `ready3` | `field_lily_3` | [mảnh 1](images/3_lil_7_0--dd17df5346.png), [mảnh 2](images/3_lil_6_0--21ed9905cb.png), [mảnh 3](images/3_lil_3_0--fb5b9d7281.png), [mảnh 4](images/3_lil_2_0--d858dea0d0.png), [mảnh 5](images/3_lil_4_0--6aca0a4a1a.png), [mảnh 6](images/3_lil_5_0--2346e0f6d1.png), [mảnh 7](images/3_lil_1_0--1d412132c4.png) |
| `ready4` | `field_lily_3` | [mảnh 1](images/3_lil_7_0--dd17df5346.png), [mảnh 2](images/3_lil_6_0--21ed9905cb.png), [mảnh 3](images/3_lil_3_0--fb5b9d7281.png), [mảnh 4](images/3_lil_2_0--d858dea0d0.png), [mảnh 5](images/3_lil_4_0--6aca0a4a1a.png), [mảnh 6](images/3_lil_5_0--2346e0f6d1.png), [mảnh 7](images/3_lil_1_0--1d412132c4.png) |
| `ready5` | `field_lily_3` | [mảnh 1](images/3_lil_7_0--dd17df5346.png), [mảnh 2](images/3_lil_6_0--21ed9905cb.png), [mảnh 3](images/3_lil_3_0--fb5b9d7281.png), [mảnh 4](images/3_lil_2_0--d858dea0d0.png), [mảnh 5](images/3_lil_4_0--6aca0a4a1a.png), [mảnh 6](images/3_lil_5_0--2346e0f6d1.png), [mảnh 7](images/3_lil_1_0--1d412132c4.png) |
| `ready1` | `field_lily_3` | [mảnh 1](images/3_lil_7_0--dd17df5346.png), [mảnh 2](images/3_lil_6_0--21ed9905cb.png), [mảnh 3](images/3_lil_3_0--fb5b9d7281.png), [mảnh 4](images/3_lil_2_0--d858dea0d0.png), [mảnh 5](images/3_lil_4_0--6aca0a4a1a.png), [mảnh 6](images/3_lil_5_0--2346e0f6d1.png), [mảnh 7](images/3_lil_1_0--1d412132c4.png) |
| `harvest2` | `field_lily_1` | [mảnh 1](images/1_lil_0--54fd6b3e06.png), [mảnh 2](images/0_lil_0--4b6ac0c778.png) |
| `harvest3` | `field_lily_1` | [mảnh 1](images/1_lil_0--54fd6b3e06.png), [mảnh 2](images/0_lil_0--4b6ac0c778.png) |
| `harvest4` | `field_lily_1` | [mảnh 1](images/1_lil_0--54fd6b3e06.png), [mảnh 2](images/0_lil_0--4b6ac0c778.png) |
| `harvest1` | `field_lily_1` | [mảnh 1](images/1_lil_0--54fd6b3e06.png), [mảnh 2](images/0_lil_0--4b6ac0c778.png) |
| `harvest0` | `field_lily_1` | [mảnh 1](images/1_lil_0--54fd6b3e06.png), [mảnh 2](images/0_lil_0--4b6ac0c778.png) |

**Công thức nguồn dùng sản phẩm này**

| Cơ sở | Sản phẩm làm ra | Cần mỗi mẻ | Điều kiện bundle nguồn |
| --- | --- | ---: | --- |
| Nhà Máy Sơn (`paint_factory`) | Sơn Hồng | 1 | Không có nhãn bundle |
| Mũ (`hats_prod`) | Mũ Biển | 2 | Không có nhãn bundle |
| Mũ (`hats_prod`) | Mũ Dạ Hội | 1 | Không có nhãn bundle |
| Nhà Máy Hoa (`flower_factory`) | Bó Hoa Paris Đêm | 2 | Không có nhãn bundle |

**Trước khi đưa vào game**

Dựng prefab đúng pivot/tỉ lệ và thứ tự vẽ, kiểm tra các pose trên map; chốt giá/thời lượng/sản lượng Farm; nối catalog, kho, save và UI; thử gieo/thu/reload hoặc chu kỳ cây lâu năm. Không dùng source ID số làm ID Farm tự động.

Nguồn APK/hash, object ID, pivot, pixels-per-unit, clip và công thức được ghi trong `crop.json`. README và hồ sơ được tạo bởi `cocos/tools/prepare-crop-sources.py`.
