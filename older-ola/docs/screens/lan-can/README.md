# Màn hình Lân cận (Địa điểm lân cận / Check-in)

- **Fragment:** `chat.ola.vn.m.i` (vị trí số **13** trong `OlaBottomTabActivity`; mở qua `OlaBottomTabActivity.a(activity, 13)`)
- **Layout:** `apktool_out/res/layout/check_in_nearby_vernues_activity_layout.xml`
  - Item dòng: `apktool_out/res/layout/check_in_item_layout.xml`
  - Action bar (include): `apktool_out/res/layout/ola_top_icon_action_bar_layout.xml`
- **Chức năng:** hiển thị **danh sách các địa điểm (venue) gần vị trí GPS hiện tại** để người dùng check-in. Mỗi dòng là 1 `OlaVenueEntity` (ảnh, tên, khoảng cách, số lượt ghé thăm, địa chỉ). Bấm 1 dòng → mở **chi tiết địa điểm** (`OlaVenueDetailActivity`). Trước khi vào màn, app **bắt buộc lấy được vị trí GPS** (xem luồng GPS ở mục 4).

## Ảnh chụp

chưa có ảnh chụp

### Assets dùng trong màn (ảnh gốc trích từ APK)

| Asset | Ảnh | Dùng cho |
|-------|-----|----------|
| `ic_check_in` | ![check-in](images/ic_check_in.png) | Icon trên action bar (bên trái tiêu đề) |
| `ic_action_quit` | ![quit](images/ic_action_quit.png) | Nút `×` đóng màn (góc phải action bar) |
| `ic_check_in_gray` | ![placeholder](images/ic_check_in_gray.png) | Ảnh placeholder của avatar địa điểm khi ảnh thật chưa tải xong |
| `ic_arrow_right` | ![arrow](images/ic_arrow_right.png) | Mũi tên `›` cuối mỗi dòng (nút mở chi tiết `btnDetail`) |

> `ic_action_back` (mũi tên quay lại) có khai báo trong action bar nhưng **luôn ẩn** ở màn này (xem mục 1). Nền action bar `bg_action_bar` là khối màu xanh `#7CB342` (`colorOlaPrimary`) kèm dải đổ bóng mỏng 1px ở đáy — không phải file ảnh nên không trích.

---

## 1. Bố cục (top → bottom)

```
FrameLayout (match_parent, nền trong suốt)
├─ ListView  lvCheckInItems                         ← danh sách địa điểm
│     • paddingTop 42dp (chừa chỗ cho action bar)
│     • divider = div_check_in_list (gạch xám #E6E6E6, dày 1dp, thụt 2 bên 8dp, bo góc 2dp)
│     • scrollbars=none, cacheColorHint=trong suốt
│     • mỗi dòng = check_in_item_layout (chỉ 1 view type — xem bảng dưới)
│
├─ include ola_top_icon_action_bar_layout           ← thanh tiêu đề nổi LÊN TRÊN ListView
│   (LinearLayout ngang, nền xanh #7CB342, cao theo nội dung, padding ngang 8dp)
│   ├─ ImageView olaActionBarBackImageView   ẩn (visibility=gone) — không dùng ở màn này
│   ├─ OlaCachedImageView olaActionBarIconImageView   ← icon ic_check_in (set trong code)
│   ├─ TextView olaActionBarTitleTextView    ← "Địa điểm lân cận" (weight=1, chữ trắng 14sp bold)
│   ├─ ImageView olaActionBarButtonImageView  ẩn (visibility=gone)
│   └─ ImageView olaActionBarCloseButtonImageView   ← nút × ic_action_quit (set VISIBLE trong code)
│
└─ ProgressBar progressBar                          ← spinner GIỮA màn, 48×48dp
      • visibility=invisible mặc định; HIỆN khi đang tải danh sách, ẨN khi tải xong
```

> Action bar được `include` **sau** ListView trong cùng `FrameLayout` nên luôn vẽ đè lên đầu list; ListView bù `paddingTop=42dp` để dòng đầu không bị che.

### Các loại dòng & view type

Đây là **ListView 1 view type duy nhất** (adapter `chat.ola.vn.b.p` kế thừa `chat.ola.vn.b.j`, không override `getViewTypeCount`/`getItemViewType` → mặc định 1 type). Không có header, không có section, không có dòng quảng cáo.

| View type | Builder/Holder | Layout | Vai trò | Hiện khi |
|-----------|----------------|--------|---------|----------|
| (mặc định, duy nhất) | `chat.ola.vn.b.p.b` (inner holder) | `check_in_item_layout.xml` | 1 địa điểm: avatar + tên + khoảng cách + số ghé thăm + địa chỉ + mũi tên | Mỗi phần tử trong danh sách `OlaVenueEntity` trả về từ server |

> Adapter `p` có sẵn `Filter` (lọc theo tên địa điểm, `performFiltering`) và 2 setter long-click (`a(OnLongClickListener)` ở cả adapter lẫn holder) nhưng **màn này KHÔNG dùng**: fragment `i` không gọi `getFilter()` và không truyền `OnLongClickListener` nào — nên **không có ô search và không có long-press** ở màn Lân cận.

## 2. Bảng style chi tiết từng phần

| Thành phần | id | Màu chữ / nền | Cỡ chữ | Kích thước / khoảng cách | Ghi chú (điều kiện ẩn/hiện) |
|------------|----|----|--------|--------------------------|------------------------------|
| Container | (FrameLayout) | nền trong suốt | — | match_parent | — |
| Danh sách | `lvCheckInItems` | cacheColorHint trong suốt | — | paddingTop 42dp; divider 1dp `#E6E6E6` | luôn hiện; nạp dữ liệu qua adapter |
| Action bar | `olaTopActionBarViewLayout` | nền `#7CB342` (`colorOlaPrimary`) + bóng đáy 1px | — | padding ngang 8dp, gravity center_vertical | nổi trên ListView |
| Nút back | `olaActionBarBackImageView` | — | — | wrap, marginRight 2dp | **ẩn** (`visibility=gone` cố định) |
| Icon tiêu đề | `olaActionBarIconImageView` | — | — | padding T/B 8dp, cao match_parent | `setImageResource(ic_check_in)` trong code |
| Tiêu đề | `olaActionBarTitleTextView` | chữ `#FFFFFF` (`colorTextWhitePrimary`) | 14sp **bold** (`defaultStyle.text.button`) | weight=1, marginLeft 8dp, maxLines 1, ellipsize end | text = "Địa điểm lân cận" (`string_check_in_nearby_venues`) |
| Nút phụ phải | `olaActionBarButtonImageView` | — | — | 48dp, padding 8dp | **ẩn** (`visibility=gone` cố định) |
| Nút đóng × | `olaActionBarCloseButtonImageView` | — | — | wrap, padding 8dp, cao match_parent | `ic_action_quit`; code set **VISIBLE** + gắn click |
| Spinner | `progressBar` | (style `defaultStyle.progresswatting`) | — | 48×48dp, layout_gravity center | **invisible** mặc định; VISIBLE khi đang tải, GONE khi xong |
| — Dòng item — | `vLinearCheckInItem` | nền **trắng** `#FFFFFF` (`white`) | — | padding 16dp, ngang | clickable qua vùng `vLinearCheckInInfo` |
| Avatar địa điểm | `imgCheckInAvatar` | nền `bg_shadown_border` (khung viền + bóng) | — | 64×64dp, gravity center_vertical, scale centerCrop | tải ảnh `venue.f()`; placeholder `ic_check_in_gray` |
| Khối thông tin | `vLinearCheckInInfo` | — | — | width 0 weight=1, marginLeft 8dp | vùng nhận click → mở chi tiết |
| Tên địa điểm | `txtPlaceName` | `#de000000` (`colorTextBlackPrimary`) | 16sp normal (`defaultStyle.text.subhead`) | maxLines 1, ellipsize end | `venue.c()` |
| Nhãn "Cách:" | `txtDistanceHint` | `#a29f9f` (`text_color_1`) | 14sp (`text.size.body1`) | marginRight 4dp | text tĩnh `string_distance`; **ẩn (GONE) khi khoảng cách rỗng**, hiện khi có |
| Khoảng cách | `txtPlaceDistanceInfo` | `#add6f6` (xanh nhạt, inline) | 14sp | marginRight 4dp | `venue.h()` (vd "1.2 km") |
| Số ghé thăm | `txtAmountPepleCheckedInfo` | (mặc định) | 14sp | width 0 weight=1, maxLines 1 | "(N Ghé thăm)" **khi `venue.i() > 0`**; chuỗi **rỗng** khi = 0 |
| Địa chỉ | `txtPlaceAddress` | (mặc định) | 12sp **nghiêng** (`text.size.caption`, italic) | maxLines 1, ellipsize end, gravity bottom | `venue.e()` |
| Mũi tên chi tiết | `btnDetail` | — | — | cao match_parent, padding ngang 4dp | `ic_arrow_right`; vùng click → mở chi tiết |

## 3. CSS tương đương (dựng lại trên web)

```css
/* ===== Khung màn ===== */
.nearby {
  position: relative;
  min-height: 100vh;
  background: transparent;
  font-family: Roboto, "Helvetica Neue", Arial, sans-serif;
}

/* Action bar nổi trên cùng */
.nearby__bar {
  position: sticky; top: 0; z-index: 2;
  display: flex; align-items: center;
  padding: 0 8px;
  height: 42px;
  background: #7CB342;                 /* colorOlaPrimary */
  box-shadow: 0 1px 0 rgba(0,0,0,.08); /* bg_action_bar: dải bóng đáy 1px */
}
.nearby__bar-icon { height: 100%; padding: 8px 0; box-sizing: border-box; }
.nearby__bar-title {
  flex: 1; margin-left: 8px;
  color: #FFFFFF;                      /* colorTextWhitePrimary */
  font-size: 14px; font-weight: 700;   /* defaultStyle.text.button */
  white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
}
.nearby__bar-close { padding: 8px; cursor: pointer; }

/* ===== Danh sách ===== */
.nearby__list { padding-top: 0; }      /* trên web không cần bù 42dp vì bar sticky */
.nearby__item {
  display: flex; align-items: stretch;
  background: #FFFFFF;                  /* white */
  padding: 16px;
  border-bottom: 1px solid #E6E6E6;    /* div_check_in_list */
  margin: 0 8px;                        /* divider thụt 2 bên 8dp */
  cursor: pointer;
}
.nearby__avatar {
  width: 64px; height: 64px;
  align-self: center;
  object-fit: cover;
  /* bg_shadown_border: khung viền trắng + bóng */
  box-shadow: 0 1px 3px rgba(0,0,0,.24); border: 1px solid #fff;
}
.nearby__info { flex: 1; margin-left: 8px; display: flex; flex-direction: column; }
.nearby__name {
  color: rgba(0,0,0,.87);              /* colorTextBlackPrimary #de000000 */
  font-size: 16px;
  white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
}
.nearby__meta { display: flex; align-items: center; flex: 1; }
.nearby__meta .hint  { color: #a29f9f; font-size: 14px; margin-right: 4px; } /* text_color_1; ẩn nếu rỗng */
.nearby__meta .dist  { color: #add6f6; font-size: 14px; margin-right: 4px; }
.nearby__meta .count { font-size: 14px; flex: 1; white-space: nowrap;
                       overflow: hidden; text-overflow: ellipsis; }
.nearby__addr {
  font-size: 12px; font-style: italic;
  align-self: flex-start;
  white-space: nowrap; overflow: hidden; text-overflow: ellipsis;
}
.nearby__arrow { align-self: stretch; display: flex; align-items: center; padding: 0 4px; }

/* ===== Spinner giữa màn ===== */
.nearby__spinner {
  position: absolute; inset: 0; margin: auto;
  width: 48px; height: 48px;
  display: none;                       /* invisible mặc định; bật khi đang tải */
}
```

```html
<div class="nearby">
  <div class="nearby__bar">
    <img class="nearby__bar-icon" src="images/ic_check_in.png">
    <span class="nearby__bar-title">Địa điểm lân cận</span>
    <img class="nearby__bar-close" src="images/ic_action_quit.png">
  </div>

  <div class="nearby__list">
    <div class="nearby__item">
      <img class="nearby__avatar" src="images/ic_check_in_gray.png">
      <div class="nearby__info">
        <div class="nearby__name">Quán Cà phê ABC</div>
        <div class="nearby__meta">
          <span class="hint">Cách:</span>
          <span class="dist">1.2 km</span>
          <span class="count">(12 Ghé thăm)</span>
        </div>
        <div class="nearby__addr">123 Nguyễn Huệ, Q.1, TP.HCM</div>
      </div>
      <div class="nearby__arrow"><img src="images/ic_arrow_right.png"></div>
    </div>
  </div>
</div>
```

## 4. Hành vi & luồng

### 4.1. Luồng GPS TRƯỚC khi vào màn (từ tab Ứng dụng, `chat.ola.vn.m.d.onItemClick`)

Bấm shortcut **"Lân cận"** (`general_tab_nearby_places`) trong tab Ứng dụng chạy nhánh `case R.string.general_tab_nearby_places`:

1. **Kiểm tra quyền vị trí** `n.b.b(activity)`: API < 23 luôn `true`; API ≥ 23 cần `ACCESS_FINE_LOCATION` **hoặc** `ACCESS_COARSE_LOCATION` đã cấp.
   - **Chưa có quyền** → `n.b.a(activity, 0)` xin runtime permission (req 0) rồi `return` (chưa vào màn).
2. **Có quyền** → tạo dialog tiến trình `chat.ola.vn.i.c` với nội dung `message_getting_location` ("Đang xác định vị trí hiện tại của bạn") và gọi `n.b.a(activity, 10000L, callback)` để lấy vị trí (timeout 10s).
3. Các callback của `n.b.InterfaceC0042b`:
   - `a(lat, lng, acc)` (**lấy được vị trí**) → đóng dialog → `OlaBottomTabActivity.a(activity, 13)` = **mở fragment Lân cận** (`m.i`).
   - `k_()` (đang chờ/cập nhật) → gia hạn dialog thêm 30s (`e.a(30000L, null)`).
   - `j_()` (**không lấy được vị trí**, đã hết giờ) → đóng dialog + dialog lỗi `dialog_title_fail` / `message_not_yet_get_location` ("Chưa xác định vị trí hiện tại của bạn").
   - `l_()` (**GPS/định vị đang TẮT**) → đóng dialog + mở **dialog bật GPS** (xem Modal #2 dưới).

> Lưu ý: trong file `chat.ola.vn.i.i` còn 1 dialog GPS khác `e(context)` (tiêu đề `string_turn_on_location_services`, nút `string_setup`/`string_cancel`) — đây là helper dùng chung ở các màn vị trí khác, **không** phải dialog mà luồng Lân cận gọi (luồng Lân cận gọi `i.a(...)` với bộ string GPS riêng — xem Modal #2).

### 4.2. Khởi tạo fragment `m.i` (`onCreateView` → `a(view)` + `d()`)

- `a(view)`: ánh xạ `lvCheckInItems`, `progressBar`; set icon action bar `ic_check_in`, tiêu đề `string_check_in_nearby_venues`; set nút đóng `ic_action_quit` **VISIBLE** + click listener.
- `d()`: đọc toạ độ đã cache `lat = n.c.a().b()`, `lng = n.c.a().c()`; gọi `a(lat, lng, f)` với `f = 0` (trang đầu) để **tải danh sách**; tạo adapter `chat.ola.vn.b.p`, gắn `OnClickListener` (chính fragment) + callback paging (`j.a`), `setAdapter`.
- `a(lat, lng, page)`: nếu lat/lng **không rỗng** → hiện spinner `a(true)` + gọi `OlaApplication.b.a(null, lat, lng, page, this)` (yêu cầu server qua socket). Nếu rỗng → ẩn spinner (`a(false)`), không tải.

### 4.3. Nhận dữ liệu & load-more

- Callback `b(List<OlaVenueEntity> list, int next)`:
  - `f == 0` (trang đầu): thay toàn bộ danh sách.
  - `f > 0` (trang sau): **nối thêm** vào danh sách hiện có.
  - Cập nhật adapter (`c.a(list)` + `notifyDataSetChanged`), lưu con trỏ trang kế `f = next`, ẩn spinner.
- **Load-more tự động (vô hạn):** base adapter `j.getView()` gọi `a(position)` — khi cuộn tới dòng cách cuối **≤ 5 dòng** và `B()` trả `true` (tức `f > 0`, còn trang kế) thì gọi `a_(lastIndex)` → fragment gọi lại `a(lat, lng, f)` tải tiếp. **Không có nút "Tải thêm" tường minh** — hoàn toàn theo cuộn.

### 4.4. Trạng thái rỗng / loading

- **Loading:** `progressBar` hiện giữa màn khi đang gọi server (`a(true)`), ẩn khi có phản hồi `b(...)` hoặc khi lat/lng rỗng.
- **Rỗng:** **không có view "danh sách trống" riêng** — nếu server trả list rỗng thì ListView chỉ đơn giản không có dòng nào (màn trắng + action bar).

### 4.5. Bảng tương tác (mọi cử chỉ)

| Thành phần | Cử chỉ | Hành vi | Loại |
|------------|--------|---------|------|
| Nút đóng × `olaActionBarCloseButtonImageView` | click | `a().d(c())` = đóng fragment Lân cận (gỡ vị trí 13 khỏi `OlaBottomTabActivity`) | nội bộ |
| Vùng thông tin dòng `vLinearCheckInInfo` | click | Mở **chi tiết địa điểm** `OlaVenueDetailActivity` với `venue.b()` (id) + hiệu ứng push_left | sang màn khác |
| Mũi tên `btnDetail` | click | (như trên) mở `OlaVenueDetailActivity` | sang màn khác |
| Avatar `imgCheckInAvatar` / tên / địa chỉ | click | **Không có click riêng** — chỉ vùng `vLinearCheckInInfo` và `btnDetail` được gắn listener; bấm vùng còn lại của dòng không làm gì | — |
| Bất kỳ dòng nào | **long-press** | **Không có** — fragment không gắn `OnItemLongClickListener`, holder không nhận `OnLongClickListener` | — |
| ListView | cuộn gần cuối (≤5 dòng) | **Load-more** tự động trang kế (mục 4.3) | nội bộ |
| Phím Back | (mặc định `OlaBottomTabActivity`) | quay lại tab trước | nội bộ |

> `onClick` của fragment chỉ phân nhánh 3 id: `btnDetail` và `vLinearCheckInInfo` → mở chi tiết; `olaActionBarCloseButtonImageView` → đóng màn. Các id khác bị bỏ qua.

### Modal/Dialog/Menu trong màn (chi tiết)

1. **Dialog "Đang lấy vị trí"** (`chat.ola.vn.i.c`, hiển thị TRƯỚC khi vào màn, từ `m.d`):
   - Nội dung: `message_getting_location` — EN "Locating your position" / VI "Đang xác định vị trí hiện tại của bạn".
   - Không có nút bấm; tự đóng khi lấy được vị trí, hoặc gia hạn 30s khi đang cập nhật. Không huỷ được khi chạm ra ngoài.

2. **Dialog "Bật GPS"** (mở khi callback `l_()` — định vị đang tắt; `i.a(ctx, title, msg, pos, neg, listener)` → dialog kiểu `e`):
   - **Tiêu đề:** `message_location_provider_gps_unavailable_title` — EN "GPS Setting" / VI "Cài đặt GPS".
   - **Nội dung:** `message_location_provider_unavailable` — EN "Cannot get your GPS location. You need to turn ON GPS and choose HIGH ACCURACY mode on your device" / VI "Không thể xác định vị trí. Bạn cần BẬT định vị GPS và chọn mục ĐỘ CHÍNH XÁC CAO trên thiết bị của bạn".
   - **Nút trái (index 0)** `string_turn_on_gps` — EN "Turn on GPS" / VI "Bật GPS" → mở màn cài đặt định vị hệ thống `Intent("android.settings.LOCATION_SOURCE_SETTINGS")` rồi đóng dialog.
   - **Nút phải** `string_close` — EN "Close" / VI "Đóng" → chỉ đóng dialog.

3. **Dialog "Chưa xác định được vị trí"** (mở khi callback `j_()` — hết giờ không lấy được vị trí):
   - **Tiêu đề:** `dialog_title_fail` — EN "Error" / VI "Lỗi hệ thống".
   - **Nội dung:** `message_not_yet_get_location` — EN "Your location service is not available" / VI "Chưa xác định vị trí hiện tại của bạn".
   - 1 nút **Đóng** (`string_close`) mặc định của dialog `e`.

> Trong **chính** fragment `m.i` không tự mở modal/menu nào (mọi dialog thuộc bước GPS trước khi vào màn).

### 4.6. Đối chiếu bản web

Chưa thấy trang tương ứng trong `web/src/pages/` (web hiện tập trung chat/room, chưa dựng tính năng check-in địa điểm). Không có điểm đối chiếu.

## 5. Strings (đa ngôn ngữ)

| Resource | EN (`values/strings.xml`) | VI (`values-vi/strings.xml`) |
|----------|---------------------------|------------------------------|
| `general_tab_nearby_places` | Nearby places | Lân cận |
| `string_check_in_nearby_venues` | Nearby places | Địa điểm lân cận |
| `string_distance` | Distance: | Cách: |
| `string_checkins` | Check-ins | Ghé thăm |
| `message_getting_location` | Locating your position | Đang xác định vị trí hiện tại của bạn |
| `message_not_yet_get_location` | Your location service is not available | Chưa xác định vị trí hiện tại của bạn |
| `message_location_provider_gps_unavailable_title` | GPS Setting | Cài đặt GPS |
| `message_location_provider_unavailable` | Cannot get your GPS location. You need to turn ON GPS and choose HIGH ACCURACY mode on your device | Không thể xác định vị trí. Bạn cần BẬT định vị GPS và chọn mục ĐỘ CHÍNH XÁC CAO trên thiết bị của bạn |
| `string_turn_on_gps` | Turn on GPS | Bật GPS |
| `string_close` | Close | Đóng |
| `dialog_title_fail` | Error | Lỗi hệ thống |
| `string_turn_on_location_services` *(helper khác)* | Turn on Location Services | Bật dịch vụ xác định vị trí |
| `string_to_use_this_feature_location_services_must_be_on` *(helper khác)* | To use this feature, location services must be on | Bạn cần bật dịch vụ xác định vị trí để sử dụng tính năng này! |
| `string_setup` *(helper khác)* | Settings | Cài đặt |
| `string_cancel` *(helper khác)* | Cancel | Huỷ |

## 6. Màn mở ra từ đây (điều hướng)

| Từ (nút/cử chỉ) | Màn đích (class) | Doc |
|-----------------|------------------|-----|
| Click dòng (vùng info) / mũi tên `btnDetail` | `chat.ola.vn.checkin.OlaVenueDetailActivity` (chi tiết địa điểm) | (chưa có doc — cần làm) |
| Nút **Bật GPS** trong dialog "Bật GPS" | Màn cài đặt định vị hệ thống (`android.settings.LOCATION_SOURCE_SETTINGS`) | (hệ thống) |
| Nút đóng × | (đóng fragment, quay lại tab Ứng dụng) | [../ung-dung/README.md](../ung-dung/README.md) |
