# Màn hình Thông báo (Notifications center)

- **Fragment:** `chat.ola.vn.m.k` (tab-fragment vị trí **9** trong `OlaBottomTabActivity`)
- **Mở từ:** tab **Ứng dụng** → shortcut **"Thông báo"** (`general_tab_notify`). Handler `chat.ola.vn.m.d` (case `R.string.general_tab_notify`) gọi `k.a(getActivity())` → reset state + xoá huy hiệu (badge) tab notify + `OlaBottomTabActivity.a(context, 9)` chuyển bottom-tab về fragment vị trí 9.
- **Layout gốc:** `apktool_out/res/layout/ola_notification_layout.xml`
- **Layout con:** `apktool_out/res/layout/ola_top_icon_action_bar_layout.xml` (action bar, qua `<include>`) · `apktool_out/res/layout/notify_item_layout.xml` (dòng list, do adapter `chat.ola.vn.b.x` inflate)
- **Adapter:** `chat.ola.vn.b.x` (kế thừa `chat.ola.vn.b.j` → `BaseAdapter`) · **Entity dòng:** `chat.ola.vn.entity.j` · **Entity action:** `chat.ola.vn.entity.d`
- **Chức năng:** danh sách thông báo của tài khoản (kết bạn, nhắc đến/mention, thích, ảnh mới, lời cầu hôn/ly hôn…). Kéo-làm-mới (pull-to-refresh) + tự nạp thêm khi cuộn xuống cuối (load-more). Mỗi dòng có thể có nút hành động ngay trong dòng và mở màn liên quan khi chạm.

## Ảnh chụp

> chưa có ảnh chụp (chưa có trong `apk-images/` / `fake-api/screenshots`).

### Assets dùng trong màn (ảnh gốc trích từ APK)

| Asset | Ảnh | Dùng cho |
|-------|-----|----------|
| `ic_tab_notify` | ![tab notify](images/ic_tab_notify.png) | Icon trên action bar (`olaActionBarIconImageView`) + icon tab |
| `ic_action_quit` | ![quit](images/ic_action_quit.png) | Nút **×** đóng màn ở góc phải action bar (`olaActionBarCloseButtonImageView`) |
| `ic_notification_add_friend` | ![add friend](images/ic_notification_add_friend.png) | Icon loại dòng **kết bạn** (`appCode = "3"`) |
| `ic_action_add_small` | ![add small](images/ic_action_add_small.png) | Icon nhỏ bên trái chữ trong nút **Kết bạn** |
| `ic_notification_mention` | ![mention](images/ic_notification_mention.png) | Icon loại dòng **nhắc đến/mention** (`appCode = "1"`) |
| `ic_notification_like` | ![like](images/ic_notification_like.png) | Icon loại dòng **thích** (`appCode = "1.4"`) |
| `ic_notification_photo` | ![photo](images/ic_notification_photo.png) | Icon loại dòng **ảnh mới** (`appCode = "3.1"`) |
| `ic_notification_heart` | ![heart](images/ic_notification_heart.png) | Dự định cho dòng **cầu hôn** (`f="2"`, `proposal`) — **nhưng runtime KHÔNG vẽ** (xem ⚠️ ở mục view type) |
| `ic_notification_broken_heart` | ![broken heart](images/ic_notification_broken_heart.png) | Dự định cho dòng **ly hôn** (`f="2"`, `divorce`) — **runtime KHÔNG vẽ** |
| `ic_contact_photo` | ![contact](images/ic_contact_photo.png) | Avatar mặc định khi dòng không có sender (`imgIcon`) |

> Avatar dòng (`imgIcon`) là `OlaCachedImageView`: nếu entity có ảnh binary (`j.i`) thì decode hiển thị; nếu có sender (`j.b`) thì tải avatar thật qua `chat.ola.vn.c.t.a().g(nick, img)`; nếu không có sender thì dùng `ic_contact_photo`.

---

## 1. Bố cục (top → bottom)

```
FrameLayout (match_parent) — nền mặc định theo theme
├─ FrameLayout (paddingTop 42dp = metric.topbar.noshadow.42dp — chừa chỗ cho action bar)
│   └─ SwipeRefreshLayout  notificationPullToRefreshLayout   ← kéo xuống để làm mới (màu vòng quay = #7CB342)
│       └─ ListView  listView  (match_parent, style defaultStyle.list.noDivider — KHÔNG kẻ phân cách hệ thống)
│            └─ [N dòng]  notify_item_layout  (1 loại view duy nhất — xem mục dưới)
│
├─ <include> ola_top_icon_action_bar_layout   ← ACTION BAR phủ trên cùng (cao 48dp; list chừa 42dp padding-top)
│   ├─ olaActionBarBackImageView   ImageView  (ic_action_back)         — visibility=gone (ẩn)
│   ├─ olaActionBarIconImageView   OlaCachedImageView (ic_tab_notify)  — icon trái
│   ├─ olaActionBarTitleTextView   TextView "Thông báo" 14sp bold trắng — tiêu đề, weight=1
│   ├─ olaActionBarButtonImageView ImageView (ic_action_notification)   — visibility=gone (ẩn)
│   └─ olaActionBarCloseButtonImageView ImageView (ic_action_quit) 48dp — nút × đóng màn
│
├─ noNotificationTextView  TextView "Không có thông báo"  (center)  — visibility=gone (CHỈ hiện khi list rỗng)
└─ progressBar  ProgressBar (center, 48×48dp)  — quay khi đang nạp; ẩn khi xong (xem 4.x)
```

### Góc trái / góc phải (chi tiết vị trí)

- **Action bar — góc trái:** `olaActionBarBackImageView` (mũi tên `ic_action_back`) có trong layout nhưng **`visibility=gone`** → không hiện. Phần tử trái cùng **đang hiện** là `olaActionBarIconImageView` = **icon `ic_tab_notify`** (padding T/B 8dp), kế đó là tiêu đề "Thông báo".
- **Action bar — góc phải:** có **2** view ở phải; `olaActionBarButtonImageView` (`ic_action_notification`, 48dp) **`visibility=gone`** (dự phòng, không hiện) → phải cùng đang hiện chỉ là **nút × `olaActionBarCloseButtonImageView`** (`ic_action_quit`, padding 8dp) = đóng màn.
- **Mỗi dòng — bên trái:** avatar `imgIcon` 40×40dp, `gravity=top` (canh **đỉnh**, không giữa).
- **Mỗi dòng — bên phải:** **KHÔNG có phần tử canh phải** — khối nội dung (`weight=1`) trải hết phần còn lại; tên/nội dung/nút/giờ đều **canh trái** trong khối đó. (Khác màn danh sách hội thoại vốn có badge/giờ ở mép phải.)
- **Chân dòng:** divider 1px thụt lề trái/phải 16dp.

> Lưu ý (đã xác minh `drawable/bg_action_bar.xml`): action bar **có nền xanh thật** — `bg_action_bar` là `layer-list` mà **lớp dưới cùng là `solid colorOlaPrimary` (#7CB342)**; 6 lớp `#11000000…#16000000` xếp chồng (mỗi lớp padding-bottom 1dp) chỉ là **dải bóng đổ ~6dp** ở mép dưới. Chiều cao bar = **48dp** (`defaultStyle.actionBar.background`, padding dưới 6dp); con số **42dp** (`metric.topbar.noshadow.42dp`) là padding-top của khối list để chừa chỗ cho bar nổi phía trên.

### Các loại dòng & view type

Adapter `chat.ola.vn.b.x` **KHÔNG override** `getViewTypeCount()`/`getItemViewType()` → mặc định **1 view type duy nhất**. Mọi dòng dùng chung layout `notify_item_layout.xml`; khác biệt giữa các loại thông báo nằm ở **icon `iconImageView`** và **vùng nút `notificationButtonLayout`** được bật/tắt theo `appCode` (`j.f`) và `type` (`j.g`).

| "Loại" (theo `appCode` j.f / type j.g) | Icon `iconImageView` | Nút hành động trong dòng | Điều kiện hiện |
|---|---|---|---|
| Kết bạn — `f="3"` | `ic_notification_add_friend` | **Kết bạn** (notificationButton1, icon `ic_action_add_small`); button2 ẩn | Code: `if (h.t.c(sender)) return;` → `h.t.c()` = **đã là bạn/đã gửi** ⇒ **ẩn cả vùng nút**; chỉ khi **chưa là bạn** mới hiện nút Kết bạn |
| Nhắc đến/mention — `f="1"` | `ic_notification_mention` | (không) | luôn |
| Thích — `f="1.4"` | `ic_notification_like` | (không) | luôn |
| Ảnh mới — `f="3.1"` | `ic_notification_photo` | (không) | luôn |
| Cầu hôn — `f="2"` & `g="proposal"` | **(GONE)** — code gán `ic_notification_heart` vào biến cục bộ nhưng chạy `e.setVisibility(8); return;` trước dòng `setImageResource` → **không vẽ** | **Đồng ý** (button1) + **Không** (button2) — vùng nút hiện | luôn (khi proposal) |
| Ly hôn — `f="2"` & `g="divorce"` | **(GONE)** — gán `ic_notification_broken_heart` nhưng cũng bị `e.setVisibility(8); return;` → **không vẽ** | (không) | luôn (khi divorce) |
| Loại khác / không khớp | (ẩn `iconImageView`) | (không) | mặc định — icon GONE |

> **⚠️ Lỗi/đặc thù bind (đã xác minh `b/x.java`):** chỉ `f="3"` gọi `e.setImageResource(...)` **tường minh** nên icon kết bạn mới hiện. `f="1"/"1.4"/"3.1"` gán icon vào biến cục bộ và áp ở dòng `imageView.setImageResource(i)` **cuối hàm** → hiện. Riêng nhánh `f="2"` (cầu hôn/ly hôn) gán icon vào biến cục bộ nhưng lại `this.e.setVisibility(8); return;` **trước** khi tới dòng áp icon ⇒ **`iconImageView` bị ẩn, heart/broken_heart không bao giờ được vẽ**. Hai asset đó chỉ "được tham chiếu" trong code (nên jadx thấy dùng) chứ runtime không hiển thị.

> Adapter này **không dùng chung** với màn khác (lấy data trực tiếp từ list tĩnh `chat.ola.vn.m.k.a`). `getCount()` = `k.a.size()`, `getItem(i)` = `k.a.get(i)`.

### Ánh xạ trường entity dòng (`chat.ola.vn.entity.j`)

| Trường | Kiểu | Ý nghĩa (suy từ cách dùng trong adapter `x` + fragment `k`) |
|--------|------|-------------------------------------------------------------|
| `a` | `entity.d[]` | Mảng **hành động** của dòng; `a[0]` quyết định điều hướng khi click cả dòng (xem 4.3) |
| `b` | `String` | **ID/nick người gửi**; rỗng → ẩn `txtSender` + avatar dùng `ic_contact_photo`; có → resolve tên qua `h.t.e(b,0).L()` và tải avatar `c.t.a().g(b, img)` |
| `c` | `String` (mặc định `null`) | Tham số phụ (vd lời nhắn kèm khi gửi kết bạn: `fVar.c(j.c)`) |
| `d` | `String` | **ID thông báo** — dùng đánh dấu đã xử lý `OlaApplication.b.d({j.d})` sau khi đồng ý/từ chối cầu hôn |
| `e` | `String` | **Nội dung** hiển thị ở `txtTitle`, render emoji/markup qua `util.i.a(...)` |
| `f` | `String` | **appCode** — chọn icon + loại dòng: `"3"` kết bạn · `"1"` mention · `"1.4"` thích · `"3.1"` ảnh · `"2"` hôn nhân |
| `g` | `String` | **type** phụ khi `f="2"`: `"proposal"` (cầu hôn) / `"divorce"` (ly hôn) |
| `h` | `long` | **Mốc thời gian (ms)** — `txtTimeLable` = `now − h` (định dạng "x phút trước"); cũng là **con trỏ phân trang** (`e = jVarArr[last].h`) |
| `i` | `byte[]` | Ảnh inline (nếu có) — decode `BitmapFactory` đặt vào `imgIcon` thay avatar |
| `j` `k` `l` `m` | `boolean` | Cờ (mặc định `true/true/true/false`) — **không tác động UI** trong màn này |

## 2. Bảng style chi tiết từng phần

| Thành phần | id | Màu chữ / nền | Cỡ chữ | Kích thước / khoảng cách | Ghi chú (điều kiện) |
|------------|----|----|--------|--------------------------|---------|
| Action bar | `olaTopActionBarViewLayout` | nền `bg_action_bar` = đáy `#7CB342` (`colorOlaPrimary`) + 6 dải bóng `#11–16 000000` ở mép dưới, padding ngang 8dp, padding dưới 6dp | — | cao **48dp** | `defaultStyle.actionBar.background` |
| Icon action bar | `olaActionBarIconImageView` | — | — | padding T/B 8dp | `ic_tab_notify` |
| Tiêu đề | `olaActionBarTitleTextView` | chữ `#FFFFFF` (`colorTextWhitePrimary`) **bold** | **14sp** (`text.size.button`) | weight=1, marginLeft 8dp, 1 dòng | text "Thông báo" |
| Nút × đóng | `olaActionBarCloseButtonImageView` | icon | — | wrap, padding 8dp | `ic_action_quit` → `a().d(9)` đóng fragment |
| SwipeRefresh | `notificationPullToRefreshLayout` | vòng quay `#7CB342` (`colorOlaPrimary`) | — | match_parent | kéo xuống làm mới |
| ListView | `listView` | trong suốt (`cacheColorHint` transparent) | — | match_parent | `defaultStyle.list.noDivider` (không divider hệ thống) |
| **Dòng (item)** | (root `notify_item_layout`) | nền `#CCFFFFFF` (`translucent_white_80_percent`) | — | padding 16dp, minHeight 72dp | nền trắng mờ 80% |
| Avatar dòng | `imgIcon` | — | — | 40×40dp, scaleType centerCrop | ảnh binary / avatar thật / `ic_contact_photo` |
| Tên người gửi | `txtSender` | chữ `rgba(0,0,0,.87)` (`colorTextBlackPrimary`) | 16sp (`text.size.subhead`) | match_parent, 1 dòng, ellipsize end | **ẩn (GONE) khi `j.b` rỗng**; có → tên hiển thị (`f.L()` nếu có trong contact, không thì dùng `j.b`) |
| Nội dung | `txtTitle` | chữ `rgba(0,0,0,.87)` (`colorTextBlackPrimary`) | 14sp (`text.size.body1`) | wrap, marginTop 4dp, maxLines 3 | render qua `chat.ola.vn.util.i.a(...)` (có emoji/markup) |
| Vùng nút | `notificationButtonLayout` | — | — | marginTop 4dp | **GONE mặc định**; bật theo loại (xem mục view type) |
| Nút 1 | `notificationButton1` | chữ `#FFFFFF` (XML đè `@color/white` lên màu mặc định `#636363`), nền `btn_green_button_selector` (xanh) | 12sp (`text.size.caption`) | cao 28dp, minWidth 64dp, weight=1 | text "Đồng ý"/"Kết bạn" tuỳ loại; style `?me.item.button` → `defaultStyle.me.footer` → `defaultStyle.text.small` (caption 12sp) |
| Nút 2 | `notificationButton2` | chữ `#636363` (mặc định `me.footer`), nền `btn_default_button_selector` (xám) | 12sp (`text.size.caption`) | cao 28dp, minWidth 64dp, marginLeft 8dp, weight=1 | text "Không"; **ẩn (GONE) ở loại kết bạn**, hiện ở loại cầu hôn |
| Icon loại | `iconImageView` | — | — | cao 20dp, marginRight 4dp | **visibility=gone trong XML**; code bật `VISIBLE` rồi gán icon theo `appCode`; loại không khớp → để GONE |
| Thời gian | `txtTimeLable` | chữ `rgba(0,0,0,.54)` (`colorTextBlackSecondaryOrIcon`) | 12sp (`text.size.caption`) | wrap | thời gian tương đối từ `now − j.h` qua `com.mg.ola.common.d.i.a(...)` + mảng `R.array.time_label` (VI: `vừa tức thì/giây/phút/giờ/ngày/tuần/tháng/năm`) |
| Divider dòng | `listViewBottomDividerView` | nền `#1F000000` (`colorTextBlackDivider`) | — | cao 1px, margin ngang 16dp | kẻ chân mỗi dòng |
| Empty state | `noNotificationTextView` | chữ `rgba(0,0,0,.54)` | 12sp (`text.size.caption`) | center | **GONE**; hiện khi list rỗng |
| Loading | `progressBar` | — | — | 48×48dp, center | quay khi đang nạp |

## 3. CSS tương đương (dựng lại trên web)

```css
.ola-notify { position: relative; min-height: 100vh; font-family: Roboto, Arial, sans-serif; }

/* Action bar phủ trên */
.ola-notify__bar {
  position: fixed; top: 0; left: 0; right: 0; height: 48px;
  display: flex; align-items: center;
  padding: 0 8px 6px;
  background: #7CB342;                        /* bg_action_bar: lớp đáy solid colorOlaPrimary */
  box-shadow: inset 0 -6px 6px -6px rgba(0,0,0,.10);   /* 6 dải #11–16 000000 = bóng mép dưới */
  color: #FFFFFF;
}
.ola-notify__bar img.icon { height: 26px; padding: 8px 0; }
.ola-notify__bar .title { flex: 1; margin-left: 8px; font-size: 14px; font-weight: 700; color: #FFFFFF;
  white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
.ola-notify__bar .close { width: 48px; padding: 8px; box-sizing: border-box; cursor: pointer; }

/* Danh sách */
.ola-notify__list { padding-top: 42px; }

/* Một dòng */
.ola-notify__item { background: rgba(255,255,255,.80); }   /* translucent_white_80_percent */
.ola-notify__item .row { display: flex; padding: 16px; min-height: 72px; }
.ola-notify__item .avatar { width: 40px; height: 40px; object-fit: cover; border-radius: 2px; }
.ola-notify__item .body { flex: 1; margin-left: 16px; display: flex; flex-direction: column; }
.ola-notify__item .sender { font-size: 16px; color: rgba(0,0,0,.87); white-space: nowrap;
  overflow: hidden; text-overflow: ellipsis; }
.ola-notify__item .content { margin-top: 4px; font-size: 14px; color: rgba(0,0,0,.87);
  display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden; }
.ola-notify__item .actions { display: none; margin-top: 4px; }   /* bật khi loại có nút */
.ola-notify__item .actions.show { display: flex; }
.ola-notify__item .btn { height: 28px; min-width: 64px; flex: 1; border: none; border-radius: 2px;
  font-size: 12px; cursor: pointer; }
.ola-notify__item .btn--green { background: #9CCC65; color: #FFFFFF; }   /* btn_green_button_selector */
.ola-notify__item .btn--default { background: #E0E0E0; color: #636363; margin-left: 8px; }
.ola-notify__item .meta { display: flex; align-items: center; margin-top: 4px; }
.ola-notify__item .meta .typeicon { height: 20px; margin-right: 4px; }
.ola-notify__item .meta .time { font-size: 12px; color: rgba(0,0,0,.54); }
.ola-notify__item .divider { height: 1px; margin: 0 16px; background: rgba(0,0,0,.12); }

/* Empty + loading */
.ola-notify__empty { position: absolute; inset: 42px 0 0 0; display: none;
  align-items: center; justify-content: center; font-size: 12px; color: rgba(0,0,0,.54); }
.ola-notify__empty.show { display: flex; }
.ola-notify__loading { width: 48px; height: 48px; }
```

```html
<div class="ola-notify">
  <div class="ola-notify__bar">
    <img class="icon" src="images/ic_tab_notify.png">
    <span class="title">Thông báo</span>
    <img class="close" src="images/ic_action_quit.png">
  </div>

  <div class="ola-notify__list">
    <div class="ola-notify__item">
      <div class="row">
        <img class="avatar" src="images/ic_contact_photo.png">
        <div class="body">
          <div class="sender">sugardaddy</div>
          <div class="content">muốn kết bạn với bạn</div>
          <div class="actions show">
            <button class="btn btn--green">Kết bạn</button>
          </div>
          <div class="meta">
            <img class="typeicon" src="images/ic_notification_add_friend.png">
            <span class="time">5 phút trước</span>
          </div>
        </div>
      </div>
      <div class="divider"></div>
    </div>
  </div>
</div>
```

## 4. Hành vi & luồng

### 4.1. Khởi tạo & nguồn dữ liệu
- `k.a(context)` (gọi từ shortcut "Thông báo"): reset con trỏ phân trang `e=0, f=-1`, **xoá list tĩnh** `k.a.clear()`, gọi `OlaBottomTabActivity.I()` (đóng overlay nếu có), **xoá huy hiệu tab notify** (`chat.ola.vn.h.v.b(R.string.general_tab_notify)` → `b(1)` + `c(null)`), rồi `OlaBottomTabActivity.a(context, 9)` mở fragment.
- `onCreateView`: inflate `ola_notification_layout`, nối action bar (icon `ic_tab_notify`, title "Thông báo"), gán listener nút × đóng, lấy `listView`, `progressBar` (`j`), `noNotificationTextView` (`k`), `SwipeRefreshLayout` (`g`) + màu vòng quay `colorOlaPrimary`, đăng ký `onRefresh`.
- `b(bundle)`: tạo adapter `x`, gán `OnClickListener` của Fragment cho adapter (cho các view con trong dòng), `setAdapter`, đăng ký `OnItemClickListener` + `OnScrollListener`, gọi `d()` nạp trang đầu.
- **Nạp dữ liệu `d()` (load-more/phân trang):** nếu `f != e` thì gọi `OlaApplication.b.a(e, true, callback)` (socket, response code **39**). Con trỏ `e` = mốc thời gian `h` của phần tử cuối trang trước; mỗi trang `a(jVarArr, i)` append vào `k.a`, `notifyDataSetChanged`, cập nhật `e`. Nếu vẫn còn nhìn thấy dòng cuối → gọi `d()` tiếp.
- **Hiện/ẩn progress + empty:**
  - Đang nạp & không phải pull-refresh (`!h`) → `progressBar` VISIBLE, `noNotificationTextView` GONE.
  - Trang trả về **rỗng/null** (`a(jVarArr,i)` với mảng rỗng) hoặc lỗi callback → `progressBar` GONE, `noNotificationTextView` **VISIBLE** (hiện "Không có thông báo").
  - Có data → cả hai GONE.

### 4.2. Bảng tương tác (mọi cử chỉ)

| Thành phần | Cử chỉ | Hành vi | Loại |
|------------|--------|---------|------|
| `SwipeRefreshLayout` | **kéo xuống (pull-to-refresh)** | `onRefresh`: reset `e=0,f=-1`, `k.a.clear()`, `notifyDataSetChanged`, `d()` nạp lại từ đầu, `a(false)` ẩn progress thủ công, `e()` bật spinner refresh (kèm hiệu ứng âm nếu bật) | nội bộ |
| `ListView` | **cuộn tới cuối** | `onScroll` đặt cờ `i = (first+visible >= total-1)`; `onScrollStateChanged` khi **idle** và `i` → `d()` nạp thêm trang. **Lưu ý:** base-adapter `j` có sẵn cơ chế prefetch (cách cuối ~5 dòng) nhưng **KHÔNG kích hoạt ở màn này** — fragment chỉ gọi `d.a(this)` set `OnClickListener`, **không** set interface prefetch `j.a` (`f` = null). Load-more thuần từ `onScroll` | nội bộ (load-more) |
| **Dòng list** (cả dòng) | **click (onItemClick)** | Lấy action đầu `j.a[0]` (`entity.d`) → điều phối theo `action`: `viewme/comment` → mở `OlaMeCommentActivity`; `viewme/homepage` → mở trang cá nhân (`me.c.a`); `viewmedia` → `OlaImageViewerActivity`; còn lại → `d.a(activity)` (xem 4.4) | hỗn hợp |
| **Dòng list** | **long-press** | **Không có** — `k` không đăng ký `OnItemLongClickListener`, item không có `setOnLongClickListener` | — |
| Avatar dòng `imgIcon` | click | Trong `onClick` case `R.id.imgIcon`: **break — không làm gì** (đã set listener nhưng rỗng) | nội bộ |
| Nội dung `txtTitle` | click | có `setTag` nhưng **không gán** click trong adapter (Fragment.onClick không xử lý `txtTitle`) → không phản ứng riêng | — |
| Nút 1 `notificationButton1` | click | **Cầu hôn** (`f≠"3"`): mở dialog "Đồng ý kết hôn?" (xem 4.4 #1). **Kết bạn** (`f="3"`): gửi kết bạn `OlaApplication.b.a(message.f)` rồi `notifyDataSetChanged` | modal / nội bộ |
| Nút 2 `notificationButton2` | click | mở dialog "Từ chối lời cầu hôn?" (xem 4.4 #2) | modal trong màn |
| Nút × action bar `olaActionBarCloseButtonImageView` | click | `a().d(9)` — đóng/quay lại tab trước trong `OlaBottomTabActivity` | nội bộ |

### 4.3. Điều phối click cả dòng (`onItemClick`) theo `entity.d.a()` (action)
Lấy `dVar = j.a[0]`, đọc `dVar.a()`:
- **`viewme`** + `dVar.c()=="comment"` → `OlaMeCommentActivity.a(activity, id)` (id = `dVar.b()`).
- **`viewme`** + `dVar.c()=="homepage"` → `chat.ola.vn.me.c.a(activity, OlaApplication.b, dVar.b())` (mở trang cá nhân người dùng).
- **`viewmedia`** → `OlaImageViewerActivity.a(activity, view, null, 0, media)` (xem ảnh, có hiệu ứng chuyển cảnh từ `view`).
- **mặc định** → `dVar.a(activity)` = `entity.d.c(context, dVar)`: bộ điều phối lớn theo `action` (`wap`/`webapp` mở web in-app, `call` quay số, `chatto` mở `OlaChatViewActivity`, `vip` mở `BuyVipActivity`, `rss`, `like`/`likeadme` gửi like, `postme` mở `OlaMeComposerActivity`, `openphoto`/`viewmedia` mở `OlaImageViewerActivity`…). Một số action (`vip`, `wap` có phí) hiện trước dialog xác nhận trả phí (xem 4.4 #3).

### 4.4. Modal/Dialog mở trong màn (chi tiết)
Tất cả là `AlertDialog` dựng qua `chat.ola.vn.i.i.a(ctx, title, message, btnYes, btnNo, listener)` — 2 nút, `i==0` là nút trái.

1. **Dialog "Đồng ý kết hôn"** — mở khi bấm **Nút 1** ở dòng cầu hôn (`notificationButton1`, `f≠"3"`).
   - Tiêu đề `string_box` ("Box - Kết Hôn"), nội dung `message_accept_married_proposal` ("Bạn có đồng ý kết hôn với @<tên>?").
   - **"Đồng ý"** (`string_agree`, i=0) → `OlaApplication.b.C(token)` chấp nhận + `OlaApplication.b.d({j.d})` đánh dấu đã xử lý notify, **xoá dòng khỏi list** (`k.a.remove`) + `notifyDataSetChanged`. **"Không"** (`string_no`) → đóng.
2. **Dialog "Từ chối lời cầu hôn"** — mở khi bấm **Nút 2** ở dòng cầu hôn (`notificationButton2`).
   - Tiêu đề `string_box`, nội dung `message_deny_married_proposal` ("Bạn muốn từ chối lời cầu hôn của @<tên>?").
   - **"Từ chối"** (`string_deny`, i=0) → `OlaApplication.b.D(token)` từ chối + `OlaApplication.b.d({j.d})` + xoá dòng + `notifyDataSetChanged`. **"Không"** → đóng.
3. **Dialog "Xác nhận trả phí"** — có thể bật khi click cả dòng dẫn tới action có phí (`entity.d.a(...)` khi `dVar.j` ≠ rỗng).
   - Tiêu đề `dialog_title_confirm` ("Xác nhận"), nội dung `message_advertisment_inline_perform_confirm` ("Bạn sẽ tốn <giá> để thực hiện thao tác này. Bạn có muốn tiếp tục không?").
   - **"Có"** (`string_yes`, i=0) → thực thi action (`d.c(context, dVar)`). **"Không"** → đóng.

> Loại **kết bạn** (`f="3"`) bấm Nút 1 **không mở dialog** — gửi luôn lời mời kết bạn (`new chat.ola.vn.message.f(sender, 0)` → `OlaApplication.b.a(fVar)`); chỉ hiện nút khi `chat.ola.vn.h.t.c(sender)` = chưa là bạn.

### 4.5. Đối chiếu bản web
Đã dựng tại `web/src/pages/apps/NotificationsPage.tsx` (route `/thong-bao`, mở từ tab Ứng dụng). Khớp về: nền dòng trắng-mờ-80%, avatar 40px + tên đậm 16px + nội dung 14px, icon loại + thời gian, divider inset 16px, nút **Kết bạn** xanh / **Đồng ý·Không**, 6 loại theo `appCode`.

**Điểm lệch cần biết:**
- Web dùng **mock data tĩnh** (chưa nối socket opcode 39, chưa phân trang/pull-refresh/mark-read); nút bấm chỉ bật toast "đang phát triển".
- Header web dùng **`ScreenHeader` (mũi tên ← quay lại)** thay cho **nút × (`ic_action_quit`)** của APK — APK đóng fragment bằng `a().d(9)`, web `navigate(home)`.
- Icon loại thông báo ở web là **SVG nội tuyến** (không dùng asset `ic_notification_*` gốc).
- **Web đang vẽ icon trái tim/trái tim vỡ cho cầu hôn/ly hôn** — lệch với app thật (app **không** vẽ icon cho 2 loại này, xem ⚠️ mục view type). Nếu muốn khớp 100% thì bỏ icon ở 2 loại đó trong `NotificationsPage.tsx`.
- Web chưa làm: ẩn `txtSender` khi không có người gửi, ảnh inline (`j.i`), empty-state "Không có thông báo", loading spinner.

## 5. Strings (đa ngôn ngữ)

| Resource | EN (`values/strings.xml`) | VI (`values-vi/strings.xml`) |
|----------|--------------------------|------------------------------|
| `general_tab_notify` | Notifications | Thông báo |
| `string_notification` | Notification | Thông báo |
| `string_no_notifications` | No notification | Không có thông báo |
| `string_make_friend` | Add friend | Kết bạn |
| `string_box` | Box - Marriage | Box - Kết Hôn |
| `string_agree` | Agree | Đồng ý |
| `string_deny` | Deny | Từ chối |
| `string_no` | No | Không |
| `string_yes` | Yes | Có |
| `message_accept_married_proposal` | Do you agree to get married with @%1$s? | Bạn có đồng ký kết hôn với @%1$s? |
| `message_deny_married_proposal` | Do you want to reject marriage proposal from @%1$s? | Bạn muốn từ chối lời cầu hôn của @%1$s? |
| `dialog_title_confirm` | Confirmation | Xác nhận |
| `message_advertisment_inline_perform_confirm` | You will pay %1$s for this action. Do you want to continue? | Bạn sẽ tốn %1$s để thực hiện thao tác này. Bạn có muốn tiếp tục không? |

## 6. Màn mở ra từ đây (điều hướng)

| Từ (nút/cử chỉ) | Màn đích (class) | Doc |
|-----------------|------------------|-----|
| Click dòng — action `viewme/comment` | `chat.ola.vn.me.OlaMeCommentActivity` (bình luận trên Me) | (chưa có doc — cần làm) |
| Click dòng — action `viewme/homepage` | Trang cá nhân (qua `chat.ola.vn.me.c.a(...)`) | (chưa có doc — cần làm) |
| Click dòng — action `viewmedia`/`openphoto` | `chat.ola.vn.activity.OlaImageViewerActivity` (xem ảnh) | (chưa có doc — cần làm) |
| Click dòng — action `chatto` | `chat.ola.vn.activity.OlaChatViewActivity` (khung chat) | [../chat/khung-chat](../chat/) (đối chiếu) |
| Click dòng — action `vip` | `chat.ola.vn.activity.BuyVipActivity` (mua VIP) | (chưa có doc — cần làm) |
| Click dòng — action `postme` | `chat.ola.vn.me.OlaMeComposerActivity` (soạn Me) | (chưa có doc — cần làm) |
| Nút × action bar | (đóng fragment, về tab trước trong `OlaBottomTabActivity`) | [../trang-chu/README.md](../trang-chu/README.md) |

## 7. Hợp đồng dữ liệu (socket) — phục vụ dựng backend

> Trích từ `network/OlaNetworkService.java` + `m/k.java` + `entity/j.java`,`entity/d.java`. App gốc dùng **socket nhị phân** (không REST); khi dựng backend mới có thể map sang REST/WebSocket tương đương.

### 7.1. Các lệnh liên quan màn này

| Mục đích | Gọi trong app | Tham số | Ghi chú backend |
|----------|---------------|---------|-----------------|
| **Lấy danh sách thông báo** | `OlaApplication.b.a(cursor, true, cb)` → `a(long, boolean, short)` với `short=39` | `cursor` = `h` (timestamp ms) của item cuối, **0 = trang đầu**; cờ boolean `true` | **opcode/sự kiện = 39**. Trả mảng `entity.j[]` + 1 `int`. Phân trang **theo con trỏ thời gian giảm dần**, KHÔNG theo offset. Khi `cursor` mới == cursor cũ (`f==e`) → client **không gửi lại** (chống trùng) |
| **Đồng ý cầu hôn** | `OlaApplication.b.C(token)` | `token` = `j.a[0].b()` (fallback `c()`) | accept marriage; sau đó client tự `d([j.d])` + xoá dòng |
| **Từ chối cầu hôn** | `OlaApplication.b.D(token)` | như trên | deny marriage |
| **Đánh dấu đã xử lý / đã đọc** | `OlaApplication.b.d(ids)` | `ids = String[]{ j.d }` | nên hỗ trợ **mark-read theo danh sách id** |
| **Gửi kết bạn (từ dòng kết bạn)** | `OlaApplication.b.a(message.f)` | `nick` người gửi (+ lời nhắn `j.c` nếu có) | server tạo quan hệ "Friends" + follow |
| **Xoá badge khi mở màn** | `bottomTab.I()` + entry `h.v.b(notify).b(1)` | — | cần API/sự kiện **đếm số chưa đọc** để dựng badge tab |

### 7.2. Mô hình một thông báo (`entity.j`) — gợi ý schema

```jsonc
{
  "id":        "string",      // j.d  — id thông báo (dùng mark-read)
  "senderId":  "string|null", // j.b  — nick/id người gửi (null => ẩn tên + avatar mặc định)
  "content":   "string",      // j.e  — nội dung (hỗ trợ emoji/markup)
  "appCode":   "string",      // j.f  — MỞ (server tự do); client chỉ gán icon cho "3"|"1"|"1.4"|"3.1"|"2", khác → generic
  "type":      "string|null", // j.g  — khi appCode="2": "proposal" | "divorce"
  "timestamp": 0,             // j.h  — ms; vừa hiển thị "x phút trước" vừa là cursor phân trang
  "inlineImage": "bytes|null",// j.i  — ảnh nhúng (hiếm dùng)
  "actions": [ /* entity.d[] */ ]  // j.a — danh sách hành động khi chạm dòng (xem 7.3)
}
```

**Wire-format (parser `w/ap.java`, opcode 39)** — mỗi bản ghi là 1 phần tử trong mảng tag **109**; tổng số chưa đọc/đếm ở tag **124**:

| Tag | → trường | Ghi chú |
|----:|----------|---------|
| 109 | (container) | mảng bản ghi thông báo; `count = c(109)` |
| —   | `d` (id) | `sVar.c(iB)` (khoá bản ghi) |
| 112 | `g` (type) | proposal/divorce… |
| 7   | `b` (sender) | nick người gửi |
| 22  | `c` (extra) | tham số phụ |
| 9   | `h` (timestamp ms) | dùng cả làm cursor phân trang |
| 23  | `i` (ảnh inline) | bytes |
| 110 | `e` (nội dung) | server cắt tiền tố `@sender`/`sender` rồi `trim()` |
| 113 | `f` (appCode) | quyết định icon |
| 111 | `a` (actions[]) | parse qua `util.o.a(str, ...)` |
| 124 | (total) | tổng/đếm |

### 7.3. Mô hình hành động (`entity.j.a[0]` = `entity.d`) — điều hướng khi chạm dòng

Mỗi thông báo mang **mảng action**; client đọc `a[0]` rồi điều phối theo `action = d.a()` (+ tham số `d.b()`, `d.c()`, nhãn `d.d()`, media `d.e()`):

**Đủ ~26 action** (đọc `entity/d.java`, hàm `c(context, dVar)`):

| `action` (d.a()) | Ý nghĩa | Đích / hành vi |
|------------------|---------|----------------|
| `viewme` + `comment` | Xem bình luận trên Me | `OlaMeCommentActivity(id=d.b())` |
| `viewme` + `homepage` | Mở trang cá nhân | `me.c.a(..., d.b())` |
| `viewmedia` | Xem media | `OlaImageViewerActivity` |
| `openphoto` | Xem ảnh | `OlaImageViewerActivity` |
| `openaudio` / `openvideo` | Mở audio/video | trình phát tương ứng |
| `chatto` | Mở hội thoại 1-1 | `OlaChatViewActivity(nick=d.b())` |
| `replyto` | Trả lời nhanh | khung chat/reply |
| `viewbox` / `viewproposalrequest` / `viewproposallist` | Hộp/danh sách cầu hôn | màn Box - Kết hôn |
| `checkin` + `venue` | Mở địa điểm check-in | `OlaVenueDetailActivity` |
| `vip` | Mua VIP | `BuyVipActivity` |
| `postme` | Soạn bài Me | `OlaMeComposerActivity` |
| `like` / `likeadme` | Gửi like (Me / quảng cáo) | gọi API like |
| `rss` | Mở RSS | tab RSS |
| `wap` | Mở web (có thể tính phí) | web in-app/ngoài; `d.j`≠rỗng → dialog xác nhận trả phí |
| `webapp` | Mở web-app | `m.m.a(...)` |
| `call` (`CATEGORY_CALL`) | Quay số | trình gọi điện |
| `sms` / `message` (`CATEGORY_MESSAGE`) | Nhắn tin | trình SMS / chat |
| `app` / `dpk` / `xt` | Mở ứng dụng/đối tác | handler tương ứng |
| `copy` / `delme` | Copy / xoá | thao tác nội bộ |

> **Hai tầng "loại" — đây là lý do nhìn tưởng ít:**
> 1. **`appCode` (j.f)** chỉ quyết định **icon + nút** trong list. Server gửi string tự do (tag 113); client **chỉ gán icon cho 6** giá trị (`3`,`1`,`1.4`,`3.1`,`2`+proposal/divorce). **Mọi appCode khác → dòng generic** (avatar + chữ + giờ, không icon) — backend mở rộng bao nhiêu loại cũng được.
> 2. **`action` (entity.d, tag 111)** mới là phần **đa dạng thật** (~26 ở trên) — quyết định chạm vào đi đâu, **độc lập** với appCode.
> ⇒ Một notification = **appCode (hình) + actions[] (hành vi)**; số "loại chức năng" là tổ hợp 2 tầng, không phải 6.

### 7.4. Quy tắc hiển thị (tóm tắt để khớp backend ↔ UI)
- `appCode` quyết định **icon nhỏ** + **có nút hay không** (xem §1 view type). Lưu ý nhánh `f="2"` proposal/divorce **không vẽ icon** (bug bind), proposal có 2 nút Đồng ý/Không, divorce không nút.
- `senderId` rỗng → ẩn dòng tên + avatar dùng `ic_contact_photo`.
- `timestamp` cần chính xác (ms) vì vừa làm nhãn thời gian vừa làm **con trỏ phân trang**.
- Empty state ("Không có thông báo") hiện khi trang đầu trả mảng rỗng/null.
