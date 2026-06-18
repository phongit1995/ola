---
name: docs-screens-apk
description: >
  Tài liệu hoá MỘT màn hình của app Ola từ APK đã decompile trong `older-ola/`
  (apktool res + jadx source) ra `older-ola/docs/screens/<slug>/README.md`: ảnh/asset,
  text, icon, cỡ chữ (font size), màu, vị trí từng component, style + CSS tương đương,
  và LOGIC HIỂN THỊ (component nào hiện/ẩn khi nào, điều kiện, luồng sự kiện). Dùng khi
  user nói "đọc/viết tài liệu màn hình từ apk", "document screen", "bóc tách UI/logic"
  một Activity/Fragment, hoặc trỏ tới folder older-ola.
---

# Bóc tách & tài liệu hoá màn hình từ APK (older-ola)

Mục tiêu: từ APK Ola **đã decompile** trong `older-ola/`, tạo tài liệu chi tiết cho **một màn hình** gồm: ảnh + asset, text, icon, cỡ chữ, màu, vị trí component, style (kèm CSS dựng lại), và **logic hiển thị** (khi nào hiện cái gì). Output bám đúng định dạng các màn đã có.

## Nguồn dữ liệu (đọc ở đâu)

| Cần gì | Lấy từ |
|--------|--------|
| Danh sách màn → Activity | `older-ola/docs/man-hinh-screens.md` |
| Logic (hiện/ẩn, click, luồng) | `older-ola/jadx_out/sources/chat/ola/vn/{activity,fragment,view,adapter}/*.java` |
| Activity → layout | trong file `.java`: `setContentView(R.layout.XXX)` hoặc `inflate(R.layout.XXX…)` |
| Cây component, id, vị trí, textSize, text/@string, @drawable, style, visibility | `older-ola/apktool_out/res/layout/XXX.xml` (và `layout-*/`) |
| Màu → hex | `older-ola/apktool_out/res/values/colors.xml` |
| Cỡ chữ / khoảng cách → dp/sp | `older-ola/apktool_out/res/values/dimens.xml` |
| Định nghĩa style (textSize/color kế thừa) | `older-ola/apktool_out/res/values/styles.xml` |
| Text (EN) | `older-ola/apktool_out/res/values/strings.xml` |
| Text (VI/locale khác) | `older-ola/apktool_out/res/values-vi*/strings.xml` nếu có; nếu không, lấy chữ VI thực tế từ ảnh chụp |
| Asset icon/ảnh (PNG/WebP gốc) | `older-ola/apktool_out/res/drawable*/`, `mipmap*/`, hoặc `older-ola/images/` |
| Ảnh chụp màn thật / fake server | `older-ola/fake-api/screenshots/`, `older-ola/apk-images/`, hoặc đã có sẵn trong `docs/screens/<slug>/images/` |

## Output (ghi vào đâu)

- **Tài liệu màn:** `older-ola/docs/screens/<slug>/README.md`
  - `<slug>` = tên kebab-case tiếng Việt không dấu theo chức năng (vd `dang-nhap`, `phong-chat`, `chat-hoi-thoai`). Theo đúng quy ước các màn đã có.
- **Asset dùng chung nhiều màn** (logo, icon clear…): `older-ola/docs/screens/images/` → tham chiếu `../images/<file>`.
- **Ảnh chụp riêng của màn:** `older-ola/docs/screens/<slug>/images/` → tham chiếu `images/<file>`.
- **Cập nhật index:** thêm link màn mới vào `older-ola/docs/screens/README.md`.

> Lưu ý: user có thể gọi nơi này là "older-ola-docs" — thực tế là `older-ola/docs/` (đã có sẵn 17 màn ở `older-ola/docs/screens/`). Luôn ghi vào đó để nhất quán, KHÔNG tạo folder song song mới. Nếu user thực sự muốn folder khác, hỏi lại.

**Mẫu chuẩn để bám theo 1:1:** đọc `older-ola/docs/screens/dang-nhap/README.md` trước khi viết — copy đúng cấu trúc, giọng văn, mức chi tiết.

## Quy trình

1. **Chọn màn & tìm Activity/layout**
   - Nếu user nêu tên màn → tra `docs/man-hinh-screens.md` ra class Activity.
   - Mở file Activity/Fragment trong `jadx_out/...` → tìm `setContentView(R.layout.XXX)` (hoặc `inflate`) → ra tên layout. Một màn có thể gồm nhiều layout con (include/`<merge>`, item list, dialog) — lần theo hết.

2. **Trích cây giao diện** từ `apktool_out/res/layout/XXX.xml`:
   - Liệt kê từng view theo thứ tự **trên → dưới**, kèm `android:id`, loại view.
   - **Vị trí/khoảng cách:** `layout_width/height`, `layout_margin*`, `padding*`, `gravity`/`layout_gravity`, ràng buộc Constraint/Relative, `orientation`.
   - **Text:** `android:text` → resolve `@string/...`. **Cỡ chữ:** `android:textSize` (số) hoặc qua `style`/`textAppearance` → resolve `@dimen/...`. **Màu:** `android:textColor`/`background` → resolve `@color/...` hoặc `@drawable/...`.
   - **Icon/ảnh:** `android:src`/`drawableLeft`/`background` → ghi tên `@drawable/...`.
   - **Hiển thị:** `android:visibility` (`gone`/`invisible`/`visible`) → đánh dấu component nào **ẩn mặc định**.

3. **Resolve giá trị thật** (KHÔNG để nguyên `@…`):
   - `@color/x` → hex trong `colors.xml` (ghi cả tên biến lẫn hex, vd `#7CB342` (`colorOlaPrimary`)).
   - `@dimen/x` → giá trị dp/sp trong `dimens.xml`.
   - `style="@style/x"`: mở `styles.xml`, đọc `x` **và parent** (kế thừa) để lấy `textSize/textColor/...` thật.
   - `@string/x` → text EN (`strings.xml`) + VI (`values-vi*` hoặc ảnh chụp).

4. **Trích LOGIC từ jadx** (phần user nhấn mạnh — "khi nào hiện cái nào"):
   - Với mỗi `id` ở layout, tìm trong file Java: `findViewById`/binding → biến.
   - Tìm `setVisibility(View.GONE/VISIBLE/INVISIBLE)` và **điều kiện bao quanh** (if/else, cờ, phản hồi server) → ghi rõ "X hiện khi <điều kiện>, ẩn khi <điều kiện>".
   - **Nút bấm → mở modal/dialog (CHI TIẾT):** với mỗi `setOnClickListener`/`onClick`, lần theo hành vi. Nếu nút **mở một modal/dialog/bottom-sheet/popup ngay trong màn này** (vd `new Dialog`, `AlertDialog.Builder`, `BottomSheetDialog`, `PopupMenu`, `show()` của `DialogFragment`, hoặc đặt một overlay `visibility=VISIBLE`), thì **mô tả CHI TIẾT modal đó**: tên modal/layout của nó, nội dung (text/nút bên trong), khi nào hiện, các nút trong modal làm gì. Ánh xạ rõ "Nút A → mở Modal X". Lặp lại tương tự cho mọi thành phần đóng/mở (đóng modal, toggle panel, menu…).
   - **Nút bấm → sang trang khác (KHÔNG cần chi tiết):** nếu nút `startActivity(...)`/điều hướng sang **một màn (Activity/Fragment) khác**, CHỈ ghi tên màn đích (vd "→ mở màn Trang cá nhân `ProfileActivity`") và link tới doc màn đó nếu có. KHÔNG mô tả lại nội dung màn đích — màn đó có tài liệu riêng.
   - Nguồn dữ liệu đổ vào màn (adapter, response, `h.O`/entity…), điều kiện enable/disable, state rỗng vs có dữ liệu.
   - Luồng mạng: REST (`api.ola.vn`) hay socket (svc …) — đối chiếu `docs/api/`.

5. **Ảnh & asset** ("lấy luôn các hình ảnh"):
   - Copy file asset gốc mà màn dùng (từ `apktool_out/res/drawable*` hoặc `older-ola/images/`) vào `docs/screens/images/` (dùng chung) hoặc `docs/screens/<slug>/images/`. Chọn mật độ phù hợp (xhdpi/xxhdpi) cho ảnh nét.
   - Tham chiếu ảnh bằng **đường dẫn tương đối** từ README của màn.
   - Ảnh chụp màn: nếu đã có trong `fake-api/screenshots`/`apk-images`/sẵn trong `images/` thì đưa vào bảng "Ảnh chụp" kèm chú thích trạng thái (vd "khi 2 ô trống → nút đổi chữ"). Nếu CHƯA có ảnh chụp, ghi rõ "chưa có ảnh chụp" thay vì bịa.

6. **Viết `README.md`** theo đúng 8 mục của mẫu (xem dưới), rồi **cập nhật index** `docs/screens/README.md`.

## Khung tài liệu (mirror `dang-nhap/README.md`)

```markdown
# Màn hình <Tên>

- **Activity:** `chat.ola.vn.activity.<Class>`
- **Layout:** `apktool_out/res/layout/<file>.xml`
- **Chức năng:** <1–2 câu>

## Ảnh chụp (nếu có)
<bảng ảnh + chú thích trạng thái hiển thị>

### Assets dùng trong màn (ảnh gốc trích từ APK)
<bảng: Asset | Ảnh | Dùng cho>

## 1. Bố cục (top → bottom)
<cây ASCII: view + kích thước/màu + ĐÁNH DẤU component ẩn/điều kiện hiện>

## 2. Bảng style chi tiết từng phần
| Thành phần | id | Màu chữ / nền | Cỡ chữ | Kích thước / khoảng cách | Ghi chú |

## 3. CSS tương đương (dựng lại trên web)
<block css + html mô phỏng>

## 4. Hành vi & luồng
<logic: component nào hiện/ẩn khi nào, REST/socket>
<bảng tương tác: | Nút/Thành phần | Hành vi | Loại |
  - mở modal trong màn → ghi CHI TIẾT modal (tên, nội dung, các nút trong modal)
  - sang màn khác → chỉ ghi tên màn đích (+ link doc nếu có), không chi tiết>

### Modal/Dialog trong màn (mô tả chi tiết từng cái)
<với mỗi modal mở từ màn này: tên + layout, mở khi nào, nội dung & các nút bên trong, mỗi nút làm gì>

## 5. Strings (đa ngôn ngữ)
| Resource | EN | VI |
```

## Quy tắc chất lượng (bắt buộc)

- **Không bịa số liệu.** Mọi cỡ chữ/màu/margin/text/điều kiện phải truy được ra file XML/values/jadx cụ thể. Resolve hết `@color`/`@dimen`/`@string`/`@style` về giá trị thật.
- **Nêu rõ điều kiện hiển thị** cho mọi view có `visibility=gone` hoặc bị `setVisibility(...)` trong code — đây là yêu cầu cốt lõi.
- **Modal mở trong màn = mô tả chi tiết; điều hướng sang màn khác = chỉ nêu tên màn đích.** Đừng tài liệu hoá lại nội dung của màn khác (nó có doc riêng).
- **Đường dẫn ảnh tương đối**, ảnh asset là file gốc trích từ APK (không screenshot thay thế).
- **Tiếng Việt**, giọng văn + cấu trúc giống các màn đã có.
- Ưu tiên đối chiếu với màn tương ứng bên web `web/src/pages/` nếu có (để doc phục vụ việc dựng lại UI).
- Khi không chắc một chi tiết (vd chữ VI chưa có trong locale), ghi nguồn/độ tin thay vì đoán.
