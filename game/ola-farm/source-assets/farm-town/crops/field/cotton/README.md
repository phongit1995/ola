# Bông — `cotton`

[Danh mục](../../README.md) · [Bản xem ảnh](../../index.html) · [Hồ sơ JSON](crop.json)

**Thư mục nguồn không được runtime nạp trực tiếp.** Nhãn khảo sát gốc: C3 — dệt may và đường mía.

![Icon](icon.png)

| Thuộc tính | Dữ liệu nguồn |
| --- | --- |
| Nhóm | Cây ruộng |
| Sản phẩm | Bông (`cotton`, source ID 44) |
| Thu mỗi đợt nguồn | 1 |
| Thời gian nguồn | 3600 giây |
| Cấp công thức / item nguồn | 13 / 13 |
| Chi phí mỗi lượt nguồn | 5 Xu |
| `BasicPrice` / `ExpOnUse` nguồn | 22 / 11 — chưa khẳng định là giá bán/XP thu hoạch Farm |
| Tệp PNG riêng trong thư mục | 17 |

Thời gian ở đây là **giây nguồn APK**, không phải giờ mô phỏng Farm. Cấp mở còn phụ thuộc công trình/shop/điều kiện. Với cây lâu năm, nhận hết đợt cuối mới chuyển sang cây cạn lượt; không mất quả khi số lượt bắt đầu mọc đã về 0.

**Ảnh theo role / giai đoạn nguồn**

Ảnh nằm trong `images/`, được dùng chung giữa các role khi nguồn trỏ cùng sprite. Một dòng có nhiều PNG là nhiều mảnh tham chiếu, không phải nhiều cây hoàn chỉnh. Chưa có thông tin ghép transform/hierarchy đầy đủ trong bộ ảnh này.

| Role nguồn | Clip | Các mảnh PNG |
| --- | --- | --- |
| `dead` | `idle` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `idle` | `idle` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `grow0` | `hlopok_1` | [mảnh 1](images/hlop_1_0--df2643f353.png) |
| `grow1` | `hlopok_2` | [mảnh 1](images/hlop_2_0--b262ca0928.png) |
| `grow2` | `hlopok_2` | [mảnh 1](images/hlop_2_0--b262ca0928.png) |
| `grow3` | `hlopok_2` | [mảnh 1](images/hlop_2_0--b262ca0928.png) |
| `grow0` | `grow0` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `ready2` | `hlopok_3` | [mảnh 1](images/hlop_3ten_0--02a00500d4.png), [mảnh 2](images/hlop_35_0--a7b92effe4.png), [mảnh 3](images/hlop_34_0--ad12d6dbca.png), [mảnh 4](images/hlop_33_0--9907bdbf02.png), [mảnh 5](images/hlop_32_0--8a2731de94.png), [mảnh 6](images/hlop_31_0--231b2160a2.png) |
| `ready3` | `hlopok_3` | [mảnh 1](images/hlop_3ten_0--02a00500d4.png), [mảnh 2](images/hlop_35_0--a7b92effe4.png), [mảnh 3](images/hlop_34_0--ad12d6dbca.png), [mảnh 4](images/hlop_33_0--9907bdbf02.png), [mảnh 5](images/hlop_32_0--8a2731de94.png), [mảnh 6](images/hlop_31_0--231b2160a2.png) |
| `ready4` | `hlopok_3` | [mảnh 1](images/hlop_3ten_0--02a00500d4.png), [mảnh 2](images/hlop_35_0--a7b92effe4.png), [mảnh 3](images/hlop_34_0--ad12d6dbca.png), [mảnh 4](images/hlop_33_0--9907bdbf02.png), [mảnh 5](images/hlop_32_0--8a2731de94.png), [mảnh 6](images/hlop_31_0--231b2160a2.png) |
| `ready5` | `hlopok_3` | [mảnh 1](images/hlop_3ten_0--02a00500d4.png), [mảnh 2](images/hlop_35_0--a7b92effe4.png), [mảnh 3](images/hlop_34_0--ad12d6dbca.png), [mảnh 4](images/hlop_33_0--9907bdbf02.png), [mảnh 5](images/hlop_32_0--8a2731de94.png), [mảnh 6](images/hlop_31_0--231b2160a2.png) |
| `ready1` | `hlopok_3` | [mảnh 1](images/hlop_3ten_0--02a00500d4.png), [mảnh 2](images/hlop_35_0--a7b92effe4.png), [mảnh 3](images/hlop_34_0--ad12d6dbca.png), [mảnh 4](images/hlop_33_0--9907bdbf02.png), [mảnh 5](images/hlop_32_0--8a2731de94.png), [mảnh 6](images/hlop_31_0--231b2160a2.png) |
| `harvest2` | `hlopok_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/korzina_p_0--7f793edf56.png), [mảnh 3](images/4_goroh_ten_0--95b1a24536.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_hlop_nutr_0--c7570d8ec1.png), [mảnh 6](images/4_hlop_3_0--57395cbdf8.png), [mảnh 7](images/4_hlop_2_0--bf51fbfffc.png), [mảnh 8](images/4_hlop_1_0--84c9442f34.png) |
| `harvest3` | `hlopok_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/korzina_p_0--7f793edf56.png), [mảnh 3](images/4_goroh_ten_0--95b1a24536.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_hlop_nutr_0--c7570d8ec1.png), [mảnh 6](images/4_hlop_3_0--57395cbdf8.png), [mảnh 7](images/4_hlop_2_0--bf51fbfffc.png), [mảnh 8](images/4_hlop_1_0--84c9442f34.png) |
| `harvest4` | `hlopok_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/korzina_p_0--7f793edf56.png), [mảnh 3](images/4_goroh_ten_0--95b1a24536.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_hlop_nutr_0--c7570d8ec1.png), [mảnh 6](images/4_hlop_3_0--57395cbdf8.png), [mảnh 7](images/4_hlop_2_0--bf51fbfffc.png), [mảnh 8](images/4_hlop_1_0--84c9442f34.png) |
| `harvest1` | `hlopok_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/korzina_p_0--7f793edf56.png), [mảnh 3](images/4_goroh_ten_0--95b1a24536.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_hlop_nutr_0--c7570d8ec1.png), [mảnh 6](images/4_hlop_3_0--57395cbdf8.png), [mảnh 7](images/4_hlop_2_0--bf51fbfffc.png), [mảnh 8](images/4_hlop_1_0--84c9442f34.png) |
| `harvest0` | `hlopok_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/korzina_p_0--7f793edf56.png), [mảnh 3](images/4_goroh_ten_0--95b1a24536.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_hlop_nutr_0--c7570d8ec1.png), [mảnh 6](images/4_hlop_3_0--57395cbdf8.png), [mảnh 7](images/4_hlop_2_0--bf51fbfffc.png), [mảnh 8](images/4_hlop_1_0--84c9442f34.png) |

**Công thức nguồn dùng sản phẩm này**

| Cơ sở | Sản phẩm làm ra | Cần mỗi mẻ | Điều kiện bundle nguồn |
| --- | --- | ---: | --- |
| Bàn Đan Len (`loom`) | Mũ Len | 1 | Không có nhãn bundle |
| Bàn May (`sewing`) | Áo Thun | 2 | Không có nhãn bundle |
| Mũ (`hats_prod`) | Điện Capitolium | 2 | Không có nhãn bundle |
| Mũ (`hats_prod`) | Mũ Dạ Hội | 2 | Không có nhãn bundle |
| Mũ (`hats_prod`) | Mũ Cưới | 2 | Không có nhãn bundle |
| Phụ Kiện (`accessories`) | Túi Lông Vũ | 1 | Không có nhãn bundle |

**Trước khi đưa vào game**

Dựng prefab đúng pivot/tỉ lệ và thứ tự vẽ, kiểm tra các pose trên map; chốt giá/thời lượng/sản lượng Farm; nối catalog, kho, save và UI; thử gieo/thu/reload hoặc chu kỳ cây lâu năm. Không dùng source ID số làm ID Farm tự động.

Nguồn APK/hash, object ID, pivot, pixels-per-unit, clip và công thức được ghi trong `crop.json`. README và hồ sơ được tạo bởi `cocos/tools/prepare-crop-sources.py`.
