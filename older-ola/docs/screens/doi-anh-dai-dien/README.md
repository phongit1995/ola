# Màn hình Đổi ảnh đại diện / Ảnh bìa (Change Avatar — Picker + Crop)

- **Activity crop:** `chat.ola.vn.activity.OlaCropImageActivity` — `jadx_out/sources/chat/ola/vn/activity/OlaCropImageActivity.java` (903 dòng)
- **Layout crop:** `apktool_out/res/layout/edit_crop_image_layout.xml` (nền đen + `CropImageView` + thanh 3 nút dưới)
- **Custom view khung crop:** `chat.ola.vn.view.CropImageView` — `jadx_out/sources/chat/ola/vn/view/CropImageView.java`
- **Dialog chọn nguồn ảnh:** `chat.ola.vn.i.m` (list popup — dựng trong `OlaCropImageActivity` dòng 471-510)
- **Điểm vào (phòng chat / clan):** `chat.ola.vn.me.OlaClanMePageActivity` — header `apktool_out/res/layout/ola_clan_page_header_layout.xml`
- **Điểm vào (cá nhân):** `OlaUserMePageActivity` / `OlaUserProfileActivity` / `OlaAppSettingActivity` (xem [trang-ca-nhan](../trang-ca-nhan/README.md))

> Đây **không phải một màn riêng lẻ** mà là **luồng đổi ảnh dùng chung** cho toàn app: từ chỗ hiển thị avatar (trang phòng/clan, trang cá nhân, cài đặt) → **dialog chọn nguồn** → **màn crop** → **upload**. Tài liệu này tập trung biến thể **đổi ảnh đại diện của PHÒNG (clan/room)** mà người dùng yêu cầu, đồng thời chỉ rõ điểm khác so với avatar cá nhân.

> ⚠️ **Thuật ngữ:** App gọi avatar là **"Ovatar"**. Trong APK, **"Phòng chat" = Clan** — màn quản lý phòng là `OlaClanMePageActivity`, và phần đổi avatar phòng dùng đúng `OlaCropImageActivity` chung với avatar cá nhân (chỉ khác tham số `clanName` và endpoint upload).

> Dựng từ **code + XML** (chưa chụp ảnh). 4 icon dùng trong màn crop đã trích vào [images/icons/](images/icons/).

> **Quy ước giá trị:** `dp` lấy trực tiếp từ `layout/*.xml`; CSS quy ở mdpi (`1dp = 1px`). Màu `#AARRGGBB` (alpha trước) đã quy ra `rgba()`.

---

## 0. Luồng tổng quát (3 bước)

```
[1] TRANG PHÒNG (OlaClanMePageActivity)
    avatar phòng (96dp) + badge camera (chỉ chủ/admin phòng mới thấy)
        │  bấm avatar  ·  hoặc bấm badge camera
        ▼
[2] DIALOG "Chọn ảnh"  (chat.ola.vn.i.m)
    ├─ "Chụp từ Camera"        → Intent IMAGE_CAPTURE   (requestCode 1)
    └─ "Chọn từ Bộ Sưu Tập"    → Intent GET_CONTENT     (requestCode 2)
        │  có ảnh
        ▼
[3] MÀN CROP (OlaCropImageActivity + edit_crop_image_layout.xml)
    khung crop VUÔNG + thanh dưới [Hủy] [Xoay] [Xong]
        │  bấm Xong  (requestCode 3)
        ▼
    UPLOAD (jpg, cạnh ≤ min(1280, bề rộng máy)) → gắn avatar cho clan
    → toast "Đã đổi ảnh đại diện cho clan #X" + đăng 1 post hệ thống
```

| Bước | Tham số quyết định "phòng hay cá nhân" |
|------|----------------------------------------|
| Mở crop avatar **phòng** | `OlaCropImageActivity.b(ctx, clanName, cb)` — **3 tham số** (`OlaCropImageActivity.java:566`) |
| Mở crop ảnh bìa **phòng** | `OlaCropImageActivity.a(ctx, clanName, cb)` — **3 tham số** (`:532`) |
| Mở crop avatar **cá nhân** | `OlaCropImageActivity.b(ctx, cb)` — 2 tham số (`:558`) |
| Mở crop ảnh bìa **cá nhân** | `OlaCropImageActivity.a(ctx, cb)` — 2 tham số (`:463`) |

> Khác biệt duy nhất giữa phòng và cá nhân ở tầng UI là **có truyền `clanName` hay không**. Toàn bộ dialog + màn crop giống hệt nhau.

---

## 1. Điểm vào — avatar phòng trên header (`ola_clan_page_header_layout.xml`)

Avatar phòng nằm trong **thẻ hồ sơ** của trang phòng, **đè góc dưới-TRÁI** của ảnh bìa (không canh giữa như trang cá nhân):

```
[Thẻ hồ sơ] (bg_shadow_span)
└─ FrameLayout (bìa + avatar)
   ├─ FrameLayout (lớp bìa, match_parent)
   │   ├─ coverPictureImageView   (OlaRatioImageView, nền colorOlaPrimaryDarkMore)   ← ẢNH BÌA PHÒNG
   │   └─ editCoverPictureImageView  (ic_action_camera, right|bottom, margin 4dp, GONE)  ← badge sửa bìa
   └─ khung avatar (bg_shadown_border, layout_gravity=left|bottom, margin 8dp, padding L4/T4/R4/B6)
       ├─ profilePictureImageView  96×96dp, centerCrop, cropToPadding                 ← AVATAR PHÒNG
       └─ editProfilePictureImageView (ic_action_camera, right|bottom, margin 4dp, GONE) ← badge sửa avatar
```

| Thành phần | id | Giá trị |
|-----------|----|---------|
| Avatar phòng | `profilePictureImageView` (`OlaCachedImageView`) | **96×96dp**, `scaleType=centerCrop`, `adjustViewBounds=true`, `cropToPadding=true` |
| Khung viền avatar | (FrameLayout bọc) | nền `bg_shadown_border`, padding **L4 / T4 / R4 / B6 dp**, `layout_margin 8dp`, `layout_gravity=left\|bottom` |
| Badge sửa avatar | `editProfilePictureImageView` | `ic_action_camera`, `layout_gravity=right\|bottom`, `margin 4dp`, **`visibility=gone`** mặc định |
| Ảnh bìa phòng | `coverPictureImageView` (`OlaRatioImageView`) | full-width, nền tạm `#33691E` |
| Badge sửa bìa | `editCoverPictureImageView` | `ic_action_camera`, `right\|bottom`, `margin 4dp`, **`gone`** mặc định |

### 1.1. Ai được thấy nút sửa? (gating quyền — `OlaClanMePageActivity.N()`)

Hai badge camera **ẩn mặc định**, chỉ bật khi user là **chủ/quản trị phòng**:

- `OlaClanMePageActivity.java:303-304` — đủ quyền → `editCoverPictureImageView.setVisibility(0)` + `editProfilePictureImageView.setVisibility(0)`
- `:306-307`, `:311-312` — không đủ quyền → cả hai `setVisibility(8)`
- Tham chiếu view: cover-edit = `this.m` (`:215`), avatar = `this.n` (`:217`), avatar-edit = `this.o` (`:219`)

### 1.2. Vùng bấm để mở luồng đổi avatar (`OlaClanMePageActivity.onClick`)

| Bấm vào | id | File:line | Hành động |
|---------|----|-----------|-----------|
| **Sửa avatar phòng** | `editProfilePictureImageView` | `OlaClanMePageActivity.java:747` | `OlaCropImageActivity.b(this, this.e.a, this)` — `this.e.a` = tên clan |
| **Sửa ảnh bìa phòng** | `editCoverPictureImageView` | `:742` | `OlaCropImageActivity.a(this, this.e.a, this)` |
| **Xem avatar full** | `profilePictureImageView` | (`:765`+) | mở `OlaImageViewerActivity` (xem, không sửa) |

> Trên thiết bị, bấm trực tiếp vào **ảnh avatar** chỉ **xem ảnh full**; muốn **đổi** phải bấm **badge camera** (chỉ admin có).

---

## 2. Dialog "Chọn ảnh" (`OlaCropImageActivity` dòng 471-510)

Là **list popup** (`chat.ola.vn.i.m`) — không phải bottom sheet Material — có tiêu đề + 2 dòng lựa chọn:

| # | Dòng | String | Bấm → |
|---|------|--------|-------|
| — | **Tiêu đề** | `string_select_photo` = "Chọn ảnh" | — |
| 0 | **Chụp từ Camera** | `string_take_from_camera` = "Chụp từ Camera" | `Intent("android.media.action.IMAGE_CAPTURE")` → `startActivityForResult(.., 1)` (`:879-887`) |
| 1 | **Chọn từ Bộ Sưu Tập** | `string_select_from_gallery` = "Chọn từ Bộ Sưu Tập" | `Intent(GET_CONTENT)` type `image/*`, bọc `createChooser` → `startActivityForResult(.., 2)` (`:892-893`) |

- Build danh sách: `OlaCropImageActivity.java:476-477`; set tiêu đề: `:479`.
- Sau khi camera/gallery trả ảnh (requestCode 1 hoặc 2) → tự động vào **màn crop** (§3).

> **Tương đương web:** một action-sheet 2 lựa chọn, hoặc gộp 1 `<input type="file" accept="image/*">` (thêm `capture="environment"` cho nhánh camera trên mobile web).

---

## 3. Màn crop (`edit_crop_image_layout.xml`)

Activity `OlaCropImageActivity` inflate layout này khi đã có ảnh nguồn. Toàn màn **nền đen**, vùng crop chiếm hết phần trên, **thanh công cụ 58dp** dưới đáy.

```
RelativeLayout  (nền @color/black, match_parent)
├─ CropImageView  @id/editImageCrop                       ← VÙNG CROP (kéo/zoom, khung sáng)
│     layout: match_parent × match_parent, layout_above=@id/linear
└─ LinearLayout  @id/linear  (thanh dưới)
      height 58dp · nền bg_bottom_bar_span · divider horizonal_div · showDividers=middle · alignParentBottom
      ├─ ImageView @id/btnBack    src=ic_menu_close_clear_cancel  (weight 1, centerInside)   ← HỦY
      ├─ ImageView @id/btnRotate  src=ic_rotate_white             (weight 1, centerInside)   ← XOAY
      └─ ImageView @id/btnAccept  src=ic_action_done              (weight 1, centerInside)   ← XONG
```

| Nút | id | Icon | Chức năng |
|-----|----|------|-----------|
| Hủy | `btnBack` | ![close](images/icons/ic_menu_close_clear_cancel.png) `ic_menu_close_clear_cancel` | đóng màn crop, không lưu |
| Xoay | `btnRotate` | ![rotate](images/icons/ic_rotate_white.png) `ic_rotate_white` | xoay ảnh 90° |
| Xong | `btnAccept` | ![done](images/icons/ic_action_done.png) `ic_action_done` | cắt + xuất ảnh → `startActivityForResult(.., 3)` → upload |

**Khung crop & kích thước xuất:**
- Khung crop **vuông (1:1)** cho avatar.
- Cạnh ảnh xuất = `Math.min(1280, chat.ola.vn.e.c)` với `e.c` = **bề rộng màn hình** (`OlaCropImageActivity.java:455-456`). Tức ảnh ra tối đa **1280px**, hoặc bằng bề rộng máy nếu nhỏ hơn.
- `CropImageView` (custom) chứa các `HighlightView` (khung kéo), hỗ trợ pan/zoom/rotate.

---

## 4. Upload + validate + thông báo

Sau khi bấm **Xong**, ảnh được upload (định dạng `jpg`) qua upload manager `chat.ola.vn.u.b.a(...)`, rồi gắn vào clan.

**Handler theo từng biến thể** (cùng file `OlaCropImageActivity.java`):

| Biến thể | Inner class | Gắn dữ liệu | Toast thành công |
|----------|-------------|-------------|------------------|
| **Avatar phòng/clan** | `AnonymousClass13` (~231-325) | `OlaApplication.b.a(clanName, ["avatar"], [url])` | `message_change_clan_avatar_success_format` = "Đã đổi ảnh đại diện cho clan %1$s" (`:285`) |
| Ảnh bìa phòng/clan | `AnonymousClass2` (~341-…) | `OlaApplication.b.a(clanName, ["cover"], [url])` | `message_change_clan_cover_success_format` (`:382`) |
| Avatar cá nhân | `AnonymousClass11` (~41-133) | `OlaApplication.b.b(["avatar"], [url])` | `message_change_avatar_success` = "Đã đổi ảnh đại diện" (`:93`) |
| Ảnh bìa cá nhân | `AnonymousClass12` (~…-…) | `OlaApplication.b.b(["cover"], [url])` | `message_change_cover_success` (`:188`) |

**Ngoài cập nhật avatar, app còn đăng 1 "post hệ thống"** báo đổi ảnh:
- Phòng: `message_change_clan_ovatar_post_me_format` = "Đổi ảnh đại diện mới cho clan %1$s" (`:272`)
- Cá nhân: `message_change_ovatar_post_me` = "Đổi ảnh đại diện mới" (`:80`)

**Trạng thái & lỗi:**
- Đang xử lý: `message_change_ovatar_watting` = "Đang đổi ảnh đại diện. Vui lòng chờ!" (clan: `message_change_clan_ovatar_watting_format`).
- Thất bại: `message_change_avatar_fail` = "Không thể đổi ảnh đại diện vào lúc này. Vui lòng thử lại sau" (clan: `message_change_clan_avatar_fail_format`).
- **Ảnh quá nhỏ:** `message_change_avatar_too_small` = "Chiều rộng ảnh đại diện nhỏ. Chiều rộng bạn đang chọn là %1$s. Yêu cầu tối thiểu là %2$s".
  > ⚠️ Chuỗi này tồn tại trong resource nhưng **không còn thấy điểm gọi trong code Java đã giải mã** (`grep` chỉ ra `R.java`). Nhiều khả năng việc chặn bề rộng tối thiểu nằm ở **server** hoặc nhánh code đã bị tối giản. Khi dựng web nên **tự validate bề rộng tối thiểu** ở client cho chắc.

---

## 5. Strings (EN → VI)

| Key | EN | VI |
|-----|----|----|
| `string_select_photo` | Select photo | Chọn ảnh |
| `string_take_from_camera` | Take from Camera | Chụp từ Camera |
| `string_select_from_gallery` | Select from Gallery | Chọn từ Bộ Sưu Tập |
| `string_change_profile_picture` | Change Profile Picture | Đổi Ảnh Đại Diện |
| `string_change_cover_picture` | Change Cover Picture | Đổi Ảnh Bìa |
| `string_set_avatar` | Set avatar | Cài ảnh đại diện |
| `message_select_media_to_set_avatar` | — | Chọn media làm Ovatar |
| `message_change_avatar_success` | Profile picture was changed | Đã đổi ảnh đại diện |
| `message_change_clan_avatar_success_format` | Changed avatar for Clan %1$s | Đã đổi ảnh đại diện cho clan %1$s |
| `message_change_ovatar_watting` | Changing profile picture. Please wait! | Đang đổi ảnh đại diện. Vui lòng chờ! |
| `message_change_ovatar_post_me` | — | Đổi ảnh đại diện mới |
| `message_change_clan_ovatar_post_me_format` | — | Đổi ảnh đại diện mới cho clan %1$s |
| `message_change_avatar_fail` | Cannot change profile picture at this time. Please try again later | Không thể đổi ảnh đại diện vào lúc này. Vui lòng thử lại sau |
| `message_change_avatar_too_small` | Width of profile picture is too small. Current is %1$s. Required width is %2$s | Chiều rộng ảnh đại diện nhỏ. Chiều rộng bạn đang chọn là %1$s. Yêu cầu tối thiểu là %2$s |

---

## 6. Bảng icon

| Vị trí | Icon | Nguồn |
|--------|------|-------|
| Badge sửa avatar / bìa (trên header phòng) | ![cam](images/icons/ic_action_camera.png) | `ic_action_camera` |
| Nút Hủy (thanh crop) | ![close](images/icons/ic_menu_close_clear_cancel.png) | `ic_menu_close_clear_cancel` |
| Nút Xoay (thanh crop) | ![rotate](images/icons/ic_rotate_white.png) | `ic_rotate_white` |
| Nút Xong (thanh crop) | ![done](images/icons/ic_action_done.png) | `ic_action_done` |

---

## 7. Tóm tắt token UI

| Thành phần | Giá trị |
|------------|---------|
| Avatar phòng | **96×96dp**, `centerCrop`, đè **góc dưới-trái** ảnh bìa |
| Khung viền avatar | nền `bg_shadown_border`, padding L4/T4/R4/B6dp, margin 8dp |
| Badge camera | `ic_action_camera`, góc dưới-phải avatar, margin 4dp, **chỉ admin** |
| Dialog chọn ảnh | list popup, tiêu đề "Chọn ảnh" + 2 mục (Camera / Bộ sưu tập) |
| Màn crop | nền **đen** full-screen |
| Thanh công cụ crop | cao **58dp**, nền `bg_bottom_bar_span`, 3 nút đều nhau (weight 1), divider giữa các nút |
| Nút crop | `ImageView` `scaleType=centerInside`, full chiều cao thanh |
| Khung crop | **vuông 1:1** |
| Ảnh xuất | `jpg`, cạnh = `min(1280, bề_rộng_máy)` px |

---

## 8. CSS tương đương (dựng lại trên web)

```css
/* ===== [1] Avatar phòng + badge camera (trên header) ===== */
.ola-room-avatar {
  position: absolute; left: 8px; bottom: -8px;       /* đè góc dưới-trái ảnh bìa */
  background: #fff; padding: 4px 4px 6px;             /* bg_shadown_border */
  box-shadow: 0 1px 3px rgba(0,0,0,.3); display: inline-flex;
}
.ola-room-avatar img { width: 96px; height: 96px; object-fit: cover; }
.ola-room-avatar__cam {                               /* ic_action_camera — chỉ render khi isAdmin */
  position: absolute; right: 4px; bottom: 4px; width: 24px; height: 24px; cursor: pointer;
}

/* ===== [2] Dialog "Chọn ảnh" (action-sheet) ===== */
.ola-photo-picker { background: #fff; border-radius: 4px; overflow: hidden; min-width: 280px; }
.ola-photo-picker__title { padding: 16px; font-size: 16px; color: rgba(0,0,0,.87); }
.ola-photo-picker__item {
  display: block; width: 100%; text-align: left; padding: 14px 16px;
  border: none; background: none; font-size: 16px; color: rgba(0,0,0,.87);
}
.ola-photo-picker__item:active { background: rgba(0,0,0,.06); }

/* ===== [3] Màn crop (full-screen đen + thanh 3 nút) ===== */
.ola-crop { position: fixed; inset: 0; background: #000; display: flex; flex-direction: column; }
.ola-crop__canvas { flex: 1; position: relative; overflow: hidden; }  /* CropImageView: ảnh + khung vuông kéo/zoom */
.ola-crop__bar {
  height: 58px; display: flex;
  background: #212121;                                /* bg_bottom_bar_span (xám đậm) */
}
.ola-crop__btn {
  flex: 1; display: flex; align-items: center; justify-content: center;
  border: none; background: none; cursor: pointer;
}
.ola-crop__btn + .ola-crop__btn { border-left: 1px solid rgba(255,255,255,.12); }  /* divider giữa */
.ola-crop__btn img { height: 24px; }
```

```html
<!-- [1] avatar phòng trên header -->
<div class="ola-room-avatar">
  <img src="room-avatar.jpg" alt="avatar phòng">
  <!-- chỉ render khi user là chủ/admin phòng -->
  <img class="ola-room-avatar__cam" src="images/icons/ic_action_camera.png" alt="đổi ảnh">
</div>

<!-- [2] dialog chọn nguồn -->
<div class="ola-photo-picker">
  <div class="ola-photo-picker__title">Chọn ảnh</div>
  <button class="ola-photo-picker__item">Chụp từ Camera</button>
  <button class="ola-photo-picker__item">Chọn từ Bộ Sưu Tập</button>
</div>

<!-- [3] màn crop -->
<div class="ola-crop">
  <div class="ola-crop__canvas"><!-- cropper vuông --></div>
  <div class="ola-crop__bar">
    <button class="ola-crop__btn"><img src="images/icons/ic_menu_close_clear_cancel.png"></button>
    <button class="ola-crop__btn"><img src="images/icons/ic_rotate_white.png"></button>
    <button class="ola-crop__btn"><img src="images/icons/ic_action_done.png"></button>
  </div>
</div>
```

> **Gợi ý thư viện web:** dùng `react-easy-crop` hoặc `cropperjs` cho `.ola-crop__canvas` (khóa tỉ lệ 1:1, xuất canvas → blob `image/jpeg`, giới hạn cạnh 1280px) trước khi upload.
