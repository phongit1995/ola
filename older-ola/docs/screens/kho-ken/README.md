# Màn hình Cửa hàng KEN (KEN store)

- **Fragment:** `chat.ola.vn.m.b` — `jadx_out/sources/chat/ola/vn/m/b.java` (108 dòng)
- **Layout:** `apktool_out/res/layout/ken_store_view_layout.xml` (+ include action bar `ola_top_icon_action_bar_layout.xml`)
- **Chức năng:** trung tâm KEN của tài khoản — hiển thị **số dư KEN** hiện có, cảnh báo khi sắp/đã hết KEN, và 3 nút giao dịch: **Nạp KEN**, **Chuyển KEN**, **Lịch sử giao dịch**, kèm nút **Hỗ trợ khách hàng**.

> **KEN = đơn vị tiền ảo trong Ola** (dùng đăng ký VIP, chơi đập trứng…). Đây là **fragment vị trí 10** trong `OlaBottomTabActivity`, KHÔNG phải một Activity riêng và KHÔNG phải danh sách (ListView) — chỉ là 1 màn cuộn tĩnh với panel giao dịch.

> **Mở từ:** tab **Ứng dụng** → shortcut **"KEN"** (`general_tab_kenstore`). Trong `chat.ola.vn.m.d.onItemClick` (case `general_tab_kenstore`): `a().J();` rồi `OlaBottomTabActivity.a(getActivity(), 10)` → chuyển sang fragment vị trí 10 (`b()` trả về `10`).

> Dựng từ **code + XML**. Bitmap icon trích sẵn vào [images/](images/).

> **Cỡ chữ chuẩn dùng trong màn:** caption (`text.size.caption`) = **12sp** · body1 (`text.size.body1`) = **14sp** · button (action bar title) = **14sp bold**.

---

## Ảnh chụp

> Chưa có ảnh chụp màn thật cho màn này.

### Assets dùng trong màn (ảnh gốc trích từ APK)

| Asset | Ảnh | Dùng cho |
|-------|-----|----------|
| `ic_tab_ken_store` | ![ken store](images/ic_tab_ken_store.png) | Icon trong action bar (đặt bằng code `setImageResource`) |
| `ic_action_quit` | ![quit](images/ic_action_quit.png) | Nút × đóng màn (`olaActionBarCloseButtonImageView`) |
| `ic_action_back` | ![back](images/ic_action_back.png) | Nút back trong action bar (ẩn mặc định `visibility=gone`) |
| `ic_ken` | ![ken](images/ic_ken.png) | Icon đồng KEN (không nhúng trực tiếp trong layout này, kèm tham khảo) |

> Các nền (`bg_form_content_span`, `bg_from_header`, `bg_action_bar`, `btn_green_button_selector`, `btn_transaction_item_selector`) là **drawable XML** (shape/selector), không phải ảnh bitmap — mô tả bằng CSS ở §3.

---

## 1. Bố cục (top → bottom)

```
FrameLayout (match_parent) — nền theo cha (xám nền app)
├─ ScrollView  @id/scrollView1   paddingTop 42dp (chừa action bar nổi), fillViewport
│  └─ LinearLayout vertical (match_parent / wrap_content)
│     ├─ [CẢNH BÁO KEN]  TextView  @id/kenNotify
│     │     nền bg_form_content_span (card trắng bo 4dp, viền #cccccc, margin 8dp)
│     │     chữ ĐỎ #e34545, 12sp, tối đa 5 dòng, margin trên 8dp
│     │     ▸ ẩn ngay khi inflate (setVisibility GONE), sau đó b(số dư) bật lại:
│     │        • số dư = 0  → text "message_out_of_ken"  (đã hết KEN)
│     │        • số dư > 0  → text "message_low_ken"     (sắp hết KEN)
│     │     ▸ click → mở PurchaseKENActivity (nạp KEN)
│     └─ LinearLayout vertical
│        ├─ [PANEL GIAO DỊCH]  LinearLayout  @id/traddingLayout
│        │     nền bg_form_content_span (card trắng), padding 8dp,
│        │     animateLayoutChanges, showDividers=middle
│        │     ├─ Header "Balance / Đang có"  (LinearLayout ngang, style form.header)
│        │     │   ├─ textView1  "Balance"        chữ xanh #1778ed, 12sp, gravity center
│        │     │   └─ txtKenAvaliable  <số dư> KEN  chữ cam #ff8400, 14sp BOLD, weight 1, margin 4dp
│        │     ├─ Button buyKENButton        "Nạp KEN"            cao 36dp, item giao dịch (trái), padding trái 8dp
│        │     ├─ divider 1px  #1f000000  (margin ngang 8dp)
│        │     ├─ Button btnTraddingTransferKen "Chuyển KEN"      cao 36dp, item giao dịch
│        │     ├─ divider 1px  #1f000000  (margin ngang 8dp)
│        │     └─ Button btnTraddingHistory  "Lịch sử giao dịch"  cao 36dp, item giao dịch
│        └─ Button  @id/btnSupportService  "Hỗ trợ khách hàng"
│              nền xanh #9CCC65 (defaultStyle.button.green), chữ trắng, cao 36dp, margin 8dp
│              ▸ luôn hiện (code set VISIBLE rõ ràng)
└─ <include ola_top_icon_action_bar_layout>  (action bar nổi trên cùng — xem §4)
```

> **Không có view nào dạng list/adapter** trong màn này → bỏ mục "Các loại dòng & view type".

## 2. Bảng style chi tiết từng phần

| Thành phần | id | Màu chữ / nền | Cỡ chữ | Kích thước / khoảng cách | Ghi chú (điều kiện ẩn/hiện) |
|------------|----|----|--------|--------------------------|------------------------------|
| Nền màn (ScrollView) | `scrollView1` | nền theo cha | — | full, paddingTop 42dp, fillViewport | chừa chỗ cho action bar nổi |
| **Cảnh báo KEN** | `kenNotify` | chữ `#e34545` (`red`), nền card trắng `bg_form_content_span` | 12sp (`text.size.caption`) | match_parent, marginTop 8dp, maxLines 5 | inflate → **GONE**; `b(j)` bật lại: j=0 → `message_out_of_ken`, j>0 → `message_low_ken`. Click → `PurchaseKENActivity` |
| Panel giao dịch | `traddingLayout` | nền card trắng `bg_form_content_span` | — | padding 8dp, `animateLayoutChanges`, `showDividers=middle` | luôn hiện |
| Header "Balance" | (LinearLayout, style `?form.header`) | nền `bg_from_header` (#eeeced + lớp mờ #cceeeced), chữ `#767676` | 14sp bold (kế thừa `form.header`) | cao 38dp (`general.form.header.height`), gravity center_vertical | dải tiêu đề panel |
| Nhãn "Balance" | `textView1` | chữ `#1778ed` (xanh dương) | 12sp (`vip.tranfer.text.lable` ← `text.small`) | wrap, gravity center | text `string_ballance` |
| **Số dư KEN** | `txtKenAvaliable` | chữ `#ff8400` (cam) **bold** | 14sp (`vip.tranfer.text.value` ← `text.medium`) | width 0dp weight 1, margin 4dp | text = `m.a(h.o)` + " KEN" (số có dấu phẩy ngăn nghìn) |
| Nút "Nạp KEN" | `buyKENButton` | nền selector `btn_transaction_item_selector`, chữ `#de000000` | 14sp (`button`) | cao 36dp, padding trái 8dp, gravity left | → `PurchaseKENActivity` |
| Divider | (View) | `#1f000000` (`colorTextBlackDivider`) | — | cao 1px, margin ngang 8dp | giữa các nút |
| Nút "Chuyển KEN" | `btnTraddingTransferKen` | như "Nạp KEN" | 14sp | cao 36dp, padding trái 8dp | → `OlaTransferKenActivity` |
| Nút "Lịch sử giao dịch" | `btnTraddingHistory` | như "Nạp KEN" | 14sp | cao 36dp, padding trái 8dp | → web "bank" (tab vị trí 8) |
| **Hỗ trợ khách hàng** | `btnSupportService` | chữ `#FFFFFF`, nền `#9CCC65` (`buttonGreen`) selector | 14sp (`button.green` ← `text.body1`) | cao 36dp, margin 8dp, gravity center | code set VISIBLE; click → gọi `1900588883` |
| Action bar | `olaTopActionBarViewLayout` | nền `bg_action_bar` (xanh `#7CB342`), chữ trắng | title 14sp bold | cao 48dp, padding ngang 8dp, paddingBottom 6dp | nổi trên cùng (xem §4) |

## 3. CSS tương đương (dựng lại trên web)

```css
.ken-store {
  position: relative;
  min-height: 100vh;
  background: #eeeced;                 /* background_solid_color */
  font-family: Roboto, "Helvetica Neue", Arial, sans-serif;
  padding-top: 42px;                   /* chừa action bar nổi */
  box-sizing: border-box;
}

/* Card trắng dùng chung (bg_form_content_span): margin 8dp + bo 4dp + viền #ccc + padding 15dp */
.ken-store__card {
  margin: 8px;
  background: #fff;
  border: 1px solid #cccccc;
  border-radius: 4px;
}

/* Cảnh báo KEN (đỏ) */
.ken-store__notify {
  margin: 8px 8px 0;
  padding: 15px;
  background: #fff;
  border: 1px solid #cccccc;
  border-radius: 4px;
  color: #e34545;                      /* red */
  font-size: 12px;                     /* caption */
  line-height: 1.4;
  cursor: pointer;                     /* → mở màn nạp KEN */
}

/* Panel giao dịch */
.ken-store__panel { padding: 8px; }
.ken-store__header {                   /* form.header */
  display: flex; align-items: center;
  min-height: 38px;
  background: #eeeced;                 /* + lớp mờ 80% phía trên */
  color: #767676; font-weight: bold; font-size: 14px;
}
.ken-store__balance-label { color: #1778ed; font-size: 12px; text-align: center; }
.ken-store__balance-value { flex: 1; margin: 4px; color: #ff8400; font-weight: bold; font-size: 14px; }

.ken-store__item {                     /* nút Nạp / Chuyển / Lịch sử */
  display: flex; align-items: center; justify-content: flex-start;
  height: 36px; padding-left: 8px;
  background: #fff; border: none;
  color: rgba(0,0,0,.87); font-size: 14px; cursor: pointer;
}
.ken-store__divider { height: 1px; margin: 0 8px; background: rgba(0,0,0,.12); }

.ken-store__support {                  /* button.green */
  display: block; width: calc(100% - 16px);
  height: 36px; margin: 8px;
  background: #9CCC65; color: #fff; border: none; border-radius: 2px;
  font-size: 14px; cursor: pointer;
}

/* Action bar nổi */
.ken-store__appbar {
  position: absolute; top: 0; left: 0; right: 0;
  height: 48px; display: flex; align-items: center;
  padding: 0 8px 6px; background: #7cb342; color: #fff;
}
.ken-store__appbar img { height: 100%; padding: 8px 0; box-sizing: border-box; }
.ken-store__appbar .title { flex: 1; margin-left: 8px; font-size: 14px; font-weight: bold; }
.ken-store__appbar .close { width: 48px; padding: 8px; }
```

```html
<div class="ken-store">
  <div class="ken-store__appbar">
    <img src="images/ic_tab_ken_store.png" alt="">
    <span class="title">KEN</span>
    <img class="close" src="images/ic_action_quit.png" alt="×">
  </div>

  <div class="ken-store__notify">Tài khoản của bạn sắp HẾT KEN. Bạn có thể nạp KEN bằng thẻ cào hoặc SMS…</div>

  <div class="ken-store__card ken-store__panel">
    <div class="ken-store__header">
      <span class="ken-store__balance-label">Đang có</span>
      <span class="ken-store__balance-value">12,500 KEN</span>
    </div>
    <button class="ken-store__item">Nạp KEN</button>
    <div class="ken-store__divider"></div>
    <button class="ken-store__item">Chuyển KEN</button>
    <div class="ken-store__divider"></div>
    <button class="ken-store__item">Lịch sử giao dịch</button>
  </div>

  <button class="ken-store__support">Hỗ trợ khách hàng</button>
</div>
```

## 4. Hành vi & luồng

### 4.1. Khởi tạo & cập nhật số dư

- **`onCreateView`:** inflate `ken_store_view_layout`, lấy `txtKenAvaliable` (số dư) và `kenNotify` (cảnh báo) → **ẩn `kenNotify`** (`setVisibility(8)`) rồi gắn listener. Đặt icon action bar = `ic_tab_ken_store`, tiêu đề = `general_tab_kenstore` ("KEN"). Hiện `btnSupportService` rõ ràng (`setVisibility(0)`). Gắn click cho: close, buyKENButton, btnTraddingTransferKen, btnTraddingHistory, btnSupportService, kenNotify.
- **`onActivityCreated`:** gọi `OlaApplication.b.r()` → `g.g((short)0)` = **yêu cầu server gửi số dư KEN** (socket). Khi server trả về, callback `chat.ola.vn.d.a.a(long j)` → `b(j)` cập nhật UI.
- **`onResume`:** gọi `b(chat.ola.vn.h.o)` — đọc số dư đang cache trong biến tĩnh `chat.ola.vn.h.o` (kiểu `long`, mặc định `0`).

**Hàm `b(long j)` — quy tắc hiển thị cảnh báo + số dư** (trích từ code):

| Số dư `j` | `kenNotify` | Text cảnh báo | `txtKenAvaliable` |
|-----------|-------------|---------------|-------------------|
| `j == 0` | **hiện** (VISIBLE) | `message_out_of_ken` ("…đã HẾT KEN… Bấm vào đây để NẠP thêm KEN") | "0 KEN" |
| `j > 0` (gồm cả > 10000) | **hiện** (VISIBLE) | `message_low_ken` ("…sắp HẾT KEN…") | "`<số có dấu phẩy>` KEN" |

> ⚠️ **Lưu ý về code:** trong nhánh `else` khi `j > 10000` có dòng `this.b.setVisibility(8)` (định ẩn cảnh báo khi còn nhiều KEN), nhưng **ngay sau đó** code lại set `this.b.setVisibility(0)` và text `message_low_ken` **không điều kiện**. Kết quả thực tế: **cảnh báo `kenNotify` LUÔN hiện** sau khi `b()` chạy — `j=0` → "hết KEN", còn lại → "sắp hết KEN" (kể cả khi số dư rất lớn). Đây là hành vi của bản APK này (có vẻ là lỗi logic gốc), tài liệu ghi đúng theo code.

> Số dư format bằng `chat.ola.vn.util.m.a(long)` = thêm dấu **phẩy ngăn hàng nghìn** (vd `12500` → `12,500`); luôn nối hậu tố `" KEN"`.

### 4.2. Bảng tương tác (mọi cử chỉ)

| Thành phần | Cử chỉ | Hành vi | Loại |
|------------|--------|---------|------|
| Cảnh báo KEN `kenNotify` | click | `PurchaseKENActivity.a(getActivity())` — mở màn nạp KEN | sang màn khác |
| Nút "Nạp KEN" `buyKENButton` | click | `PurchaseKENActivity.a(getActivity())` — mở màn nạp KEN | sang màn khác |
| Nút "Chuyển KEN" `btnTraddingTransferKen` | click | `OlaTransferKenActivity.a(getActivity())` — mở màn chuyển KEN | sang màn khác |
| Nút "Lịch sử giao dịch" `btnTraddingHistory` | click | `m.a(getActivity(), "bank", getString(string_bank))` → `OlaBottomTabActivity.a(ctx, 8)` = fragment WebView "bank" (lịch sử giao dịch) | sang màn khác (tab) |
| "Hỗ trợ khách hàng" `btnSupportService` | click | Nếu máy gọi được & có quyền (`com.mg.ola.common.d.g.a` + `util.n.b`) → quay số `1900588883` (`util.b.c`); ngược lại → `chat.ola.vn.i.i.b(activity)` (dialog hướng dẫn gọi hỗ trợ) | hỗn hợp |
| Nút × đóng `olaActionBarCloseButtonImageView` | click | `a().d(b())` = `OlaBottomTabActivity.d(10)` — đóng/thoát fragment KEN, quay lại tab trước | nội bộ (tab) |

> **Không có cử chỉ long-press / swipe / onItemClick** trong màn này (không phải list; tất cả là `View.OnClickListener` đơn). Action bar **không có** nút back hiển thị (`olaActionBarBackImageView` để `visibility=gone` trong include) và **không có** nút phụ (`olaActionBarButtonImageView` cũng `gone`).

### 4.3. Modal/Dialog/Menu trong màn

- **Không** có dialog/menu/bottom-sheet nào được mở **trực tiếp trong màn KEN** này. Mọi nút đều điều hướng sang Activity/tab khác hoặc gọi điện thoại.
- Riêng "Hỗ trợ khách hàng" khi máy **không** gọi điện được sẽ gọi `chat.ola.vn.i.i.b(activity)` — đây là helper dùng chung hiển thị thông báo gọi hotline (giống dialog `message_tip_to_call_cse` ở màn đăng nhập); nội dung do helper quyết định, không khai trong màn.

### 4.4. Action bar (`ola_top_icon_action_bar_layout.xml`)

`LinearLayout` ngang, nền `bg_action_bar` (xanh `#7CB342`), cao 48dp, padding ngang 8dp:

| # | id | Thành phần | Trạng thái / hành động |
|---|----|-----------|------------------------|
| 1 | `olaActionBarBackImageView` | back `ic_action_back` | **ẩn** (`visibility=gone` trong XML) — màn này không dùng back |
| 2 | `olaActionBarIconImageView` | icon (OlaCachedImageView) | code đặt `ic_tab_ken_store` |
| 3 | `olaActionBarTitleTextView` | tiêu đề, chữ trắng 14sp bold (`text.button`) | code đặt text `general_tab_kenstore` = "KEN" |
| 4 | `olaActionBarButtonImageView` | nút phụ | **ẩn** (`visibility=gone` trong XML) |
| 5 | `olaActionBarCloseButtonImageView` | × `ic_action_quit`, padding 8dp | click → `a().d(10)` đóng fragment |

## 5. Strings (đa ngôn ngữ)

| Resource | EN (`values/strings.xml`) | VI (`values-vi/strings.xml`) |
|----------|---------------------------|------------------------------|
| `general_tab_kenstore` | KEN | KEN |
| `string_ballance` | Balance | Đang có |
| `string_purchase_ken` | Purchase KEN | Nạp KEN |
| `string_transfer_ken` | Transfer KEN | Chuyển KEN |
| `string_tradding_history` | Transaction history | Lịch sử giao dịch |
| `string_customer_support` | Customer support | Hỗ trợ khách hàng |
| `string_bank` | Bank | Bank |
| `message_out_of_ken` | Run out of KEN, purchase more KEN to subcribe VIP, play Eggy and a lot of interesting features on Ola. Touch here to buy more KEN | Tài khoản của bạn đã HẾT KEN, hãy nạp KEN để có thể đăng ký VIP, chơi đập trứng và nhiều tính năng hấp dẫn khác trong Ola. Bấm vào đây để NẠP thêm KEN |
| `message_low_ken` | Your account almost runs out of KEN. You can purchase more KEN by prepaid card or SMS | Tài khoản của bạn sắp HẾT KEN. Bạn có thể nạp KEN bằng thẻ cào hoặc SMS tương ứng bên dưới |

## 6. Màn mở ra từ đây (điều hướng)

| Từ (nút/cử chỉ) | Màn đích (class) | Doc |
|-----------------|------------------|-----|
| "Nạp KEN" `buyKENButton` / cảnh báo `kenNotify` | `chat.ola.vn.activity.PurchaseKENActivity` (nạp KEN — layout `ken_purchase_layout`) | (chưa có doc — cần làm) |
| "Chuyển KEN" `btnTraddingTransferKen` | `chat.ola.vn.transferken.OlaTransferKenActivity` (chuyển KEN — flow `ola_transfer_ken_step1/2`) | (chưa có doc — cần làm) |
| "Lịch sử giao dịch" `btnTraddingHistory` | `OlaBottomTabActivity` fragment vị trí **8** (WebView "bank") | (chưa có doc — cần làm) |
| "Hỗ trợ khách hàng" `btnSupportService` | Trình gọi điện hệ thống → `1900588883` (hoặc dialog `i.i.b`) | (hệ thống) |
| Nút × `olaActionBarCloseButtonImageView` | `OlaBottomTabActivity.d(10)` — đóng fragment KEN | (nội bộ tab) |
