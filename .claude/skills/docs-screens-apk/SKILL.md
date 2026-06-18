---
name: docs-screens-apk
description: >
  Tài liệu hoá màn hình app Ola từ APK đã decompile trong `older-ola/` (apktool res + jadx
  source) — làm MỘT màn, một NHÓM màn, hoặc TẤT CẢ màn — ra `older-ola/docs/screens/<slug>/README.md`:
  ảnh/asset, text, icon, cỡ chữ (font size), màu, vị trí từng component, style + CSS tương đương,
  và LOGIC HIỂN THỊ (component nào hiện/ẩn khi nào, view type của list, mọi cử chỉ, modal/menu).
  Dùng khi user nói "đọc/viết tài liệu màn hình từ apk", "document screen(s)", "bóc tách UI/logic",
  "làm hết / tất cả các màn", hoặc trỏ tới folder older-ola.
---

# Bóc tách & tài liệu hoá màn hình từ APK (older-ola)

Mục tiêu: từ APK Ola **đã decompile** trong `older-ola/`, tạo tài liệu chi tiết cho **một hoặc nhiều màn hình** gồm: ảnh + asset, text, icon, cỡ chữ, màu, vị trí component, style (kèm CSS dựng lại), và **logic hiển thị** (khi nào hiện cái gì). Output bám đúng định dạng các màn đã có.

> Đây là quy trình **chung, áp cho từng màn**. Khác nhau chỉ ở **phạm vi**: 1 màn, vài màn, hay quét toàn bộ. Mỗi màn = một file README riêng và phải đi qua **đủ** pipeline + checklist; KHÔNG gộp nhiều màn vào một file.

## Phạm vi — làm 1 màn, nhiều màn, hay TẤT CẢ

Xác định phạm vi NGAY đầu, trước khi bóc tách:

- **1 màn:** user nêu tên màn / Activity cụ thể → làm đúng màn đó.
- **Nhóm màn:** user liệt kê vài màn hoặc 1 cụm chức năng (vd "cụm chat", "các màn cài đặt") → làm lần lượt từng màn trong nhóm.
- **Tất cả / "làm hết":** lấy danh sách đầy đủ rồi quét.

**Cách lập danh sách & tránh làm trùng:**
1. Đọc `older-ola/docs/man-hinh-screens.md` → bảng **màn → Activity** (nguồn liệt kê chuẩn).
2. Đọc `older-ola/docs/screens/README.md` (index) → biết màn nào **ĐÃ có** doc, màn nào **CHƯA**.
3. Phạm vi "tất cả" mặc định = các màn **chưa có doc** (hoặc doc còn sơ sài). Chỉ viết lại màn đã có nếu user yêu cầu rõ ("rà lại / sửa màn X").
4. Trình bày cho user danh sách dự kiến (đã có / sẽ làm) trước khi chạy hàng loạt, để chốt thứ tự ưu tiên.

**Khi làm nhiều/tất cả màn:**
- Xử lý **tuần tự từng màn**; mỗi màn chạy ĐỦ pipeline (mục 1→6) + **chốt checklist** rồi mới sang màn kế.
- Có thể **fan-out mỗi màn một sub-agent** (Explore/general-purpose) để chạy song song khi số màn lớn — nhưng mỗi sub-agent vẫn phải tuân đúng skill này (đủ bước + checklist) và trả về theo khung template. Tự mình kiểm lại checklist cho từng output trước khi coi là xong.
- **Cập nhật index ngay sau mỗi màn** (đừng dồn cuối). Với phạm vi lớn, duy trì một bảng tiến độ (màn | slug | trạng thái) trong phần trả lời để user theo dõi.
- Nếu hết lượt mà còn màn chưa làm → nói rõ còn những màn nào, KHÔNG ngầm coi là đã xong hết.

## Nguồn dữ liệu (đọc ở đâu)

| Cần gì | Lấy từ |
|--------|--------|
| Danh sách màn → Activity | `older-ola/docs/man-hinh-screens.md` |
| Màn nào đã có doc / chưa | `older-ola/docs/screens/README.md` (index) + thư mục `older-ola/docs/screens/` |
| Logic (hiện/ẩn, click, luồng) | `older-ola/jadx_out/sources/chat/ola/vn/{activity,fragment,view,adapter}/*.java` (chú ý: code đã obfuscate — class/method 1 chữ cái như `g.k`, `m.n`, `h.t`; lần theo kiểu trả về & layout inflate để định danh) |
| Activity → layout | trong file `.java`: `setContentView(R.layout.XXX)` hoặc `inflate(R.layout.XXX…)` |
| **Adapter dạng list** (mọi loại dòng, view type, thứ tự, section) | class adapter (`BaseAdapter`/`RecyclerView.Adapter`/`ArrayAdapter`): `getViewTypeCount()`, `getItemViewType()`, `getView()`/`onCreateViewHolder`, và **hàm dựng mảng dữ liệu** (vd build/refresh list — nơi `add(...)` từng row-builder, header, dòng đặc biệt theo điều kiện) |
| **Row-builder / ViewHolder** (view nào hiện/ẩn theo cờ) | class builder (inflate layout của 1 loại dòng) + class holder: từng `findViewById`, `setVisibility`, và **các cờ boolean** mà builder set lên holder (vd `k`/`l`) quyết định ẩn/hiện |
| **Cử chỉ** (mọi loại chạm) | `OnItemClickListener`, **`OnItemLongClickListener`**, `onClick`, `onTouch`, `OnEditorActionListener`, `OnFocusChangeListener` trong Fragment/Activity; **và delegate trong builder** (vd `a()`=long-press, `b()`=click của từng row-builder) |
| Cây component, id, vị trí, textSize, text/@string, @drawable, style, visibility | `older-ola/apktool_out/res/layout/XXX.xml` (và `layout-*/`) |
| Màu → hex | `older-ola/apktool_out/res/values/colors.xml` |
| Cỡ chữ / khoảng cách → dp/sp | `older-ola/apktool_out/res/values/dimens.xml` |
| Định nghĩa style (textSize/color kế thừa) | `older-ola/apktool_out/res/values/styles.xml` |
| Text (EN) | `older-ola/apktool_out/res/values/strings.xml` |
| Text (VI/locale khác) | `older-ola/apktool_out/res/values-vi*/strings.xml` nếu có; nếu không, lấy chữ VI thực tế từ ảnh chụp |
| Asset icon/ảnh (PNG/WebP gốc) | `older-ola/apktool_out/res/drawable*/`, `mipmap*/`, hoặc `older-ola/images/` |
| Ảnh chụp màn thật / fake server | `older-ola/fake-api/screenshots/`, `older-ola/apk-images/`, hoặc đã có sẵn trong `docs/screens/<slug>/images/` |

## Output (ghi vào đâu)

- **Tài liệu màn:** `older-ola/docs/screens/<slug>/README.md` — **mỗi màn một file riêng**.
  - `<slug>` = tên kebab-case tiếng Việt không dấu theo chức năng (vd `dang-nhap`, `phong-chat`, `chat-hoi-thoai`). Theo đúng quy ước các màn đã có.
- **Asset dùng chung nhiều màn** (logo, icon clear…): `older-ola/docs/screens/images/` → tham chiếu `../images/<file>`.
- **Ảnh chụp riêng của màn:** `older-ola/docs/screens/<slug>/images/` → tham chiếu `images/<file>`.
- **Cập nhật index:** thêm link mỗi màn mới vào `older-ola/docs/screens/README.md` (làm ngay sau khi viết xong màn đó).

> Lưu ý: user có thể gọi nơi này là "older-ola-docs" — thực tế là `older-ola/docs/` (đã có sẵn nhiều màn ở `older-ola/docs/screens/`). Luôn ghi vào đó để nhất quán, KHÔNG tạo folder song song mới. Nếu user thực sự muốn folder khác, hỏi lại.

**Mẫu chuẩn để bám theo 1:1:** đọc `older-ola/docs/screens/dang-nhap/README.md` trước khi viết — copy đúng cấu trúc, giọng văn, mức chi tiết. (Màn dạng list: tham khảo thêm `older-ola/docs/screens/chat/danh-ba.md`.)

## Quy trình (chạy cho TỪNG màn trong phạm vi)

0. **Xác định phạm vi** (xem mục "Phạm vi" trên): chốt sẽ làm những màn nào, theo thứ tự nào, loại bỏ màn đã có doc tốt. Phạm vi nhiều màn → lặp các bước 1→6 cho từng màn.

1. **Chọn màn & tìm Activity/layout**
   - Tra `docs/man-hinh-screens.md` ra class Activity của màn.
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
   - **Mỗi khi gặp 1 màn đích MỚI (chưa có doc), NOTE NGAY xuống mục "6. Màn mở ra từ đây" ở cuối README** (ghi "(chưa có doc — cần làm)"). Đây là cách tự sinh **hàng đợi** màn cần làm tiếp: khi quét "tất cả màn", gom các note này lại để biết còn thiếu màn nào.
   - **Quét HẾT cử chỉ — không chỉ click thường.** Với MỖI thành phần (và mỗi loại dòng list), kiểm tra đủ: `onClick`, **long-press** (`OnItemLongClickListener`/`setOnLongClickListener`), `onItemClick`, `onTouch`, `OnEditorActionListener` (Enter ở ô nhập/search), `OnFocusChangeListener`, swipe. **Long-press trên dòng list gần như luôn mở menu ngữ cảnh** (Xem/Đổi tên/Xoá/Chặn…) — đây là chỗ HAY BỊ SÓT nhất. Nếu là adapter, cử chỉ thường uỷ quyền cho method trong row-builder (vd `a(ctx,view,i,j)`=long-press, `b(...)`=click) → **phải mở từng method đó**, không dừng ở Fragment.
   - **Mỗi view bên trong dòng cũng có thể có click riêng:** trong ViewHolder, các `imgX.setOnClickListener(...)` (avatar, thumbnail, icon…) → liệt kê từng cái và đích của nó.
   - Nguồn dữ liệu đổ vào màn (adapter, response, `h.O`/entity…), điều kiện enable/disable, state rỗng vs có dữ liệu.
   - Luồng mạng: REST (`api.ola.vn`) hay socket (svc …) — đối chiếu `docs/api/`.

4b. **Màn dạng DANH SÁCH (ListView/RecyclerView/adapter) — BẮT BUỘC bóc kỹ** (chỗ dễ sót nhất: list không phải lúc nào cũng phẳng, một list có thể gồm nhiều loại dòng + header + dòng đặc biệt):
   - **Đếm đủ loại dòng:** đọc `getViewTypeCount()` và `getItemViewType()`. Liệt kê **TỪNG view type** → row-builder/holder nào, layout nào. Nếu có N type mà bạn mới mô tả được vài cái → **CHƯA xong**. (Cảnh báo: `getViewTypeCount()` có thể > số type màn này thực dùng — xem mục adapter dùng chung dưới.)
   - **Đọc hàm dựng mảng dữ liệu** (nơi adapter `add(...)` từng phần tử — vd một method `build/refresh` chạy mỗi lần data đổi). Từ đó rút ra:
     - **Thứ tự** các dòng từ trên xuống (panel → dòng cố định → các section…).
     - **Section/header**: nhiều list chia nhóm có **dòng tiêu đề** (vd "ONLINE"/"BẠN BÈ"/"SINH NHẬT") là 1 view type riêng — phải tìm và resolve string của chúng.
     - **Dòng cố định vs dòng theo data**: cái nào LUÔN có, cái nào CHỈ hiện khi list con ≠ rỗng / cờ bật (ghi rõ điều kiện).
     - **Cờ đầu/cuối section** (first/last) ảnh hưởng bo góc/divider.
   - **Mỗi row-builder + ViewHolder:** liệt kê tất cả `findViewById` trong holder, và với mỗi view ghi **điều kiện hiện/ẩn** từ code holder (`setVisibility`). Đặc biệt chú ý **các cờ boolean builder set lên holder** (vd `holder.k=true; holder.l=false;`) — một view có trong layout XML vẫn có thể bị holder **ẩn vĩnh viễn** theo cờ. Đừng kết luận "view hiện" chỉ vì nó có trong XML.
   - **Adapter/model DÙNG CHUNG nhiều màn** (rất hay gặp ở app này, vd `message.g`/`h.t`): một class vừa là model vừa là adapter, phục vụ nhiều màn qua **nhiều list khác nhau** (vd list `n` cho màn A, list `k` cho màn B). PHẢI xác định **màn này render list/mảng NÀO** (xem `setAdapter(...)` + hàm dựng mảng) và **chỉ** mô tả dòng thuộc list đó. KHÔNG gán nhầm dòng của màn khác (vd quảng cáo/bot của list hội thoại) vào màn này.
   - **Nguồn của từng section/list con:** ghi list con được nạp từ đâu (DB `h.b.x()`, response server, cache…) để biết khi nào section xuất hiện.

5. **Ảnh & asset** ("lấy luôn các hình ảnh"):
   - Copy file asset gốc mà màn dùng (từ `apktool_out/res/drawable*` hoặc `older-ola/images/`) vào `docs/screens/images/` (dùng chung) hoặc `docs/screens/<slug>/images/`. Chọn mật độ phù hợp (xhdpi/xxhdpi) cho ảnh nét.
   - Tham chiếu ảnh bằng **đường dẫn tương đối** từ README của màn.
   - Ảnh chụp màn: nếu đã có trong `fake-api/screenshots`/`apk-images`/sẵn trong `images/` thì đưa vào bảng "Ảnh chụp" kèm chú thích trạng thái (vd "khi 2 ô trống → nút đổi chữ"). Nếu CHƯA có ảnh chụp, ghi rõ "chưa có ảnh chụp" thay vì bịa.

6. **Viết `README.md`** theo đúng các mục của mẫu (xem dưới), **cập nhật index** `docs/screens/README.md`, rồi **chốt checklist** trước khi sang màn kế.

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
<NẾU là list: cây phải phản ánh THỨ TỰ dựng thật (panel → dòng cố định → từng section có header), không vẽ list phẳng>

### Các loại dòng & view type
<CHỈ thêm mục này khi màn là DANH SÁCH (ListView/RecyclerView/adapter); BỎ HẲN mục này nếu màn không phải list>
| View type | Builder/Holder | Layout | Vai trò | Hiện khi |
<liệt kê HẾT view type; ghi rõ type nào LUÔN có / type nào theo điều kiện; nếu adapter dùng chung, ghi rõ màn này chỉ dùng những type nào>

## 2. Bảng style chi tiết từng phần
| Thành phần | id | Màu chữ / nền | Cỡ chữ | Kích thước / khoảng cách | Ghi chú (điều kiện ẩn/hiện theo holder + cờ) |

## 3. CSS tương đương (dựng lại trên web)
<block css + html mô phỏng>

## 4. Hành vi & luồng
<logic: component nào hiện/ẩn khi nào, REST/socket>
<bảng tương tác — phải có cột "Cử chỉ" để không sót long-press:
  | Thành phần | Cử chỉ (click / long-press / swipe / enter…) | Hành vi | Loại |
  - mở modal trong màn → ghi CHI TIẾT modal (tên, nội dung, các nút trong modal)
  - sang màn khác → chỉ ghi tên màn đích (+ link doc nếu có), không chi tiết>

### Modal/Dialog/Menu trong màn (mô tả chi tiết từng cái)
<với mỗi modal/popup/menu ngữ cảnh mở từ màn này (gồm cả menu long-press): tên + layout, mở khi nào, từng mục/nút bên trong + mỗi cái làm gì>

## 5. Strings (đa ngôn ngữ)
| Resource | EN | VI |

## 6. Màn mở ra từ đây (điều hướng)
<liệt kê MỌI màn (Activity/Fragment) mà màn này điều hướng tới — để làm "hàng đợi" tài liệu hoá:
  | Từ (nút/cử chỉ) | Màn đích (class) | Doc |
  - đã có doc → link `../<slug>/README.md`
  - CHƯA có doc → ghi "(chưa có doc — cần làm)" để lần sau biết còn thiếu màn nào>
```

## Quy tắc chất lượng (bắt buộc)

- **Không bịa số liệu.** Mọi cỡ chữ/màu/margin/text/điều kiện phải truy được ra file XML/values/jadx cụ thể. Resolve hết `@color`/`@dimen`/`@string`/`@style` về giá trị thật.
- **Nêu rõ điều kiện hiển thị** cho mọi view có `visibility=gone` hoặc bị `setVisibility(...)` trong code — đây là yêu cầu cốt lõi.
- **Modal mở trong màn = mô tả chi tiết; điều hướng sang màn khác = chỉ nêu tên màn đích.** Đừng tài liệu hoá lại nội dung của màn khác (nó có doc riêng).
- **Đường dẫn ảnh tương đối**, ảnh asset là file gốc trích từ APK (không screenshot thay thế).
- **Tiếng Việt**, giọng văn + cấu trúc giống các màn đã có.
- Ưu tiên đối chiếu với màn tương ứng bên web `web/src/pages/` nếu có (để doc phục vụ việc dựng lại UI).
- Khi không chắc một chi tiết (vd chữ VI chưa có trong locale), ghi nguồn/độ tin thay vì đoán.
- **Đếm đủ, không bỏ giữa chừng.** Nếu adapter khai báo N view type, hoặc 1 view có nhiều nhánh `setVisibility`, hoặc 1 dòng có nhiều cử chỉ → phải bóc HẾT, không dừng ở cái đầu tiên thấy được.
- **Không suy từ XML ra hành vi.** Một view có trong layout KHÔNG đồng nghĩa nó hiển thị: holder có thể ẩn theo cờ. Luôn đối chiếu code holder/adapter trước khi khẳng định "hiện".
- **Adapter dùng chung → chỉ tính phần của màn này.** Trước khi gán 1 loại dòng cho màn, xác nhận nó nằm trong list/mảng mà màn này thực sự render.
- **Long-press & cử chỉ phụ là hạng mục bắt buộc**, không phải tuỳ chọn — kiểm cho cả thành phần tĩnh lẫn từng loại dòng list.
- **Mỗi màn một file + cập nhật index.** Làm nhiều màn thì lặp đủ quy trình cho từng màn; không gộp, không bỏ qua index; báo rõ màn nào còn thiếu nếu chưa làm hết.

## Checklist tự kiểm trước khi báo "xong" (cho TỪNG màn)

Chạy hết checklist này cho mỗi màn; nếu còn ô chưa tick → màn đó CHƯA hoàn chỉnh:

- [ ] Đã liệt kê **mọi layout con** màn dùng (include/merge/item/dialog/popup), không chỉ layout gốc.
- [ ] **Mọi `@color/@dimen/@string/@style`** đã resolve ra giá trị thật (hex/dp/sp/text), kèm cả EN lẫn VI.
- [ ] **Mọi view có `visibility` hoặc bị `setVisibility(...)`** đã ghi điều kiện hiện/ẩn.
- [ ] (List) Đã khớp **đủ số view type** của `getViewTypeCount()`; mỗi type có builder/holder/layout/vai trò; đã nêu type nào không thuộc màn này (adapter dùng chung).
- [ ] (List) Đã đọc **hàm dựng mảng** → ghi đúng thứ tự, các **section + header**, dòng cố định vs theo điều kiện.
- [ ] (List) Mỗi **ViewHolder**: mọi view + điều kiện ẩn/hiện + **cờ boolean** builder set đã được mô tả.
- [ ] Đã quét **mọi cử chỉ**: click, **long-press**, onItemClick, onTouch, Enter ô nhập, focus, swipe — cho cả thành phần tĩnh lẫn từng loại dòng; gồm click của từng view con trong holder.
- [ ] Mỗi **modal/popup/menu ngữ cảnh** mở trong màn đã mô tả chi tiết (mục + hành động); mỗi điều hướng sang màn khác chỉ ghi tên màn đích.
- [ ] Đã **đối chiếu web** `web/src/pages/` (nếu có) và nêu điểm lệch.
- [ ] Đã liệt kê **mọi màn đích điều hướng** vào mục "6. Màn mở ra từ đây"; màn đích **chưa có doc** đã note "(chưa có doc — cần làm)".
- [ ] Đã **copy asset gốc** + **cập nhật index** `docs/screens/README.md`.

> Phạm vi nhiều/tất cả màn: sau khi tick xong checklist cho 1 màn mới chuyển màn kế. Kết thúc, đối chiếu lại danh sách ở mục "Phạm vi" — báo rõ đã làm những màn nào, còn sót màn nào (nếu có).
