# Màn hình Trang Clan (trang cộng đồng `#tên`)

- **Activity:** `chat.ola.vn.me.OlaClanMePageActivity` — `jadx_out/sources/chat/ola/vn/me/OlaClanMePageActivity.java` (801 dòng)
- **Layout màn (scaffold):** `apktool_out/res/layout/ola_user_me_page_layout.xml` (dùng chung với [Trang cá nhân](../trang-ca-nhan/README.md): action bar nổi + ListView pull-to-refresh + FAB)
- **Layout action bar:** `ola_user_me_page_top_action_bar_layout.xml` (back + ô tìm nick/#clan)
- **Layout header:** `ola_clan_page_header_layout.xml` (header cuộn cùng feed — bản CLAN, khác với header trang cá nhân)
- **Cụm nút quan hệ:** `like_follow_post_more_button_layout.xml` (`@id/relationMakerPan`)
- **Chức năng:** trang hồ sơ của một **Clan** (`#tên`): ảnh bìa + avatar + bộ máy (Bang chủ / Phó bang chủ / Đại sứ) + chính sách + số thành viên + ngày lập + **feed bài Me của clan**. Người xem có thể **Quan tâm** (join/follow), **Viết Me** lên clan; **bang chủ** có thêm **Quản lý Clan** và đổi ảnh.
- **Mở từ (entry points):**
  - Gõ `#tên` vào ô tìm ở màn [Me](../me/README.md), [Trang cá nhân](../trang-ca-nhan/README.md) (`OlaUserMePageActivity.java:899`), hoặc ngay trong màn này.
  - Bấm `#hashtag` clan trong nội dung bài Me (span màu xanh — xử lý chung của feed).
  - Màn chi tiết địa điểm `checkin.OlaVenueDetailActivity:523`.
  - WebView bridge `openMeByClan(str)` (`util/http/WebAppInterfaceImp.java:218`).
  - Mỗi lần mở đều **ghi vào lịch sử "Clan đã xem"** (`h("#x")`, dòng 569-587 — bảng recent của màn Me, tăng đếm số lần xem).

> Thuật ngữ: trong app cũ, **`#tên` vừa là phòng chat vừa là Clan** — Clan là phòng chat đã có "bang chủ" đứng tên. Trang này dùng **Intent extra `"contactId"`** (tên clan không kèm `#`).

## Ảnh chụp

> **Chưa có ảnh chụp màn này** (`fake-api/screenshots/` trống). Tài liệu dựng từ layout XML + code jadx.

### Assets dùng trong màn (ảnh gốc trích từ APK)

| Asset | Ảnh | Dùng cho |
|-------|-----|----------|
| `ic_action_back` | ![back](../images/ic_action_back.png) | Nút back action bar |
| `ic_action_search_small` | ![search](../images/ic_action_search_small.png) | Icon kính lúp trong ô tìm |
| `ic_action_compose_message` | ![compose](../images/ic_action_compose_message.png) | FAB tròn xanh góc phải-dưới (mở chat) |
| `ic_action_camera` | ![camera](../images/ic_action_camera.png) | Icon máy ảnh đè góc bìa + avatar (chỉ bang chủ) |
| `ic_checked` | ![checked](../images/ic_checked.png) | Tick xác thực cạnh id — **gone, màn clan không bật** |
| `ic_clan_role_leader` | ![leader](../images/ic_clan_role_leader.png) | Icon dòng **Bang chủ** + badge trên bài đăng của bang chủ |
| `ic_clan_role_vice_leader` | ![vice](../images/ic_clan_role_vice_leader.png) | Icon dòng **Phó bang chủ** + badge trên bài của phó bang |
| `ic_clan_role_supporter` | ![supporter](../images/ic_clan_role_supporter.png) | Icon dòng **Đại sứ** + badge trên bài của đại sứ |
| `ic_profile_note` | ![note](../images/ic_profile_note.png) | Icon dòng **Chính sách** |
| `ic_like_gray` | ![like](../images/ic_like_gray.png) | Nút "Thích" trong cụm quan hệ — **màn clan LUÔN ẨN** |
| `ic_follow_black_disable` | ![follow](../images/ic_follow_black_disable.png) | Nút "Quan tâm" khi **chưa** follow |
| `ic_state_following` | ![following](../images/ic_state_following.png) | Nút "Quan tâm" khi **đang** follow (đổi icon + chữ xanh) |
| `ic_manage_clan` | ![manage](../images/ic_manage_clan.png) | Nút "Quản lý Clan" (chỉ bang chủ) |
| `ic_post_me_gray` | ![post](../images/ic_post_me_gray.png) | Nút "Viết Me" |
| `ic_more_horizon_black_disable` | ![more](../images/ic_more_horizon_black_disable.png) | Nút "Khác" — **màn clan LUÔN ẨN** |
| `ic_menu_clan` | ![menuclan](../images/ic_menu_clan.png) | Placeholder avatar clan cỡ nhỏ (loader `c/t.k()` — dùng ở list/drawer, nêu để đủ bộ icon clan) |

---

## 1. Bố cục (top → bottom)

```
FrameLayout globalViewLayout (3 lớp chồng)
├─ Lớp nội dung (paddingTop 42dp chừa action bar)
│  └─ SwipeRefreshLayout pullToRefreshLayout (spinner màu #7CB342)
│     └─ ListView pageListView  ← HEADER (dưới đây) là headerView, sau đó là FEED bài Me của clan
│        ┌────────────── HEADER ola_clan_page_header_layout ──────────────┐
│        │ Thẻ hồ sơ clan (nền bg_shadow_span — trắng + bóng, paddingB 16dp, marginB 8dp)
│        │ ├─ Ảnh bìa coverPictureImageView (OlaRatioImageView, nền #33691E khi chưa có ảnh)
│        │ │   └─ [✎📷 editCoverPictureImageView]  — GONE; chỉ hiện khi LÀ BANG CHỦ
│        │ ├─ Avatar 96×96dp profilePictureImageView (khung bg_shadown_border, đè góc trái-dưới bìa)
│        │ │   └─ [✎📷 editProfilePictureImageView] — GONE; chỉ hiện khi LÀ BANG CHỦ
│        │ ├─ Dòng ID:  contactIdTextView "#tên"  (24sp #8A000000)
│        │ │   └─ [tick imgCheckedPhoneNumberVerified] — GONE (màn clan không bật)
│        │ ├─ ── divider 1px #1F000000 ──
│        │ ├─ Cụm nút quan hệ relationMakerPan (5 ô đều nhau — like_follow_post_more_button_layout)
│        │ │   ├─ [Thích addFriendViewLayout]      — CODE ẨN LUÔN ở màn clan (dòng 224)
│        │ │   ├─ [Quan tâm followViewLayout]      — hiện khi KHÔNG phải bang chủ; icon+chữ đổi theo trạng thái follow
│        │ │   ├─ [Quản lý Clan editProfileViewLayout] — GONE; chỉ hiện khi LÀ BANG CHỦ
│        │ │   ├─ Viết Me postMeViewLayout          — luôn hiện
│        │ │   └─ [Khác moreViewLayout]             — CODE ẨN LUÔN ở màn clan (dòng 234)
│        │ ├─ [Nút "Tạo Clan" createClanButton]     — GONE; chỉ hiện khi clan CHƯA CÓ CHỦ (nút xanh dương full ngang)
│        │ ├─ ── divider ──
│        │ ├─ Số thành viên vLinewarFanNumber:  "<n>" (20sp đen) + "Thành viên" (12sp xám)
│        │ ├─ "Ngày lập Clan dd/MM/yyyy" txtJoinOlaDate (12sp #8A000000)
│        │ ├─ 👑 @bangchu   clanManagerTextView1 (12sp, icon leader)
│        │ ├─ 🛡 @phobang   clanManagerTextView2 (12sp, icon vice) — có listener nhưng không làm gì
│        │ ├─ 🎖 @daisu     clanManagerTextView3 (12sp, icon supporter)
│        │ └─ 📝 <chính sách> clanPolicyTextView (12sp, icon ic_profile_note)
│        │ TextView "ME Đã Đăng" (16sp #DE000000) — mở đầu danh sách bài
│        └──────────────────────────────────────────────────────────────┘
│     └─ ProgressBar wattingProgressBar 48dp giữa màn — hiện khi đang tải info/feed
├─ Action bar nổi (ola_user_me_page_top_action_bar_layout — nền #7CB342 + bóng, cao 42dp)
│  ├─ Nút back olaActionBarBackImageView
│  └─ Ô tìm searchEditText (OlaQuickTypingSuggestedText): kính lúp 16dp + hint trắng mờ
│      "Nhập nick hoặc #clan" — code tự điền "#<tên clan>" khi load xong
└─ FAB addConversationImageButton 56dp tròn #7CB342, icon compose trắng, góc phải-dưới
    — theo code N(): ẨN khi clan ĐÃ có chủ, HIỆN khi chưa có chủ (mở phòng chat #tên)
```

### Các loại dòng & view type (ListView `pageListView`)

Adapter **`chat.ola.vn.b.u`** ("feed Me" — **dùng chung** cho bảng tin Me, Trang cá nhân và Trang Clan; `b/u.java`):

| Thành phần list | Nguồn dữ liệu | Ghi chú |
|-----------------|---------------|---------|
| Header (mục 1 ở trên) | `addHeaderView` (dòng 236) | không thuộc adapter |
| **Dòng 0 — bài ghim (Me Top)** | `store.f()` (entry `o` của `r/a/e.java:737`) | chỉ có khi clan có **Me Top** (bang chủ "Cài đặt làm Me top clan"); `getCount()` cộng thêm 1 (`b/u.java:100-107`) |
| **Các bài Me của clan** | `store.i()` (list `k`) — nạp từ socket **mã lệnh 80** | trang đầu `b(str,s,list)`, trang sau `c(list)` (`r/a/e.java:585,656`) |

- `getViewTypeCount()` = **10** (`b/u.java:124-126`); `getItemViewType(i)` = `entry.d()` (field `t` của `entry/b.java:225`) — **loại dòng do server/parser gán cho từng entry**, không phải màn quyết định. Type `2` là dòng phụ (bị bỏ qua khi tính cursor phân trang — `r/a/e.java:770-778`).
- **Giải phẫu 1 bài Me** (avatar, tên, nội dung, media, like/comment, các layout `me_entry_*` cho từng loại bài): xem tài liệu chung ở [../me/README.md §4](../me/README.md) — KHÔNG lặp lại ở đây.
- **Khác biệt riêng ở trang clan:**
  - **Badge cấp bậc** cạnh người đăng (`entry/b/ab.n()`, dòng 479-508): entry `h()` = 1 → `ic_clan_role_leader`, 2 → `ic_clan_role_vice_leader`, 3 → `ic_clan_role_supporter`, khác → không badge.
  - **Menu bài đăng đổi theo vai trò** (xem §4.5).
  - Riêng bảng tin Me (owner `null`) mới chèn dòng "story/notice" đặc biệt (`r/a/e.java:592-609`) — **trang clan KHÔNG có** dòng này (owner = `#tên`).

## 2. Bảng style chi tiết từng phần

> Token chữ: `caption` 12sp `#8A000000` · `body1` 14sp `#DE000000` · `subhead` 16sp `#DE000000` · `title` 20sp bold `#DE000000` · `headline` 24sp.

| Thành phần | id | Màu chữ / nền | Cỡ chữ | Kích thước / khoảng cách | Ghi chú (điều kiện ẩn/hiện) |
|------------|----|----|--------|--------------------------|---------|
| Action bar | `olaTopActionBarViewLayout` | nền `#7CB342` + bóng đáy | — | cao 42dp, padding 8/4/16/10dp | luôn hiện, nổi đè nội dung |
| Ô tìm | `searchEditText` | chữ **trắng**, hint `#4DFFFFFF`, khung viền nhạt (`bg_edit_text_small_light_border`), kính lúp 16dp | 14sp | weight 1, padding 8dp | hint `string_enter_nick_name_or_clan`; sau khi load tự điền `#tên` + select-all khi focus; **Enter/Search** → §4.4 |
| Ảnh bìa | `coverPictureImageView` | nền chờ `#33691E` (`colorOlaPrimaryDarkMore`) | — | full ngang, cao theo tỉ lệ ảnh | ảnh từ `props.kaspee.com/clan/photo/<tên>-cover-<size>.jpg` (`c/f.d()`, dòng 512) |
| Icon 📷 sửa bìa | `editCoverPictureImageView` | — | — | margin 4dp, góc phải-dưới bìa | **gone mặc định**; hiện khi clan tồn tại **và** mình là bang chủ (`N()`, dòng 300-318) |
| Avatar | `profilePictureImageView` | khung trắng viền bóng (`bg_shadown_border`, padding 4/4/4/6dp) | — | **96×96dp** (= `me.info.avatar.thumbnail.clan.size`), margin 8dp, đè góc trái-dưới bìa | ảnh `…-avatar-<size>.jpg` (`c/f.c()`, dòng 500) |
| Icon 📷 sửa avatar | `editProfilePictureImageView` | — | — | margin 4dp | **gone mặc định**; hiện cùng điều kiện icon sửa bìa |
| ID clan | `contactIdTextView` | `#8A000000` | **24sp** (`text.size.headline` override style caption) | padding cụm 8dp, canh giữa | text `#<tên>` |
| Tick xác thực | `imgCheckedPhoneNumberVerified` | — | — | 24dp | **gone — màn clan không bao giờ bật** |
| Nút Thích | `addFriendViewLayout` | icon `ic_like_gray` + chữ `#42000000` | 12sp | weight 1, icon cao 20dp | **CODE ẨN LUÔN** (dòng 224) — chỉ dùng ở trang cá nhân |
| Nút Quan tâm | `followViewLayout` | chưa follow: `ic_follow_black_disable` + chữ `#42000000`; đang follow: `ic_state_following` + chữ **`#7CB342`** | 12sp | weight 1 | hiện khi clan tồn tại và mình **không phải** bang chủ (`Q()`, dòng 362-394); click → §4.4 |
| Nút Quản lý Clan | `editProfileViewLayout` | `ic_manage_clan` + chữ `#42000000` | 12sp | weight 1 | **gone mặc định**; hiện khi mình **là bang chủ**; badge "!" `editProfileNotificationTextView` — gone, không bật |
| Nút Viết Me | `postMeViewLayout` | `ic_post_me_gray` + chữ `#42000000` | 12sp | weight 1 | luôn hiện |
| Nút Khác | `moreViewLayout` | `ic_more_horizon_black_disable` | 12sp | weight 1 | **CODE ẨN LUÔN** (dòng 234) |
| Nút Tạo Clan | `createClanButton` | chữ trắng 12sp, nền **xanh dương `#2A63CC`** bo 2dp (`btn_blue_button_selector`) | 12sp | full ngang, padding T/B 16dp | **gone mặc định**; hiện khi clan **chưa có chủ** (`Q()` nhánh else) — đè lên vị trí cụm nút quan hệ |
| Số thành viên | `fanNumberTextView` + nhãn | số: đen `#000000` 20sp; nhãn "Thành viên": 12sp `#8A000000` | 20/12sp | margin T/B 16dp, canh giữa | số format `m.a(long)` |
| Ngày lập | `txtJoinOlaDate` | `#8A000000` | 12sp | marginLeft 16dp, marginTop 8dp | "Ngày lập Clan dd/MM/yyyy" (`P()`, dòng 354-360); chưa rõ → "Chưa biết" |
| Bang chủ | `clanManagerTextView1` | `#8A000000` | 12sp | marginLeft 16dp + icon trái 4dp | text `@nick` (định dạng span `i.c(...)`); rỗng → dòng trống |
| Phó bang chủ | `clanManagerTextView2` | như trên | 12sp | như trên | **có đăng ký click nhưng handler rỗng** (case chỉ `break`, dòng 723) |
| Đại sứ | `clanManagerTextView3` | như trên | 12sp | như trên | — |
| Chính sách | `clanPolicyTextView` | như trên | 12sp | như trên, icon `ic_profile_note` | text theo map mã→chuỗi (bảng ở [Quản lý Clan §4.2](../quan-ly-clan/README.md)) |
| "ME Đã Đăng" | — | `#DE000000` | 16sp (`text.subhead`) | margin 16/8/16dp | tiêu đề mở đầu feed |
| FAB chat | `addConversationImageButton` | nền tròn `#7CB342` (`floating_action_bar_shape`), icon trắng | — | 56dp, margin 16dp góc phải-dưới | theo `N()`: **ẩn khi clan có chủ, hiện khi chưa có chủ**; click → mở phòng chat `#tên` |
| Spinner giữa màn | `wattingProgressBar` | — | — | 48dp | hiện khi đang tải info (cmd 68) / tra nick |

## 3. CSS tương đương (dựng lại trên web)

> Scaffold (action bar nổi + list + FAB) giống [Trang cá nhân §9](../trang-ca-nhan/README.md) — dưới đây chỉ phần **header clan**.

```css
.clan-page__card {
  background: #fff;
  box-shadow: 0 1px 3px rgba(0,0,0,.16);  /* bg_shadow_span */
  padding-bottom: 16px; margin-bottom: 8px;
}
.clan-page__cover {
  position: relative; width: 100%; aspect-ratio: 2 / 1;
  background: #33691E;                     /* colorOlaPrimaryDarkMore khi chưa có ảnh */
  object-fit: cover;
}
.clan-page__cover-edit, .clan-page__avatar-edit {
  position: absolute; right: 4px; bottom: 4px;
  display: none;                            /* chỉ bang chủ */
}
.clan-page__avatar-frame {
  position: absolute; left: 8px; bottom: 8px;
  padding: 4px 4px 6px;
  background: #fff; box-shadow: 0 1px 3px rgba(0,0,0,.24); /* bg_shadown_border */
}
.clan-page__avatar { width: 96px; height: 96px; object-fit: cover; }

.clan-page__id {
  text-align: center; padding: 8px;
  font-size: 24px; color: rgba(0,0,0,.54);
}
.clan-page__divider { height: 1px; background: rgba(0,0,0,.12); }

/* Cụm nút quan hệ — 5 ô, ở clan chỉ dùng 3 (Quan tâm | Quản lý | Viết Me) */
.clan-page__actions { display: flex; padding: 8px; }
.clan-page__action {
  flex: 1; text-align: center; cursor: pointer;
  font-size: 12px; color: rgba(0,0,0,.26);
}
.clan-page__action img { height: 20px; }
.clan-page__action--following { color: #7CB342; }  /* đang quan tâm */
.clan-page__action--hidden { display: none; }       /* Thích + Khác luôn ẩn ở clan */

/* Nút Tạo Clan — thay chỗ cụm nút khi clan chưa có chủ */
.clan-page__create {
  display: none;
  width: calc(100% - 16px); margin: 8px;
  padding: 16px 0;
  background: #2A63CC; color: #fff;
  font-size: 12px; border: 0; border-radius: 2px; cursor: pointer;
}

.clan-page__members { text-align: center; margin: 16px 0; }
.clan-page__members b { font-size: 20px; color: #000; }
.clan-page__members span { font-size: 12px; color: rgba(0,0,0,.54); margin-left: 2px; }

.clan-page__info-row {
  display: flex; align-items: center; gap: 4px;
  margin: 8px 0 0 16px;
  font-size: 12px; color: rgba(0,0,0,.54);
}
.clan-page__info-row img { width: 17px; height: 15px; }

.clan-page__feed-title {
  margin: 8px 16px 0;
  font-size: 16px; color: rgba(0,0,0,.87);
}
```

```html
<div class="clan-page__card">
  <div style="position:relative">
    <img class="clan-page__cover" src="http://props.kaspee.com/clan/photo/teamviet-cover-480.jpg">
    <div class="clan-page__avatar-frame">
      <img class="clan-page__avatar" src="http://props.kaspee.com/clan/photo/teamviet-avatar-200.jpg">
    </div>
  </div>
  <div class="clan-page__id">#teamviet</div>
  <div class="clan-page__divider"></div>
  <div class="clan-page__actions">
    <div class="clan-page__action"><img src="../images/ic_follow_black_disable.png"><div>Quan tâm</div></div>
    <div class="clan-page__action"><img src="../images/ic_post_me_gray.png"><div>Viết Me</div></div>
  </div>
  <div class="clan-page__divider"></div>
  <div class="clan-page__members"><b>1.234</b><span>Thành viên</span></div>
  <div class="clan-page__info-row">Ngày lập Clan 15/03/2015</div>
  <div class="clan-page__info-row"><img src="../images/ic_clan_role_leader.png"> @bangchu01</div>
  <div class="clan-page__info-row"><img src="../images/ic_clan_role_vice_leader.png"> @phobang02</div>
  <div class="clan-page__info-row"><img src="../images/ic_clan_role_supporter.png"> @daisu03</div>
  <div class="clan-page__info-row"><img src="../images/ic_profile_note.png"> Tự do gia nhập</div>
</div>
<div class="clan-page__feed-title">ME Đã Đăng</div>
```

## 4. Hành vi & luồng

### 4.1. Nạp dữ liệu (socket — không có REST riêng cho clan)

```
Mở màn → C() bind view → K() (dòng 257-282)
  e == null → hiện spinner → gửi mã lệnh 68 (OlaNetworkService.f(tên, 68))
     ├─ a(entity.b, 68)  = CLAN CÓ CHỦ → this.e = clan (k=đang follow nếu store.a()==1) → K() render
     └─ a(String, 68)    = CHƯA CÓ CHỦ → e mới chỉ có tên + e.e=<chuỗi lỗi> → K() render "trang trống"
  e != null → đổ header (ô tìm + id + N() ảnh/quyền + Q() cụm nút + member + P() ngày + O() bộ máy + policy)
              feed trống (store.j()==0) → a_(0): gửi mã lệnh 80 ("#tên", cursor=store.k())
     └─ a(str, s, list, 80): s==1 → đánh dấu đang follow; trang đầu store.b(...) / trang sau store.c(list)
        → adapter.notifyDataSetChanged(); cuộn cuối list → adapter gọi a_(...) nạp trang kế (cursor = timestamp bài cuối)
```

- **2 cờ quyền quyết định mọi hiển thị** (dòng 284-298): `M()` = clan **có chủ** (`e.e` rỗng) · `L()` = mình **là bang chủ** (nick mình == `e.b`).

| Trạng thái | Icon 📷 sửa ảnh | Cụm nút quan hệ | Nút "Tạo Clan" | FAB chat |
|---|---|---|---|---|
| Clan có chủ + mình là bang chủ | ✅ | Quản lý Clan + Viết Me | ẩn | ẩn |
| Clan có chủ + người thường | ẩn | Quan tâm + Viết Me | ẩn | ẩn |
| Clan **chưa có chủ** | ẩn | ẩn hết | ✅ (xanh dương) | ✅ |

  ("Thích" và "Khác" **luôn ẩn** ở màn clan — dòng 224, 234.)
- Ảnh: `http://props.kaspee.com/clan/photo/<tên>-avatar-<size>.jpg` / `-cover-<size>.jpg` (CDN tĩnh — [cấu hình](../../api/cau-hinh-api-server.md)); nạp qua `c/t.e()/d()` với cờ `I` ép tải lại sau khi crop.
- **Kéo làm mới** (SwipeRefresh): `S()` bật spinner → `I()` xoá store + `e=null` → nạp lại 68+80; tự tắt sau tối đa **30s** (dòng 92-114).

### 4.2. Bảng tương tác (mọi cử chỉ — header + action bar + FAB)

| Thành phần | Cử chỉ | Hành vi | Loại |
|------------|--------|---------|------|
| Nút back | click | `finish()` (trượt phải) | nội bộ |
| Ô tìm `searchEditText` | **Enter / nút Search** | text bắt đầu `#` → mở **Trang Clan mới**; ngược lại → tra nick (§4.4) | hỗn hợp |
| Ô tìm | chọn 1 dòng **gợi ý** (dropdown adapter `b/q`) | như trên (dòng 167-183) | hỗn hợp |
| Ảnh bìa | click | mở **trình xem ảnh** `OlaImageViewerActivity` với ảnh bìa gốc | sang màn khác |
| Avatar | click | mở trình xem ảnh với avatar gốc | sang màn khác |
| Icon 📷 bìa | click | mở **crop ảnh** `OlaCropImageActivity.a(...)` (đổi bìa clan) — xong callback `D()/E()` ép tải lại ảnh | sang màn khác |
| Icon 📷 avatar | click | `OlaCropImageActivity.b(...)` (đổi avatar clan) | sang màn khác |
| Nút **Quan tâm** | click | `R()` (§4.3 modal 1): đang follow → confirm rồi bỏ; chưa → follow ngay (event 19) | modal trong màn |
| Nút **Quản lý Clan** | click | mở [Quản lý Clan](../quan-ly-clan/README.md) (truyền clan qua static) | sang màn khác |
| Nút **Viết Me** | click | mở composer `OlaMeComposerActivity` với đích `#tên` | sang màn khác |
| Nút **Tạo Clan** | click | mở [Tạo Clan](../tao-clan/README.md) — điền sẵn tên | sang màn khác |
| Số thành viên `vLinewarFanNumber` | click | có listener nhưng **không làm gì** (chỉ gọi hàm check rỗng) | — |
| Dòng phó bang `clanManagerTextView2` | click | có listener nhưng **case rỗng — không làm gì** | — |
| FAB 💬 | click | mở **phòng chat** `OlaChatViewActivity` với `#tên` | sang màn khác |
| List feed | **cuộn tới cuối** | tự nạp trang kế (mã lệnh 80, cursor timestamp) | nội bộ |
| List feed | **kéo xuống (pull-to-refresh)** | nạp lại toàn bộ (§4.1) | nội bộ |
| Phím Back | onBackPressed | `finish()` | nội bộ |

**Cử chỉ trên TỪNG BÀI trong feed** (uỷ quyền `q/b.a()` = long-press, `q/b.b()` = click — dòng 189-200; chi tiết vùng bấm chung xem [../me/README.md §4.7](../me/README.md)):

| Vùng trên bài | Cử chỉ | Hành vi |
|---------------|--------|---------|
| Avatar / tên người đăng | click | mở [Trang cá nhân](../trang-ca-nhan/README.md) của nick đó |
| Avatar / tên người đăng | **long-press** | nick người khác → **gửi nhanh "buzz"/quan tâm** (`q/b.java:1552-1560`); nick mình → mở trang cá nhân mình |
| Nội dung `#hashtag` / `@nick` | click | mở Trang Clan / Trang cá nhân tương ứng |
| Ảnh/media 1-5 | click | mở trình xem ảnh (long-press cũng mở viewer tương ứng media) |
| Nút Thích | click | like/bỏ like bài |
| Nút Thích | **long-press** | mở danh sách người đã thích (`OlaMeLikerListActivity`) |
| Nút Bình luận | click | mở màn bình luận `OlaMeCommentActivity` |
| Nút ⋯ (footer bài) | click | mở **menu bài đăng theo vai trò** (§4.5) |

### 4.3. Modal/Dialog mở trong màn (chi tiết)

1. **Confirm bỏ Quan tâm** (`R()`, dòng 396-436) — chỉ hiện khi **đang** follow mà bấm lại:
   - Tiêu đề "Xác nhận", nội dung `me_message_notfollow_confirm` — "Bạn có muốn ngừng quan tâm **Clan #x** không?".
   - Nút **"Ngừng quan tâm"** (`string_notfollow`) → gửi unfollow (event 19) + đổi nút về trạng thái xám. Nút **"Đóng"** → thôi.
   - (Bấm **Quan tâm** khi chưa follow thì **KHÔNG có confirm** — follow ngay.)
2. **Dialog "Tài khoản không tồn tại"** — khi tra nick từ ô tìm thất bại (dòng 548-563): thông báo `string_buddy_is_not_exist` (hoặc `message_fail_phone_number_invalid` nếu tra bằng SĐT), nút đóng; ô tìm select-all để sửa.
3. **Menu bài đăng** (mở từ nút ⋯ / thao tác trên bài) — xem §4.5, đây là menu list (`chat.ola.vn.i.m`).

### 4.4. Ô tìm kiếm trên action bar (`g(str)`, dòng 488-567)

- Nhập bắt đầu `#` → mở **Trang Clan** khác (đệ quy màn này).
- Nhập nick → spinner + tra server: tồn tại → mở [Trang cá nhân](../trang-ca-nhan/README.md); không → dialog "Tài khoản không tồn tại!".
- Nhập **số điện thoại** (khi server bật cờ `h.O.x`) → tra SĐT lấy nick rồi mở trang cá nhân; sai → "Số điện thoại không hợp lệ".
- Ô có **gợi ý gõ nhanh** (adapter `b/q` — OlaQuickTypingSuggestedText, nguồn `g.a()`).

### 4.5. Menu bài đăng trong clan — đổi theo VAI TRÒ (`q/b.c()`, dòng 589-608)

Khi đang đứng ở trang `#clan` (`store.g()` bắt đầu `#`), nút ⋯ của một bài phân nhánh theo vai trò của **mình** (so nick với bộ máy clan — decompile mất tham số so sánh, nhánh chính xác cần đối chiếu smali nếu quan trọng):

1. **Menu quản trị bài** (`b(ctx, entry, clan)`, dòng 454-587 — bang chủ/phó xem bài người khác):
   - **Chat** → mở chat với người đăng
   - **Copy** → copy nội dung (+hashtag)
   - **Chặn khỏi Clan** (`string_ban_from_clan`) → **confirm** "Bạn có muốn khóa nick @x khỏi Clan #y?" → gửi `OlaNetworkService.g(nick, clan)`
   - **Xoá Me** → confirm "Bạn muốn xoá Me của @x?" → xoá bài (lệnh theo loại bài)
   - **Thao tác khác** → mở tiếp menu 2
   - (bài của **chính mình** → chỉ Copy / Xoá Me / Thao tác khác)
2. **Menu quản trị clan trên 1 bài** (`d(ctx, entry, clan)`, dòng 764-…):
   - **Loan tin toàn clan** (`string_broadcast_to_clan`) → broadcast bài cho cả clan (`b(msgId, clan)`)
   - **Cài đặt làm Me top clan** (`string_post_me_top_clan`) → ghim bài lên **dòng 0** của feed (`a(msgId, clan)`)
   - **Bỏ Me top clan** (`string_discard_me_top_clan`) → gỡ ghim (`q(clan)`)
   - **Xóa hết Me từ @x** (`message_delete_all_me_from_clan_of`) → confirm "Bạn muốn xoá tất cả Me của @x trong Clan #y?" nút **"Xóa tất cả"** → `h(nick, clan)`
   - **Copy+** → copy nội dung kèm mọi hashtag
3. Người thường → menu bài đăng **thường** (như bảng tin — xem [../me/README.md §4.7](../me/README.md)).

### 4.6. Bản đồ lệnh socket của màn

| Hành vi | Gọi trong code | Mã lệnh / lệnh text |
|---------|----------------|----------------------|
| Nạp info clan | `OlaApplication.b.f(tên, 68)` | 68 |
| Nạp feed (phân trang) | `b.a("#tên", cursor, 80)` | 80 |
| Follow / bỏ follow | `b.a("#tên", true/false, cb)` | event 19 |
| Chặn nick khỏi clan | `b.g(nick, clan)` | (builder `OlaNetworkService`) |
| Loan tin / Me top / bỏ top / xoá hết Me | `b.b(id, clan)` / `b.a(id, clan)` / `b.q(clan)` / `b.h(nick, clan)` | (builder `OlaNetworkService`) |

(Giao thức chung text `@113 …` — xem [../../api/socket-protocol.md](../../api/socket-protocol.md).)

### 4.7. Đối chiếu web (`web/src/pages/`)

**Web hiện CHƯA có tính năng Clan.** Gần nhất là trang cá nhân/feed Me của web — khi dựng lại trang clan có thể tái dùng khung feed đó + header theo tài liệu này.

## 5. Strings (đa ngôn ngữ)

| Resource | EN (`values/strings.xml`) | VI (`values-vi/strings.xml`) |
|----------|--------------------------|------------------------------|
| `string_enter_nick_name_or_clan` | Enter nick or #clan | Nhập nick hoặc #clan |
| `string_members` | Members | Thành viên |
| `string_clan_foundation_date` | Clan foundation date %1$s | Ngày lập Clan %1$s |
| `string_unknown` | Unknown | Chưa biết |
| `string_follow` / `string_following` | Follow / Following | Quan tâm / Đang quan tâm |
| `string_notfollow` | Unfollow | Ngừng quan tâm |
| `me_message_notfollow_confirm` | Do you want to unfollow %1$s? | Bạn có muốn ngừng quan tâm %1$s không? |
| `string_manage_clan` | Manage Clan | Quản lý Clan |
| `string_post_me` | Post Me | Viết Me |
| `string_like` / `string_more` | Like / More | Thích / Khác |
| `string_create_clan` | Create Clan | Tạo Clan |
| `string_me_posts` | Me Posts | ME Đã Đăng |
| `string_ban_from_clan` | Ban from Clan | Chặn khỏi Clan |
| `message_ban_from_clan_confirm_format` | Do you want to ban %1$s from Clan %2$s? | Bạn có muốn khóa nick %1$s khỏi Clan %2$s? |
| `string_broadcast_to_clan` | Boost whole Clan | Loan tin toàn clan |
| `string_post_me_top_clan` | Set Me Top of Clan | Cài đặt làm Me top clan |
| `string_discard_me_top_clan` | Discard Me Top of Clan | Bỏ Me top clan |
| `message_delete_all_me_from_clan_of` | Delete Me from %1$s | Xóa hết Me từ %1$s |
| `message_delete_all_me_from_clan_format` | Do you want to delete Me of %1$s in Clan %2$s? | Bạn muốn xoá tất cả Me của %1$s trong Clan %2$s? |
| `string_delete_me` / `string_delete_all` | Delete Me / Delete all | Xoá Me / Xóa tất cả |
| `string_chat` / `string_copy` / `string_copy_plus` / `string_more_action` | Chat / Copy / Copy+ / More actions | Chat / Copy / Copy+ / Thao tác khác |
| `message_delete_me_format` | Do you want to delete Me of %s? | Bạn muốn xoá Me của %s? |
| `string_buddy_is_not_exist` | Account is not exist! | Tài khoản không tồn tại! |
| `string_recent_clan` | Viewed Clan(s) | Clan đã xem |
| `me_message_join_confirm` | Do you want to join this Clan? | Bạn có muôn gia nhập Clan không? *(sic — typo "muôn" gốc APK)* |
| `me_message_notjoin_confirm` | Do you want to quit this Clan? | Bạn có muôn rời Clan không? |

> `me_message_join_confirm`/`notjoin_confirm` tồn tại trong resource nhưng màn này dùng `me_message_notfollow_confirm`; 2 string join/quit dùng ở luồng khác (giữ đây để tra cứu thuật ngữ clan).

## 6. Màn mở ra từ đây (điều hướng)

| Từ (nút/cử chỉ) | Màn đích (class) | Doc |
|-----------------|------------------|-----|
| Nút "Quản lý Clan" (bang chủ) | `activity.ClanManagementActivity` | [../quan-ly-clan/README.md](../quan-ly-clan/README.md) |
| Nút "Tạo Clan" (clan chưa có chủ) | `activity.CreateClanActivity` | [../tao-clan/README.md](../tao-clan/README.md) |
| Nút "Viết Me" | `me.OlaMeComposerActivity` (composer đăng bài) | xem [../me/README.md §6](../me/README.md) |
| FAB 💬 / menu bài "Chat" | `activity.OlaChatViewActivity` (khung chat) | [../chat-hoi-thoai/README.md](../chat-hoi-thoai/README.md) |
| Click bìa / avatar / media bài | `activity.OlaImageViewerActivity` (xem ảnh) | [../hinh-anh/README.md](../hinh-anh/README.md) |
| Icon 📷 sửa bìa/avatar (bang chủ) | `activity.OlaCropImageActivity` (crop ảnh) | [../doi-anh-dai-dien/README.md](../doi-anh-dai-dien/README.md) |
| Ô tìm nhập nick / click avatar-tên trong feed | `me.OlaUserMePageActivity` (Trang cá nhân) | [../trang-ca-nhan/README.md](../trang-ca-nhan/README.md) |
| Ô tìm nhập `#khác` / click #hashtag | `me.OlaClanMePageActivity` (chính màn này, clan khác) | (màn này) |
| Nút Bình luận trên bài | `me.OlaMeCommentActivity` (bình luận) | [../me/comment/](../me/comment/) |
| Long-press nút Thích trên bài | `me.OlaMeLikerListActivity` (danh sách người thích) | (chưa có doc — cần làm) |
