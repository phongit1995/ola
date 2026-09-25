# Gạo — `rice`

[Danh mục](../../README.md) · [Bản xem ảnh](../../index.html) · [Hồ sơ JSON](crop.json)

**Thư mục nguồn không được runtime nạp trực tiếp.** Nhãn khảo sát gốc: C5 — món ăn mở rộng.

![Icon](icon.png)

| Thuộc tính | Dữ liệu nguồn |
| --- | --- |
| Nhóm | Cây ruộng |
| Sản phẩm | Gạo (`rice`, source ID 160) |
| Thu mỗi đợt nguồn | 1 |
| Thời gian nguồn | 1800 giây |
| Cấp công thức / item nguồn | 9 / 9 |
| Chi phí mỗi lượt nguồn | 6 Xu |
| `BasicPrice` / `ExpOnUse` nguồn | 24 / 12 — chưa khẳng định là giá bán/XP thu hoạch Farm |
| Tệp PNG riêng trong thư mục | 16 |

Thời gian ở đây là **giây nguồn APK**, không phải giờ mô phỏng Farm. Cấp mở còn phụ thuộc công trình/shop/điều kiện. Với cây lâu năm, nhận hết đợt cuối mới chuyển sang cây cạn lượt; không mất quả khi số lượt bắt đầu mọc đã về 0.

**Ảnh theo role / giai đoạn nguồn**

Ảnh nằm trong `images/`, được dùng chung giữa các role khi nguồn trỏ cùng sprite. Một dòng có nhiều PNG là nhiều mảnh tham chiếu, không phải nhiều cây hoàn chỉnh. Chưa có thông tin ghép transform/hierarchy đầy đủ trong bộ ảnh này.

| Role nguồn | Clip | Các mảnh PNG |
| --- | --- | --- |
| `dead` | `idle` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `idle` | `idle` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `grow0` | `ris_1` | [mảnh 1](images/ris_1_0--5f14e7eaef.png) |
| `grow1` | `ris_2` | [mảnh 1](images/ris_2_0--7d45c2e476.png) |
| `grow2` | `ris_2` | [mảnh 1](images/ris_2_0--7d45c2e476.png) |
| `grow3` | `ris_2` | [mảnh 1](images/ris_2_0--7d45c2e476.png) |
| `grow0` | `grow0` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `ready2` | `ris_3` | [mảnh 1](images/ris_3voda_0--9a45201fb3.png), [mảnh 2](images/ris_36_0--ee417a4bda.png), [mảnh 3](images/ris_35_0--b073db9d14.png), [mảnh 4](images/ris_34_0--98b99a4956.png), [mảnh 5](images/ris_33_0--1d2121e369.png), [mảnh 6](images/ris_32_0--cd5dc1de58.png), [mảnh 7](images/ris_31_0--9c417a4b3a.png) |
| `ready3` | `ris_3` | [mảnh 1](images/ris_3voda_0--9a45201fb3.png), [mảnh 2](images/ris_36_0--ee417a4bda.png), [mảnh 3](images/ris_35_0--b073db9d14.png), [mảnh 4](images/ris_34_0--98b99a4956.png), [mảnh 5](images/ris_33_0--1d2121e369.png), [mảnh 6](images/ris_32_0--cd5dc1de58.png), [mảnh 7](images/ris_31_0--9c417a4b3a.png) |
| `ready4` | `ris_3` | [mảnh 1](images/ris_3voda_0--9a45201fb3.png), [mảnh 2](images/ris_36_0--ee417a4bda.png), [mảnh 3](images/ris_35_0--b073db9d14.png), [mảnh 4](images/ris_34_0--98b99a4956.png), [mảnh 5](images/ris_33_0--1d2121e369.png), [mảnh 6](images/ris_32_0--cd5dc1de58.png), [mảnh 7](images/ris_31_0--9c417a4b3a.png) |
| `ready5` | `ris_3` | [mảnh 1](images/ris_3voda_0--9a45201fb3.png), [mảnh 2](images/ris_36_0--ee417a4bda.png), [mảnh 3](images/ris_35_0--b073db9d14.png), [mảnh 4](images/ris_34_0--98b99a4956.png), [mảnh 5](images/ris_33_0--1d2121e369.png), [mảnh 6](images/ris_32_0--cd5dc1de58.png), [mảnh 7](images/ris_31_0--9c417a4b3a.png) |
| `ready1` | `ris_3` | [mảnh 1](images/ris_3voda_0--9a45201fb3.png), [mảnh 2](images/ris_36_0--ee417a4bda.png), [mảnh 3](images/ris_35_0--b073db9d14.png), [mảnh 4](images/ris_34_0--98b99a4956.png), [mảnh 5](images/ris_33_0--1d2121e369.png), [mảnh 6](images/ris_32_0--cd5dc1de58.png), [mảnh 7](images/ris_31_0--9c417a4b3a.png) |
| `harvest2` | `ris_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_ris_nutr_1_0--c06f5a3b39.png), [mảnh 6](images/4_ris_1_0--a0e1a9bd29.png) |
| `harvest3` | `ris_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_ris_nutr_1_0--c06f5a3b39.png), [mảnh 6](images/4_ris_1_0--a0e1a9bd29.png) |
| `harvest4` | `ris_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_ris_nutr_1_0--c06f5a3b39.png), [mảnh 6](images/4_ris_1_0--a0e1a9bd29.png) |
| `harvest1` | `ris_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_ris_nutr_1_0--c06f5a3b39.png), [mảnh 6](images/4_ris_1_0--a0e1a9bd29.png) |
| `harvest0` | `ris_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_ris_nutr_1_0--c06f5a3b39.png), [mảnh 6](images/4_ris_1_0--a0e1a9bd29.png) |

**Công thức nguồn dùng sản phẩm này**

| Cơ sở | Sản phẩm làm ra | Cần mỗi mẻ | Điều kiện bundle nguồn |
| --- | --- | ---: | --- |
| Chảo Wok (`noodle_factory`) | Mì Cá | 3 | Không có nhãn bundle |
| Chảo Wok (`noodle_factory`) | Mì Chay | 3 | Không có nhãn bundle |
| Cửa hàng Sushi (`sushi_bar`) | Sushi | 3 | Không có nhãn bundle |
| Cửa hàng Sushi (`sushi_bar`) | Cuộn Sushi | 2 | Không có nhãn bundle |
| Sản Xuất Súp (`soup_manufacture`) | Súp Cà Chua | 1 | Không có nhãn bundle |

**Trước khi đưa vào game**

Dựng prefab đúng pivot/tỉ lệ và thứ tự vẽ, kiểm tra các pose trên map; chốt giá/thời lượng/sản lượng Farm; nối catalog, kho, save và UI; thử gieo/thu/reload hoặc chu kỳ cây lâu năm. Không dùng source ID số làm ID Farm tự động.

Nguồn APK/hash, object ID, pivot, pixels-per-unit, clip và công thức được ghi trong `crop.json`. README và hồ sơ được tạo bởi `cocos/tools/prepare-crop-sources.py`.
