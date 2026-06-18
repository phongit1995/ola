# Màn hình Me (Bảng tin cá nhân / Newsfeed)

- **Tab:** Bottom tab thứ 3 — string `general_tab_me` = "Me".
- **Fragment:** `chat.ola.vn.me.c` — `jadx_out/sources/chat/ola/vn/me/c.java`
- **Layout màn:** `apktool_out/res/layout/me_view_layout.xml`
- **Item bài đăng:** `me_entry_layout.xml` (gồm 3 phần include + ViewStub)
- **Adapter feed:** `chat.ola.vn.me.u` (extends `q`)
- **Đăng bài:** `OlaMeComposerActivity` + `ola_me_composer_layout.xml`
- **Trang cá nhân:** `OlaUserMePageActivity` (người) / `OlaClanMePageActivity` (clan) + `ola_user_me_page_header_layout.xml`
- **Phụ trợ:** `OlaMeCommentActivity` (bình luận — 📄 [comment/README.md](comment/README.md)), `OlaMeLikerListActivity` (ai đã thích), `OlaVisitorListActivity` (khách ghé thăm), `OlaDiaryActivity` (nhật ký)

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
                               📄 comment/README.md

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

**Bấm 1 mục** — `onItemClick` ([me/c.java:1309](../../../jadx_out/sources/chat/ola/vn/me/c.java#L1309)) lấy `af` tại vị trí, **chặn riêng `mariage diary`** rồi gọi `f(af.b())` → `a(af.b(), 0)` ([me/c.java:205](../../../jadx_out/sources/chat/ola/vn/me/c.java#L205)), cuối cùng `e()` đóng drawer. Rẽ nhánh theo mã `af.b()` — **có mục mở màn mới, có mục chỉ nạp feed TẠI CHỖ:**

| Mã `af.b()` | Cử chỉ | Hành vi |
|-------------|--------|---------|
| `my diary` | click | mở **`OlaDiaryActivity`** (màn Nhật ký riêng) — [me/c.java:210](../../../jadx_out/sources/chat/ola/vn/me/c.java#L210) |
| `mariage diary` | click | **chưa kết hôn → mở dialog "Thông báo"** (xem *Modal* dưới); **đã kết hôn →** nạp **feed nhật ký hôn nhân TẠI CHỖ** (`a(long)` → `OlaApplication.b.c(...)`, [me/c.java:119](../../../jadx_out/sources/chat/ola/vn/me/c.java#L119)) |
| `me` · `lk` · `rs` (và `tl`/`md`/`av` ẩn) — `e(strJ)==true` | click | **nạp feed TẠI CHỖ** vào `listView` qua network service ([me/c.java:222](../../../jadx_out/sources/chat/ola/vn/me/c.java#L222)) — **KHÔNG** mở màn mới |
| nick thường · `#daptrung` · `#apk` · `#ola` · `#hai` (`e(strJ)==false`) | click | mở **`OlaUserMePageActivity`** (trang Me của nick/tag đó) — [me/c.java:219](../../../jadx_out/sources/chat/ola/vn/me/c.java#L219) |

> `e(strJ)` ([me/c.java:351](../../../jadx_out/sources/chat/ola/vn/me/c.java#L351)) chỉ `true` khi mã **rỗng** hoặc thuộc `{tl, md, rs, me, lk, av}` — đây là các **feed hệ thống nạp tại chỗ**. Mọi mã khác (kể cả các `#tag`) → `false` → mở `OlaUserMePageActivity`.

> ⚠️ **Đính chính so với bản trước:** click `#daptrung`/`#apk`/`#ola`/`#hai` mở **`OlaUserMePageActivity`** (KHÔNG phải `OlaClanMePageActivity`); còn `me`/`lk`/`rs` **chỉ nạp feed tại chỗ**, không điều hướng.

> Tức drawer trái = **Nhật ký + Box Kết Hôn + (Clan/trang theo dõi) + Me yêu thích + Đập trứng + #Android + #Ola + Hài hước** — nên danh sách dài chứ không chỉ vài mục.

> **"Đập trứng" (`#daptrung`) nằm ở đây.** Hệ thống tự thêm một `entity.af` = `af("Đập trứng" /*system_me_eggy*/, "#daptrung")` ([network/e.java:2986](../../../jadx_out/sources/chat/ola/vn/network/e.java#L2986)); item này được gán icon **trứng nứt** `ic_indicate_broken_egg` ([r/a/e.java:517](../../../jadx_out/sources/chat/ola/vn/r/a/e.java#L517)). Bấm vào → mở **`OlaUserMePageActivity`** cho tag `#daptrung` (feed bài đăng) — **KHÔNG phải lưới trứng để đập**. Client **không có** màn game đập trứng riêng (không layout/Activity `egg`); trò đập trứng do **server/web** điều khiển qua feed của tag này.

##### Modal "Thông báo — chưa kết hôn" (mở khi bấm `mariage diary` lúc chưa cưới)

[me/c.java:1315](../../../jadx_out/sources/chat/ola/vn/me/c.java#L1315) — kiểm tra `h.O.e` rỗng (chưa kết hôn) → dựng `AlertDialog` 2 nút (helper `i.a(...)`):

| Phần | Resource | VI | EN |
|------|----------|----|----|
| Tiêu đề | `dialog_title_inform` | **Thông báo** | Inform |
| Nội dung | `message_cannot_open_box_because_not_married` | **Tính năng chỉ dành cho người có trạng thái Kết Hôn trên Ola** | Only for married person on Ola |
| Nút phải | `string_get_married` | **Kết Hôn** → mở `MarriageRequestComposerActivity` (gửi yêu cầu kết hôn) | Married |
| Nút trái | `string_close` | **Đóng** → đóng dialog | Close |

Sau khi hiện dialog, drawer đóng lại (`e()`) và **không nạp feed**. Nếu **đã** kết hôn thì bỏ qua dialog, nạp luôn feed nhật ký hôn nhân.

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

> Thứ tự nút trái→phải: **Bình luận · Ghét · Thích**. Chữ nút mặc định màu `colorTextBlackHintOrDisable` (xám .26).

#### Số lượt bình luận (`btnMeItemViewComment` — method `o()` trong `entry/b/ab.java`)

TextView nằm **bên trái dòng thống kê** (`btnMeItemLikeSpan`), `weight=1` nên chiếm phần trái; bên phải cùng dòng là 3 avatar người thích + `txtMeItemLikeNumber`.

- **Style:** `defaultStyle.text.caption` → cỡ chữ **12sp**, màu `colorTextBlackSecondaryOrIcon` = **#8A000000** (đen 54%); `gravity=left|bottom`, `maxLines=1`, `ellipsize=end`, `marginRight=48dp`.
- **Điều kiện hiện chung:** chỉ chạy khi cờ `this.L` bật **và** loại bài `k() != 11`; nếu không → **ẩn** (`setVisibility(GONE)`).
- **Văn bản theo số bình luận `g()`** (và loại bài `k()`):

| Trường hợp | Hiển thị |
|---|---|
| `g() == 0` (mặc định / type 2) | **Ẩn** — không hiện gì |
| `g() == 1` | `1 Bình luận` — số + `string_comment` (**viết hoa** "Bình luận") |
| `g() > 1` | `N bình luận` — số + `string_comment_plural` (**viết thường** "bình luận") |
| type `k()==1` (hoặc `k()==2` khi có lượt xem `v()>0`) | chữ tĩnh **`Xem bình luận`** (`string_view_comment`), **không kèm số** |

> Tức APK **không hiển thị "0 bình luận"** — khi chưa có bình luận thì ẩn hẳn dòng này. Phân biệt số ít/số nhiều: `1 Bình luận` (B hoa) vs `5 bình luận` (b thường).

#### Số lượt thích + avatar người thích (`txtMeItemLikeNumber` / `imgMeItemLikeBuddy1-3` — method `t()`)

Nằm **bên phải dòng thống kê** (đối diện số bình luận): tối đa **3 avatar người thích** rồi tới **số lượt thích**.

- **Style số:** `txtMeItemLikeNumber` — caption **12sp**, màu **#8A000000** (đen 54%), `marginLeft=8dp`.
- **Avatar người thích:** `imgMeItemLikeBuddy1/2/3` — mỗi cái **20dp** tròn, cách nhau `marginLeft=2dp`, nạp từ mảng avatar người thích `E()`. Hiện **tối đa 3** (nhiều hơn vẫn chỉ 3); ít hơn thì ẩn bớt; không có ai (`E()==null`) → ẩn cả 3.
- **Điều kiện chung:** ẩn hết khi bài đang gửi/nháp (`h()==1||2`).
- **Văn bản theo lượt thích `f()`:**

| Lượt thích `f()` | Hiển thị |
|---|---|
| **0** | **Ẩn** — APK không hiện "0 lượt thích" |
| **1** | `1 Lượt thích` (`string_like_single`) |
| **2–9** | `N Lượt thích` (`string_like_plural`), vd `5 Lượt thích` |
| **> 9** | `9+ Lượt thích` — **chặn trần ở "9+"** qua `m.a(n) = a(9, n)` |

> Khác số bình luận ở chỗ: lượt thích **chặn trần "9+"** (qua `util/m.a`), còn số bình luận in **số thực** (không chặn). VI cả số ít lẫn số nhiều đều là "Lượt thích" (EN: Like / Likes).

**Bonus — số "Ghét" hiển thị khác hẳn:** số ghét KHÔNG nằm ở dòng thống kê mà **gắn ngay trong chữ nút Ghét** (method `v()`): text = `Ghét (N)` với `N = m.a(D())` (cũng chặn 9+); khi mình đã ghét (`i()==2`) → icon `ic_dislike_black` + chữ đổi sang màu `f.y`. Chưa có lượt ghét → chỉ chữ "Ghét".

#### Đổi màu icon + chữ theo trạng thái

Code render bài (`entry/b/*.java`) set **động** cả icon lẫn màu chữ, dùng hằng màu trong [`chat/ola/vn/f.java`](../../../jadx_out/sources/chat/ola/vn/f.java):

| Nút | Trạng thái | Icon | Màu chữ (`f.*`) | HEX / token |
|-----|-----------|------|-----------------|-------------|
| **Thích** | chưa thích | `ic_like_gray` | `f.A` | `#42000000` = `colorTextBlackHintOrDisable` (xám .26) |
| **Thích** | đã thích | `ic_like_selected` | `f.H` | `#7CB342` = `colorOlaPrimary` (**xanh lá**), chữ "Thích" → "Đã thích" |
| **Ghét** | chưa ghét | `ic_dislike_gray` | `f.A` | `#42000000` (xám .26) |
| **Ghét** | đã ghét | `ic_dislike_black` | `f.y` | `#DE000000` = `colorTextBlackPrimary` (**đen .87**) |

> **Biến thể trên nền tối / nền ảnh** (bài có ảnh phủ kín): icon đổi sang bản trắng `ic_like_white` / `ic_dislike_white` (Ghét còn có `ic_dislike_green` cho trạng thái đã ghét), màu chữ dùng `f.C` = `#FFFFFF` (`colorTextWhitePrimary`) / `f.D` = `#B3FFFFFF` (`colorTextWhiteSecondary`) — thay cho bản xám trên nền thẻ trắng.

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

### 4.4. Tô màu `@nick` và `#tag` trong nội dung

Nội dung (`txtMeItemContent`, CommpressTextView) **không hiển thị `@nick`/`#tag` dạng text thường** — chúng được parse và bọc thành **ClickableSpan có màu** trong [`util/i.java`](../../../jadx_out/sources/chat/ola/vn/util/i.java):

- Regex mention: `e = (\B@((?:[a-zA-Z][a-zA-Z0-9_]*[.]?[a-zA-Z0-9_]*[a-zA-Z0-9])))` → bắt `@nick`
- Regex hashtag: `d = (\B#((?:[a-zA-Z0-9][a-zA-Z0-9_.]*[a-zA-Z0-9])))` → bắt `#clan`/`#tag`
- Mỗi match → `com.mg.ola.common.d.a.a(màu, …)` (clickable). Bấm → mở trang Me của nick/clan đó.

| Ngữ cảnh | Màu chữ `@nick` / `#tag` | Token |
|----------|--------------------------|-------|
| Bài trên **nền sáng** (card trắng — mặc định) | **`#33691E`** | `colorOlaPrimaryDarkMore` (`f.a`) — **xanh lá đậm** |
| Bài trên **nền tối / nền ảnh** | `#FFFFFF` | trắng (`f.g`) |

> Đây là **xanh lá** (không phải xanh dương). URL/RSS/file link trong nội dung cũng được tô cùng màu này. Click span gọi `OlaTextView.b.a(view, null, "@nick")`.

### 4.5. Hiển thị ảnh đính kèm (`me_attached_media_layout.xml`)

Lưới ảnh nằm trong `meMediaAttachedViewStub`, gắn từ `me_attached_media_layout` — **bố cục cố định 2 hàng** (`thumbnailSpan`, dọc), khoảng cách **8dp**:

```
┌───────────────┬───────────────┐
│ mediaImageView1│ mediaImageView2│   ← hàng trên: 2 ô, OlaRatioImageView (giữ tỉ lệ), weight 1
├──────────┬──────────┬──────────┤
│ media3   │ media4   │ media5 + "+N"│ ← hàng dưới: 3 ô vuông, OlaSquareCachedImageView, weight 1
└──────────┴──────────┴────────────┘
```

- Tối đa hiển thị **5 thumbnail**; nếu nhiều hơn 5 → ô thứ 5 (`theTenViewLayout`) phủ overlay `moreMediaTextView` = **"+N"** (số ảnh còn lại).
- Ô 1–2: `OlaRatioImageView` (giữ tỉ lệ gốc); ô 3–5: `OlaSquareCachedImageView` (cắt vuông).
- Số ô hiển thị tuỳ số ảnh thật (code ẩn các ô thừa); 1 ảnh → 1 ô rộng.
- Bộ đếm video/audio (`imgMeItemMediaVideo`/`imgMeItemMediaSound`) nằm ở phần nút (mục 4.2), không nằm trong lưới ảnh.

### 4.6. Hiển thị check-in / địa điểm (`me_entry_venue_layout`)

Check-in nằm trong `meCheckInViewStub`. Code chọn 1 trong 2 layout ([entry/b/ab.java:218–239](../../../jadx_out/sources/chat/ola/vn/entry/b/ab.java#L218)):

- **`me_entry_venue_layout`** — check-in **không kèm media**: là **thẻ ảnh bìa địa điểm** (`imCheckInCover` phủ kín) + lớp phủ đen **50%** (`translucent_black_50_percent` = `rgba(0,0,0,.5)`) chứa hàng thông tin.
- **`me_entry_venue_with_mediacodes_layout`** — check-in **kèm ảnh**: cùng hàng thông tin nhưng đặt **đè lên lưới media** (không có ảnh bìa riêng).

Hàng thông tin (trên nền phủ đen, padding 4dp, chữ **trắng**):

| View | Kiểu | Nội dung |
|------|------|----------|
| `imgCheckInAction` | icon (mặc định `ic_check_in_action_default`) | biểu tượng hành động/loại địa điểm |
| `txtCheckInAction` | `AutoScrollTextView`, **headline 24sp**, trắng, weight 2 | hành động (vd "đang ở", loại check-in) — tự cuộn nếu dài |
| `txtCheckInVenueName` | `TextView`, **body1 14sp**, trắng, weight 1 | **tên địa điểm** |
| `btnDetail` | `ImageView` `ic_arrow_right_white` | → mở chi tiết địa điểm (`OlaVenueDetailActivity`) |

> Ảnh bìa (`imCheckInCover`) nạp từ media code đầu của check-in; icon hành động (`imgCheckInAction`) nạp từ `OlaCheckInItemEntity` (mặc định `ic_check_in_item_default`). Toàn khối bấm được → mở chi tiết venue.

#### CSS tương đương — check-in card

```css
.ola-me-checkin {
  position: relative; margin: 0 16px; border-radius: 2px; overflow: hidden;
}
.ola-me-checkin__cover { width: 100%; display: block; object-fit: cover; }
.ola-me-checkin__bar {
  position: absolute; inset: auto 0 0 0;            /* hoặc phủ toàn khối */
  display: flex; align-items: center; gap: 4px; padding: 4px 8px;
  background: rgba(0,0,0,.5);                        /* translucent_black_50_percent */
  color: #fff;
}
.ola-me-checkin__icon { width: 24px; height: 24px; }
.ola-me-checkin__action { flex: 2; font-size: 24px; }     /* headline, AutoScroll khi dài */
.ola-me-checkin__venue  { flex: 1; font-size: 14px; }     /* body1 */
.ola-me-checkin__detail { width: 16px; }                  /* ic_arrow_right_white */
```

### 4.7. Cử chỉ trên bài đăng & menu ⋮ (xử lý ở `chat.ola.vn.q.b`)

Mọi chạm trên 1 bài đăng **KHÔNG** do `me.c` xử lý trực tiếp: adapter `me.u` gắn **2 listener dùng chung** cho từng dòng ([me/c.java:748](../../../jadx_out/sources/chat/ola/vn/me/c.java#L748)), cả hai uỷ quyền cho singleton **`chat.ola.vn.q.b`**:

- **click** → `q.b.a().b(activity, view)` — `switch(view.getId())` ([q/b.java:1571](../../../jadx_out/sources/chat/ola/vn/q/b.java#L1571))
- **long-press** → `q.b.a().a(activity, view)` — `switch(view.getId())` ([q/b.java:1487](../../../jadx_out/sources/chat/ola/vn/q/b.java#L1487))

`view.getTag()` mang model `entry.b` (bài) hoặc `message.f` (nick) để 2 hàm biết tác động lên bài/nick nào.

#### Bảng cử chỉ (click vs long-press)

| View (id) | Click | Long-press |
|-----------|-------|------------|
| `btnMeItemFooterMore` (⋮) | **mở menu ⋮** (`c()`→`f()`, xem dưới) | — |
| `btnMeItemFooterReply` ("Bình luận") | mở **`OlaMeCommentActivity`** | chia sẻ nhanh (`h()` → đăng lại lên timeline) |
| `btnMeItemFooterShare` ("Chia sẻ") | đăng lại `rss://<id>` lên timeline + dialog **"Đã chia sẻ…"** | — |
| `btnMeItemLikeSpan` (dòng thống kê like) | mở **`OlaMeLikerListActivity`** (ai đã thích) | — |
| `btnMeItemViewComment` ("X bình luận") | mở luồng bình luận | — |
| `imgMeAvatarThumbnail` (avatar) | mở trang Me tác giả | popup nhanh / mở trang Me |
| `meOwnerInfoSpan` · `txtMeItemTitle` (tên) | mở trang Me tác giả | **menu nick** (Kết bạn/Chat/VIP/Thêm) → `a(ctx,nick)` |
| `contactIdTextView` · `profilePictureImageView` · `suggestedFriendItemLayout` | mở trang Me | mở **`OlaUserMePageActivity`** |
| `mediaImageView1..5` | xem ảnh | xem/menu ảnh (`a(ctx,view,idx)`) |
| `imgMeItemMediaVideo` / `imgMeItemMediaSound` | phát video / audio | phát |
| `imgMeYoutubeThumbnail1` / `linearYoutubeSpan` | mở YouTube | mở YouTube |
| `txtMeItemLikeWrapper` (nút Thích) | toggle Thích (xem §4.2) | hiện popup người thích |

#### Menu ⋮ — `f(ctx, bVar)` ([q/b.java:898](../../../jadx_out/sources/chat/ola/vn/q/b.java#L898))

`c()` ([q/b.java:589](../../../jadx_out/sources/chat/ola/vn/q/b.java#L589)) chọn biến thể theo feed: feed thường → `f()`; đang trong feed `#clan` mà mình là chủ clan → biến thể có thêm **Chặn khỏi Clan** (`string_ban_from_clan`). `f()` dựng **`ListOptionDialog`** (`chat.ola.vn.i.m`) — mỗi mục map sang hành động (theo `onItemClick`, [q/b.java:914](../../../jadx_out/sources/chat/ola/vn/q/b.java#L914)):

| Mục | String | Hành động |
|-----|--------|-----------|
| **Copy** | `string_copy` | chép nội dung bài (+ `#tag`) vào clipboard |
| **Copy+** | `string_copy_plus` | chép kèm thông tin mở rộng |
| **Copy nick** | `string_copy_nick` | chép `@nick` tác giả |
| **Chat** | `string_chat` | mở `OlaChatViewActivity` (nhắn tin tác giả) |
| **Chia sẻ** | `string_share` | đăng lại bài lên timeline của mình (`h()`) |
| **Phiên dịch** | `general_tab_translater` | dịch nội dung bài (`z.a()`) |
| **Xem kho VIP** | `string_view_vip_store` | mở `OlaVipStoreActivity` |
| **Báo nick xấu** | `string_bad_nick_report` | gửi báo cáo nick (`i.a(ctx,nick)`) |
| **Cài làm Me TOP / Bỏ Me top** | `string_post_me_top` / `string_discard_me_top` | ghim / bỏ ghim bài lên đầu trang |
| **Xoá Me** | `string_delete_me` | **dialog xác nhận** (xem dưới) → xoá bài |
| **Thao tác khác** | `string_more_action` | mở submenu phụ (`g(ctx,bVar)`) |

> Bài **nháp / đang gửi** (`bVar.h()==1|2`) → menu rút gọn chỉ **[Copy · Copy+ · Xoá Me]**.

#### Menu long-press nick — `a(ctx, nick)` ([q/b.java:357](../../../jadx_out/sources/chat/ola/vn/q/b.java#L357))

`ListOptionDialog` mở khi long-press tên/owner-info: **Kết bạn** (`string_make_friend`, ẩn nếu đã là bạn) · **Chat** (`string_chat`) · **Xem kho VIP** (`string_view_vip_store`) · **Thao tác khác** (`string_more_action`).

#### Các dialog xác nhận liên quan

| Dialog | Mở khi | Tiêu đề | Nội dung | Nút |
|--------|--------|---------|----------|-----|
| **Xoá bài** | menu ⋮ → *Xoá Me* | `string_delete_me` = **Xoá Me** | `message_delete_me_format` = **"Bạn muốn xoá Me của %s?"** | **Xoá Me** / **Huỷ** |
| **Chia sẻ xong** | nút *Chia sẻ* | `dialog_title_inform` = **Thông báo** | `message_shared_on_your_timeline` = **"Đã chia sẻ lên trang cá nhân của bạn"** | OK |
| **Xoá lịch sử Me** (drawer phải) | nút *Xóa* `clearHistoryTextView` ([me/c.java:1028](../../../jadx_out/sources/chat/ola/vn/me/c.java#L1028)) | `dialog_title_confirm` = **Xác nhận** | `message_delete_me_history` = **"Bạn muốn xóa danh sách ghi nhớ các trang Me đã xem?"** | **Có** / **Không** |

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
| **Ảnh đính kèm** | `attachedPhotoListView` (HListView — **danh sách NGANG**) | cao 164dp, ẩn tới khi chọn ảnh. **Hỗ trợ NHIỀU ảnh**: mỗi lần chọn thêm → adapter cộng dồn, dải ảnh dài thêm và tự cuộn tới ảnh cuối (`q.c(r.getCount()-1)`); nhận cả mảng nhiều URI qua `EXTRA_STREAM`. Client **không có** giới hạn cứng số ảnh (nếu có do server). |
| **Thanh đính kèm** | `chatAttachmentLayout` | 5 nút (xem bảng dưới) — layout dùng chung với chat |
| **Action bar** | `ola_top_action_bar_center_title_layout` | tiêu đề `general_tab_me_edit` = "Viết mới" + nút Đăng |

**Thanh đính kèm — 5 nút** (theo `OlaMeComposerActivity.onClick`):

| Nút (id) | Icon | Mở |
|----------|------|----|
| `cameraImageButton` | `ic_local` | **Ảnh trong máy** (thư viện) → `OlaLocalPhotoChooserActivity` — *không phải chụp ảnh* |
| `localPhotoImageButton` | `ic_cloud` | **Ảnh trên cloud** → `OlaCloudPhotoChooserActivity` |
| `voiceImageButton` | `ic_tag_people` | **Gắn thẻ người** (tag) → `OlaContactPickerActivity` |
| `moreImageButton` | `ic_checkin_gray` | **Check-in vị trí** → `OlaCheckInActivity` |
| `chatTextSmileyImageButton` | (smiley) | **Sticker / emoji** |

> Cả ảnh máy lẫn ảnh cloud đều đổ vào cùng `attachedPhotoListView` → có thể trộn nhiều ảnh từ nhiều nguồn trong 1 bài.

> Quyền riêng tư: `string_me_privacy_public` = **Cộng đồng**, `_friend` = **Bạn bè**, `_private` = **Riêng tư**.
> Thoát giữa chừng → hỏi lưu nháp (`message_edit_me_back_confirm`); nháp quản lý bởi class `chat.ola.vn.me.a`.

## 7. Strings (EN → VI)

| Key | EN | VI |
|-----|----|----|
| `general_tab_me` | Me | Me |
| `general_tab_me_edit` | Post Me | Viết mới |
| `general_hint_me` | What hot today... | Hôm nay có gì hot … |
| `string_like` | Like | Thích |
| `string_like_single` | Like | Lượt thích |
| `string_like_plural` | Likes | Lượt thích |
| `string_like_friend_list` | %1$s people like this | %1$s người thích |
| `string_dislike` | Dislike | Ghét |
| `string_comment` | Comment | Bình luận |
| `string_comment_plural` | comments | bình luận |
| `string_view_comment` | View comment | Xem bình luận |
| `string_follow` | Follow | Quan tâm |
| `string_following` | Following | Đang quan tâm |
| `string_people_care` | people care | người quan tâm |
| `string_kiss` | Kiss | Nụ hôn |
| `message_new_me_inform` | ↑ New Me | ↑ Me mới |
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
| `dialog_title_inform` | Inform | Thông báo |
| `message_cannot_open_box_because_not_married` | Only for married person on Ola | Tính năng chỉ dành cho người có trạng thái Kết Hôn trên Ola |
| `string_get_married` | Married | Kết Hôn |
| `string_close` | Close | Đóng |
| `string_copy` | Copy | Copy |
| `string_copy_plus` | Copy+ | Copy+ |
| `string_copy_nick` | Copy nick | Copy nick |
| `string_chat` | Chat | Chat |
| `string_share` | Share | Chia sẻ |
| `string_delete_me` | Delete Me | Xoá Me |
| `string_more_action` | More actions | Thao tác khác |
| `string_bad_nick_report` | Report bad account | Báo nick xấu |
| `string_view_vip_store` | View VIP icon collection | Xem kho VIP |
| `string_make_friend` | Add friend | Kết bạn |
| `string_block_me` | Block | Chặn Me |
| `general_tab_translater` | Translator | Phiên dịch |
| `string_post_me_top` | Set Me Top | Cài đặt làm Me TOP trang cá nhân |
| `string_discard_me_top` | Discard Me top | Bỏ Me top |
| `string_ban_from_clan` | Ban from Clan | Chặn khỏi Clan |
| `string_cancel` | Cancel | Huỷ |
| `string_yes` | Yes | Có |
| `string_no` | No | Không |
| `dialog_title_confirm` | Confirmation | Xác nhận |
| `message_delete_me_format` | Do you want to delete Me of %s? | Bạn muốn xoá Me của %s? |
| `message_delete_me_history` | Do you want to delete Me history? | Bạn muốn xóa danh sách ghi nhớ các trang Me đã xem? |
| `message_shared_on_your_timeline` | Shared on your timeline | Đã chia sẻ lên trang cá nhân của bạn |

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
| Ghét (mặc định) | ![dislike](images/icons/ic_dislike_gray.png) | `ic_dislike_gray` (nền thẻ trắng) |
| Ghét — biến thể nền | ![dis black](images/icons/ic_dislike_black.png) ![dis green](images/icons/ic_dislike_green.png) ![dis white](images/icons/ic_dislike_white.png) | `ic_dislike_black` · `ic_dislike_green` (đã ghét) · `ic_dislike_white` (nền tối) |
| Thích | ![like](images/icons/ic_like_gray.png) → ![like sel](images/icons/ic_like_selected.png) → ![like white](images/icons/ic_like_white.png) | `ic_like_gray` → `ic_like_selected` (đã thích, xanh) · `ic_like_white` (nền tối) |
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

## 11. Màn mở ra từ đây (điều hướng)

Mọi màn (Activity) mà màn Me feed điều hướng tới — dùng làm hàng đợi tài liệu hoá:

| Từ (nút/cử chỉ) | Màn đích (class) | Doc |
|------------------|------------------|-----|
| FAB ✎ `writeStatusImageButton` | `OlaMeComposerActivity` (đăng bài) | mô tả ở §6 (chưa tách file riêng) |
| Drawer trái: mục nick / `#tag` · avatar/tên trong bài | `OlaUserMePageActivity` (trang Me người dùng/tag) | [../trang-ca-nhan/README.md](../trang-ca-nhan/README.md) |
| Post: nút **Bình luận** | `OlaMeCommentActivity` (luồng bình luận) | [comment/README.md](comment/README.md) |
| Drawer trái: mục **Nhật ký** (`my diary`) | `OlaDiaryActivity` | *(chưa có doc — cần làm)* |
| Dialog "Thông báo" → nút **Kết Hôn** | `MarriageRequestComposerActivity` (gửi yêu cầu kết hôn) | *(chưa có doc — cần làm)* |
| Action bar: icon **Quan tâm** (`buttonFollowerImageView`) | `OlaVisitorListActivity` (khách ghé thăm) | *(chưa có doc — cần làm)* |
| Check-in trong bài: `btnDetail` | `OlaVenueDetailActivity` (chi tiết địa điểm) | *(chưa có doc — cần làm)* |
| Composer: nút Ảnh máy / Ảnh cloud / Tag người / Check-in | `OlaLocalPhotoChooserActivity` · `OlaCloudPhotoChooserActivity` · `OlaContactPickerActivity` · `OlaCheckInActivity` | *(chưa có doc — cần làm)* |

> `OlaClanMePageActivity` **không** được mở từ click drawer của màn này (xem đính chính §2.1) — nó vào từ ngữ cảnh clan khác (vd luồng đổi ảnh bìa, [../doi-anh-dai-dien/README.md](../doi-anh-dai-dien/README.md)).
