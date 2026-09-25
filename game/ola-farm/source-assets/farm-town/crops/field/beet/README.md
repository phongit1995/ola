# Củ Cải Đường — `beet`

[Danh mục](../../README.md) · [Bản xem ảnh](../../index.html) · [Hồ sơ JSON](crop.json)

**Thư mục nguồn không được runtime nạp trực tiếp.** Nhãn khảo sát gốc: C2 — đường và thức ăn heo/cừu.

![Icon](icon.png)

| Thuộc tính | Dữ liệu nguồn |
| --- | --- |
| Nhóm | Cây ruộng |
| Sản phẩm | Củ Cải Đường (`beet`, source ID 10) |
| Thu mỗi đợt nguồn | 1 |
| Thời gian nguồn | 600 giây |
| Cấp công thức / item nguồn | 7 / 7 |
| Chi phí mỗi lượt nguồn | 2 Xu |
| `BasicPrice` / `ExpOnUse` nguồn | 8 / 4 — chưa khẳng định là giá bán/XP thu hoạch Farm |
| Tệp PNG riêng trong thư mục | 18 |

Thời gian ở đây là **giây nguồn APK**, không phải giờ mô phỏng Farm. Cấp mở còn phụ thuộc công trình/shop/điều kiện. Với cây lâu năm, nhận hết đợt cuối mới chuyển sang cây cạn lượt; không mất quả khi số lượt bắt đầu mọc đã về 0.

**Ảnh theo role / giai đoạn nguồn**

Ảnh nằm trong `images/`, được dùng chung giữa các role khi nguồn trỏ cùng sprite. Một dòng có nhiều PNG là nhiều mảnh tham chiếu, không phải nhiều cây hoàn chỉnh. Chưa có thông tin ghép transform/hierarchy đầy đủ trong bộ ảnh này.

| Role nguồn | Clip | Các mảnh PNG |
| --- | --- | --- |
| `dead` | `idle` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `idle` | `idle` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `grow0` | `svekla_1` | [mảnh 1](images/rep_1_0--cc8623872b.png) |
| `grow1` | `svekla_2` | [mảnh 1](images/rep_2_0--f01309f3a6.png) |
| `grow2` | `svekla_2` | [mảnh 1](images/rep_2_0--f01309f3a6.png) |
| `grow3` | `svekla_2` | [mảnh 1](images/rep_2_0--f01309f3a6.png) |
| `grow0` | `grow0` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `ready2` | `svekla_3` | [mảnh 1](images/rep_342_0--e5a4eb22a1.png), [mảnh 2](images/rep_332_0--aeeffad0e3.png), [mảnh 3](images/rep_322_0--0cea787429.png), [mảnh 4](images/rep_312_0--0eb39f0a5e.png), [mảnh 5](images/rep_341_0--4873220c37.png), [mảnh 6](images/rep_331_0--b3597ec22e.png), [mảnh 7](images/rep_321_0--bc02576ac2.png), [mảnh 8](images/rep_311_0--5173280cdf.png) |
| `ready3` | `svekla_3` | [mảnh 1](images/rep_342_0--e5a4eb22a1.png), [mảnh 2](images/rep_332_0--aeeffad0e3.png), [mảnh 3](images/rep_322_0--0cea787429.png), [mảnh 4](images/rep_312_0--0eb39f0a5e.png), [mảnh 5](images/rep_341_0--4873220c37.png), [mảnh 6](images/rep_331_0--b3597ec22e.png), [mảnh 7](images/rep_321_0--bc02576ac2.png), [mảnh 8](images/rep_311_0--5173280cdf.png) |
| `ready4` | `svekla_3` | [mảnh 1](images/rep_342_0--e5a4eb22a1.png), [mảnh 2](images/rep_332_0--aeeffad0e3.png), [mảnh 3](images/rep_322_0--0cea787429.png), [mảnh 4](images/rep_312_0--0eb39f0a5e.png), [mảnh 5](images/rep_341_0--4873220c37.png), [mảnh 6](images/rep_331_0--b3597ec22e.png), [mảnh 7](images/rep_321_0--bc02576ac2.png), [mảnh 8](images/rep_311_0--5173280cdf.png) |
| `ready5` | `svekla_3` | [mảnh 1](images/rep_342_0--e5a4eb22a1.png), [mảnh 2](images/rep_332_0--aeeffad0e3.png), [mảnh 3](images/rep_322_0--0cea787429.png), [mảnh 4](images/rep_312_0--0eb39f0a5e.png), [mảnh 5](images/rep_341_0--4873220c37.png), [mảnh 6](images/rep_331_0--b3597ec22e.png), [mảnh 7](images/rep_321_0--bc02576ac2.png), [mảnh 8](images/rep_311_0--5173280cdf.png) |
| `ready1` | `svekla_3` | [mảnh 1](images/rep_342_0--e5a4eb22a1.png), [mảnh 2](images/rep_332_0--aeeffad0e3.png), [mảnh 3](images/rep_322_0--0cea787429.png), [mảnh 4](images/rep_312_0--0eb39f0a5e.png), [mảnh 5](images/rep_341_0--4873220c37.png), [mảnh 6](images/rep_331_0--b3597ec22e.png), [mảnh 7](images/rep_321_0--bc02576ac2.png), [mảnh 8](images/rep_311_0--5173280cdf.png) |
| `harvest2` | `svekla_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_svek_nutr_0--c3d010bc24.png), [mảnh 6](images/4_svek_0--1394c6ad9b.png), [mảnh 7](images/4_svek_ten_0--f31276864d.png) |
| `harvest3` | `svekla_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_svek_nutr_0--c3d010bc24.png), [mảnh 6](images/4_svek_0--1394c6ad9b.png), [mảnh 7](images/4_svek_ten_0--f31276864d.png) |
| `harvest4` | `svekla_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_svek_nutr_0--c3d010bc24.png), [mảnh 6](images/4_svek_0--1394c6ad9b.png), [mảnh 7](images/4_svek_ten_0--f31276864d.png) |
| `harvest1` | `svekla_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_svek_nutr_0--c3d010bc24.png), [mảnh 6](images/4_svek_0--1394c6ad9b.png), [mảnh 7](images/4_svek_ten_0--f31276864d.png) |
| `harvest0` | `svekla_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_svek_nutr_0--c3d010bc24.png), [mảnh 6](images/4_svek_0--1394c6ad9b.png), [mảnh 7](images/4_svek_ten_0--f31276864d.png) |

**Công thức nguồn dùng sản phẩm này**

| Cơ sở | Sản phẩm làm ra | Cần mỗi mẻ | Điều kiện bundle nguồn |
| --- | --- | ---: | --- |
| Máy Chế Biến Đường (`sugar_processor`) | Kẹo Dẻo Hình Giun | 1 | halloween |
| Máy Chế Biến Đường (`sugar_processor`) | Đường Trắng | 1 | Không có nhãn bundle |

**Trước khi đưa vào game**

Dựng prefab đúng pivot/tỉ lệ và thứ tự vẽ, kiểm tra các pose trên map; chốt giá/thời lượng/sản lượng Farm; nối catalog, kho, save và UI; thử gieo/thu/reload hoặc chu kỳ cây lâu năm. Không dùng source ID số làm ID Farm tự động.

Nguồn APK/hash, object ID, pivot, pixels-per-unit, clip và công thức được ghi trong `crop.json`. README và hồ sơ được tạo bởi `cocos/tools/prepare-crop-sources.py`.
