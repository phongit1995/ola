# Lúa Mì — `wheat`

[Danh mục](../../README.md) · [Bản xem ảnh](../../index.html) · [Hồ sơ JSON](crop.json)

**Thư mục nguồn không được runtime nạp trực tiếp.** Nhãn khảo sát gốc: REF — đối chiếu, giữ art Farm hiện có.

![Icon](icon.png)

| Thuộc tính | Dữ liệu nguồn |
| --- | --- |
| Nhóm | Cây ruộng |
| Sản phẩm | Lúa Mì (`wheat`, source ID 152) |
| Thu mỗi đợt nguồn | 1 |
| Thời gian nguồn | 30 giây |
| Cấp công thức / item nguồn | 1 / 1 |
| Chi phí mỗi lượt nguồn | 0 Xu |
| `BasicPrice` / `ExpOnUse` nguồn | 2 / 1 — chưa khẳng định là giá bán/XP thu hoạch Farm |
| Tệp PNG riêng trong thư mục | 17 |

Thời gian ở đây là **giây nguồn APK**, không phải giờ mô phỏng Farm. Cấp mở còn phụ thuộc công trình/shop/điều kiện. Với cây lâu năm, nhận hết đợt cuối mới chuyển sang cây cạn lượt; không mất quả khi số lượt bắt đầu mọc đã về 0.

**Ảnh theo role / giai đoạn nguồn**

Ảnh nằm trong `images/`, được dùng chung giữa các role khi nguồn trỏ cùng sprite. Một dòng có nhiều PNG là nhiều mảnh tham chiếu, không phải nhiều cây hoàn chỉnh. Chưa có thông tin ghép transform/hierarchy đầy đủ trong bộ ảnh này.

| Role nguồn | Clip | Các mảnh PNG |
| --- | --- | --- |
| `dead` | `idle` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `idle` | `idle` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `grow0` | `psheno_1` | [mảnh 1](images/pshen_1_0--f907516cde.png) |
| `grow1` | `psheno_2` | [mảnh 1](images/pshen_2_0--bb95f173c7.png) |
| `grow2` | `psheno_2` | [mảnh 1](images/pshen_2_0--bb95f173c7.png) |
| `grow3` | `psheno_2` | [mảnh 1](images/pshen_2_0--bb95f173c7.png) |
| `grow0` | `grow0` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `ready2` | `psheno_3` | [mảnh 1](images/pshen_3ten_0--8da8920045.png), [mảnh 2](images/pshen_36_0--6acb214fd4.png), [mảnh 3](images/pshen_35_0--23007a2893.png), [mảnh 4](images/pshen_34_0--bda92f656d.png), [mảnh 5](images/pshen_33_0--cfef80558c.png), [mảnh 6](images/pshen_32_0--e7ce423b30.png), [mảnh 7](images/pshen_31_0--66ff2eddd8.png) |
| `ready3` | `psheno_3` | [mảnh 1](images/pshen_3ten_0--8da8920045.png), [mảnh 2](images/pshen_36_0--6acb214fd4.png), [mảnh 3](images/pshen_35_0--23007a2893.png), [mảnh 4](images/pshen_34_0--bda92f656d.png), [mảnh 5](images/pshen_33_0--cfef80558c.png), [mảnh 6](images/pshen_32_0--e7ce423b30.png), [mảnh 7](images/pshen_31_0--66ff2eddd8.png) |
| `ready4` | `psheno_3` | [mảnh 1](images/pshen_3ten_0--8da8920045.png), [mảnh 2](images/pshen_36_0--6acb214fd4.png), [mảnh 3](images/pshen_35_0--23007a2893.png), [mảnh 4](images/pshen_34_0--bda92f656d.png), [mảnh 5](images/pshen_33_0--cfef80558c.png), [mảnh 6](images/pshen_32_0--e7ce423b30.png), [mảnh 7](images/pshen_31_0--66ff2eddd8.png) |
| `ready5` | `psheno_3` | [mảnh 1](images/pshen_3ten_0--8da8920045.png), [mảnh 2](images/pshen_36_0--6acb214fd4.png), [mảnh 3](images/pshen_35_0--23007a2893.png), [mảnh 4](images/pshen_34_0--bda92f656d.png), [mảnh 5](images/pshen_33_0--cfef80558c.png), [mảnh 6](images/pshen_32_0--e7ce423b30.png), [mảnh 7](images/pshen_31_0--66ff2eddd8.png) |
| `ready1` | `psheno_3` | [mảnh 1](images/pshen_3ten_0--8da8920045.png), [mảnh 2](images/pshen_36_0--6acb214fd4.png), [mảnh 3](images/pshen_35_0--23007a2893.png), [mảnh 4](images/pshen_34_0--bda92f656d.png), [mảnh 5](images/pshen_33_0--cfef80558c.png), [mảnh 6](images/pshen_32_0--e7ce423b30.png), [mảnh 7](images/pshen_31_0--66ff2eddd8.png) |
| `harvest2` | `psheno_end` | [mảnh 1](images/meshok_z_0--c1848e62a1.png), [mảnh 2](images/4_ten_meshok_0--89cb7583a7.png), [mảnh 3](images/meshok_p_0--956db0cfd0.png), [mảnh 4](images/4_pshen_nutr_2_0--a74de476d9.png), [mảnh 5](images/4_pshen_nutr_1_0--1f0120acc4.png), [mảnh 6](images/4_pshen_2_0--677f932735.png), [mảnh 7](images/4_pshen_1_0--0091d7f093.png) |
| `harvest3` | `psheno_end` | [mảnh 1](images/meshok_z_0--c1848e62a1.png), [mảnh 2](images/4_ten_meshok_0--89cb7583a7.png), [mảnh 3](images/meshok_p_0--956db0cfd0.png), [mảnh 4](images/4_pshen_nutr_2_0--a74de476d9.png), [mảnh 5](images/4_pshen_nutr_1_0--1f0120acc4.png), [mảnh 6](images/4_pshen_2_0--677f932735.png), [mảnh 7](images/4_pshen_1_0--0091d7f093.png) |
| `harvest4` | `psheno_end` | [mảnh 1](images/meshok_z_0--c1848e62a1.png), [mảnh 2](images/4_ten_meshok_0--89cb7583a7.png), [mảnh 3](images/meshok_p_0--956db0cfd0.png), [mảnh 4](images/4_pshen_nutr_2_0--a74de476d9.png), [mảnh 5](images/4_pshen_nutr_1_0--1f0120acc4.png), [mảnh 6](images/4_pshen_2_0--677f932735.png), [mảnh 7](images/4_pshen_1_0--0091d7f093.png) |
| `harvest1` | `psheno_end` | [mảnh 1](images/meshok_z_0--c1848e62a1.png), [mảnh 2](images/4_ten_meshok_0--89cb7583a7.png), [mảnh 3](images/meshok_p_0--956db0cfd0.png), [mảnh 4](images/4_pshen_nutr_2_0--a74de476d9.png), [mảnh 5](images/4_pshen_nutr_1_0--1f0120acc4.png), [mảnh 6](images/4_pshen_2_0--677f932735.png), [mảnh 7](images/4_pshen_1_0--0091d7f093.png) |
| `harvest0` | `psheno_end` | [mảnh 1](images/meshok_z_0--c1848e62a1.png), [mảnh 2](images/4_ten_meshok_0--89cb7583a7.png), [mảnh 3](images/meshok_p_0--956db0cfd0.png), [mảnh 4](images/4_pshen_nutr_2_0--a74de476d9.png), [mảnh 5](images/4_pshen_nutr_1_0--1f0120acc4.png), [mảnh 6](images/4_pshen_2_0--677f932735.png), [mảnh 7](images/4_pshen_1_0--0091d7f093.png) |

**Công thức nguồn dùng sản phẩm này**

| Cơ sở | Sản phẩm làm ra | Cần mỗi mẻ | Điều kiện bundle nguồn |
| --- | --- | ---: | --- |
| Lò Pizza (`pizza_bakery`) | Pizza Pepperoni | 2 | Không có nhãn bundle |
| Lò Pizza (`pizza_bakery`) | Pizza Margherita | 2 | Không có nhãn bundle |
| Lò Pizza (`pizza_bakery`) | Pizza Hải Sản | 2 | Không có nhãn bundle |
| Lò Pizza (`pizza_bakery`) | Pizza Tráng Miệng | 2 | Không có nhãn bundle |
| Mũ (`hats_prod`) | Mũ Hoa Dại | 5 | Không có nhãn bundle |
| Mũ (`hats_prod`) | Mũ Biển | 3 | Không có nhãn bundle |
| Mũ (`hats_prod`) | Mũ Mùa Hè | 5 | Không có nhãn bundle |
| Mũ (`hats_prod`) | Mũ Dễ Thương | 3 | Không có nhãn bundle |
| Chảo Wok (`noodle_factory`) | Mì Heo | 3 | Không có nhãn bundle |
| Phụ Kiện (`accessories`) | Quạt Công | 2 | Không có nhãn bundle |
| Tiệm Bánh (`bakery`) | Bánh Mì | 3 | Không có nhãn bundle |
| Tiệm Bánh (`bakery`) | Bánh Quy Táo | 3 | halloween |
| Tiệm Bánh (`bakery`) | Bánh Kẹp Pancake | 4 | Không có nhãn bundle |
| Tiệm Bánh (`bakery`) | Bánh Quy | 3 | Không có nhãn bundle |
| Tiệm Bánh (`bakery`) | Bánh Sừng Bò (Croissant) | 1 | Không có nhãn bundle |
| Tiệm Bánh (`bakery`) | Bánh Tortilla | 2 | Không có nhãn bundle |
| Tiệm Bánh (`bakery`) | Bánh Quế (Waffle) | 3 | Không có nhãn bundle |
| Nhà Máy Giấy (`paper_factory`) | Giấy Vàng | 3 | Không có nhãn bundle |
| Cửa hàng Sushi (`sushi_bar`) | Mì Sợi | 3 | Không có nhãn bundle |
| Máy Chế Biến Thực Phẩm (`food_processor`) | Thức Ăn Chim | 2 | Không có nhãn bundle |
| Tiệm Bánh Pie (`pie_bakery`) | Bánh Táo | 2 | Không có nhãn bundle |
| Tiệm Bánh Pie (`pie_bakery`) | Bánh Bắp Cải | 2 | Không có nhãn bundle |
| Tiệm Bánh Pie (`pie_bakery`) | Bánh Thịt Nghiền (Shepherd's Pie) | 2 | Không có nhãn bundle |
| Tiệm Bánh Pie (`pie_bakery`) | Bánh Pie Lễ Hội | 3 | halloween |
| Tiệm Bánh Pie (`pie_bakery`) | Bánh Bí Ngô | 2 | Không có nhãn bundle |
| Tiệm Bánh Pie (`pie_bakery`) | Bánh Pie Việt Quất | 2 | Không có nhãn bundle |
| Tiệm Bánh Pie (`pie_bakery`) | Bánh Chanh | 2 | Không có nhãn bundle |
| Tiệm Bánh Kem (`cake_bakery`) | Bánh Kem | 1 | Không có nhãn bundle |
| Tiệm Bánh Kem (`cake_bakery`) | Bánh Cà Rốt | 1 | Không có nhãn bundle |
| Tiệm Bánh Kem (`cake_bakery`) | Bánh Phô Mai | 1 | Không có nhãn bundle |
| Tiệm Bánh Kem (`cake_bakery`) | Bánh Donut | 1 | Không có nhãn bundle |

**Trước khi đưa vào game**

Dựng prefab đúng pivot/tỉ lệ và thứ tự vẽ, kiểm tra các pose trên map; chốt giá/thời lượng/sản lượng Farm; nối catalog, kho, save và UI; thử gieo/thu/reload hoặc chu kỳ cây lâu năm. Giữ hình và ID giống hiện tại, dùng bộ nguồn này để đối chiếu.

Nguồn APK/hash, object ID, pivot, pixels-per-unit, clip và công thức được ghi trong `crop.json`. README và hồ sơ được tạo bởi `cocos/tools/prepare-crop-sources.py`.
