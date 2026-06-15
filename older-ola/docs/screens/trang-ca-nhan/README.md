# Màn hình Trang cá nhân / Thông tin người dùng (User Info)

- **Activity:** `chat.ola.vn.me.OlaUserMePageActivity` — `jadx_out/sources/chat/ola/vn/me/OlaUserMePageActivity.java` (1372 dòng)
- **Layout màn (scaffold):** `apktool_out/res/layout/ola_user_me_page_layout.xml` (khung: action bar nổi + ListView pull-to-refresh + FAB)
- **Layout action bar:** `ola_user_me_page_top_action_bar_layout.xml` (`@id/olaTopActionBarViewLayout` — back + ô tìm nick/#clan)
- **Layout header:** `ola_user_me_page_header_layout.xml` (header cuộn cùng feed bài đăng của người đó)
- **Cụm nút quan hệ:** `add_follow_post_more_button_layout.xml` (`@id/relationMakerPan`)
- **Mở từ:** bấm avatar/tên trong feed Me, danh bạ, menu drawer trái màn Me, hoặc `OlaUserMePageActivity.a(context, "<nick>")`

> Đây là **trang hồ sơ một người** (giống profile Facebook): ảnh bìa + avatar + ID + nút quan hệ + số người quan tâm + nụ hôn + tiểu sử + thông tin cá nhân + Kho Media + Đang quan tâm + danh sách bài Me. Khi xem **chính mình** vs **người khác** thì các nút/menu khác nhau.

> Dựng từ **code + XML** (chưa chụp ảnh). Icon đã trích sẵn vào [images/icons/](images/icons/).

> **Quy ước giá trị:** `dp/sp` lấy trực tiếp từ `res/values/dimens.xml`; màu `#AARRGGBB` (alpha trước) đã quy ra `rgba()`. Bảng cỡ chữ chuẩn của app dùng xuyên suốt tài liệu:
>
> | Style | size | weight | màu mặc định |
> |-------|------|--------|--------------|
> | `…text.caption` | 12sp | normal | `#8A000000` (đen .54) |
> | `…text.body1` | 14sp | normal | `#DE000000` (đen .87) |
> | `…text.subhead` | 16sp | normal | `#DE000000` |
> | `…text.title` | 20sp | **bold** | `#DE000000` |
> | `…text.headline` | 24sp | normal | `#DE000000` |

---

## 0. Khung màn hình tổng (`ola_user_me_page_layout.xml`)

Root là **`FrameLayout` 3 lớp xếp chồng** (`@id/globalViewLayout`, match_parent) — action bar **nổi đè** lên nội dung, FAB nổi góc dưới-phải:

```
globalViewLayout (FrameLayout, match_parent)
├─ [lớp 1 — NỘI DUNG] FrameLayout  paddingTop=42dp  ← chừa chỗ cho action bar nổi (metric.topbar.noshadow.42dp)
│   ├─ SwipeRefreshLayout @id/pullToRefreshLayout         ← KÉO XUỐNG LÀM MỚI
│   │   └─ ListView @id/pageListView  style=list.rowSpacing  ← header (§1) là headerView, dưới là list bài Me
│   └─ ProgressBar @id/wattingProgressBar  48×48dp, center ← loading giữa màn
├─ [lớp 2 — ACTION BAR] <include ola_user_me_page_top_action_bar_layout> ← NỔI TRÊN CÙNG (§0.1)
└─ [lớp 3 — FAB] ImageButton @id/addConversationImageButton ← NÚT NHẮN TIN (§0.2)
```

- **`ListView` style `defaultStyle.list.rowSpacing`**: `scrollbars=none`, `fadingEdge=none`, `divider=transparent`, `cacheColorHint=transparent` → list **không kẻ vạch, không thanh cuộn**, các thẻ tự cách nhau bằng `marginBottom 8dp` của từng thẻ trong header.
- **`paddingTop=42dp`** ở lớp nội dung = đúng chiều cao action bar nổi, nên ảnh bìa bắt đầu **ngay dưới** action bar (action bar che mép trên khi cuộn).

### 0.1. Action bar trên cùng (`ola_user_me_page_top_action_bar_layout.xml`)

`LinearLayout` ngang, `gravity=center_vertical`, nền `bg_action_bar` (xanh lá Ola), padding **L8 / T4 / R16 / B10 dp**:

| # | id | Thành phần | Chi tiết |
|---|----|-----------|----------|
| 1 | `olaActionBarBackImageView` | **Nút back** `ic_action_back` | `wrap × match_parent`, `marginRight 8dp`, `scaleType=centerInside` → bấm = `finish()` (dòng 1305) |
| 2 | (LinearLayout weight 1) | **Ô tìm kiếm** | style `edittext.small.border.light` (nền `bg_edit_text_small_light_border`, bo góc sáng, padding 8dp) |
| 2a | — | Icon kính lúp `ic_action_search_small` | 16×16dp, `gravity=center` |
| 2b | `searchEditText` | `OlaQuickTypingSuggestedText` (ô nhập gợi ý nhanh) | body1 **14sp**, chữ **trắng**, hint trắng-mờ `#4DFFFFFF` = "Enter nick or #clan", `maxLines=1`, `inputType=textNoSuggestions`, `imeOptions=actionSearch` |

**Hành vi ô tìm (dòng 147+, `onEditorAction`):** nhấn Enter/Search → lấy text:
- bắt đầu bằng **`#`** → mở **clan** tương ứng;
- ngược lại → mở **trang cá nhân** của nick vừa nhập (`OlaUserMePageActivity.a(...)`).

> Action bar **không có tiêu đề** — toàn bộ phần giữa là ô tìm nick/clan (đặc trưng màn Me: từ trang người này nhảy thẳng sang người khác).

### 0.2. Nút nổi "Nhắn tin" (FAB — `addConversationImageButton`)

| Thuộc tính | Giá trị |
|-----------|---------|
| Vị trí | góc phải-dưới (`layout_gravity=right\|bottom`), `marginRight/Bottom = 16dp` |
| Kích thước | **56×56dp**, `padding 16dp` |
| Nền | `floating_action_bar_shape` (tròn, xanh Ola, đổ bóng) |
| Icon | `ic_action_compose_message`, `tint=white`, `scaleType=centerInside` |
| Bấm → | mở **chat 1-1** với người này: `OlaChatViewActivity.a(this, m.j(nick))` (dòng 1194-1197) |

> Đây là **nhắn tin riêng**, không phải viết Me. Nút "Viết Me" nằm trong cụm 5 nút quan hệ (§2).

### 0.3. Vào màn từ đâu? (entry points)

⚠️ **Phân biệt 2 màn "cá nhân":**

| Màn | Activity | Là gì | Mở bằng |
|-----|----------|-------|---------|
| **Trang cá nhân** (màn này) | `OlaUserMePageActivity` | **XEM** hồ sơ 1 người | bấm **avatar / nick** của người đó ở bất kỳ đâu (không có icon riêng — chính ảnh avatar là vùng bấm) |
| **Thông tin cá nhân** | `OlaUserProfileActivity` | **SỬA** hồ sơ của mình | tab **Ứng dụng** → mục **"Profile"** (icon ![per](images/icons/ic_tab_persional.png) `ic_tab_persional`), hoặc từ Trang cá nhân của mình → nút **"Cập Nhật Thông Tin"** (![edit](images/icons/ic_edit_profile_gray.png) `ic_edit_profile_gray`) |

> ⛔ Không có icon "hồ sơ" trên bottom tab. Tab **Me** mở **bảng tin (newsfeed)**, không phải trang cá nhân. Muốn xem **hồ sơ của chính mình** → mở **drawer trái** màn Me rồi bấm **header (ảnh bìa + avatar + tên của bạn)**.

**Mọi nơi bấm vào để mở Trang cá nhân** (đều gọi `OlaUserMePageActivity.a(ctx, nick)`; nếu nick bắt đầu `#` → mở Clan thay vì người):

| Từ màn | Vùng bấm (view id) | File:line | Mở hồ sơ của |
|--------|--------------------|-----------|--------------|
| **Bảng tin Me** | avatar `profilePictureImageView`, nick `contactIdTextView`, ô gợi ý `suggestedFriendItemLayout`, cụm tác giả `meOwnerInfoSpan` | `q/b.java:1499`,`1555` | người đăng bài |
| **Drawer trái màn Me** | **header** `system_me_menu_user_info_header` (cover + avatar 40dp + tên) | `me/c.java:551` | **chính mình** (`h.a()`) |
| **Danh sách hội thoại / Danh bạ** | avatar `imgItemIcon` (khi `k()==0`) | `m/o.java:744` | người trong hội thoại |
| **Thành viên nhóm / clan** | avatar `imgItemIcon` (khi `k()==0`) | `m/n.java:632` | thành viên |
| **Thêm liên hệ / tìm bạn** | cả dòng `contactSummaryViewLayout` | `OlaAddContactActivity.java:203` | kết quả tìm |
| **Chi tiết địa điểm (check-in)** | dòng người check-in | `OlaVenueDetailActivity.java:587`,`600` | người check-in |
| **Nhật ký (Diary)** | chủ nhật ký | `OlaDiaryActivity.java:378` | chủ diary |
| **Ngay trong Trang cá nhân** | ô tìm trên action bar (§0.1) | `OlaUserMePageActivity.java:147` | nick vừa nhập |

> Tóm gọn: **bấm vào avatar hoặc tên của ai đó ở bất kỳ đâu** → ra Trang cá nhân của người đó. **Xem hồ sơ mình** = drawer trái màn Me → bấm header. **Sửa hồ sơ mình** = tab Ứng dụng → "Profile", hoặc nút "Cập Nhật Thông Tin" trong hồ sơ mình.

---

## 1. Cấu trúc header (`ola_user_me_page_header_layout.xml`)

Toàn bộ header gồm **3 thẻ** (mỗi thẻ nền `bg_shadow_span`, cách nhau 8dp): **(A) Thẻ hồ sơ** · **(B) Kho Media** · **(C) Đang quan tâm** — rồi tới tiêu đề **"ME Đã Đăng"** mở đầu danh sách bài.

```
vLinearUserInfo (vertical)
├─ [A] THẺ HỒ SƠ (bg_shadow_span)
│   ├─ FrameLayout (bìa + avatar)
│   │   ├─ coverPictureImageView   (OlaRatioImageView ratio 1.777 = 16:9, nền colorOlaPrimaryDarkMore) ← ẢNH BÌA
│   │   │   └─ editCoverPictureImageView  (ic_action_camera, ẩn — chỉ hồ sơ mình)
│   │   └─ khung avatar (bg_shadown_border, đè đáy bìa, marginBottom 48dp)
│   │       ├─ profilePictureImageView  96×96dp                                       ← AVATAR
│   │       │   └─ editProfilePictureImageView (ic_action_camera, ẩn)
│   │       └─ honeyProfilePictureImageView  96×96dp (ẩn — avatar bạn đời nếu đã cưới)
│   ├─ vLinearMeUserId (ngang, giữa)
│   │   ├─ contactIdTextView   (headline, màu .54)                                    ← NICK/ID
│   │   └─ imgCheckedPhoneNumberVerified  24dp (ic_checked, ẩn nếu chưa xác thực)     ← ✓ đã xác thực SĐT
│   ├─ ─── divider 1px ───
│   ├─ relationMakerPan = add_follow_post_more_button_layout   ← 5 NÚT QUAN HỆ (xem §2)
│   │   └─ btnUnBlockMe (Button đỏ, ẩn — hiện khi đang chặn người này) = "Bỏ chặn"
│   ├─ ─── divider 1px ───
│   ├─ vLinewarFanNumber (ngang, giữa)
│   │   └─ fanNumberTextView (title, đen) + "người quan tâm"                          ← SỐ FAN
│   ├─ kissViewLayout (ngang, giữa)
│   │   ├─ kissImageView (sticker_kiss, max 80dp) + kissTextView (title)              ← NỤ HÔN
│   ├─ linearStatusSpan (RelativeLayout, margin 16dp)
│   │   ├─ txtInfoStatusSpan (caption, tối đa 5 dòng)                                 ← TIỂU SỬ/STATUS
│   │   └─ imgStatusIcon  36×36dp (ic_media_photo) — ảnh kèm status
│   ├─ vipAccountGroup (ngang, ẩn nếu không VIP)
│   │   ├─ imgVipIcon 24dp (tải từ URL) + "Tài khoản VIP" (đậm, màu colorOlaAccent)   ← VIP
│   ├─ txtJoinOlaDate (caption)                                                       ← "Tham gia Ola …"
│   ├─ txtMeUserGender         (drawableLeft ic_indicate_dynamic_gender)              ← GIỚI TÍNH
│   ├─ txtMeUserMarriesStatus  (drawableLeft ic_profile_marriage)                     ← TÌNH TRẠNG HÔN NHÂN
│   ├─ txtMeUserBirthday       (drawableLeft ic_profile_birthday)                     ← SINH NHẬT
│   └─ txtMeUserNote (italic, màu colorOlaPrimaryDarkMore, drawableLeft ic_profile_note) ← "Xem bài viết"
├─ [B] mediaStorageViewLayout (bg_shadow_span)                                        ← KHO MEDIA
│   ├─ mediaStorageTextView = "Kho Media" (subhead)
│   ├─ lưới 2 hàng × 3 ô: mediaImageView1,2,5 / mediaImageView3,4,6 (OlaSquareCachedImageView, gap 4dp)
│   └─ "Xem Tất Cả Ảnh" (body1, giữa)
├─ [C] friendViewLayout (bg_shadow_span)                                             ← ĐANG QUAN TÂM
│   ├─ friendTextView = "Đang quan tâm" (subhead)
│   ├─ 5 ô: friendViewLayout1..5 — ảnh vuông + tên overlay (bg_gradient_black, chữ trắng, đáy)
│   └─ "Xem Tất Cả" (body1, giữa)
└─ TextView "ME Đã Đăng" (subhead, màu đen)                                          ← mở đầu list bài Me
```

## 2. Cụm 5 nút quan hệ (`add_follow_post_more_button_layout.xml`)

5 nút ngang đều nhau (weight 1), mỗi nút = icon 20dp + nhãn caption (màu `colorTextBlackHintOrDisable`). Hành động xử lý trong `OlaUserMePageActivity.onClick` (dòng 1200+):

| # | id | Icon | Nhãn (VI) | Bấm → làm gì |
|---|----|------|-----------|---------------|
| 1 | `addFriendViewLayout` | ![addf](images/icons/ic_add_friend_black_disable.png) `ic_add_friend_black_disable` | **Kết bạn** (`string_make_friend`) | gửi lời mời kết bạn `OlaApplication.b.d(nick)`; nếu đã là bạn → nhãn đổi **"Đã Kết Bạn"** (`string_already_friend`) |
| 2 | `followViewLayout` | ![follow](images/icons/ic_follow_black_disable.png) `ic_follow_black_disable` | **Quan tâm** (`string_follow`) | `Z()` theo dõi; đang theo dõi → **"Đang quan tâm"** (`string_following`) |
| 3 | `editProfileViewLayout` | ![edit](images/icons/ic_edit_profile_gray.png) `ic_edit_profile_gray` | **Cập Nhật Thông Tin** (`string_update_info`) | **chỉ hồ sơ MÌNH** (ẩn với người khác) → `OlaUserProfileActivity` ([tài liệu màn sửa hồ sơ](../thong-tin-ca-nhan/README.md)); có badge "!" nếu cần cập nhật |
| 4 | `postMeViewLayout` | ![postme](images/icons/ic_post_me_gray.png) `ic_post_me_gray` | **Viết Me** (`string_post_me`) | mình → `OlaMeComposerActivity`; người khác → soạn Me nhắc "@nick" |
| 5 | `moreViewLayout` | ![more](images/icons/ic_more_horizon_black_disable.png) `ic_more_horizon_black_disable` | **Khác** (`string_more`) | mở menu (xem §3) |

## 3. Menu "Khác" (đổi theo mình / người khác)

`moreViewLayout` → nếu là **hồ sơ mình** (`V()`) gọi `W()`, ngược lại gọi `X()`:

**Người khác** (`X()`, dòng 708) — list popup `chat.ola.vn.i.m`:

| Mục | String (VI) | Hành động |
|-----|-------------|-----------|
| Chặn | `string_block` = "Chặn" | chặn người này (sau đó nút **"Bỏ chặn"** `btnUnBlockMe` hiện) |
| Copy nick | `string_copy_nick` = "Copy nick" | sao chép nick |
| Báo nick xấu | `string_bad_nick_report` = "Báo nick xấu" | báo cáo |

**Hồ sơ mình** (`W()`) — chọn quyền riêng tư Me:

| Mục | VI |
|-----|----|
| `string_me_privacy_public` | Cộng đồng |
| `string_me_privacy_friend` | Bạn bè |
| `string_me_privacy_private` | Riêng tư |
| `string_me_privacy_help` | Hướng dẫn |

### Menu nút **Quan tâm** (ẩn — `Z()`, dòng 915)

Bấm nút **Quan tâm** không chỉ theo dõi ngay mà mở popup (khi đã có quan hệ) gồm:

| Mục | String (VI) | API |
|-----|-------------|-----|
| Hủy kết bạn | `string_unfriend` = "Hủy kết bạn" | `OlaApplication.b.e(nick)` |
| Ngừng quan tâm | `string_notfollow` = "Ngừng quan tâm" | `b.a(nick, false, 0)` |
| Quan tâm | `string_follow` = "Quan tâm" | `b.a(nick, true, 0)` |

## 4. Tính năng (tổng hợp các vùng bấm được — `onClick`)

| Vùng | id | Hành động |
|------|----|-----------|
| **Back** | `olaActionBarBackImageView` (1305) | `finish()` đóng màn |
| **Tìm nick/clan** | `searchEditText` (147) | Enter → `#…` mở clan, ngược lại mở trang cá nhân nick đó |
| **FAB Nhắn tin** | `addConversationImageButton` (1194) | mở chat 1-1: `OlaChatViewActivity.a(this, m.j(nick))` |
| **Kéo làm mới** | `pullToRefreshLayout` | nạp lại hồ sơ + feed Me của người này |
| **Xem ảnh bìa** | `coverPictureImageView` (1220) | mở `OlaImageViewerActivity` xem bìa full |
| **Sửa ảnh bìa** | `editCoverPictureImageView` (1230) | `OlaCropImageActivity` (chỉ mình) |
| **Xem avatar** | `profilePictureImageView` (1318) | `OlaImageViewerActivity` xem avatar full |
| **Sửa avatar** | `editProfilePictureImageView` (1235) | `OlaCropImageActivity` (chỉ mình) |
| **Gửi nụ hôn** 💋 | `kissViewLayout` (1277) | `OlaApplication.b.i(nick)` + animation zoom; tăng số nụ hôn. Chưa ai hôn → "Chưa ai hôn" (`string_not_yet_been_kissed`) |
| **Xem ảnh status** | `imgStatusIcon` (1258) | mở ảnh đính kèm trong status |
| **Kho Media** | `mediaStorageViewLayout` (1289) | mình → `OlaCloudAlbumListActivity`; người khác → `OlaCloudPhotoListActivity` |
| **Số fan** | `vLinewarFanNumber` (1333) | `OlaPeopleListActivity` (danh sách người quan tâm) |
| **Đang quan tâm** | `friendViewLayout` (1246) | `OlaPeopleListActivity` (danh sách đang theo dõi) |
| **Tình trạng hôn nhân / avatar bạn đời** | `txtMeUserMarriesStatus`/`honeyProfilePictureImageView` (1252) | mở trang Me của bạn đời |
| **Xem note** | `txtMeUserNote` (1328) | mở `rss://note/<nick>` |
| **Bỏ chặn** | `btnUnBlockMe` (1211) | `OlaApplication.b.o(nick)` bỏ chặn |

### Trạng thái động (các text đổi theo dữ liệu)
- Giới tính: **Nam** (`string_male`) / **Nữ** (`string_female`).
- Hôn nhân: **Độc thân** (`string_marry_alone`/`string_single`) / **Chưa biết** (`string_unknown`) / đã cưới (hiện avatar bạn đời).
- Kết bạn: **Kết bạn** → **Đã Kết Bạn**. Theo dõi: **Quan tâm** → **Đang quan tâm**.

## 5. Strings (EN → VI)

| Key | EN | VI |
|-----|----|----|
| `string_make_friend` | Make friend | Kết bạn |
| `string_already_friend` | Friend | Đã Kết Bạn |
| `string_follow` | Follow | Quan tâm |
| `string_following` | Following | Đang quan tâm |
| `string_update_info` | Update info | Cập Nhật Thông Tin |
| `string_post_me` | Post Me | Viết Me |
| `string_more` | More | Khác |
| `string_people_care` | people care | người quan tâm |
| `string_kiss` | Kiss | Nụ hôn |
| `string_not_yet_been_kissed` | — | Chưa ai hôn |
| `message_vip_account` | VIP account | Tài khoản VIP |
| `string_join_ola` | Join Ola | Tham gia Ola |
| `string_view_note` | View note | Xem bài viết |
| `string_media_store` | Photos | Kho Media |
| `string_view_all_photos` | View all photos | Xem Tất Cả Ảnh |
| `string_following` (mục) | Following | Đang quan tâm |
| `string_view_all_followings` | View all | Xem Tất Cả |
| `string_me_posts` | Me Posts | ME Đã Đăng |
| `string_unblock` | Unblock | Bỏ chặn |
| `string_block` | Block | Chặn |
| `string_copy_nick` | Copy nick | Copy nick |
| `string_bad_nick_report` | Report | Báo nick xấu |
| `string_male` / `string_female` | Male / Female | Nam / Nữ |
| `string_marry_alone` / `string_unknown` | Single / Unknown | Độc thân / Chưa biết |

## 6. Bảng icon & ảnh hiển thị

| Vị trí | Icon/ảnh | Nguồn |
|--------|----------|-------|
| Ảnh bìa | (tải từ URL) | `coverPictureImageView`, nền tạm `colorOlaPrimaryDarkMore` |
| Avatar | (tải từ URL) | `profilePictureImageView` 96dp |
| Avatar bạn đời | (tải từ URL) | `honeyProfilePictureImageView` (ẩn nếu chưa cưới) |
| Sửa ảnh | ![cam](images/icons/ic_action_camera.png) | `ic_action_camera` |
| Đã xác thực SĐT | ![check](images/icons/ic_checked.png) | `ic_checked` |
| Nụ hôn | ![kiss](images/icons/sticker_kiss.png) | `sticker_kiss` |
| Ảnh kèm status | ![photo](images/icons/ic_media_photo.png) | `ic_media_photo` (mặc định) |
| Giới tính | ![gender](images/icons/ic_indicate_dynamic_gender.png) | `ic_indicate_dynamic_gender` |
| Hôn nhân | ![marriage](images/icons/ic_profile_marriage.png) | `ic_profile_marriage` |
| Sinh nhật | ![bday](images/icons/ic_profile_birthday.png) | `ic_profile_birthday` |
| Note | ![note](images/icons/ic_profile_note.png) | `ic_profile_note` |
| VIP | (tải từ URL) | `imgVipIcon` |
| Nút Kết bạn | ![addf](images/icons/ic_add_friend_black_disable.png) | `ic_add_friend_black_disable` |
| Nút Quan tâm | ![follow](images/icons/ic_follow_black_disable.png) | `ic_follow_black_disable` |
| Nút Cập nhật | ![edit](images/icons/ic_edit_profile_gray.png) | `ic_edit_profile_gray` |
| Nút Viết Me | ![postme](images/icons/ic_post_me_gray.png) | `ic_post_me_gray` |
| Nút Khác | ![more](images/icons/ic_more_horizon_black_disable.png) | `ic_more_horizon_black_disable` |
| Tên bạn bè (overlay) | nền `bg_gradient_black`, chữ trắng | lưới Đang quan tâm |
| Back (action bar) | ![back](images/icons/ic_action_back.png) | `ic_action_back` |
| Kính lúp ô tìm | ![search](images/icons/ic_action_search_small.png) | `ic_action_search_small` (16dp) |
| FAB Nhắn tin | ![compose](images/icons/ic_action_compose_message.png) | `ic_action_compose_message` (tint trắng) |

## 7. Tóm tắt token UI

| Thành phần | Giá trị |
|------------|---------|
| Action bar | cao 42dp, nền `bg_action_bar` (#7CB342), padding L8/T4/R16/B10dp, **nổi đè** nội dung |
| Back | `ic_action_back`, marginRight 8dp |
| Ô tìm | nền `bg_edit_text_small_light_border`, padding 8dp; chữ trắng body1 14sp; hint `#4DFFFFFF`; icon kính lúp 16dp |
| FAB Nhắn tin | 56×56dp, padding 16dp, nền `floating_action_bar_shape` tròn, icon tint trắng, margin 16dp |
| ListView | `list.rowSpacing`: không divider/scrollbar; pull-to-refresh (`SwipeRefreshLayout`) |
| Progress giữa màn | 48×48dp, center |
| Thẻ | nền `bg_shadow_span`, cách nhau 8dp |
| Ảnh bìa | tỉ lệ (OlaRatioImageView), nền tạm `#33691E` |
| Avatar | **96×96dp**, khung `bg_shadown_border` (padding 4/4/4/6dp), đè đáy bìa (marginBottom 48dp) |
| Avatar bạn đời | 96×96dp, marginLeft 1dp |
| Nick/ID | headline, `rgba(0,0,0,.54)` |
| Icon ✓ xác thực | 24dp |
| Nút quan hệ | icon 20dp + nhãn caption `rgba(0,0,0,.26)` |
| Nút Bỏ chặn | nền đỏ `btn_red_button_selector`, chữ trắng, padding dọc 16dp |
| Số fan / nụ hôn | title, màu đen |
| Sticker nụ hôn | max 80dp |
| Tiểu sử | caption, tối đa 5 dòng; ảnh status 36dp |
| VIP | icon 24dp + chữ đậm `#FF4081` |
| Dòng thông tin (giới tính/hôn nhân/sinh nhật/note) | caption, marginLeft 16dp, marginTop 8dp, icon drawableLeft + padding 4dp; note in nghiêng màu `#33691E` |
| Lưới Kho Media | 2×3 ô vuông, gap 4dp |
| Lưới Đang quan tâm | 5 ô vuông, tên overlay `bg_gradient_black` (cao tối thiểu 24dp, chữ trắng caption) |
| Divider | 1px `rgba(0,0,0,.12)` |

---

## 8. Bản đồ API ↔ tính năng (gồm tính năng ẩn)

Tất cả lệnh gọi `OlaApplication.b.<method>` (= `OlaNetworkService`) trong `OlaUserMePageActivity`:

| Tính năng | API gọi (file:line) | Ghi chú |
|-----------|---------------------|---------|
| **Tải hồ sơ** người dùng | `b.a(nick, callback)` (387) | nạp toàn bộ thông tin profile |
| **Lấy tên hiển thị** | `b.a(nick, ["name"], cb)` (1014) | resolve field "name" |
| **Resolve nick** | `b.a(nick, p.i cb)` (1046) | tra cứu nick → thông tin |
| **Tải feed Me** (làm mới) | `b.a(nick, true, …)` (874) | bài đăng của người đó |
| **Tải feed Me** (cũ hơn) | `b.a(nick, false, …)` (883) | tải tiếp |
| **Tải thêm bài (paging)** 🔒 | `b.a(nick, n.k(), (short) 79)` (1159) | gọi khi cuộn cuối list (`a_(int)`), **svc 79** |
| **Kết bạn** | `b.d(nick)` (1203) | gửi lời mời / tạo hội thoại |
| **Hủy kết bạn** 🔒 | `b.e(nick)` (921) | trong menu nút Quan tâm |
| **Theo dõi / Bỏ theo dõi** | `b.a(nick, true/false, 0)` (925/928) | "Quan tâm" / "Ngừng quan tâm" |
| **Gửi nụ hôn** 💋 | `b.i(nick)` (1280) | tiêu **KEN** (`i()` kiểm `x.e()` + phát hiệu ứng); chặn tự hôn mình |
| **Chặn** | `b.m(nick)` (721) | menu "Khác" |
| **Bỏ chặn** | `b.o(nick)` (1214) | nút `btnUnBlockMe` |
| **Đặt quyền riêng tư Me** 🔒 | `b.g(0)` / `b.f(0)` / `b.e(0)` (773/790/824) | Cộng đồng / Bạn bè / Riêng tư (menu "Khác" của hồ sơ mình, `W()`) |

> 🔒 = **tính năng ẩn / có điều kiện** (chỉ hiện trong menu phụ hoặc khi đủ điều kiện), không thấy ngay trên màn.

### Tính năng/UI ẩn theo điều kiện (visibility=gone tới khi đủ điều kiện)

| Thành phần | Hiện khi | 
|------------|----------|
| `editProfileViewLayout` + badge `editProfileNotificationTextView` ("!") | **hồ sơ mình** / có thông tin cần cập nhật |
| `editCoverPictureImageView`, `editProfilePictureImageView` (ic_action_camera) | **hồ sơ mình** (sửa bìa/avatar) |
| `honeyProfilePictureImageView` (avatar bạn đời) + `kissViewLayout` cưới | đã **kết hôn** |
| `btnUnBlockMe` ("Bỏ chặn", nền đỏ) | đang **chặn** người này |
| `vipAccountGroup` ("Tài khoản VIP") | tài khoản **VIP** |
| `imgCheckedPhoneNumberVerified` (✓) | đã **xác thực SĐT** |
| Menu Quan tâm (`Z()`: Hủy kết bạn / Ngừng quan tâm) | đã là **bạn / đang theo dõi** |
| Menu "Khác" = privacy (`W()`) vs block/report (`X()`) | **mình** vs **người khác** |

---

## 9. CSS tương đương (dựng lại trên web)

```css
/* ===== Khung màn (scaffold) ===== */
.ola-page { position: relative; min-height: 100vh; padding-top: 42px; }   /* chừa action bar nổi */
.ola-page__actionbar {                              /* bg_action_bar xanh Ola */
  position: fixed; top: 0; left: 0; right: 0; height: 42px; z-index: 10;
  display: flex; align-items: center; gap: 8px;
  padding: 4px 16px 10px 8px; background: #7CB342;
}
.ola-page__back { width: 24px; height: 24px; }
.ola-page__search {                                 /* edittext.small.border.light */
  flex: 1; display: flex; align-items: center; gap: 4px;
  padding: 8px; border-radius: 4px; background: rgba(255,255,255,.18);
}
.ola-page__search img { width: 16px; height: 16px; }
.ola-page__search input {
  flex: 1; border: none; background: none; color: #fff; font-size: 14px;
}
.ola-page__search input::placeholder { color: rgba(255,255,255,.30); }   /* #4DFFFFFF */
.ola-page__fab {                                    /* floating_action_bar_shape */
  position: fixed; right: 16px; bottom: 16px; width: 56px; height: 56px;
  padding: 16px; border-radius: 50%; border: none;
  background: #7CB342; box-shadow: 0 3px 6px rgba(0,0,0,.3);
}
.ola-page__fab img { width: 100%; height: 100%; filter: brightness(0) invert(1); }  /* tint trắng */

/* ===== Thẻ chung ===== */
.ola-profile { background: #ECEFF1; font-family: Roboto, "Helvetica Neue", Arial, sans-serif; }
.ola-profile__card {
  background: #FFFFFF; margin-bottom: 8px;
  box-shadow: 0 1px 2px rgba(0,0,0,.18);          /* bg_shadow_span */
}

/* ===== Bìa + avatar ===== */
.ola-profile__cover {
  position: relative; width: 100%; aspect-ratio: 16/9;  /* OlaRatioImageView mặc định 1.777 (BASE_WIDTH) */
  background: #33691E center/cover no-repeat;      /* colorOlaPrimaryDarkMore */
  margin-bottom: 48px;
}
.ola-profile__avatar-frame {
  position: absolute; left: 50%; bottom: -48px; transform: translateX(-50%);
  background: #fff; padding: 4px 4px 6px;
  box-shadow: 0 1px 3px rgba(0,0,0,.3);            /* bg_shadown_border */
  display: flex;
}
.ola-profile__avatar { width: 96px; height: 96px; object-fit: cover; }
.ola-profile__avatar--honey { margin-left: 1px; }  /* avatar bạn đời */
.ola-profile__edit-cam {                            /* ic_action_camera */
  position: absolute; right: 4px; bottom: 4px; width: 24px; height: 24px;
}

/* ===== ID + xác thực ===== */
.ola-profile__id { display: flex; align-items: center; justify-content: center; gap: 4px; padding: 8px; }
.ola-profile__nick { font-size: 24px; color: rgba(0,0,0,.54); }   /* headline — contactIdTextView đặt textSize=headline trực tiếp (đè style caption) */
.ola-profile__verified { width: 24px; height: 24px; }

/* ===== 5 nút quan hệ ===== */
.ola-profile__actions { display: flex; padding: 8px; }
.ola-profile__btn {
  flex: 1; display: flex; flex-direction: column; align-items: center; gap: 4px;
  background: none; border: none;
  font-size: 12px; color: rgba(0,0,0,.26);          /* colorTextBlackHintOrDisable */
}
.ola-profile__btn img { height: 20px; }
.ola-profile__btn--unblock {                        /* btnUnBlockMe */
  width: 100%; padding: 16px 0; background: #dd4b39; color: #fff;   /* btn_red_button hardcode #dd4b39, không phải token red #E34545 */
  border: none; font-size: 12px;
}

/* ===== Số fan / nụ hôn ===== */
.ola-profile__fans, .ola-profile__kiss {
  display: flex; align-items: center; justify-content: center; gap: 2px; margin-top: 16px;
}
.ola-profile__fans b { font-size: 20px; color: #000; }     /* fanNumberTextView (title) */
.ola-profile__fans span { font-size: 12px; color: rgba(0,0,0,.54); }
.ola-profile__kiss img { max-height: 80px; }                /* sticker_kiss */
.ola-profile__kiss b { font-size: 20px; color: #000; }

/* ===== Tiểu sử + dòng thông tin ===== */
.ola-profile__bio {
  display: flex; gap: 8px; margin: 0 16px 8px;
  font-size: 12px; color: rgba(0,0,0,.54);
}
.ola-profile__bio-text { flex: 1; text-align: center;
  display: -webkit-box; -webkit-line-clamp: 5; -webkit-box-orient: vertical; overflow: hidden; }
.ola-profile__status-icon { width: 36px; height: 36px; object-fit: cover; }
.ola-profile__vip { display: flex; align-items: center; gap: 4px; margin-left: 16px; }
.ola-profile__vip img { width: 24px; height: 24px; }
.ola-profile__vip span { font-weight: bold; color: #FF4081; font-size: 12px; }  /* colorOlaAccent */
.ola-profile__info {                                /* giới tính / hôn nhân / sinh nhật / note */
  display: flex; align-items: center; gap: 4px;
  margin: 8px 0 0 16px; font-size: 12px; color: rgba(0,0,0,.54);
}
.ola-profile__info img { width: 16px; height: 16px; }       /* drawableLeft */
.ola-profile__info--note { font-style: italic; color: #33691E; }

/* ===== Kho Media (2×3) ===== */
.ola-profile__section-title { margin: 8px 16px; font-size: 16px; color: rgba(0,0,0,.54); }
.ola-profile__media-grid {
  display: grid; grid-template-columns: repeat(3, 1fr); gap: 4px; padding: 0 8px;
}
.ola-profile__media-grid img { width: 100%; aspect-ratio: 1; object-fit: cover; }

/* ===== Đang quan tâm (5 ô + tên overlay) ===== */
.ola-profile__friend-grid { display: flex; gap: 4px; padding: 0 8px; }
.ola-profile__friend { position: relative; flex: 1; aspect-ratio: 1; }
.ola-profile__friend img { width: 100%; height: 100%; object-fit: cover; }
.ola-profile__friend span {
  position: absolute; left: 0; right: 0; bottom: 0; min-height: 24px;
  padding: 4px; text-align: center;
  background: linear-gradient(transparent, rgba(0,0,0,.7));  /* bg_gradient_black */
  color: #fff; font-size: 12px;
}
.ola-profile__view-all { display: block; text-align: center; padding: 12px 0; font-size: 14px; color: rgba(0,0,0,.54); }
```

```html
<div class="ola-page">
  <div class="ola-page__actionbar">
    <img class="ola-page__back" src="images/icons/ic_action_back.png">
    <div class="ola-page__search">
      <img src="images/icons/ic_action_search_small.png">
      <input placeholder="Enter nick or #clan">
    </div>
  </div>
  <div class="ola-profile">
  <div class="ola-profile__card">
    <div class="ola-profile__cover" style="background-image:url(cover.jpg)">
      <div class="ola-profile__avatar-frame">
        <img class="ola-profile__avatar" src="avatar.jpg">
      </div>
    </div>
    <div class="ola-profile__id">
      <span class="ola-profile__nick">linhchi92</span>
      <img class="ola-profile__verified" src="images/icons/ic_checked.png">
    </div>
    <div class="ola-profile__actions">
      <button class="ola-profile__btn"><img src="images/icons/ic_add_friend_black_disable.png">Kết bạn</button>
      <button class="ola-profile__btn"><img src="images/icons/ic_follow_black_disable.png">Quan tâm</button>
      <button class="ola-profile__btn"><img src="images/icons/ic_post_me_gray.png">Viết Me</button>
      <button class="ola-profile__btn"><img src="images/icons/ic_more_horizon_black_disable.png">Khác</button>
    </div>
    <div class="ola-profile__fans"><b>128</b><span>người quan tâm</span></div>
    <div class="ola-profile__info"><img src="images/icons/ic_indicate_dynamic_gender.png">Nữ</div>
  </div>
  </div>
  <button class="ola-page__fab"><img src="images/icons/ic_action_compose_message.png"></button>
</div>
```
