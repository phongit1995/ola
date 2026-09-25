# Bắp Cải — `cabbage`

[Danh mục](../../README.md) · [Bản xem ảnh](../../index.html) · [Hồ sơ JSON](crop.json)

**Thư mục nguồn không được runtime nạp trực tiếp.** Nhãn khảo sát gốc: C1 — ngô và bắp cải.

![Icon](icon.png)

| Thuộc tính | Dữ liệu nguồn |
| --- | --- |
| Nhóm | Cây ruộng |
| Sản phẩm | Bắp Cải (`cabbage`, source ID 21) |
| Thu mỗi đợt nguồn | 1 |
| Thời gian nguồn | 300 giây |
| Cấp công thức / item nguồn | 5 / 5 |
| Chi phí mỗi lượt nguồn | 2 Xu |
| `BasicPrice` / `ExpOnUse` nguồn | 10 / 3 — chưa khẳng định là giá bán/XP thu hoạch Farm |
| Tệp PNG riêng trong thư mục | 17 |

Thời gian ở đây là **giây nguồn APK**, không phải giờ mô phỏng Farm. Cấp mở còn phụ thuộc công trình/shop/điều kiện. Với cây lâu năm, nhận hết đợt cuối mới chuyển sang cây cạn lượt; không mất quả khi số lượt bắt đầu mọc đã về 0.

**Ảnh theo role / giai đoạn nguồn**

Ảnh nằm trong `images/`, được dùng chung giữa các role khi nguồn trỏ cùng sprite. Một dòng có nhiều PNG là nhiều mảnh tham chiếu, không phải nhiều cây hoàn chỉnh. Chưa có thông tin ghép transform/hierarchy đầy đủ trong bộ ảnh này.

| Role nguồn | Clip | Các mảnh PNG |
| --- | --- | --- |
| `dead` | `idle` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `idle` | `idle` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `grow0` | `kapusta_1` | [mảnh 1](images/kap_1_0--469bac7fe6.png) |
| `grow1` | `kapusta_1` | [mảnh 1](images/kap_1_0--469bac7fe6.png) |
| `grow2` | `kapusta_2` | [mảnh 1](images/kap_2_0--507bcf772a.png) |
| `grow3` | `kapusta_2` | [mảnh 1](images/kap_2_0--507bcf772a.png) |
| `grow0` | `grow0` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `ready2` | `kapusta_3` | [mảnh 1](images/kap_3ten_0--5ef2250fc9.png), [mảnh 2](images/kap_34_0--6806a0ce74.png), [mảnh 3](images/kap_33_0--5c00d89db8.png), [mảnh 4](images/kap_32_0--54f9a9cabd.png), [mảnh 5](images/kap_31_0--48b4aa6fff.png) |
| `ready3` | `kapusta_3` | [mảnh 1](images/kap_3ten_0--5ef2250fc9.png), [mảnh 2](images/kap_34_0--6806a0ce74.png), [mảnh 3](images/kap_33_0--5c00d89db8.png), [mảnh 4](images/kap_32_0--54f9a9cabd.png), [mảnh 5](images/kap_31_0--48b4aa6fff.png) |
| `ready4` | `kapusta_3` | [mảnh 1](images/kap_3ten_0--5ef2250fc9.png), [mảnh 2](images/kap_34_0--6806a0ce74.png), [mảnh 3](images/kap_33_0--5c00d89db8.png), [mảnh 4](images/kap_32_0--54f9a9cabd.png), [mảnh 5](images/kap_31_0--48b4aa6fff.png) |
| `ready5` | `kapusta_3` | [mảnh 1](images/kap_3ten_0--5ef2250fc9.png), [mảnh 2](images/kap_34_0--6806a0ce74.png), [mảnh 3](images/kap_33_0--5c00d89db8.png), [mảnh 4](images/kap_32_0--54f9a9cabd.png), [mảnh 5](images/kap_31_0--48b4aa6fff.png) |
| `ready1` | `kapusta_3` | [mảnh 1](images/kap_3ten_0--5ef2250fc9.png), [mảnh 2](images/kap_34_0--6806a0ce74.png), [mảnh 3](images/kap_33_0--5c00d89db8.png), [mảnh 4](images/kap_32_0--54f9a9cabd.png), [mảnh 5](images/kap_31_0--48b4aa6fff.png) |
| `harvest2` | `kapusta_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_kapusta_nutr_3_0--31a3799ab9.png), [mảnh 6](images/4_kapusta_nutr_2_0--e0ea82e125.png), [mảnh 7](images/4_kapusta_nutr_1_0--eacd3b8a64.png), [mảnh 8](images/4_kapusta_0--a330ca311a.png), [mảnh 9](images/4_kapusta_ten_0--5be3f509a3.png) |
| `harvest3` | `kapusta_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_kapusta_nutr_3_0--31a3799ab9.png), [mảnh 6](images/4_kapusta_nutr_2_0--e0ea82e125.png), [mảnh 7](images/4_kapusta_nutr_1_0--eacd3b8a64.png), [mảnh 8](images/4_kapusta_0--a330ca311a.png), [mảnh 9](images/4_kapusta_ten_0--5be3f509a3.png) |
| `harvest4` | `kapusta_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_kapusta_nutr_3_0--31a3799ab9.png), [mảnh 6](images/4_kapusta_nutr_2_0--e0ea82e125.png), [mảnh 7](images/4_kapusta_nutr_1_0--eacd3b8a64.png), [mảnh 8](images/4_kapusta_0--a330ca311a.png), [mảnh 9](images/4_kapusta_ten_0--5be3f509a3.png) |
| `harvest1` | `kapusta_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_kapusta_nutr_3_0--31a3799ab9.png), [mảnh 6](images/4_kapusta_nutr_2_0--e0ea82e125.png), [mảnh 7](images/4_kapusta_nutr_1_0--eacd3b8a64.png), [mảnh 8](images/4_kapusta_0--a330ca311a.png), [mảnh 9](images/4_kapusta_ten_0--5be3f509a3.png) |
| `harvest0` | `kapusta_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_kapusta_nutr_3_0--31a3799ab9.png), [mảnh 6](images/4_kapusta_nutr_2_0--e0ea82e125.png), [mảnh 7](images/4_kapusta_nutr_1_0--eacd3b8a64.png), [mảnh 8](images/4_kapusta_0--a330ca311a.png), [mảnh 9](images/4_kapusta_ten_0--5be3f509a3.png) |

**Công thức nguồn dùng sản phẩm này**

| Cơ sở | Sản phẩm làm ra | Cần mỗi mẻ | Điều kiện bundle nguồn |
| --- | --- | ---: | --- |
| Máy Chế Biến Thực Phẩm (`food_processor`) | Thức Ăn Bò | 2 | Không có nhãn bundle |
| Máy Chế Biến Thực Phẩm (`food_processor`) | Thức Ăn Heo | 2 | Không có nhãn bundle |
| Tiệm Bánh Pie (`pie_bakery`) | Bánh Bắp Cải | 2 | Không có nhãn bundle |

**Trước khi đưa vào game**

Dựng prefab đúng pivot/tỉ lệ và thứ tự vẽ, kiểm tra các pose trên map; chốt giá/thời lượng/sản lượng Farm; nối catalog, kho, save và UI; thử gieo/thu/reload hoặc chu kỳ cây lâu năm. Không dùng source ID số làm ID Farm tự động.

Nguồn APK/hash, object ID, pivot, pixels-per-unit, clip và công thức được ghi trong `crop.json`. README và hồ sơ được tạo bởi `cocos/tools/prepare-crop-sources.py`.
