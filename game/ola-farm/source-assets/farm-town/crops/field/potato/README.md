# Khoai Tây — `potato`

[Danh mục](../../README.md) · [Bản xem ảnh](../../index.html) · [Hồ sơ JSON](crop.json)

**Thư mục nguồn không được runtime nạp trực tiếp.** Nhãn khảo sát gốc: C2 — đường và thức ăn heo/cừu.

![Icon](icon.png)

| Thuộc tính | Dữ liệu nguồn |
| --- | --- |
| Nhóm | Cây ruộng |
| Sản phẩm | Khoai Tây (`potato`, source ID 128) |
| Thu mỗi đợt nguồn | 1 |
| Thời gian nguồn | 2400 giây |
| Cấp công thức / item nguồn | 10 / 10 |
| Chi phí mỗi lượt nguồn | 4 Xu |
| `BasicPrice` / `ExpOnUse` nguồn | 16 / 8 — chưa khẳng định là giá bán/XP thu hoạch Farm |
| Tệp PNG riêng trong thư mục | 20 |

Thời gian ở đây là **giây nguồn APK**, không phải giờ mô phỏng Farm. Cấp mở còn phụ thuộc công trình/shop/điều kiện. Với cây lâu năm, nhận hết đợt cuối mới chuyển sang cây cạn lượt; không mất quả khi số lượt bắt đầu mọc đã về 0.

**Ảnh theo role / giai đoạn nguồn**

Ảnh nằm trong `images/`, được dùng chung giữa các role khi nguồn trỏ cùng sprite. Một dòng có nhiều PNG là nhiều mảnh tham chiếu, không phải nhiều cây hoàn chỉnh. Chưa có thông tin ghép transform/hierarchy đầy đủ trong bộ ảnh này.

| Role nguồn | Clip | Các mảnh PNG |
| --- | --- | --- |
| `dead` | `idle` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `idle` | `idle` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `grow0` | `kartoshka_1` | [mảnh 1](images/kart_1_0--7fc289c00d.png) |
| `grow1` | `kartoshka_2` | [mảnh 1](images/kart_2_0--380c74fa7b.png) |
| `grow2` | `kartoshka_2` | [mảnh 1](images/kart_2_0--380c74fa7b.png) |
| `grow3` | `kartoshka_2` | [mảnh 1](images/kart_2_0--380c74fa7b.png) |
| `grow0` | `grow0` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `ready2` | `kartoshka_3` | [mảnh 1](images/kart_3ten_0--b5da0ed74d.png), [mảnh 2](images/kart_34_0--f61fd8b461.png), [mảnh 3](images/kart_312_0--0df57412a7.png), [mảnh 4](images/kart_332_0--f5bc70c44f.png), [mảnh 5](images/kart_331_0--deafe63ce3.png), [mảnh 6](images/kart_321_0--8ca8ed1acd.png), [mảnh 7](images/kart_311_0--f364f1577d.png) |
| `ready3` | `kartoshka_3` | [mảnh 1](images/kart_3ten_0--b5da0ed74d.png), [mảnh 2](images/kart_34_0--f61fd8b461.png), [mảnh 3](images/kart_312_0--0df57412a7.png), [mảnh 4](images/kart_332_0--f5bc70c44f.png), [mảnh 5](images/kart_331_0--deafe63ce3.png), [mảnh 6](images/kart_321_0--8ca8ed1acd.png), [mảnh 7](images/kart_311_0--f364f1577d.png) |
| `ready4` | `kartoshka_3` | [mảnh 1](images/kart_3ten_0--b5da0ed74d.png), [mảnh 2](images/kart_34_0--f61fd8b461.png), [mảnh 3](images/kart_312_0--0df57412a7.png), [mảnh 4](images/kart_332_0--f5bc70c44f.png), [mảnh 5](images/kart_331_0--deafe63ce3.png), [mảnh 6](images/kart_321_0--8ca8ed1acd.png), [mảnh 7](images/kart_311_0--f364f1577d.png) |
| `ready5` | `kartoshka_3` | [mảnh 1](images/kart_3ten_0--b5da0ed74d.png), [mảnh 2](images/kart_34_0--f61fd8b461.png), [mảnh 3](images/kart_312_0--0df57412a7.png), [mảnh 4](images/kart_332_0--f5bc70c44f.png), [mảnh 5](images/kart_331_0--deafe63ce3.png), [mảnh 6](images/kart_321_0--8ca8ed1acd.png), [mảnh 7](images/kart_311_0--f364f1577d.png) |
| `ready1` | `kartoshka_3` | [mảnh 1](images/kart_3ten_0--b5da0ed74d.png), [mảnh 2](images/kart_34_0--f61fd8b461.png), [mảnh 3](images/kart_312_0--0df57412a7.png), [mảnh 4](images/kart_332_0--f5bc70c44f.png), [mảnh 5](images/kart_331_0--deafe63ce3.png), [mảnh 6](images/kart_321_0--8ca8ed1acd.png), [mảnh 7](images/kart_311_0--f364f1577d.png) |
| `harvest2` | `kartoshka_end` | [mảnh 1](images/meshok_z_0--c1848e62a1.png), [mảnh 2](images/4_ten_meshok_0--89cb7583a7.png), [mảnh 3](images/meshok_p_0--956db0cfd0.png), [mảnh 4](images/4_kart_nutr_3_0--15bc50ab29.png), [mảnh 5](images/4_kart_nutr_2_0--019cfa9f30.png), [mảnh 6](images/4_kart_nutr_1_0--ff6279a7bb.png), [mảnh 7](images/4_kart_3_0--356629bffb.png), [mảnh 8](images/4_kart_2_0--41c203a51f.png), [mảnh 9](images/4_kart_1_0--e307a2685f.png), [mảnh 10](images/4_kart_ten_0--2dac6354a3.png) |
| `harvest3` | `kartoshka_end` | [mảnh 1](images/meshok_z_0--c1848e62a1.png), [mảnh 2](images/4_ten_meshok_0--89cb7583a7.png), [mảnh 3](images/meshok_p_0--956db0cfd0.png), [mảnh 4](images/4_kart_nutr_3_0--15bc50ab29.png), [mảnh 5](images/4_kart_nutr_2_0--019cfa9f30.png), [mảnh 6](images/4_kart_nutr_1_0--ff6279a7bb.png), [mảnh 7](images/4_kart_3_0--356629bffb.png), [mảnh 8](images/4_kart_2_0--41c203a51f.png), [mảnh 9](images/4_kart_1_0--e307a2685f.png), [mảnh 10](images/4_kart_ten_0--2dac6354a3.png) |
| `harvest4` | `kartoshka_end` | [mảnh 1](images/meshok_z_0--c1848e62a1.png), [mảnh 2](images/4_ten_meshok_0--89cb7583a7.png), [mảnh 3](images/meshok_p_0--956db0cfd0.png), [mảnh 4](images/4_kart_nutr_3_0--15bc50ab29.png), [mảnh 5](images/4_kart_nutr_2_0--019cfa9f30.png), [mảnh 6](images/4_kart_nutr_1_0--ff6279a7bb.png), [mảnh 7](images/4_kart_3_0--356629bffb.png), [mảnh 8](images/4_kart_2_0--41c203a51f.png), [mảnh 9](images/4_kart_1_0--e307a2685f.png), [mảnh 10](images/4_kart_ten_0--2dac6354a3.png) |
| `harvest1` | `kartoshka_end` | [mảnh 1](images/meshok_z_0--c1848e62a1.png), [mảnh 2](images/4_ten_meshok_0--89cb7583a7.png), [mảnh 3](images/meshok_p_0--956db0cfd0.png), [mảnh 4](images/4_kart_nutr_3_0--15bc50ab29.png), [mảnh 5](images/4_kart_nutr_2_0--019cfa9f30.png), [mảnh 6](images/4_kart_nutr_1_0--ff6279a7bb.png), [mảnh 7](images/4_kart_3_0--356629bffb.png), [mảnh 8](images/4_kart_2_0--41c203a51f.png), [mảnh 9](images/4_kart_1_0--e307a2685f.png), [mảnh 10](images/4_kart_ten_0--2dac6354a3.png) |
| `harvest0` | `kartoshka_end` | [mảnh 1](images/meshok_z_0--c1848e62a1.png), [mảnh 2](images/4_ten_meshok_0--89cb7583a7.png), [mảnh 3](images/meshok_p_0--956db0cfd0.png), [mảnh 4](images/4_kart_nutr_3_0--15bc50ab29.png), [mảnh 5](images/4_kart_nutr_2_0--019cfa9f30.png), [mảnh 6](images/4_kart_nutr_1_0--ff6279a7bb.png), [mảnh 7](images/4_kart_3_0--356629bffb.png), [mảnh 8](images/4_kart_2_0--41c203a51f.png), [mảnh 9](images/4_kart_1_0--e307a2685f.png), [mảnh 10](images/4_kart_ten_0--2dac6354a3.png) |

**Công thức nguồn dùng sản phẩm này**

| Cơ sở | Sản phẩm làm ra | Cần mỗi mẻ | Điều kiện bundle nguồn |
| --- | --- | ---: | --- |
| Máy Chế Biến Thực Phẩm (`food_processor`) | Thức Ăn Cừu | 2 | Không có nhãn bundle |
| Đồ Ăn Mexico (`mexico`) | Bánh Enchiladas | 1 | Không có nhãn bundle |
| Lò Nướng (`oven`) | Khoai Tây Chiên | 3 | Không có nhãn bundle |
| Tiệm Bánh Pie (`pie_bakery`) | Bánh Thịt Nghiền (Shepherd's Pie) | 2 | Không có nhãn bundle |

**Trước khi đưa vào game**

Dựng prefab đúng pivot/tỉ lệ và thứ tự vẽ, kiểm tra các pose trên map; chốt giá/thời lượng/sản lượng Farm; nối catalog, kho, save và UI; thử gieo/thu/reload hoặc chu kỳ cây lâu năm. Không dùng source ID số làm ID Farm tự động.

Nguồn APK/hash, object ID, pivot, pixels-per-unit, clip và công thức được ghi trong `crop.json`. README và hồ sơ được tạo bởi `cocos/tools/prepare-crop-sources.py`.
