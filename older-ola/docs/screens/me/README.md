# Màn hình Me (Bảng tin cá nhân / Newsfeed)

- **Tab:** Bottom tab thứ 3 — string `general_tab_me` = "Me".
- **Fragment:** `chat.ola.vn.me.c` — `jadx_out/sources/chat/ola/vn/me/c.java`
- **Layout màn:** `apktool_out/res/layout/me_view_layout.xml`
- **Item bài đăng:** `me_entry_layout.xml` (gồm 3 phần include + ViewStub)
- **Adapter feed:** `chat.ola.vn.me.u` (extends `q`)
- **Đăng bài:** `OlaMeComposerActivity` + `ola_me_composer_layout.xml`
- **Trang cá nhân:** `OlaUserMePageActivity` (người) / `OlaClanMePageActivity` (clan) + `ola_user_me_page_header_layout.xml`
- **Phụ trợ:** `OlaMeCommentActivity` (bình luận), `OlaMeLikerListActivity` (ai đã thích), `OlaVisitorListActivity` (khách ghé thăm), `OlaDiaryActivity` (nhật ký)

> **Me là gì:** đây là **mạng xã hội dòng thời gian** bên trong Ola — giống newsfeed Facebook. Người dùng đăng trạng thái (text/ảnh/sticker/check-in), người khác **Thích / Ghét / Bình luận**, theo dõi nhau ("Quan tâm"). Khác với "Phòng chat" (chat thời gian thực) và "Chat" (1-1): Me là **nội dung tồn tại lâu, có tương tác công khai**.

> Tài liệu này dựng từ **code + XML** (chưa chụp ảnh). Khi bật được fake server cấp feed sẽ chụp bổ sung.

---

## 1. Flow tổng thể

```
                         ┌─────────────────────────────────────────┐
                         │  Bottom tab "Me"  → Fragment me.c        │
                         └─────────────────────────────────────────┘
                                          │
            ┌─────────────────────────────┼──────────────────────────────┐
            │                             │                              │
     [Action bar 4 icon]          [Feed - OlaListView]            [FAB ✎ đăng bài]
     btnHomePage  (Bảng tin)      kéo-xuống làm mới               writeStatusImageButton
     btnReplyMe   (@ Nhắc đến)    mỗi dòng = me_entry_layout            │
     btnMediaMe   (Ảnh)                   │                              ▼
     buttonFollower (Quan tâm)            │                   OlaMeComposerActivity
            │                             │                   (text + ảnh + sticker +
            │ f(null/"tl"/"md")           │                    check-in + quyền riêng tư)
            ▼                             ▼                              │
     đổi tab feed              ┌──────────────────────┐          [Đăng] → server
     (icon _selected)          │ 1 bài đăng (post):   │
                               │  • avatar + tên + giờ │
     buttonFollower ─────────► │  • nội dung + ảnh     │
     OlaVisitorListActivity    │  • Thống kê like/cmt  │
                               │  • [Bình luận][Ghét]  │
                               │       [Thích]         │◄── bấm Thích → ic_like_selected
                               └──────────┬───────────┘
                                          │ bấm avatar/tên
                                          ▼
                               OlaUserMePageActivity (trang cá nhân)
                               ola_user_me_page_header_layout:
                               cover + avatar 96dp + "X người quan tâm"
                               + [Quan tâm/Nhắn tin] + Kho Media (6 ảnh)
                               + Đang quan tâm (5 người) + "Me Posts"
                                          │ bấm "Bình luận"
                                          ▼
                               OlaMeCommentActivity (luồng bình luận)

   [Drawer trái 240dp]  ← vuốt mép trái: danh sách Clan / Nhật ký / trang yêu thích
   [Drawer phải 240dp]  → lịch sử & kết quả tìm kiếm
   [Thanh "↑ Me mới"]   khi có bài mới → bấm để nạp (txtNewUnreadMeInfo)
```

---

## 2. Bố cục màn (`me_view_layout.xml`)

```
DrawerLayout  @id/meDrawerLayout
├─ RelativeLayout (nội dung chính)
│   ├─ FrameLayout (paddingTop 42dp = chừa action bar)
│   │   ├─ SwipeRefreshLayout  @id/swipeRefreshLayout         ← kéo-để-làm-mới
│   │   │   └─ OlaListView  @id/listView  (list.rowSpacing, scrollbars none)  ← FEED
│   │   ├─ <include> blank_page_layout  @id/stubBlankContent  (ẩn)  ← empty state
│   │   ├─ ProgressBar  @id/meWattingProgress  (giữa)         ← đang tải
│   │   └─ ImageButton  @id/writeStatusImageButton  56dp, góc phải-dưới (margin 16dp),
│   │        nền floating_action_bar_shape, src=ic_action_edit, tint trắng   ← FAB đăng bài
│   ├─ LinearLayout  @id/stickyHeader  (style actionBar.background — nền xanh #7CB342)  ← ACTION BAR
│   │   └─ LinearLayout  @id/linearQuickButton  (canh giữa, marginL/R 32dp, weight 1)
│   │       ├─ FrameLayout (minWidth 48dp)
│   │       │   ├─ ImageView  @id/btnHomePage  (ic_action_tab_ola, padding 8dp)   ← Bảng tin
│   │       │   └─ TextView   @id/txtNewMeNotify  (badge số, ẩn)
│   │       ├─ ImageView  @id/btnReplyMe          (ic_action_tab_tag)             ← @ Nhắc đến
│   │       ├─ ImageView  @id/btnMediaMe          (ic_action_tab_media)           ← Ảnh
│   │       └─ ImageView  @id/buttonFollowerImageView (ic_action_tab_follower)    ← Quan tâm
│   └─ TextView  @id/txtNewUnreadMeInfo  (dưới stickyHeader, canh giữa,
│        nền bg_unread_info, chữ body1 màu colorOlaPrimaryDark, ẩn)   ← "↑ Me mới"
├─ OlaListView  @id/left_drawer   240dp, nền trắng   ← Clan / Nhật ký / trang yêu thích
└─ OlaListView  @id/right_drawer  240dp, nền trắng   ← lịch sử tìm kiếm
```

### 2.1. Hai drawer (menu trái & phải)

> **Mở drawer = cử chỉ vuốt cạnh, KHÔNG có nút.** Action bar chỉ có 4 icon tab, không có nút hamburger; trong `me.c` không hề gọi `openDrawer`, chỉ `closeDrawer(3)`/`closeDrawer(5)`. Vì vậy người dùng **vuốt từ mép trái sang phải** để mở menu trái, **vuốt từ mép phải sang trái** để mở menu tìm kiếm.

#### a) Drawer TRÁI — menu trang Me (`Gravity.LEFT`, `left_drawer` = `this.u`)

Là `OlaListView` 240dp nền trắng. Gồm **header người dùng** + **danh sách trang Me** (adapter `chat.ola.vn.b.an`):

```
left_drawer (240dp)
├─ [Header] system_me_menu_user_info_header   (addHeaderView, me/c.java:552)
│   ├─ OlaRatioImageView  imgMenuConver        ← ảnh bìa của mình
│   ├─ OlaCachedImageView imgMeOwnerAvatar  40dp
│   └─ TextView  txtMeOwnerAlias  (chữ trắng, overlay gradient đen)
│        = tên hiển thị, mặc định string_personal = "Cá nhân"
└─ [List] adapter an  (entity.af, nguồn h.u.b())  — item = slider_menu_item.xml:
    ├─ ImageView  imgMenuIcon   (af.c(); mặc định ic_indicate_like)
    └─ TextView   imgMenuTitle  (af.a() — tên trang)
```

**Vì sao thấy NHIỀU mục?** Ngoài các Clan/trang bạn theo dõi, hệ thống **tự chèn một loạt trang Me cố định** vào danh sách (`network/e.java:2950–3005`). Thứ tự & nội dung đầy đủ:

| # | Tên hiển thị (VI) | Mã `af.b()` | String | Icon (`af.c()`) | Điều kiện |
|---|-------------------|-------------|--------|------------------|-----------|
| 0 | **Nhật ký** | `my diary` | `system_me_diary` | `ic_indicate_note` | luôn (thêm đầu list) |
| 1 | **Box - Kết Hôn** | `mariage diary` | `system_me_box` | `ic_indicate_box` | luôn (thêm thứ 2) |
| … | *(các Clan / trang bạn theo dõi)* | `#<clan>` / nick | — | icon riêng / mặc định | theo dữ liệu user |
| | **Me yêu thích** | `lk` | `system_me_likes` | `ic_section_like` | khi bật (z2) |
| | **Đập trứng** 🥚 | `#daptrung` | `system_me_eggy` | `ic_indicate_broken_egg` | khi bật (z) |
| | **#Android** | `#apk` | (literal "#Android") | `ic_indicate_android` | luôn |
| | **#Ola** | `#Ola` | (literal "#Ola") | `ic_indicate_me` | luôn |
| | **Hài hước** | `#hai` | `system_me_funny` | `ic_indicate_funny` | luôn |

> Ngoài ra trong cùng nhóm icon còn có `me` → "Mọi người" (`ic_indicate_public`) và `rs` → RSS (`ic_indicate_rss`) khi xuất hiện.

**Bấm 1 mục** (`me.c` `onItemClick` → `a(String, long)` dòng 205) — rẽ nhánh theo mã:

| Mã `af.b()` | Mở |
|-------------|----|
| `my diary` | `OlaDiaryActivity` (Nhật ký của tôi) |
| `mariage diary` | nhật ký hôn nhân (`a(j)`) |
| `#<clan>` (kể cả `#daptrung`, `#apk`, `#Ola`, `#hai`) — `e(strJ)==true` | nạp trang Me kiểu Clan → `OlaClanMePageActivity` |
| nick / còn lại | `OlaUserMePageActivity` (trang cá nhân) |

> Tức drawer trái = **Nhật ký + Box Kết Hôn + (Clan/trang theo dõi) + Me yêu thích + Đập trứng + #Android + #Ola + Hài hước** — nên danh sách dài chứ không chỉ vài mục.

> **"Đập trứng" (`#daptrung`) nằm ở đây.** Hệ thống tự thêm một `entity.af` = `af("Đập trứng" /*system_me_eggy*/, "#daptrung")` ([network/e.java:2986](../../../jadx_out/sources/chat/ola/vn/network/e.java#L2986)); item này được gán icon **trứng nứt** `ic_indicate_broken_egg` ([r/a/e.java:517](../../../jadx_out/sources/chat/ola/vn/r/a/e.java#L517)). Bấm vào → mở **`OlaClanMePageActivity`** (trang Me kiểu Clan, feed bài đăng) — **KHÔNG phải lưới trứng để đập**. Client **không có** màn game đập trứng riêng (không layout/Activity `egg`); trò đập trứng do **server/web** điều khiển qua feed của trang `#daptrung`.

#### b) Drawer PHẢI — tìm kiếm Me (`Gravity.RIGHT`, `right_drawer` = `this.w`)

`OlaListView` 240dp. Header `me_history_search_layout.xml` + danh sách lịch sử/kết quả (adapter `chat.ola.vn.me.b`, `this.x`):

```
right_drawer (240dp)
├─ [Header] me_history_search_layout
│   ├─ Ô tìm kiếm  (nền bg_search_box, cao 40dp, padding 16/12dp)
│   │   ├─ ImageView  ic_action_search_small_gray  16dp
│   │   └─ OlaQuickTypingSuggestedText  searchSuggestedText
│   │        hint string_search = "Tìm kiếm", imeOptions=actionSearch
│   ├─ View 1px (kẻ ngăn)
│   └─ LinearLayout (nền trắng, padding 16/8dp)
│       ├─ TextView  string_recent_me = "ME ĐÃ XEM"  (caption, weight 1)
│       └─ TextView  clearHistoryTextView  string_clear = "Xóa"  (caption)  ← xoá lịch sử
└─ [List] adapter me.b  — lịch sử Me đã xem / kết quả tìm kiếm
```

**Tương tác**: gõ vào ô tìm → tìm nick / #clan (gợi ý `string_enter_nick_name_or_clan` = "Nhập nick hoặc #clan"); bấm **Xóa** (`clearHistoryTextView`, `me.c` dòng 1027) → xoá toàn bộ "ME ĐÃ XEM"; bấm 1 mục lịch sử/kết quả → mở trang Me tương ứng (cùng logic `a(String,long)` như drawer trái).

## 3. Action bar — 4 icon (`stickyHeader`)

Mỗi icon là `ImageView` style `actionBar.tab.button`, nền `btn_transparent_image_selector`, padding 8dp, minWidth 48dp. Bấm gọi `c.f(<tab>)` → đổi icon sang bản `_selected` (logic ở `c.i(String)`).

| # | id | Icon thường | Icon chọn | Tab | Code | Mở |
|---|----|-------------|-----------|-----|------|----|
| 1 | `btnHomePage` | ![ola](images/icons/ic_action_tab_ola.png) | ![ola sel](images/icons/ic_action_tab_ola_selected.png) | **Bảng tin** (feed) | `f(null)` | feed mặc định + badge `txtNewMeNotify` |
| 2 | `btnReplyMe` | ![tag](images/icons/ic_action_tab_tag.png) | ![tag sel](images/icons/ic_action_tab_tag_selected.png) | **@ Nhắc đến** | `f("tl")` | bài có nhắc/trả lời mình |
| 3 | `btnMediaMe` | ![media](images/icons/ic_action_tab_media.png) | ![media sel](images/icons/ic_action_tab_media_selected.png) | **Ảnh** | `f("md")` | chỉ bài có media |
| 4 | `buttonFollowerImageView` | ![follow](images/icons/ic_action_tab_follower.png) | ![follow sel](images/icons/ic_action_tab_follower_selected.png) | **Quan tâm** | `"av"` | `OlaVisitorListActivity` (khách ghé thăm) |

> Thanh **"↑ Me mới"** (`txtNewUnreadMeInfo` = `message_new_me_inform`) hiện ngay dưới action bar khi có bài mới; bấm → `c.d()` nạp bài.

## 4. Item 1 bài đăng (`me_entry_layout.xml`)

Container `@id/meContentView`, nền **`bg_shadow_2_edges`** (thẻ trắng có bóng 2 cạnh — kiểu card). Ghép từ 3 phần + 2 ViewStub:

```
meContentView (card, bg_shadow_2_edges)
├─ <include> me_entry_body_text_part_layout   ← ĐẦU BÀI (avatar + tên + giờ + nội dung)
├─ FrameLayout
│   ├─ ViewStub  meMediaAttachedViewStub  (visible)  ← lưới ảnh/video đính kèm
│   └─ ViewStub  meCheckInViewStub        (gone)     ← thông tin check-in
├─ <include> me_entry_body_media_and_button_part_layout  ← THỐNG KÊ + NÚT HÀNH ĐỘNG
└─ ViewStub  meSuggestedPhotoViewStub  (me_entry_suggested_photo_layout)  ← gợi ý ảnh
```

### 4.1. Đầu bài — `me_entry_body_text_part_layout.xml` (padding L/T/B 16dp)

```
LinearLayout vertical
├─ LinearLayout (hàng tác giả)
│   ├─ RelativeLayout (weight 1)
│   │   ├─ OlaCachedImageView  imgMeAvatarThumbnail  40×40dp, centerCrop (ic_contact_photo)
│   │   └─ LinearLayout  meOwnerInfoSpan (bên phải avatar, marginLeft 16dp)
│   │       ├─ LinearLayout  txtMeOwnerName (ngang)
│   │       │   ├─ OlaCachedImageView  vipImageMeOwner  24dp (ẩn nếu không VIP)
│   │       │   └─ TextView  txtMeItemTitle  (subhead 16sp, 1 dòng)        ← TÊN
│   │       └─ TextView  txtMeItemTimeAgo  (caption 12sp, marginTop 2dp)   ← giờ "x phút trước"
│   ├─ ImageView  btnMeItemFooterMore  (ic_more, 36dp, padding 8dp)        ← menu ⋮
│   └─ ImageView  btnMakeFriend  (ic_add_friend_black_disable, ẩn)         ← kết bạn nhanh
└─ LinearLayout (ngang, paddingTop 16dp)
    ├─ OlaCachedImageView  stickerImageView  cao 84dp (ẩn)                 ← sticker
    └─ CommpressTextView  txtMeItemContent  (body1 14sp, max 5 dòng,       ← NỘI DUNG
                                              lineSpacing ×1.2, "Xem thêm")
```

### 4.2. Thống kê + nút — `me_entry_body_media_and_button_part_layout.xml`

```
LinearLayout vertical (paddingBottom 12dp)
├─ LinearLayout (đếm media)
│   ├─ TextView  imgMeItemMediaVideo  (nền ic_media_video, style me.media.count)  ← số video
│   └─ TextView  imgMeItemMediaSound  (nền ic_media_sound)                         ← số audio
├─ FrameLayout  attachedMeItemSpan  (nền bg_me_entry_attached_item, margin 16dp)   ← media chia sẻ
├─ TextView  advViewCount  (nền btn_green_button_selector, chữ trắng, cao 32dp)    ← lượt xem (quảng cáo)
├─ LinearLayout  btnMeItemLikeSpan  (cao 20dp, canh phải, margin 16dp)             ← DÒNG THỐNG KÊ
│   ├─ TextView  btnMeItemViewComment  (caption, weight 1, trái)        ← "X bình luận"
│   ├─ OlaCachedImageView  imgMeItemLikeBuddy1/2/3  20dp                ← 3 avatar người thích
│   └─ TextView  txtMeItemLikeNumber  (caption)                        ← "X lượt thích"
├─ View  btnMeActionSpanDivider  1px, colorTextBlackDivider, margin 16dp
└─ LinearLayout  btnMeActionSpan  (ngang, padding 16dp, top 12dp)       ← 3 NÚT (mỗi nút weight 1, cao 28dp)
    ├─ btnMeItemFooterReply   ic_action_reply_gray + "Bình luận"
    ├─ txtMeItemDislikeWrapper  ic_dislike_gray   + "Ghét"  (icon txtMeItemDislikeIcon)
    └─ txtMeItemLikeWrapper     ic_like_gray      + "Thích" (icon txtMeItemLikeIcon)
```

> Thứ tự nút trái→phải: **Bình luận · Ghét · Thích**. Chữ nút màu `colorTextBlackHintOrDisable` (xám nhạt). Khi đã thích → icon đổi `ic_like_gray` → `ic_like_selected` (xanh), chữ "Thích" → "Đã thích".

### 4.3. Các loại bài đăng (layout `me_entry_*`)

| Loại | Layout / dấu hiệu |
|------|-------------------|
| Text thường | `me_entry_layout` (chỉ `txtMeItemContent`) |
| Text + ảnh/video | + `meMediaAttachedViewStub` (lưới ảnh) + bộ đếm video/audio |
| Text + sticker | + `stickerImageView` (84dp) |
| Check-in vị trí | + `meCheckInViewStub` |
| Địa điểm (venue) | `me_entry_venue_layout`, `me_entry_venue_with_mediacodes_layout` |
| YouTube | `me_entry_youtube_me_layout` |
| Kỷ niệm "ngày này năm xưa" | `me_entry_history_story_layout` |
| Gợi ý kết bạn / ảnh | `me_entry_suggested_friend_layout`, `me_entry_suggested_photo_layout` |
| Quảng cáo | `me_entry_advertisment_general_me_layout`, `_software_me_layout`, `me_entry_admob_native_layout` |

## 5. Trang cá nhân (`OlaUserMePageActivity` / `ola_user_me_page_header_layout.xml`)

> 📄 **Tài liệu chi tiết riêng:** [trang-ca-nhan/README.md](../trang-ca-nhan/README.md) — đầy đủ 5 nút quan hệ, menu "Khác", mọi vùng bấm, icon & token. Dưới đây là bản tóm tắt.

Header (cuộn cùng feed của người đó), từ trên xuống:

| Phần | View id | Ghi chú |
|------|---------|---------|
| **Ảnh bìa** | `coverPictureImageView` | tỉ lệ, nền `colorOlaPrimaryDarkMore`; nút sửa `editCoverPictureImageView` (chỉ của mình) |
| **Avatar** | `profilePictureImageView` | **96×96dp**, đè lên bìa; `honeyProfilePictureImageView` = avatar bạn đời (nếu đã kết hôn) |
| **ID + xác thực** | `contactIdTextView` + `imgCheckedPhoneNumberVerified` | headline, dấu ✓ nếu xác thực SĐT |
| **Nút quan hệ** | `add_follow_post_more_button_layout` | Quan tâm / Nhắn tin / ⋮; `btnUnBlockMe` (đỏ) nếu đang chặn |
| **Số fan** | `fanNumberTextView` + "người quan tâm" | `string_people_care` |
| **Nụ hôn** | `kissImageView` + `kissTextView` | `string_kiss` (cặp đã cưới) |
| **Tiểu sử/status** | `txtInfoStatusSpan` (max 5 dòng) + `imgStatusIcon` 36dp | |
| **VIP** | `imgVipIcon` 24dp + "VIP Account" (chữ `colorOlaAccent`, đậm) | |
| **Thông tin** | `txtJoinOlaDate`, `txtMeUserGender`, `txtMeUserMarriesStatus`, `txtMeUserBirthday`, `txtMeUserNote` | mỗi dòng có drawableLeft riêng (gender/marriage/birthday/note) |
| **Kho Media** | `mediaImageView1..6` | lưới **6 ảnh**, "Xem Tất Cả Ảnh" (`string_view_all_photos`) |
| **Đang quan tâm** | `friendImageView1..5` + `friendTextView1..5` | lưới **5 người** (tên overlay gradient đen), "Xem tất cả" |
| **Footer** | "Me Posts" | mở đầu danh sách bài đăng |

> Drawer trái header (`system_me_menu_user_info_header.xml`): ảnh bìa `imgMenuConver` + avatar 40dp `imgMeOwnerAvatar` + tên trắng `txtMeOwnerAlias` (overlay gradient đen).

## 6. Đăng bài mới (`OlaMeComposerActivity` / `ola_me_composer_layout.xml`)

Mở từ FAB ✎. Bố cục (SoftKeyLinearLayout — co theo bàn phím):

| Phần | id | Nội dung |
|------|----|----|
| **Quyền riêng tư** | `postToViewLayout` → `postToTextView` | "To:" + chọn **Cộng đồng / Bạn bè / Riêng tư / Clan** (ic_arrow_right) |
| **Đăng lên trang Me** | `postToMeCheckBox` | `string_post_status_to_me_page` = "Đăng trạng thái lên trang Me" (ẩn mặc định) |
| **Sticker** | `stickerImageView` | 72×72dp (ẩn) |
| **Ô nhập** | `meContentEditText` (OlaTypingSuggestedText) | minHeight 48dp, đa dòng, hint `general_hint_me` = **"Hôm nay có gì hot …"** |
| **Gợi ý địa điểm** | `suggestedVenueViewLayout` | check-in |
| **Ảnh đính kèm** | `attachedPhotoListView` (HListView) | cao 164dp (ẩn tới khi chọn ảnh) |
| **Thanh đính kèm** | `chatAttachmentLayout` | ảnh / máy ảnh / vị trí / sticker (dùng chung với chat) |
| **Action bar** | `ola_top_action_bar_center_title_layout` | tiêu đề `general_tab_me_edit` = "Viết mới" + nút Đăng |

> Quyền riêng tư: `string_me_privacy_public` = **Cộng đồng**, `_friend` = **Bạn bè**, `_private` = **Riêng tư**.
> Thoát giữa chừng → hỏi lưu nháp (`message_edit_me_back_confirm`); nháp quản lý bởi class `chat.ola.vn.me.a`.

## 7. Strings (EN → VI)

| Key | EN | VI |
|-----|----|----|
| `general_tab_me` | Me | Me |
| `general_tab_me_edit` | Post Me | Viết mới |
| `general_hint_me` | What's on your mind? | Hôm nay có gì hot … |
| `string_like` | Like | Thích |
| `string_dislike` | Dislike | Ghét |
| `string_comment` | Comment | Bình luận |
| `string_follow` | Follow | Quan tâm |
| `string_following` | Following | Đang quan tâm |
| `string_people_care` | people care | người quan tâm |
| `string_kiss` | Kiss | Nụ hôn |
| `message_new_me_inform` | You have new posts | ↑ Me mới |
| `me_no_content_page` | Me page has no content | Trang Me chưa có nội dung |
| `string_me_privacy_public` | Public | Cộng đồng |
| `string_me_privacy_friend` | Friends | Bạn bè |
| `string_me_privacy_private` | Private | Riêng tư |
| `string_media_store` | Photos | Kho Media |
| `string_view_all_photos` | View all photos | Xem Tất Cả Ảnh |
| `string_post_status_to_me_page` | Post to Me page | Đăng trạng thái lên trang Me |
| `general_tab_diary_edit` | Write Diary | Viết nhật ký |
| `string_personal` | Personal | Cá nhân |
| `string_search` | Search | Tìm kiếm |
| `string_recent_me` | Recent Me | ME ĐÃ XEM |
| `string_clear` | Clear | Xóa |
| `string_enter_nick_name_or_clan` | Enter nick name or clan | Nhập nick hoặc #clan |

## 8. CSS tương đương — 1 bài đăng (card feed)

```css
/* ===== Card 1 bài đăng ===== */
.ola-me-post {
  background: #FFFFFF;
  box-shadow: 0 1px 2px rgba(0,0,0,.18);     /* bg_shadow_2_edges */
  margin-bottom: 8px;
  font-family: Roboto, "Helvetica Neue", Arial, sans-serif;
}
/* Đầu bài */
.ola-me-post__head { display: flex; align-items: flex-start; padding: 16px 0 0 16px; }
.ola-me-post__avatar { width: 40px; height: 40px; border-radius: 50%; object-fit: cover; flex-shrink: 0; }
.ola-me-post__author { flex: 1; margin-left: 16px; }
.ola-me-post__name { display: flex; align-items: center; font-size: 16px; color: rgba(0,0,0,.87); }
.ola-me-post__vip { width: 24px; height: 24px; margin-right: 4px; }
.ola-me-post__time { margin-top: 2px; font-size: 12px; color: rgba(0,0,0,.54); }
.ola-me-post__more { width: 36px; padding: 0 8px; color: rgba(0,0,0,.54); }   /* ic_more */
/* Nội dung */
.ola-me-post__body { display: flex; padding: 16px 16px 0 16px; }
.ola-me-post__sticker { height: 84px; margin-right: 8px; }
.ola-me-post__text {
  flex: 1; font-size: 14px; line-height: 1.2; color: rgba(0,0,0,.87);
  display: -webkit-box; -webkit-line-clamp: 5; -webkit-box-orient: vertical; overflow: hidden;
}
/* Ảnh đính kèm */
.ola-me-post__media { margin: 16px; }
.ola-me-post__media img { width: 100%; display: block; border-radius: 2px; }

/* Dòng thống kê */
.ola-me-post__stats {
  display: flex; align-items: flex-end; justify-content: flex-end;
  height: 20px; margin: 16px 16px 0; gap: 2px;
  font-size: 12px; color: rgba(0,0,0,.54);
}
.ola-me-post__cmt-count { flex: 1; }                 /* "X bình luận" canh trái */
.ola-me-post__liker { width: 20px; height: 20px; border-radius: 50%; }
.ola-me-post__like-count { margin-left: 8px; }

/* Nút hành động */
.ola-me-post__divider { height: 1px; background: rgba(0,0,0,.12); margin: 4px 16px 0; }
.ola-me-post__actions { display: flex; padding: 12px 16px 0; }
.ola-me-post__btn {
  flex: 1; height: 28px;
  display: flex; align-items: center; justify-content: center; gap: 2px;
  background: none; border: none;
  font-size: 14px; color: rgba(0,0,0,.26);          /* colorTextBlackHintOrDisable */
}
.ola-me-post__btn img { height: 100%; }
.ola-me-post__btn.is-liked { color: #7CB342; }       /* đã thích → ic_like_selected */
```

```html
<article class="ola-me-post">
  <div class="ola-me-post__head">
    <img class="ola-me-post__avatar" src="...">
    <div class="ola-me-post__author">
      <div class="ola-me-post__name">linhchi92</div>
      <div class="ola-me-post__time">5 phút trước</div>
    </div>
    <img class="ola-me-post__more" src="images/icons/ic_more.png">
  </div>
  <div class="ola-me-post__body">
    <p class="ola-me-post__text">Hôm nay trời đẹp quá ☀️ #ola</p>
  </div>
  <div class="ola-me-post__media"><img src="..."></div>
  <div class="ola-me-post__stats">
    <span class="ola-me-post__cmt-count">12 bình luận</span>
    <img class="ola-me-post__liker" src="..."><img class="ola-me-post__liker" src="...">
    <span class="ola-me-post__like-count">34 lượt thích</span>
  </div>
  <div class="ola-me-post__divider"></div>
  <div class="ola-me-post__actions">
    <button class="ola-me-post__btn"><img src="images/icons/ic_action_reply_gray.png">Bình luận</button>
    <button class="ola-me-post__btn"><img src="images/icons/ic_dislike_gray.png">Ghét</button>
    <button class="ola-me-post__btn is-liked"><img src="images/icons/ic_like_selected.png">Đã thích</button>
  </div>
</article>
```

## 9. Bảng icon đặc trưng

| UI | Icon | Drawable |
|----|------|----------|
| Tab Bảng tin | ![ola](images/icons/ic_action_tab_ola.png) ![ola sel](images/icons/ic_action_tab_ola_selected.png) | `ic_action_tab_ola(_selected)` |
| Tab @ Nhắc đến | ![tag](images/icons/ic_action_tab_tag.png) ![tag sel](images/icons/ic_action_tab_tag_selected.png) | `ic_action_tab_tag(_selected)` |
| Tab Ảnh | ![media](images/icons/ic_action_tab_media.png) ![media sel](images/icons/ic_action_tab_media_selected.png) | `ic_action_tab_media(_selected)` |
| Tab Quan tâm | ![follow](images/icons/ic_action_tab_follower.png) ![follow sel](images/icons/ic_action_tab_follower_selected.png) | `ic_action_tab_follower(_selected)` |
| FAB đăng bài | ![edit](images/icons/ic_action_edit.png) | `ic_action_edit` (tint trắng) |
| Bình luận | ![reply](images/icons/ic_action_reply_gray.png) | `ic_action_reply_gray` |
| Ghét | ![dislike](images/icons/ic_dislike_gray.png) | `ic_dislike_gray` (+ `_green/_white/_black`) |
| Thích | ![like](images/icons/ic_like_gray.png) → ![like sel](images/icons/ic_like_selected.png) | `ic_like_gray` → `ic_like_selected` |
| Menu bài ⋮ | ![more](images/icons/ic_more.png) | `ic_more` |

## 10. Tóm tắt token UI

| Thành phần | Giá trị |
|------------|---------|
| Action bar | nền `#7CB342`, cao 48dp, 4 icon giữa (margin 32dp), padding icon 8dp |
| FAB đăng bài | 56dp, nền xanh `floating_action_bar_shape`, icon ✎ trắng, góc phải-dưới margin 16dp |
| Drawer trái/phải | 240dp, nền trắng, divider 1dp |
| Thanh "↑ Me mới" | nền `bg_unread_info`, chữ body1 `colorOlaPrimaryDark` |
| Card bài đăng | nền trắng + bóng `bg_shadow_2_edges`, padding 16dp |
| Avatar bài | 40×40dp tròn |
| Tên | subhead 16sp `rgba(0,0,0,.87)` |
| Giờ | caption 12sp `rgba(0,0,0,.54)` |
| Nội dung | body1 14sp, line ×1.2, tối đa 5 dòng |
| Sticker trong bài | cao 84dp |
| Avatar người thích | 20dp ×3 |
| Nút Bình luận/Ghét/Thích | cao 28dp, chữ xám `rgba(0,0,0,.26)`, đã thích → xanh `#7CB342` |
| Avatar trang cá nhân | 96×96dp |
| Lưới ảnh hồ sơ | 6 ô; lưới bạn bè 5 ô |
