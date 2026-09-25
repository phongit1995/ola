# Bộ ảnh cây trồng Farm Town cho Farm

**Bộ ảnh và hồ sơ nguồn để tra cứu, giữ nguyên PNG đã xuất.** Bộ này nằm ngoài `cocos/assets/`, được theo dõi trong Git và không tự đi vào tài nguyên build Cocos.

[Xem toàn bộ ảnh](index.html) · [Danh mục JSON](catalog.json) · [Asset pipeline](../../../docs/cocos/asset-pipeline.md) · [Cơ chế trồng/nuôi](../../../docs/cocos/farm-town-husbandry-runtime.md)

Có **30 loại**: 14 cây ruộng, 10 cây/bụi quả, 6 bụi hoa; **430 tệp PNG** (2,760,518 byte). Một số hình dùng chung giữa nhiều loại, giữ bản sao trong từng thư mục để có thể chọn một loại độc lập.

Các nhãn `plannedBatch`, `newFieldCandidates` và `existingFarmFieldCrops` ghi lại phân nhóm lúc khảo sát, không phải kế hoạch hay danh sách giống hiện đang chơi. `runtimeEnabled: false` nghĩa là bộ nguồn này không tự được đóng gói. Runtime hiện có 8 giống trong `cocos/assets/farm/bundles/farm-town/catalog.json`; dùng luật chơi hiện hành ở liên kết phía trên. Bụi dâu nguồn không tự thay cây dâu trên ruộng.

```text
crops/
  catalog.json
  index.html
  field/<key>/
  orchard/<key>/
  flowers/<key>/
    icon.png       # icon giống/cây trong bảng chọn
    product.png    # icon sản phẩm nếu khác icon cây
    images/*.png   # mảnh hình trên map, giữ nguyên pixel
    crop.json      # phase, nguồn/hash/pivot, công thức và nơi tiêu thụ
    README.md      # chi tiết loại bằng tiếng Việt
```

Ảnh không phải prefab hoàn chỉnh. Không ghép mọi mảnh cùng lúc, không hiểu các role `ready1…ready5` thành năm cấp cây và không đổi đuôi clip Unity thành `.anim` Cocos. `crop.json` lưu cả role không có Sprite PPtr để tránh giấu các trạng thái cần xử lý tiếp.

**Cây ruộng**

| Loại / thư mục | Sản phẩm | Nhãn khảo sát gốc | PNG |
| --- | --- | --- | ---: |
| [Lúa Mì](field/wheat/README.md) — `wheat` | Lúa Mì | REF — đối chiếu, giữ art Farm hiện có | 17 |
| [Ngô](field/corn/README.md) — `corn` | Ngô | C1 — ngô và bắp cải | 16 |
| [Bắp Cải](field/cabbage/README.md) — `cabbage` | Bắp Cải | C1 — ngô và bắp cải | 17 |
| [Củ Cải Đường](field/beet/README.md) — `beet` | Củ Cải Đường | C2 — đường và thức ăn heo/cừu | 18 |
| [Cà Rốt](field/carrot/README.md) — `carrot` | Cà Rốt | C2 — đường và thức ăn heo/cừu | 13 |
| [Gạo](field/rice/README.md) — `rice` | Gạo | C5 — món ăn mở rộng | 16 |
| [Khoai Tây](field/potato/README.md) — `potato` | Khoai Tây | C2 — đường và thức ăn heo/cừu | 20 |
| [Bí Ngô](field/pumpkin/README.md) — `pumpkin` | Bí Ngô | C2 — đường và thức ăn heo/cừu | 23 |
| [Bông](field/cotton/README.md) — `cotton` | Bông | C3 — dệt may và đường mía | 17 |
| [Cây Lanh](field/flax/README.md) — `flax` | Cây Lanh | C3 — dệt may và đường mía | 10 |
| [Mía](field/cane/README.md) — `cane` | Mía | C3 — dệt may và đường mía | 24 |
| [Ớt](field/pepper/README.md) — `pepper` | Ớt | C5 — món ăn mở rộng | 25 |
| [Đậu](field/beans/README.md) — `beans` | Đậu | C5 — món ăn mở rộng | 18 |
| [Cà Chua](field/tomato/README.md) — `tomato` | Cà Chua | REF — đối chiếu, giữ art Farm hiện có | 17 |

**Cây / bụi ăn quả**

| Loại / thư mục | Sản phẩm | Nhãn khảo sát gốc | PNG |
| --- | --- | --- | ---: |
| [Cây Táo](orchard/apple_tree/README.md) — `apple_tree` | Táo | C4 — vườn táo đầu tiên | 9 |
| [Bụi Dâu Tây](orchard/strawberry_bush/README.md) — `strawberry_bush` | Dâu Tây | C5 — mở rộng vườn quả | 14 |
| [Cây Anh Đào](orchard/cherry_tree/README.md) — `cherry_tree` | Anh Đào | C5 — mở rộng vườn quả | 5 |
| [Cây Ca Cao](orchard/cacao_tree/README.md) — `cacao_tree` | Hạt Ca Cao | C5 — mở rộng vườn quả | 5 |
| [Bụi Mâm Xôi](orchard/raspberry_bush/README.md) — `raspberry_bush` | Mâm Xôi | C5 — mở rộng vườn quả | 5 |
| [Cây Cà Phê](orchard/coffee_tree/README.md) — `coffee_tree` | Hạt Cà Phê | C5 — mở rộng vườn quả | 5 |
| [Việt Quất](orchard/blueberry/README.md) — `blueberry` | Việt Quất | C5 — mở rộng vườn quả | 14 |
| [Cây Cam](orchard/orange_tree/README.md) — `orange_tree` | Cam | C5 — mở rộng vườn quả | 4 |
| [Cây Chanh](orchard/lemon_tree/README.md) — `lemon_tree` | Chanh | C5 — mở rộng vườn quả | 5 |
| [Quả Lê](orchard/pear_tree/README.md) — `pear_tree` | Quả Lê | C5 — mở rộng vườn quả | 10 |

**Bụi hoa**

| Loại / thư mục | Sản phẩm | Nhãn khảo sát gốc | PNG |
| --- | --- | --- | ---: |
| [Tử Đinh Hương](flowers/bush_lilac/README.md) — `bush_lilac` | Tử Đinh Hương | C6 — hoa và chuỗi trang trí | 20 |
| [Hoa Tulip](flowers/bush_tulip/README.md) — `bush_tulip` | Hoa Tulip | C6 — hoa và chuỗi trang trí | 16 |
| [Hoa Hồng](flowers/bush_roses/README.md) — `bush_roses` | Hoa Hồng | C6 — hoa và chuỗi trang trí | 18 |
| [Cúc Vàng](flowers/bush_hriz/README.md) — `bush_hriz` | Cúc Vàng | C6 — hoa và chuỗi trang trí | 17 |
| [Hoa Ly](flowers/bush_lily/README.md) — `bush_lily` | Hoa Ly | C6 — hoa và chuỗi trang trí | 14 |
| [Hoa Diên Vĩ](flowers/bush_iris/README.md) — `bush_iris` | Hoa Diên Vĩ | C6 — hoa và chuỗi trang trí | 18 |

**Kiểm tra và tạo lại**

```sh
python3 cocos/tools/prepare-crop-sources.py --check
```

Lệnh kiểm tra dùng Python chuẩn, không cần APK, Pillow, UnityPy, Cocos Editor hay thư mục `artifacts/`. Kiểm tra checksum/kích thước PNG, manifest, ảnh của từng phase và đường dẫn tài liệu.

Tạo lại bộ ảnh từ khảo sát tại máy này:

```sh
python3 cocos/tools/prepare-crop-sources.py --source artifacts/farm-town
```

Lệnh tạo yêu cầu các báo cáo `agriculture-audit.json`, `catalog.json`, `localization-vi.json`, `agriculture-source-checks.json`, manifest/sprite/clip đã xuất. Chạy lại không đổi byte; nếu file đích đã sửa khác nội dung sinh ra, lệnh dừng trước khi ghi để giữ chỉnh sửa đó.

Các giá, thời lượng, cấp và XP trong hồ sơ là số liệu **APK mod 5.16 nguồn**. Bảng cân bằng Farm nằm trong tài liệu runtime hiện hành. Nguồn: SHA-256 `4233a96b74efe5ec1b73b91e5846f5c0309b7b96c402851abf23ddad438ece5b`.

Khi một loại đã dựng và kiểm tra xong, đưa đúng tập phụ thuộc cần dùng vào `cocos/assets/farm/bundles/…`, tạo/giữ `.meta` bằng pipeline Cocos và cập nhật manifest runtime. Bộ ảnh này không tự sửa map, catalog, save hoặc `package.json`.
