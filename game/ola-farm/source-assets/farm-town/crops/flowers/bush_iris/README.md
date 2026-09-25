# Hoa Diên Vĩ — `bush_iris`

[Danh mục](../../README.md) · [Bản xem ảnh](../../index.html) · [Hồ sơ JSON](crop.json)

**Thư mục nguồn không được runtime nạp trực tiếp.** Nhãn khảo sát gốc: C6 — hoa và chuỗi trang trí.

![Icon](icon.png)

| Thuộc tính | Dữ liệu nguồn |
| --- | --- |
| Nhóm | Bụi hoa |
| Sản phẩm | Hoa Diên Vĩ (`iris`, source ID 94) |
| Thu mỗi đợt nguồn | 1 |
| Thời gian nguồn | 2700 giây |
| Cấp công thức / item nguồn | 20 / 20 |
| Chi phí mỗi lượt nguồn | Không có nguyên liệu mỗi lượt; mua cây qua cửa hàng là giao dịch riêng |
| `BasicPrice` / `ExpOnUse` nguồn | 36 / 6 — chưa khẳng định là giá bán/XP thu hoạch Farm |
| Tệp PNG riêng trong thư mục | 18 |
| Số lượt bắt đầu mọc nguồn | 5 |
| Dụng cụ dọn cây | 1 Dao Cắt |
| Drop bảo đảm khi dọn | 1 Dây Thừng |

Thời gian ở đây là **giây nguồn APK**, không phải giờ mô phỏng Farm. Cấp mở còn phụ thuộc công trình/shop/điều kiện. Với cây lâu năm, nhận hết đợt cuối mới chuyển sang cây cạn lượt; không mất quả khi số lượt bắt đầu mọc đã về 0.

**Ảnh theo role / giai đoạn nguồn**

Ảnh nằm trong `images/`, được dùng chung giữa các role khi nguồn trỏ cùng sprite. Một dòng có nhiều PNG là nhiều mảnh tham chiếu, không phải nhiều cây hoàn chỉnh. Chưa có thông tin ghép transform/hierarchy đầy đủ trong bộ ảnh này.

| Role nguồn | Clip | Các mảnh PNG |
| --- | --- | --- |
| Gán sẵn trong prefab | — | [ảnh 1](images/0_iris_zem_1_0--0b4e6fb4e6.png), [ảnh 2](images/0_iris_2_0--487e3aa464.png), [ảnh 3](images/0_iris_1_0--0568f2c446.png), [ảnh 4](images/1_iris_3--cf16641b52.png), [ảnh 5](images/0_iris_zem_2_0--52449dff05.png) |
| `dead` | `irises_end` | [mảnh 1](images/4_iris_zem_0--999329fa21.png), [mảnh 2](images/4_iris_0--8c4a2f35c3.png) |
| `idle` | `irises_1` | [mảnh 1](images/1_iris_3--cf16641b52.png), [mảnh 2](images/0_iris_1_0--0568f2c446.png) |
| `grow0` | `irises_1` | [mảnh 1](images/1_iris_3--cf16641b52.png), [mảnh 2](images/0_iris_1_0--0568f2c446.png) |
| `grow1` | `irises_2` | [mảnh 1](images/2_iris_1--6d8e70216a.png) |
| `grow2` | `irises_2` | [mảnh 1](images/2_iris_1--6d8e70216a.png) |
| `grow3` | `irises_2` | [mảnh 1](images/2_iris_1--6d8e70216a.png) |
| `grow0` | `grow0` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `ready2` | `irises_3` | [mảnh 1](images/3_iris_8_0--9e828475c7.png), [mảnh 2](images/3_iris_7_0--63ebbf89cb.png), [mảnh 3](images/3_iris_6_0--61d06db333.png), [mảnh 4](images/3_iris_5_0--a69ad42b39.png), [mảnh 5](images/3_iris_4_0--24c92fe295.png), [mảnh 6](images/3_iris_3_0--d945202d9d.png), [mảnh 7](images/3_iris_2_0--68e1bd5ab1.png), [mảnh 8](images/3_iris_1_0--488c9a2dba.png) |
| `ready3` | `irises_3` | [mảnh 1](images/3_iris_8_0--9e828475c7.png), [mảnh 2](images/3_iris_7_0--63ebbf89cb.png), [mảnh 3](images/3_iris_6_0--61d06db333.png), [mảnh 4](images/3_iris_5_0--a69ad42b39.png), [mảnh 5](images/3_iris_4_0--24c92fe295.png), [mảnh 6](images/3_iris_3_0--d945202d9d.png), [mảnh 7](images/3_iris_2_0--68e1bd5ab1.png), [mảnh 8](images/3_iris_1_0--488c9a2dba.png) |
| `ready4` | `irises_3` | [mảnh 1](images/3_iris_8_0--9e828475c7.png), [mảnh 2](images/3_iris_7_0--63ebbf89cb.png), [mảnh 3](images/3_iris_6_0--61d06db333.png), [mảnh 4](images/3_iris_5_0--a69ad42b39.png), [mảnh 5](images/3_iris_4_0--24c92fe295.png), [mảnh 6](images/3_iris_3_0--d945202d9d.png), [mảnh 7](images/3_iris_2_0--68e1bd5ab1.png), [mảnh 8](images/3_iris_1_0--488c9a2dba.png) |
| `ready5` | `irises_3` | [mảnh 1](images/3_iris_8_0--9e828475c7.png), [mảnh 2](images/3_iris_7_0--63ebbf89cb.png), [mảnh 3](images/3_iris_6_0--61d06db333.png), [mảnh 4](images/3_iris_5_0--a69ad42b39.png), [mảnh 5](images/3_iris_4_0--24c92fe295.png), [mảnh 6](images/3_iris_3_0--d945202d9d.png), [mảnh 7](images/3_iris_2_0--68e1bd5ab1.png), [mảnh 8](images/3_iris_1_0--488c9a2dba.png) |
| `ready1` | `irises_3` | [mảnh 1](images/3_iris_8_0--9e828475c7.png), [mảnh 2](images/3_iris_7_0--63ebbf89cb.png), [mảnh 3](images/3_iris_6_0--61d06db333.png), [mảnh 4](images/3_iris_5_0--a69ad42b39.png), [mảnh 5](images/3_iris_4_0--24c92fe295.png), [mảnh 6](images/3_iris_3_0--d945202d9d.png), [mảnh 7](images/3_iris_2_0--68e1bd5ab1.png), [mảnh 8](images/3_iris_1_0--488c9a2dba.png) |
| `harvest2` | `irises_1` | [mảnh 1](images/1_iris_3--cf16641b52.png), [mảnh 2](images/0_iris_1_0--0568f2c446.png) |
| `harvest3` | `irises_1` | [mảnh 1](images/1_iris_3--cf16641b52.png), [mảnh 2](images/0_iris_1_0--0568f2c446.png) |
| `harvest4` | `irises_1` | [mảnh 1](images/1_iris_3--cf16641b52.png), [mảnh 2](images/0_iris_1_0--0568f2c446.png) |
| `harvest1` | `irises_1` | [mảnh 1](images/1_iris_3--cf16641b52.png), [mảnh 2](images/0_iris_1_0--0568f2c446.png) |
| `harvest0` | `irises_1` | [mảnh 1](images/1_iris_3--cf16641b52.png), [mảnh 2](images/0_iris_1_0--0568f2c446.png) |

**Công thức nguồn dùng sản phẩm này**

| Cơ sở | Sản phẩm làm ra | Cần mỗi mẻ | Điều kiện bundle nguồn |
| --- | --- | ---: | --- |
| Nhà Máy Sơn (`paint_factory`) | Sơn Hồng | 1 | Không có nhãn bundle |
| Mũ (`hats_prod`) | Mũ Biển | 2 | Không có nhãn bundle |
| Mũ (`hats_prod`) | Mũ Dễ Thương | 2 | Không có nhãn bundle |
| Nhà Máy Hoa (`flower_factory`) | Bó Hoa Paris Đêm | 1 | Không có nhãn bundle |

**Trước khi đưa vào game**

Dựng prefab đúng pivot/tỉ lệ và thứ tự vẽ, kiểm tra các pose trên map; chốt giá/thời lượng/sản lượng Farm; nối catalog, kho, save và UI; thử gieo/thu/reload hoặc chu kỳ cây lâu năm. Không dùng source ID số làm ID Farm tự động.

Nguồn APK/hash, object ID, pivot, pixels-per-unit, clip và công thức được ghi trong `crop.json`. README và hồ sơ được tạo bởi `cocos/tools/prepare-crop-sources.py`.
