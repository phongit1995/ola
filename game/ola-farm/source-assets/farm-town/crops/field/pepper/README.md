# Ớt — `pepper`

[Danh mục](../../README.md) · [Bản xem ảnh](../../index.html) · [Hồ sơ JSON](crop.json)

**Thư mục nguồn không được runtime nạp trực tiếp.** Nhãn khảo sát gốc: C5 — món ăn mở rộng.

![Icon](icon.png)

| Thuộc tính | Dữ liệu nguồn |
| --- | --- |
| Nhóm | Cây ruộng |
| Sản phẩm | Ớt (`pepper`, source ID 168) |
| Thu mỗi đợt nguồn | 1 |
| Thời gian nguồn | 3000 giây |
| Cấp công thức / item nguồn | 24 / 24 |
| Chi phí mỗi lượt nguồn | 5 Xu |
| `BasicPrice` / `ExpOnUse` nguồn | 16 / 8 — chưa khẳng định là giá bán/XP thu hoạch Farm |
| Tệp PNG riêng trong thư mục | 25 |

Thời gian ở đây là **giây nguồn APK**, không phải giờ mô phỏng Farm. Cấp mở còn phụ thuộc công trình/shop/điều kiện. Với cây lâu năm, nhận hết đợt cuối mới chuyển sang cây cạn lượt; không mất quả khi số lượt bắt đầu mọc đã về 0.

**Ảnh theo role / giai đoạn nguồn**

Ảnh nằm trong `images/`, được dùng chung giữa các role khi nguồn trỏ cùng sprite. Một dòng có nhiều PNG là nhiều mảnh tham chiếu, không phải nhiều cây hoàn chỉnh. Chưa có thông tin ghép transform/hierarchy đầy đủ trong bộ ảnh này.

| Role nguồn | Clip | Các mảnh PNG |
| --- | --- | --- |
| `dead` | `idle` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `idle` | `idle` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `grow0` | `perec_1` | [mảnh 1](images/perec_1_0--8621b6143e.png) |
| `grow1` | `perec_2` | [mảnh 1](images/perec_2_0--754ce01fc1.png) |
| `grow2` | `perec_2` | [mảnh 1](images/perec_2_0--754ce01fc1.png) |
| `grow3` | `perec_2` | [mảnh 1](images/perec_2_0--754ce01fc1.png) |
| `grow0` | `grow0` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `ready2` | `perec_3` | [mảnh 1](images/perec_3ten_0--e7b8ad2f2f.png), [mảnh 2](images/perec_3kust4_0--41a302f3ae.png), [mảnh 3](images/perec_342_0--696e1bc732.png), [mảnh 4](images/perec_341_0--a19d93e977.png), [mảnh 5](images/perec_3kust3_0--2ed2815498.png), [mảnh 6](images/perec_333_0--c5742c65a6.png), [mảnh 7](images/perec_332_0--dc93f6006d.png), [mảnh 8](images/perec_331_0--d5132b8a8c.png), [mảnh 9](images/perec_3kust2_0--66e42dd4b8.png), [mảnh 10](images/perec_323_0--f7d2fe5736.png), [mảnh 11](images/perec_322_0--ee19ccc7f5.png), [mảnh 12](images/perec_321_0--3aef360dfa.png), [mảnh 13](images/perec_313_0--b79864b25c.png), [mảnh 14](images/perec_312_0--e91870efc5.png), [mảnh 15](images/perec_311_0--dc6f99cb4c.png), [mảnh 16](images/perec_3kust1_0--7ed7060f5b.png) |
| `ready3` | `perec_3` | [mảnh 1](images/perec_3ten_0--e7b8ad2f2f.png), [mảnh 2](images/perec_3kust4_0--41a302f3ae.png), [mảnh 3](images/perec_342_0--696e1bc732.png), [mảnh 4](images/perec_341_0--a19d93e977.png), [mảnh 5](images/perec_3kust3_0--2ed2815498.png), [mảnh 6](images/perec_333_0--c5742c65a6.png), [mảnh 7](images/perec_332_0--dc93f6006d.png), [mảnh 8](images/perec_331_0--d5132b8a8c.png), [mảnh 9](images/perec_3kust2_0--66e42dd4b8.png), [mảnh 10](images/perec_323_0--f7d2fe5736.png), [mảnh 11](images/perec_322_0--ee19ccc7f5.png), [mảnh 12](images/perec_321_0--3aef360dfa.png), [mảnh 13](images/perec_313_0--b79864b25c.png), [mảnh 14](images/perec_312_0--e91870efc5.png), [mảnh 15](images/perec_311_0--dc6f99cb4c.png), [mảnh 16](images/perec_3kust1_0--7ed7060f5b.png) |
| `ready4` | `perec_3` | [mảnh 1](images/perec_3ten_0--e7b8ad2f2f.png), [mảnh 2](images/perec_3kust4_0--41a302f3ae.png), [mảnh 3](images/perec_342_0--696e1bc732.png), [mảnh 4](images/perec_341_0--a19d93e977.png), [mảnh 5](images/perec_3kust3_0--2ed2815498.png), [mảnh 6](images/perec_333_0--c5742c65a6.png), [mảnh 7](images/perec_332_0--dc93f6006d.png), [mảnh 8](images/perec_331_0--d5132b8a8c.png), [mảnh 9](images/perec_3kust2_0--66e42dd4b8.png), [mảnh 10](images/perec_323_0--f7d2fe5736.png), [mảnh 11](images/perec_322_0--ee19ccc7f5.png), [mảnh 12](images/perec_321_0--3aef360dfa.png), [mảnh 13](images/perec_313_0--b79864b25c.png), [mảnh 14](images/perec_312_0--e91870efc5.png), [mảnh 15](images/perec_311_0--dc6f99cb4c.png), [mảnh 16](images/perec_3kust1_0--7ed7060f5b.png) |
| `ready5` | `perec_3` | [mảnh 1](images/perec_3ten_0--e7b8ad2f2f.png), [mảnh 2](images/perec_3kust4_0--41a302f3ae.png), [mảnh 3](images/perec_342_0--696e1bc732.png), [mảnh 4](images/perec_341_0--a19d93e977.png), [mảnh 5](images/perec_3kust3_0--2ed2815498.png), [mảnh 6](images/perec_333_0--c5742c65a6.png), [mảnh 7](images/perec_332_0--dc93f6006d.png), [mảnh 8](images/perec_331_0--d5132b8a8c.png), [mảnh 9](images/perec_3kust2_0--66e42dd4b8.png), [mảnh 10](images/perec_323_0--f7d2fe5736.png), [mảnh 11](images/perec_322_0--ee19ccc7f5.png), [mảnh 12](images/perec_321_0--3aef360dfa.png), [mảnh 13](images/perec_313_0--b79864b25c.png), [mảnh 14](images/perec_312_0--e91870efc5.png), [mảnh 15](images/perec_311_0--dc6f99cb4c.png), [mảnh 16](images/perec_3kust1_0--7ed7060f5b.png) |
| `ready1` | `perec_3` | [mảnh 1](images/perec_3ten_0--e7b8ad2f2f.png), [mảnh 2](images/perec_3kust4_0--41a302f3ae.png), [mảnh 3](images/perec_342_0--696e1bc732.png), [mảnh 4](images/perec_341_0--a19d93e977.png), [mảnh 5](images/perec_3kust3_0--2ed2815498.png), [mảnh 6](images/perec_333_0--c5742c65a6.png), [mảnh 7](images/perec_332_0--dc93f6006d.png), [mảnh 8](images/perec_331_0--d5132b8a8c.png), [mảnh 9](images/perec_3kust2_0--66e42dd4b8.png), [mảnh 10](images/perec_323_0--f7d2fe5736.png), [mảnh 11](images/perec_322_0--ee19ccc7f5.png), [mảnh 12](images/perec_321_0--3aef360dfa.png), [mảnh 13](images/perec_313_0--b79864b25c.png), [mảnh 14](images/perec_312_0--e91870efc5.png), [mảnh 15](images/perec_311_0--dc6f99cb4c.png), [mảnh 16](images/perec_3kust1_0--7ed7060f5b.png) |
| `harvest2` | `perec_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_perec_nutr_0--c2da3e5382.png), [mảnh 6](images/4_perec_0--b364799bdb.png) |
| `harvest3` | `perec_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_perec_nutr_0--c2da3e5382.png), [mảnh 6](images/4_perec_0--b364799bdb.png) |
| `harvest4` | `perec_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_perec_nutr_0--c2da3e5382.png), [mảnh 6](images/4_perec_0--b364799bdb.png) |
| `harvest1` | `perec_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_perec_nutr_0--c2da3e5382.png), [mảnh 6](images/4_perec_0--b364799bdb.png) |
| `harvest0` | `perec_end` | [mảnh 1](images/korzina_z_0--883118c11b.png), [mảnh 2](images/4_goroh_ten_0--95b1a24536.png), [mảnh 3](images/korzina_p_0--7f793edf56.png), [mảnh 4](images/ruchka_korzina_0--aaf9e6b4e2.png), [mảnh 5](images/4_perec_nutr_0--c2da3e5382.png), [mảnh 6](images/4_perec_0--b364799bdb.png) |

**Công thức nguồn dùng sản phẩm này**

| Cơ sở | Sản phẩm làm ra | Cần mỗi mẻ | Điều kiện bundle nguồn |
| --- | --- | ---: | --- |
| Lò Pizza (`pizza_bakery`) | Pizza Pepperoni | 2 | Không có nhãn bundle |
| Chảo Wok (`noodle_factory`) | Mì Cá | 1 | Không có nhãn bundle |
| Chảo Wok (`noodle_factory`) | Mì Chay | 1 | Không có nhãn bundle |
| Đồ Ăn Mexico (`mexico`) | Bánh Nachos | 1 | Không có nhãn bundle |

**Trước khi đưa vào game**

Dựng prefab đúng pivot/tỉ lệ và thứ tự vẽ, kiểm tra các pose trên map; chốt giá/thời lượng/sản lượng Farm; nối catalog, kho, save và UI; thử gieo/thu/reload hoặc chu kỳ cây lâu năm. Không dùng source ID số làm ID Farm tự động.

Nguồn APK/hash, object ID, pivot, pixels-per-unit, clip và công thức được ghi trong `crop.json`. README và hồ sơ được tạo bởi `cocos/tools/prepare-crop-sources.py`.
