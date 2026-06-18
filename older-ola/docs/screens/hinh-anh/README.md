# Màn hình Hình Ảnh (Kho ảnh cloud — danh sách album)

- **Activity:** `chat.ola.vn.cloud.OlaCloudAlbumListActivity`
- **Layout:** `apktool_out/res/layout/ola_cloud_album_list_layout.xml` (+ item `ola_cloud_album_layout.xml`, action bar `ola_top_action_bar_layout.xml`)
- **Chức năng:** lưới (grid) 3 cột hiển thị các **album ảnh trên cloud** của tài khoản (kho ảnh của chính mình hoặc của một người khác). Bấm 1 album để xem ảnh; với kho ảnh của mình còn cho **chọn nhiều album để xoá** (long-press để vào chế độ chọn).

> Mở từ tab **Ứng dụng** (`general_tab_mediastore` = "Hình Ảnh") — fragment `m/d.java` (dòng 98) gọi `OlaCloudAlbumListActivity.a(getActivity())` (mở kho ảnh của chính mình, `e = null`). Cũng được mở từ Trang cá nhân `me.OlaUserMePageActivity` và `q/b`, `i/k` với tham số `e` = id người khác (xem kho ảnh người đó).

## Ảnh chụp

Chưa có ảnh chụp.

### Assets dùng trong màn (ảnh gốc trích từ APK)

| Asset | Ảnh | Dùng cho |
|-------|-----|----------|
| `ic_action_back` | ![back](images/ic_action_back.png) | Nút quay lại trên action bar |
| `ic_checked` | ![checked](images/ic_checked.png) | Dấu tick góc phải-trên ô album khi được chọn (chế độ xoá) |
| `frame_overlay_gallery_folder` | ![folder](images/frame_overlay_gallery_folder.png) | Icon thư mục bên trái badge "số ảnh" ở đáy ô |
| `ic_indicate_media_cloud` | ![cloud](images/ic_indicate_media_cloud.png) | Badge cho album cloud thường (drawableLeft của số đếm) |
| `ic_indicate_privacy_public` | ![public](images/ic_indicate_privacy_public.png) | Badge album cờ quyền riêng tư = **Công khai** |
| `ic_indicate_privacy_friends` | ![friends](images/ic_indicate_privacy_friends.png) | Badge album quyền riêng tư = **Bạn bè** |
| `ic_indicate_privacy_private` | ![private](images/ic_indicate_privacy_private.png) | Badge album quyền riêng tư = **Riêng tư** |
| `ic_media_photo` | ![photo](images/ic_media_photo.png) | Ảnh thay thế (placeholder) khi cover là ảnh đang tải |
| `ic_media_video` | ![video](images/ic_media_video.png) | Ảnh thay thế khi cover là video |
| `ic_media_sound` | ![sound](images/ic_media_sound.png) | Ảnh thay thế khi cover là âm thanh |

> `bg_action_bar`, `bg_cell_item_selector`, `bg_shadown_border` là drawable XML (selector/9-patch), không phải bitmap — không copy.

---

## 1. Bố cục (top → bottom)

```
FrameLayout (nền trắng #FFFFFF, full màn)
├─ GridView  albumGridView          3 cột, full màn
│     padding: trái/phải 8dp, TRÊN 56dp (chừa chỗ action bar), dưới 16dp; clipToPadding=false
│     spacing: ngang 4dp, dọc 8dp; không divider, không scrollbar (style list.noDivider)
│     └─ [mỗi ô] item ola_cloud_album_layout (xem "Các loại dòng & view type")
│
├─ FrameLayout  wattingProgressBar   OVERLAY LOADING — nền đen 38% (#61000000), full màn
│     │                              visibility=gone (ẩn mặc định); clickable=true (chặn chạm)
│     └─ ProgressBar 48×48dp, canh giữa
│
└─ include ola_top_action_bar_layout  ACTION BAR (vẽ đè lên trên cùng, cao 48dp)
      nền @drawable/bg_action_bar (xanh), padding ngang 8dp, padding dưới 6dp
      ├─ olaActionBarBackViewLayout   FrameLayout — vùng nút Back
      │     ├─ ImageView ic_action_back (mũi tên trái)
      │     └─ olaActionBarBackNotificationTextView  (badge số chưa đọc — GONE, không dùng ở màn này)
      ├─ olaActionBarTitleViewLayout  LinearLayout vertical, weight=1
      │     ├─ olaActionBarTitleTextView     tiêu đề, chữ trắng 14sp bold
      │     └─ olaActionBarSubTitleTextView  phụ đề (GONE — không dùng)
      ├─ olaActionBarButtonTextView   "Xoá (n)" — chữ trắng 14sp bold; GONE mặc định
      ├─ olaActionBarButtonImageView  (GONE — không dùng)
      └─ olaActionBarMoreButtonImageView (GONE — không dùng)
```

**View ẩn / theo điều kiện:**
- `wattingProgressBar`: **gone** mặc định; bật `VISIBLE` khi đang gọi mạng nạp album (`c(true)`), tắt khi xong/lỗi/timeout (`c(false)`). Có timeout **30 giây** → tự ẩn + dialog "Hết thời gian thực thi".
- `olaActionBarButtonTextView` ("Xoá"): set `GONE` ngay trong `F()`; chỉ `VISIBLE` khi **đang ở chế độ chọn** và là **kho ảnh của mình** (xem mục 4).
- `olaActionBarSubTitleTextView`, `olaActionBarBackNotificationTextView`, `olaActionBarButtonImageView`, `olaActionBarMoreButtonImageView`: `gone` cố định trong XML, màn này không bật.

### Các loại dòng & view type

Adapter `chat.ola.vn.cloud.a` (extends `chat.ola.vn.b.j<l>`, BaseAdapter) — **chỉ 1 view type** (`getViewTypeCount()` = 1, `getItemViewType()` = 0). Mỗi item là 1 album (`chat.ola.vn.entity.l`).

| View type | Holder | Layout | Vai trò | Hiện khi |
|-----------|--------|--------|---------|----------|
| 0 (duy nhất) | `a.C0026a` | `ola_cloud_album_layout.xml` | 1 ô album: cover vuông + tên + badge số ảnh/cờ quyền + tick chọn | Luôn — mỗi phần tử trong list `d` |

**Cấu trúc 1 ô album** (`ola_cloud_album_layout.xml`):

```
LinearLayout vertical, gravity=center, paddingBottom 4dp
├─ FrameLayout  cloudAlbumViewLayout    nền bg_shadown_border (khung viền+bóng),
│   │                                   foreground bg_cell_item_selector (hiệu ứng nhấn/selected)
│   ├─ OlaRatioImageView cloudAlbumCoverImageView  ẢNH BÌA — match_parent, tỉ lệ 1:1 (ratio=1.0),
│   │                                              scaleType=centerCrop (placeholder: centerInside)
│   ├─ TextView cloudAlbumChildCountTextView  BADGE đáy — số ảnh, chữ trắng 12sp,
│   │                                         nền đen 38%, drawableLeft = icon cờ/thư mục
│   └─ ImageView cloudAlbumCheckImageView     TICK ic_checked góc phải-trên — GONE mặc định
└─ TextView cloudAlbumNameTextView      TÊN album, 14sp bold, 1 dòng ellipsize=end, canh giữa
```

**Hàm dựng & sắp xếp mảng** (`a.a(List)` / `a.b(List)` → `g()`): danh sách album được **sắp xếp** bởi comparator (`a.1`): album "đặc biệt" (`l.a()` trả true — loại `i ∈ {1,2,3,5}`, vd album hệ thống / clan) đẩy lên trước; còn lại sắp theo `l.i` tăng dần. Mỗi lần nhận thêm trang (`a()`) thì `addAll` rồi sort lại; nạp mới (`b()`) thì thay toàn bộ.

**Logic bind từng ô** (`a.C0026a.a()`):
- **Tick chọn** `cloudAlbumCheckImageView`: `VISIBLE` khi `l.k == true` (album đang được chọn) — đồng thời `cloudAlbumViewLayout.setSelected(true)`; ngược lại `GONE` + `setSelected(false)`.
- **Ảnh bìa** `cloudAlbumCoverImageView`:
  - cover (`l.c`) bắt đầu bằng `http` → tải ảnh thật từ server (kích thước = bề rộng màn `e.c / 3`).
  - cover là id media nội bộ → phân loại theo ký tự thứ 2 của id (`entity.i.i()`): `P`→placeholder **ic_media_photo**, `V`→**ic_media_video**, `S`→**ic_media_sound** (scaleType=centerInside).
  - cover rỗng → xoá ảnh (ô trống).
- **Badge số ảnh** `cloudAlbumChildCountTextView`:
  - `l.g > 0` (có số ảnh) → `VISIBLE`, hiện số đã format (vd "1.2K").
  - album đặc biệt (`l.a()`=true) mà `g==0` → **GONE** (ẩn badge).
  - còn lại → `VISIBLE` nhưng text rỗng (chỉ hiện icon cờ).
  - **Icon cờ (drawableLeft) của badge** theo `l.i` / `l.j`:
    - `l.i == 0` → theo `l.j` (quyền riêng tư): `0`→**ic_indicate_privacy_public** (Công khai), `1`→**ic_indicate_privacy_friends** (Bạn bè), `2`→**ic_indicate_privacy_private** (Riêng tư).
    - `l.i == 5` (album gallery/clan) → **không icon** (xoá drawable).
    - khác → **ic_indicate_media_cloud** (album cloud thường).
- **Tên** `cloudAlbumNameTextView` = `l.a`.

---

## 2. Bảng style chi tiết từng phần

| Thành phần | id | Màu chữ / nền | Cỡ chữ | Kích thước / khoảng cách | Ghi chú (điều kiện) |
|------------|----|----|--------|--------------------------|---------|
| Nền màn | (FrameLayout gốc) | nền `#FFFFFF` (`white`) | — | full màn | — |
| Lưới album | `albumGridView` | trong suốt | — | 3 cột; pad T 56dp, L/R 8dp, B 16dp; spacing 4dp×8dp | style `defaultStyle.list.noDivider` (không divider/scrollbar) |
| Ô album (khung) | `cloudAlbumViewLayout` | nền `bg_shadown_border` | — | vuông (ratio 1:1) | foreground `bg_cell_item_selector` (ripple + trạng thái selected) |
| Ảnh bìa | `cloudAlbumCoverImageView` | — | — | match_parent, tỉ lệ 1:1 | `OlaRatioImageView` setRatio(1.0); centerCrop / centerInside cho placeholder |
| Badge số ảnh | `cloudAlbumChildCountTextView` | chữ `#FFFFFF`, nền `#61000000` (đen 38%) | 12sp (`text.size.caption`) | padding 4dp, drawablePadding 4dp, canh đáy | drawableLeft = icon cờ; ẩn nếu album đặc biệt & g==0 |
| Tick chọn | `cloudAlbumCheckImageView` | — | — | góc phải-trên, margin T/R 4dp | `ic_checked`; **GONE** trừ khi `l.k==true` |
| Tên album | `cloudAlbumNameTextView` | chữ `#000000DE` (`colorTextBlackPrimary`) | 14sp bold (`text.size.button`) | padding 2dp, 1 dòng, canh giữa | style `defaultStyle.text.button` |
| Overlay loading | `wattingProgressBar` | nền `#61000000` (đen 38%) | — | full màn, spinner 48dp giữa | **GONE** mặc định; bật khi nạp mạng; clickable chặn chạm |
| Action bar | `olaTopActionBarViewLayout` | nền `bg_action_bar` (xanh) | — | cao 48dp, pad L/R 8dp, B 6dp | include, vẽ đè lên grid |
| Nút Back | `olaActionBarBackViewLayout` | — | — | wrap × cao 48dp | `ic_action_back` |
| Tiêu đề | `olaActionBarTitleTextView` | chữ `#FFFFFF` (`colorTextWhitePrimary`) | 14sp bold | weight=1, marginLeft 8dp, 1 dòng | text = tên kho (xem 4.1) |
| Nút "Xoá (n)" | `olaActionBarButtonTextView` | chữ `#FFFFFF` | 14sp bold | minWidth 48dp, padding 8dp | **GONE** trừ chế độ chọn + kho của mình |

## 3. CSS tương đương (dựng lại trên web)

```css
.cloud-albums {
  position: relative;
  min-height: 100vh;
  background: #FFFFFF;
}
/* Action bar đè trên cùng */
.cloud-albums__bar {
  position: absolute; top: 0; left: 0; right: 0;
  height: 48px; display: flex; align-items: center;
  padding: 0 8px 6px; background: #7CB342;       /* bg_action_bar (xanh Ola) */
  color: #FFFFFF; box-sizing: border-box; z-index: 2;
}
.cloud-albums__bar .title { flex: 1; margin-left: 8px; font-size: 14px; font-weight: 700; }
.cloud-albums__bar .delete { display: none; min-width: 48px; padding: 8px; font-size: 14px; font-weight: 700; }
.cloud-albums.is-selecting .cloud-albums__bar .delete { display: inline-block; } /* chế độ chọn + kho của mình */

/* Lưới 3 cột */
.cloud-albums__grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 8px 4px;                                   /* dọc 8 / ngang 4 */
  padding: 56px 8px 16px;                          /* chừa action bar 56px */
}

/* 1 ô album */
.album {
  display: flex; flex-direction: column; align-items: center;
  padding-bottom: 4px;
}
.album__cover {
  position: relative; width: 100%; aspect-ratio: 1 / 1;
  border: 1px solid rgba(0,0,0,.12);
  box-shadow: 0 1px 3px rgba(0,0,0,.24);          /* mô phỏng bg_shadown_border */
  overflow: hidden;
}
.album__cover img { width: 100%; height: 100%; object-fit: cover; }
.album__count {                                    /* badge đáy */
  position: absolute; left: 0; right: 0; bottom: 0;
  display: flex; align-items: center; gap: 4px;
  padding: 4px; font-size: 12px; color: #FFFFFF;
  background: rgba(0,0,0,.38);
}
.album__check {                                    /* tick góc */
  position: absolute; top: 4px; right: 4px;
  display: none;                                   /* hiện khi album.selected */
}
.album.is-selected .album__check { display: block; }
.album.is-selected .album__cover { outline: 2px solid #7CB342; }
.album__name {
  margin-top: 2px; padding: 2px; font-size: 14px; font-weight: 700;
  color: rgba(0,0,0,.87); text-align: center;
  white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 100%;
}

/* Overlay loading */
.cloud-albums__loading {
  position: absolute; inset: 0; display: none;     /* bật khi đang nạp */
  align-items: center; justify-content: center;
  background: rgba(0,0,0,.38); z-index: 3;
}
```

```html
<div class="cloud-albums">
  <div class="cloud-albums__bar">
    <img src="images/ic_action_back.png" width="24">
    <span class="title">Hình Ảnh</span>
    <span class="delete">Xoá (2)</span>
  </div>

  <div class="cloud-albums__grid">
    <div class="album is-selected">
      <div class="album__cover">
        <img src="cover.jpg">
        <div class="album__count"><img src="images/ic_indicate_privacy_public.png" width="14"> 128</div>
        <img class="album__check" src="images/ic_checked.png" width="20">
      </div>
      <div class="album__name">Ảnh của tôi</div>
    </div>
    <!-- … các ô khác … -->
  </div>

  <div class="cloud-albums__loading"><span class="spinner"></span></div>
</div>
```

## 4. Hành vi & luồng

### 4.1. Khởi tạo (`onCreate` → `F()` → `a()` → `G()`)

- `e` (static) = id chủ kho ảnh: `null`/rỗng → **kho ảnh của chính mình**; ngược lại = id người khác.
- **Tiêu đề action bar** đặt trong `F()`:
  - `e` rỗng → "Hình Ảnh" (`general_tab_mediastore`).
  - `e` có & tìm được liên hệ `h.t.d(e)` → tên hiển thị của người đó (`f.L()`).
  - không có liên hệ → hiện thẳng chuỗi `e`.
- **`H()`** (= "kho của mình?"): true nếu `e` rỗng, hoặc `e` trùng id mình (`m.b(e, h.a())`). Quyết định: cho chọn-xoá, dùng API kho mình hay kho người khác.
- Adapter cho **selectable theo `H()`**: `g.a(true/false)` — cờ `g` của adapter (chỉ khi `true` mới cho long-press/chọn).
- `G()`: tạo adapter, gắn vào grid; nếu danh sách trống → gọi `a_(0)` để nạp trang đầu.
- **Nạp dữ liệu** (`a_(i)` của interface `j.a` — cũng là callback cuộn-tới-cuối để **phân trang lazy**): bật loading nếu là trang đầu (`i==0`); kho của mình → `OlaApplication.b.e(...)` (svc op 16); kho người khác → `OlaApplication.b.f(e,...)`. Token phân trang lưu ở `j`/`k`; hết trang khi server trả token null → đặt `j="null"` (ngừng nạp thêm). Khi cuộn còn cách cuối 5 item, base adapter `j` tự gọi `a_(...)` để nạp tiếp (điều kiện `B()` = còn token).

### 4.2. Bảng tương tác (mọi cử chỉ)

| Thành phần | Cử chỉ | Hành vi | Loại |
|------------|--------|---------|------|
| Nút Back `olaActionBarBackViewLayout` | click | `finish()` — thoát màn (anim trượt phải) | nội bộ |
| Vùng tiêu đề `olaActionBarTitleViewLayout` | click | gắn listener nhưng `onClick` **không xử lý** id này → không làm gì | nội bộ |
| Nút "Xoá (n)" `olaActionBarButtonTextView` | click | Mở **dialog xác nhận xoá album** (xem Modal) — chỉ khi có album được chọn & là kho của mình | modal trong màn |
| Ô album (`cloudAlbumViewLayout`) | **click** | **Chế độ thường:** mở màn ảnh của album (xem mục 6). **Chế độ chọn** (mode=1) & album KHÔNG đặc biệt & selectable: **toggle chọn** album đó (đảo `l.k`), cập nhật tick + đếm số chọn `d(n)` | hỗn hợp |
| Ô album (`cloudAlbumViewLayout`) | **long-press** | Nếu album KHÔNG đặc biệt (`!l.a()`) & adapter selectable (`g==true`): **vào chế độ chọn** (`d()`), đánh dấu album này `k=true`, đếm số chọn `d(n)`, hiện nút "Xoá". Trả về true (nuốt sự kiện). Album đặc biệt hoặc kho người khác → bỏ qua | nội bộ |
| Phím Back | onBackPressed | **Đang ở chế độ chọn** → thoát chế độ chọn (`g.e()`, bỏ hết tick, ẩn nút Xoá). Ngược lại → `super.onBackPressed()` thoát màn | nội bộ |
| Cuộn grid tới gần cuối | scroll | Tự nạp trang tiếp theo (nếu còn token) | nội bộ |

> **Lưu ý:** không có click riêng trên ảnh bìa / tên / badge — toàn bộ ô album dùng chung một `OnClickListener` + `OnLongClickListener` đặt trên `cloudAlbumViewLayout`. Click thường khi mở album phân nhánh theo `l.i`: `i==5` → màn gallery của clan, còn lại → màn danh sách ảnh cloud.

### 4.3. Chế độ chọn (multi-select) & callback giao diện

Adapter giữ `c` (mode: 0=thường, 1=chọn) và list dữ liệu `d`. Interface `d` nối adapter ↔ Activity:

| Callback | Khi nào | Activity làm gì |
|----------|---------|-----------------|
| `C()` | adapter vào chế độ chọn (`d()`) | hiện nút "Xoá" (`i.setVisibility(VISIBLE)`) |
| `D()` | adapter thoát chế độ chọn (`e()`) | ẩn nút "Xoá" |
| `d(n)` | mỗi lần đổi số album được chọn | nếu `n==0` hoặc không phải kho của mình → ẩn nút; ngược lại đặt text **"Xoá (n)"** và hiện |
| `a(l)` | click 1 album ở chế độ thường | điều hướng sang màn xem ảnh (mục 6) |
| `a(View, i)` | (không dùng — body rỗng) | — |

### Modal/Dialog/Menu trong màn

**Dialog xác nhận xoá album** — mở từ nút "Xoá (n)" trên action bar (`onClick`, dùng helper `i.d(...)` = dialog 2 nút).
- Tiêu đề: `string_delete_album` ("Xoá album" / EN "Delete album").
- Nội dung: `message_delete_albums_confirm_format` với số lượng — "Bạn có muốn xóa **n** album không?" (EN "Do you want to delete n album(s)?").
- Nút **"Xoá"** (`string_delete`): với mỗi album đã chọn → gỡ khỏi list cục bộ + gọi `OlaApplication.b.q(albumId, 0)` (xoá trên server), rồi `g.e()` thoát chế độ chọn + refresh grid.
- Nút **"Không"** (`string_no`): đóng dialog, không xoá.

> Màn không có long-press mở menu ngữ cảnh (Đổi tên/Chia sẻ…); long-press chỉ dùng để bật chế độ chọn nhiều. Việc xoá đi qua nút "Xoá" + dialog trên.

**Dialog "Hết thời gian thực thi"** — tự bật khi nạp album quá **30s** (`c(true)` đặt Runnable timeout): tiêu đề `dialog_title_inform` ("Thông báo"), nội dung `message_process_timeout` ("Hết thời gian thực thi. Xin thử lại"), nút đóng mặc định; đồng thời ẩn loading.

### 4.4. Đối chiếu bản web

Chưa có màn tương ứng trong `web/src/pages/` (web hiện chưa dựng lại Kho ảnh cloud).

## 5. Strings (đa ngôn ngữ)

| Resource | EN (`values/strings.xml`) | VI (`values-vi/strings.xml`) |
|----------|---------------------------|------------------------------|
| `general_tab_mediastore` | Photos | Hình Ảnh |
| `string_delete` | Delete | Xoá |
| `string_delete_album` | Delete album | Xoá album |
| `string_no` | No | Không |
| `message_delete_albums_confirm_format` | Do you want to delete %1$s album(s)? | Bạn có muốn xóa %1$s album không? |
| `message_delete_album_confirm_format` | Do you want to delete album %1$s? | Bạn có muốn xóa album %1$s không? |
| `dialog_title_inform` | Inform | Thông báo |
| `message_process_timeout` | Request timeout. Please try again | Hết thời gian thực thi. Xin thử lại |

## 6. Màn mở ra từ đây (điều hướng)

| Từ (nút/cử chỉ) | Màn đích (class) | Doc |
|-----------------|------------------|-----|
| Click 1 album (mode thường) khi `l.i == 5` | `cloud.OlaGalleryAlbumListActivity` (album gallery/clan) | (chưa có doc — cần làm) |
| Click 1 album (mode thường), các loại khác | `cloud.OlaCloudPhotoListActivity` (danh sách ảnh trong album cloud) | (chưa có doc — cần làm) |

> Các Activity cloud liên quan khác — `cloud.OlaCloudPhotoChooserActivity`, `cloud.OlaGalleryPhotoListActivity`, `cloud.OlaLocalPhotoChooserActivity` — **không** được điều hướng trực tiếp từ màn này (thuộc luồng chọn/đăng ảnh khác), nên không liệt kê ở bảng trên. (chưa có doc — cần làm)
