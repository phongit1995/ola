# Bí Ngô — `pumpkin`

[Danh mục](../../README.md) · [Bản xem ảnh](../../index.html) · [Hồ sơ JSON](crop.json)

**Thư mục nguồn không được runtime nạp trực tiếp.** Nhãn khảo sát gốc: C2 — đường và thức ăn heo/cừu.

![Icon](icon.png)

| Thuộc tính | Dữ liệu nguồn |
| --- | --- |
| Nhóm | Cây ruộng |
| Sản phẩm | Bí Ngô (`pumpkin`, source ID 129) |
| Thu mỗi đợt nguồn | 1 |
| Thời gian nguồn | 3000 giây |
| Cấp công thức / item nguồn | 11 / 11 |
| Chi phí mỗi lượt nguồn | 4 Xu |
| `BasicPrice` / `ExpOnUse` nguồn | 22 / 9 — chưa khẳng định là giá bán/XP thu hoạch Farm |
| Tệp PNG riêng trong thư mục | 23 |

Thời gian ở đây là **giây nguồn APK**, không phải giờ mô phỏng Farm. Cấp mở còn phụ thuộc công trình/shop/điều kiện. Với cây lâu năm, nhận hết đợt cuối mới chuyển sang cây cạn lượt; không mất quả khi số lượt bắt đầu mọc đã về 0.

**Ảnh theo role / giai đoạn nguồn**

Ảnh nằm trong `images/`, được dùng chung giữa các role khi nguồn trỏ cùng sprite. Một dòng có nhiều PNG là nhiều mảnh tham chiếu, không phải nhiều cây hoàn chỉnh. Chưa có thông tin ghép transform/hierarchy đầy đủ trong bộ ảnh này.

| Role nguồn | Clip | Các mảnh PNG |
| --- | --- | --- |
| `dead` | `idle` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `idle` | `idle` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `grow0` | `tikva_1` | [mảnh 1](images/tikv_1_0--ad4d2ddcb0.png) |
| `grow1` | `tikva_2` | [mảnh 1](images/tikv_2_0--fa98d973b1.png) |
| `grow2` | `tikva_2` | [mảnh 1](images/tikv_2_0--fa98d973b1.png) |
| `grow3` | `tikva_2` | [mảnh 1](images/tikv_2_0--fa98d973b1.png) |
| `grow0` | `grow0` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `ready2` | `tikva_3` | [mảnh 1](images/tikv_3ten_0--dc4c60d8b1.png), [mảnh 2](images/tikv_3t_2_0--63aa69bbfc.png), [mảnh 3](images/tikv_3lian9_0--c4ca03e61d.png), [mảnh 4](images/tikv_3lian8_0--2381a13705.png), [mảnh 5](images/tikv_3lian5_0--bf45c16c3a.png), [mảnh 6](images/tikv_3lian6_0--74f6db9c45.png), [mảnh 7](images/tikv_3lian4_0--c8b9151fd6.png), [mảnh 8](images/tikv_3lian3_0--6ea723c824.png), [mảnh 9](images/tikv_3t_1_0--d3b7d6bff0.png), [mảnh 10](images/tikv_3lian1_0--003c9da3b0.png), [mảnh 11](images/tikv_3lian2_0--7dc3011015.png) |
| `ready3` | `tikva_3` | [mảnh 1](images/tikv_3ten_0--dc4c60d8b1.png), [mảnh 2](images/tikv_3t_2_0--63aa69bbfc.png), [mảnh 3](images/tikv_3lian9_0--c4ca03e61d.png), [mảnh 4](images/tikv_3lian8_0--2381a13705.png), [mảnh 5](images/tikv_3lian5_0--bf45c16c3a.png), [mảnh 6](images/tikv_3lian6_0--74f6db9c45.png), [mảnh 7](images/tikv_3lian4_0--c8b9151fd6.png), [mảnh 8](images/tikv_3lian3_0--6ea723c824.png), [mảnh 9](images/tikv_3t_1_0--d3b7d6bff0.png), [mảnh 10](images/tikv_3lian1_0--003c9da3b0.png), [mảnh 11](images/tikv_3lian2_0--7dc3011015.png) |
| `ready4` | `tikva_3` | [mảnh 1](images/tikv_3ten_0--dc4c60d8b1.png), [mảnh 2](images/tikv_3t_2_0--63aa69bbfc.png), [mảnh 3](images/tikv_3lian9_0--c4ca03e61d.png), [mảnh 4](images/tikv_3lian8_0--2381a13705.png), [mảnh 5](images/tikv_3lian5_0--bf45c16c3a.png), [mảnh 6](images/tikv_3lian6_0--74f6db9c45.png), [mảnh 7](images/tikv_3lian4_0--c8b9151fd6.png), [mảnh 8](images/tikv_3lian3_0--6ea723c824.png), [mảnh 9](images/tikv_3t_1_0--d3b7d6bff0.png), [mảnh 10](images/tikv_3lian1_0--003c9da3b0.png), [mảnh 11](images/tikv_3lian2_0--7dc3011015.png) |
| `ready5` | `tikva_3` | [mảnh 1](images/tikv_3ten_0--dc4c60d8b1.png), [mảnh 2](images/tikv_3t_2_0--63aa69bbfc.png), [mảnh 3](images/tikv_3lian9_0--c4ca03e61d.png), [mảnh 4](images/tikv_3lian8_0--2381a13705.png), [mảnh 5](images/tikv_3lian5_0--bf45c16c3a.png), [mảnh 6](images/tikv_3lian6_0--74f6db9c45.png), [mảnh 7](images/tikv_3lian4_0--c8b9151fd6.png), [mảnh 8](images/tikv_3lian3_0--6ea723c824.png), [mảnh 9](images/tikv_3t_1_0--d3b7d6bff0.png), [mảnh 10](images/tikv_3lian1_0--003c9da3b0.png), [mảnh 11](images/tikv_3lian2_0--7dc3011015.png) |
| `ready1` | `tikva_3` | [mảnh 1](images/tikv_3ten_0--dc4c60d8b1.png), [mảnh 2](images/tikv_3t_2_0--63aa69bbfc.png), [mảnh 3](images/tikv_3lian9_0--c4ca03e61d.png), [mảnh 4](images/tikv_3lian8_0--2381a13705.png), [mảnh 5](images/tikv_3lian5_0--bf45c16c3a.png), [mảnh 6](images/tikv_3lian6_0--74f6db9c45.png), [mảnh 7](images/tikv_3lian4_0--c8b9151fd6.png), [mảnh 8](images/tikv_3lian3_0--6ea723c824.png), [mảnh 9](images/tikv_3t_1_0--d3b7d6bff0.png), [mảnh 10](images/tikv_3lian1_0--003c9da3b0.png), [mảnh 11](images/tikv_3lian2_0--7dc3011015.png) |
| `harvest2` | `tikva_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_tikv_nutr_0--c5280ad59c.png), [mảnh 6](images/4_tikv_1_0--8146bfc501.png), [mảnh 7](images/4_tikv_list_nutr_0--c00567f9eb.png), [mảnh 8](images/4_tikv_list_0--fdd760bee2.png), [mảnh 9](images/4_tikv_ten_0--1f7c48bfae.png) |
| `harvest3` | `tikva_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_tikv_nutr_0--c5280ad59c.png), [mảnh 6](images/4_tikv_1_0--8146bfc501.png), [mảnh 7](images/4_tikv_list_nutr_0--c00567f9eb.png), [mảnh 8](images/4_tikv_list_0--fdd760bee2.png), [mảnh 9](images/4_tikv_ten_0--1f7c48bfae.png) |
| `harvest4` | `tikva_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_tikv_nutr_0--c5280ad59c.png), [mảnh 6](images/4_tikv_1_0--8146bfc501.png), [mảnh 7](images/4_tikv_list_nutr_0--c00567f9eb.png), [mảnh 8](images/4_tikv_list_0--fdd760bee2.png), [mảnh 9](images/4_tikv_ten_0--1f7c48bfae.png) |
| `harvest1` | `tikva_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_tikv_nutr_0--c5280ad59c.png), [mảnh 6](images/4_tikv_1_0--8146bfc501.png), [mảnh 7](images/4_tikv_list_nutr_0--c00567f9eb.png), [mảnh 8](images/4_tikv_list_0--fdd760bee2.png), [mảnh 9](images/4_tikv_ten_0--1f7c48bfae.png) |
| `harvest0` | `tikva_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_tikv_nutr_0--c5280ad59c.png), [mảnh 6](images/4_tikv_1_0--8146bfc501.png), [mảnh 7](images/4_tikv_list_nutr_0--c00567f9eb.png), [mảnh 8](images/4_tikv_list_0--fdd760bee2.png), [mảnh 9](images/4_tikv_ten_0--1f7c48bfae.png) |

**Công thức nguồn dùng sản phẩm này**

| Cơ sở | Sản phẩm làm ra | Cần mỗi mẻ | Điều kiện bundle nguồn |
| --- | --- | ---: | --- |
| Phụ Kiện (`accessories`) | Đèn Bí Ngô Jack O’Lantern | 1 | halloween |
| Máy Chế Biến Thực Phẩm (`food_processor`) | Thức Ăn Cừu | 1 | Không có nhãn bundle |
| Sản Xuất Súp (`soup_manufacture`) | Súp Bí Ngô | 1 | Không có nhãn bundle |
| Đồ Ăn Mexico (`mexico`) | Bánh Quesadilla | 1 | Không có nhãn bundle |
| Tiệm Bánh Pie (`pie_bakery`) | Bánh Pie Lễ Hội | 1 | halloween |
| Tiệm Bánh Pie (`pie_bakery`) | Bánh Bí Ngô | 2 | Không có nhãn bundle |

**Trước khi đưa vào game**

Dựng prefab đúng pivot/tỉ lệ và thứ tự vẽ, kiểm tra các pose trên map; chốt giá/thời lượng/sản lượng Farm; nối catalog, kho, save và UI; thử gieo/thu/reload hoặc chu kỳ cây lâu năm. Không dùng source ID số làm ID Farm tự động.

Nguồn APK/hash, object ID, pivot, pixels-per-unit, clip và công thức được ghi trong `crop.json`. README và hồ sơ được tạo bởi `cocos/tools/prepare-crop-sources.py`.
