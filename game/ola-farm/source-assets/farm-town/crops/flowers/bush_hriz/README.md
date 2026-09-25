# Cúc Vàng — `bush_hriz`

[Danh mục](../../README.md) · [Bản xem ảnh](../../index.html) · [Hồ sơ JSON](crop.json)

**Thư mục nguồn không được runtime nạp trực tiếp.** Nhãn khảo sát gốc: C6 — hoa và chuỗi trang trí.

![Icon](icon.png)

| Thuộc tính | Dữ liệu nguồn |
| --- | --- |
| Nhóm | Bụi hoa |
| Sản phẩm | Cúc Vàng (`hrizantema`, source ID 89) |
| Thu mỗi đợt nguồn | 1 |
| Thời gian nguồn | 1200 giây |
| Cấp công thức / item nguồn | 17 / 17 |
| Chi phí mỗi lượt nguồn | Không có nguyên liệu mỗi lượt; mua cây qua cửa hàng là giao dịch riêng |
| `BasicPrice` / `ExpOnUse` nguồn | 32 / 5 — chưa khẳng định là giá bán/XP thu hoạch Farm |
| Tệp PNG riêng trong thư mục | 17 |
| Số lượt bắt đầu mọc nguồn | 5 |
| Dụng cụ dọn cây | 1 Dao Cắt |
| Drop bảo đảm khi dọn | 1 Dây Thừng |

Thời gian ở đây là **giây nguồn APK**, không phải giờ mô phỏng Farm. Cấp mở còn phụ thuộc công trình/shop/điều kiện. Với cây lâu năm, nhận hết đợt cuối mới chuyển sang cây cạn lượt; không mất quả khi số lượt bắt đầu mọc đã về 0.

**Ảnh theo role / giai đoạn nguồn**

Ảnh nằm trong `images/`, được dùng chung giữa các role khi nguồn trỏ cùng sprite. Một dòng có nhiều PNG là nhiều mảnh tham chiếu, không phải nhiều cây hoàn chỉnh. Chưa có thông tin ghép transform/hierarchy đầy đủ trong bộ ảnh này.

| Role nguồn | Clip | Các mảnh PNG |
| --- | --- | --- |
| Gán sẵn trong prefab | — | [ảnh 1](images/0_hriz_2_0--0dd32f113e.png), [ảnh 2](images/0_hriz_1_0--c776b3752f.png), [ảnh 3](images/1_hriz_0--e762f9ebe1.png), [ảnh 4](images/3_hriz_dop_2_0--96dfc11e2e.png), [ảnh 5](images/3_hriz_dop_0--6cf33f7a47.png) |
| `dead` | `chrysanthemums_end` | [mảnh 1](images/4_hriz_2--e054cfd54a.png) |
| `idle` | `chrysanthemums_1` | [mảnh 1](images/1_hriz_0--e762f9ebe1.png), [mảnh 2](images/3_hriz_dop_0--6cf33f7a47.png), [mảnh 3](images/3_hriz_dop_2_0--96dfc11e2e.png), [mảnh 4](images/0_hriz_1_0--c776b3752f.png) |
| `grow0` | `chrysanthemums_1` | [mảnh 1](images/1_hriz_0--e762f9ebe1.png), [mảnh 2](images/3_hriz_dop_0--6cf33f7a47.png), [mảnh 3](images/3_hriz_dop_2_0--96dfc11e2e.png), [mảnh 4](images/0_hriz_1_0--c776b3752f.png) |
| `grow1` | `chrysanthemums_2` | [mảnh 1](images/2_hriz_0--63b06fcb48.png) |
| `grow2` | `chrysanthemums_2` | [mảnh 1](images/2_hriz_0--63b06fcb48.png) |
| `grow3` | `chrysanthemums_2` | [mảnh 1](images/2_hriz_0--63b06fcb48.png) |
| `grow0` | `grow0` | Không có Sprite PPtr trong clip; xem ghi chú JSON |
| `ready2` | `chrysanthemums_3` | [mảnh 1](images/3_hriz_5_0--b46760f1ee.png), [mảnh 2](images/3_hriz_6_0--851dbfb8f8.png), [mảnh 3](images/3_hriz_3_0--a999a21f8f.png), [mảnh 4](images/3_hriz_1_0--d40377289f.png), [mảnh 5](images/3_hriz_2_0--9f36fc6483.png), [mảnh 6](images/3_hriz_4_0--346d2c49d7.png), [mảnh 7](images/3_hriz_7_0--e15a216d7d.png), [mảnh 8](images/3_hriz_8_0--d5b03d8c3d.png) |
| `ready3` | `chrysanthemums_3` | [mảnh 1](images/3_hriz_5_0--b46760f1ee.png), [mảnh 2](images/3_hriz_6_0--851dbfb8f8.png), [mảnh 3](images/3_hriz_3_0--a999a21f8f.png), [mảnh 4](images/3_hriz_1_0--d40377289f.png), [mảnh 5](images/3_hriz_2_0--9f36fc6483.png), [mảnh 6](images/3_hriz_4_0--346d2c49d7.png), [mảnh 7](images/3_hriz_7_0--e15a216d7d.png), [mảnh 8](images/3_hriz_8_0--d5b03d8c3d.png) |
| `ready4` | `chrysanthemums_3` | [mảnh 1](images/3_hriz_5_0--b46760f1ee.png), [mảnh 2](images/3_hriz_6_0--851dbfb8f8.png), [mảnh 3](images/3_hriz_3_0--a999a21f8f.png), [mảnh 4](images/3_hriz_1_0--d40377289f.png), [mảnh 5](images/3_hriz_2_0--9f36fc6483.png), [mảnh 6](images/3_hriz_4_0--346d2c49d7.png), [mảnh 7](images/3_hriz_7_0--e15a216d7d.png), [mảnh 8](images/3_hriz_8_0--d5b03d8c3d.png) |
| `ready5` | `chrysanthemums_3` | [mảnh 1](images/3_hriz_5_0--b46760f1ee.png), [mảnh 2](images/3_hriz_6_0--851dbfb8f8.png), [mảnh 3](images/3_hriz_3_0--a999a21f8f.png), [mảnh 4](images/3_hriz_1_0--d40377289f.png), [mảnh 5](images/3_hriz_2_0--9f36fc6483.png), [mảnh 6](images/3_hriz_4_0--346d2c49d7.png), [mảnh 7](images/3_hriz_7_0--e15a216d7d.png), [mảnh 8](images/3_hriz_8_0--d5b03d8c3d.png) |
| `ready1` | `chrysanthemums_3` | [mảnh 1](images/3_hriz_5_0--b46760f1ee.png), [mảnh 2](images/3_hriz_6_0--851dbfb8f8.png), [mảnh 3](images/3_hriz_3_0--a999a21f8f.png), [mảnh 4](images/3_hriz_1_0--d40377289f.png), [mảnh 5](images/3_hriz_2_0--9f36fc6483.png), [mảnh 6](images/3_hriz_4_0--346d2c49d7.png), [mảnh 7](images/3_hriz_7_0--e15a216d7d.png), [mảnh 8](images/3_hriz_8_0--d5b03d8c3d.png) |
| `harvest2` | `chrysanthemums_1` | [mảnh 1](images/1_hriz_0--e762f9ebe1.png), [mảnh 2](images/3_hriz_dop_0--6cf33f7a47.png), [mảnh 3](images/3_hriz_dop_2_0--96dfc11e2e.png), [mảnh 4](images/0_hriz_1_0--c776b3752f.png) |
| `harvest3` | `chrysanthemums_1` | [mảnh 1](images/1_hriz_0--e762f9ebe1.png), [mảnh 2](images/3_hriz_dop_0--6cf33f7a47.png), [mảnh 3](images/3_hriz_dop_2_0--96dfc11e2e.png), [mảnh 4](images/0_hriz_1_0--c776b3752f.png) |
| `harvest4` | `chrysanthemums_1` | [mảnh 1](images/1_hriz_0--e762f9ebe1.png), [mảnh 2](images/3_hriz_dop_0--6cf33f7a47.png), [mảnh 3](images/3_hriz_dop_2_0--96dfc11e2e.png), [mảnh 4](images/0_hriz_1_0--c776b3752f.png) |
| `harvest1` | `chrysanthemums_1` | [mảnh 1](images/1_hriz_0--e762f9ebe1.png), [mảnh 2](images/3_hriz_dop_0--6cf33f7a47.png), [mảnh 3](images/3_hriz_dop_2_0--96dfc11e2e.png), [mảnh 4](images/0_hriz_1_0--c776b3752f.png) |
| `harvest0` | `chrysanthemums_1` | [mảnh 1](images/1_hriz_0--e762f9ebe1.png), [mảnh 2](images/3_hriz_dop_0--6cf33f7a47.png), [mảnh 3](images/3_hriz_dop_2_0--96dfc11e2e.png), [mảnh 4](images/0_hriz_1_0--c776b3752f.png) |

**Công thức nguồn dùng sản phẩm này**

| Cơ sở | Sản phẩm làm ra | Cần mỗi mẻ | Điều kiện bundle nguồn |
| --- | --- | ---: | --- |
| Mũ (`hats_prod`) | Mũ Dễ Thương | 1 | Không có nhãn bundle |
| Nhà Máy Hoa (`flower_factory`) | Bó Hoa Lãng Mạn | 3 | Không có nhãn bundle |

**Trước khi đưa vào game**

Dựng prefab đúng pivot/tỉ lệ và thứ tự vẽ, kiểm tra các pose trên map; chốt giá/thời lượng/sản lượng Farm; nối catalog, kho, save và UI; thử gieo/thu/reload hoặc chu kỳ cây lâu năm. Không dùng source ID số làm ID Farm tự động.

Nguồn APK/hash, object ID, pivot, pixels-per-unit, clip và công thức được ghi trong `crop.json`. README và hồ sơ được tạo bởi `cocos/tools/prepare-crop-sources.py`.
