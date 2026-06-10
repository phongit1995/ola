# Màn hình RSS (Tin tức)

- **Tab:** Bottom tab thứ 4 — string `general_tab_rss` = "RSS".
- **Fragment host:** `chat.ola.vn.m.j` — `jadx_out/sources/chat/ola/vn/m/j.java`
- **Layout màn:** `apktool_out/res/layout/news_content_view_layout.xml`
- **Action bar:** `ola_news_top_action_bar_layout.xml`
- **3 fragment con trong ViewPager:**
  - `m.x` — **trang danh sách** bài (`news_page_list_layout.xml`)
  - `m.y` — **trang nội dung** có bình luận/thích/chia sẻ (`news_page_content_layout.xml`)
  - `m.z` — **WebView** đọc bài full HTML (`rss_content_view_layout.xml`)
- **Adapter list:** `chat.ola.vn.b.aj` (item = `entity.t`)

> **RSS là gì:** đây là **trình đọc tin tức** trong Ola — duyệt các kênh/bài (tin tức, truyện "fic", note…), đọc trong app bằng WebView, **đánh dấu (bookmark)**, **lịch sử**, và **chia sẻ bài lên Me / chat**. Render kiểu lai: **danh sách native** (`OlaListView`) + **nội dung WebView**.

> Dựng từ **code + XML** (chưa chụp ảnh). Icon đã trích vào [images/icons/](images/icons/).

---

## 1. Flow tổng thể

```
Bottom tab "RSS" → Fragment m.j (host, DrawerLayout + ViewPager)
   │
   ├─ Action bar: [← Back] [🔍 ô "Tìm kiếm"] [🏠 Home] [⋮ Menu]
   │
   ├─ ViewPager (newsContentPager) — đổi trang theo entity.t.m():
   │     ├─ m()=0,1,2 → Fragment x (DANH SÁCH bài, news_page_list_layout)
   │     │      └─ OlaListView + adapter aj → item rss_article_*_layout (4 kiểu)
   │     │             │ bấm 1 bài
   │     │             ▼
   │     └─ m()≥3 → Fragment y (NỘI DUNG, có Bình luận/Thích/Chia sẻ)
   │            └─ bấm "đọc full" → Fragment z (WebView wvContent) — đọc trong app
   │
   ├─ Vuốt mép TRÁI → phải: Drawer trái = BOOKMARK (dấu trang) + ô "Nhập Bookmark"
   └─ Vuốt mép PHẢI → trái: Drawer phải = LỊCH SỬ + ô "Nhập từ cần tìm"

   Chia sẻ 1 bài → OlaMeComposerActivity ("<tên>\nrss://<url>") → đăng lên Me/Diary
```

## 2. Bố cục màn (`news_content_view_layout.xml`)

```
FrameLayout
└─ DrawerLayout  @id/newsDrawerLayout
    ├─ FrameLayout (nội dung chính)
    │   ├─ OlaViewPager  @id/newsContentPager  (paddingTop 42dp = chừa action bar)  ← TRANG RSS
    │   ├─ ProgressBar   @id/progressNewsWatting (giữa)
    │   └─ <include> ola_news_top_action_bar_layout                                 ← ACTION BAR
    ├─ FrameLayout  @id/left_drawer  240dp, nền trắng                               ← BOOKMARK
    │   ├─ OlaQuickTypingSuggestedText  txtLeftMenuInput  (hint "Nhập Bookmark", imeOptions=actionGo)
    │   ├─ ImageView  btnLeftButtonClear  (ic_menu_delete — xoá tất cả)
    │   └─ ListView  left_List  (divider 1dp)  + ProgressBar progressBookmarkWatting
    └─ FrameLayout  @id/right_drawer 240dp, nền trắng                               ← LỊCH SỬ
        ├─ OlaQuickTypingSuggestedText  txtRightMenuInput (hint "Nhập từ cần tìm")
        ├─ ImageView  btnRightButtonClear (ic_menu_delete)
        └─ ListView  right_List  + ProgressBar progressHistoryWatting
```

## 3. Action bar (`ola_news_top_action_bar_layout.xml`)

Nền xanh (`actionBar.background`), padding 8/4/8/10dp:

| Thành phần | id | Icon/nội dung |
|------------|----|----|
| Quay lại | `olaActionBarBackImageView` | `ic_action_back` |
| **Ô tìm kiếm** (weight 1, viền sáng) | `searchNewsEditText` | `ic_action_search_small` 16dp + EditText hint `string_search` = **"Tìm kiếm"**, chữ **trắng**, `imeOptions=actionSearch` |
| **Home** | `newsActionBarHomeImageView` | `ic_action_home` — về trang chủ RSS (`a(new entity.t(null))`) |
| **Menu ⋮** | `olaActionBarMoreButtonImageView` | `ic_more_white` |

> Tìm kiếm gửi URL `search/<type>/<keyword>`; **type** đổi được: `news` (tin) / `note` (ghi chú) / `fic` (truyện) — chạm icon để đổi loại (`tutorial_rss_touch_to_change_search_type`).

## 4. Item 1 bài (`adapter aj`, kiểu theo `entity.t.m()`)

| `m()` | Layout | Bố cục |
|------:|--------|--------|
| **0** | `rss_article_default_layout` | tiêu đề **24sp đen** (3 dòng) → hàng [mô tả **17sp** (5 dòng) \| **thumbnail 188dp**] → kẻ `#d5d5d5`. Nền `translucent_white_90_percent`, minHeight 72dp |
| **1** | `rss_article_pic_and_description_layout` | tiêu đề → **ảnh full chiều ngang** → mô tả |
| **2** | `rss_article_magazine_layout` | **ảnh full** + tiêu đề **đè lên** (chữ trắng 20sp, nền `translucent_black_38_percent`) |
| **3+** | `rss_publisher_layout` | chỉ tiêu đề 20sp (kênh/nhà xuất bản) |

Item đặc biệt khác: `news_youtube_content_item` (video YouTube), `news_related_article_item` (bài liên quan), `news_title_header_layout` (tiêu đề mục), `news_adme_software_content_item` / `news_admob_native_rss_content_item` / `rss_admob_native_*` (quảng cáo).

> `entity.t`: `o()`=URL · `p()`=tên · `m()`=kiểu layout · `j()`=mục con · `x()`=số bình luận · `s()`=số thích · ảnh `e[]` / thumbnail `h`.

## 5. Đọc nội dung — WebView (`m.z`, `rss_content_view_layout.xml`)

- Bài đọc **trong app** bằng **WebView** `@id/wvContent` (không mở trình duyệt ngoài).
- `WebViewClient`: `onPageFinished` (ẩn progress), `onReceivedError` (báo lỗi); có bản **offline** `offline_rss_content_view_layout.xml` khi mất mạng.
- Nội dung tải qua `OlaApplication.b.r(url, …)`; URL nội bộ prefix **`rss://`**.
- Chỉnh **cỡ chữ** WebView (menu ⋮ → "Cỡ chữ" `setting_rss_font_size_title`).

## 6. Trang nội dung tương tác (`m.y`) & RSS trong chat (`chat_rss_layout.xml`)

Một bài (khi xem chi tiết hoặc khi nhúng vào chat) có **thanh tương tác**:

```
chatRssViewLayout (vertical)
├─ OlaRatioImageView  imgNewsThumbnail   (ảnh, full width, centerCrop)
├─ TextView  txtNewsTitle    (style title, 3 dòng)
├─ TextView  txtNewsSubTitle (style button, 5 dòng)
├─ rssCommentSpanLayout (cao 20dp, canh phải)
│   ├─ rssCommentNumberTextView  "X bình luận" (caption, .54)
│   └─ rssLikeNumberTextView     "X thích"
├─ divider 1px
└─ rssCommandViewLayout (3 nút, mỗi nút cao 28dp, weight 1)
    ├─ rssCommentViewLayout  ic_action_reply_gray + "Bình luận"
    ├─ rssShareViewLayout    ic_action_share_gray + "Chia sẻ"
    └─ rssLikeViewLayout     ic_like_gray + "Thích"  (rssLikeImageView/rssLikeTextView)
```

> **Chia sẻ** (`j.c()`): mở `OlaMeComposerActivity` với nội dung `"<tên bài>\nrss://<url>"` → đăng lên **Me/Diary**; bài hiển thị bằng `attached_me_rss_holder_layout.xml`. **Bình luận/Thích** đi qua luồng Me (`OlaMeComposerActivity` comment).

## 7. Tính năng

| Tính năng | Vào từ | Chi tiết |
|-----------|--------|----------|
| **Tìm kiếm** | ô 🔍 action bar | `search/<news\|note\|fic>/<keyword>`; chạm icon đổi loại |
| **Trang chủ RSS** | nút 🏠 | về home (`a(new entity.t(null))`) |
| **Bookmark (dấu trang)** | vuốt mép trái / menu ⋮ "Thêm dấu trang" | dialog nhập tên (`general_hint_bookmark_name` = "Tên Bookmark"); danh sách ở drawer trái; xoá tất cả (ic_menu_delete) |
| **Lịch sử** | vuốt mép phải | trang đã xem; ghi nhớ bật/tắt (`setting_rss_save_history_title`) |
| **Chia sẻ lên Me** | nút Chia sẻ | đăng `rss://` vào Diary/Me |
| **Bình luận / Thích** | nút trong bài | qua luồng Me |
| **Cỡ chữ** | menu ⋮ "Cỡ chữ" | đổi font WebView |
| **Lưu offline** | `string_save_rss_offline` = "Lưu offline" | đọc khi mất mạng (`offline_rss_content_view_layout`) |
| **Bố cục danh sách** | Cài đặt | `setting_rss_layout_type_title` = "Bố cục trang" (đổi kiểu item 0/1/2) |
| **Cử chỉ trang** | — | vuốt trái/phải chuyển trang trước/sau (`tutorial_rss_pull_left/right`) |

**Menu ⋮** (trang danh sách `x` / nội dung `y`): Copy (sao chép `rss://`) · Thêm dấu trang · *(Cỡ chữ — chỉ trang nội dung)* · Cài đặt.

## 8. Strings (EN → VI)

| Key | EN | VI |
|-----|----|----|
| `general_tab_rss` | RSS | RSS |
| `string_search` | Search | Tìm kiếm |
| `string_suggested_rss` | News | Tin hay |
| `string_add_bookmark` | Add bookmark | Thêm dấu trang |
| `general_hint_bookmark` | Search bookmark | Nhập Bookmark |
| `general_hint_bookmark_name` | Bookmark name | Tên Bookmark |
| `general_hint_history` | Search history | Nhập từ cần tìm |
| `string_save_rss_offline` | Save offline | Lưu offline |
| `setting_rss_font_size_title` | Font size | Cỡ chữ |
| `setting_rss_layout_type_title` | Layout | Bố cục trang |
| `setting_rss_save_history_title` | Remember Rss history | Ghi nhớ trang đã xem |
| `string_comment` | Comment | Bình luận |
| `string_share` | Share | Chia sẻ |
| `string_like` | Like | Thích |
| `message_clear_all_rss_bookmark` | Clear all bookmarks | Bạn có chắc muốn xoá tất cả đánh dấu tin tức không |
| `message_clear_all_rss_history` | Clear history | Bạn có chắc muốn xoá tất cả lịch sử tin tức không |
| `tutorial_rss_pull_left` | Swipe left for next page | Vuốt sang trái để đến trang kế |
| `tutorial_rss_pull_right` | Swipe right for previous page | Vuốt sang phải để về trang trước |

## 9. CSS tương đương

```css
/* ===== Action bar RSS ===== */
.ola-rss-bar {
  display: flex; align-items: center; gap: 8px;
  background: #7CB342; padding: 4px 8px 10px;
  font-family: Roboto, "Helvetica Neue", Arial, sans-serif;
}
.ola-rss-bar__back, .ola-rss-bar__home, .ola-rss-bar__more { width: 24px; }
.ola-rss-bar__search {
  flex: 1; display: flex; align-items: center; gap: 4px;
  border: 1px solid rgba(255,255,255,.5); border-radius: 4px; padding: 2px 8px;
}
.ola-rss-bar__search img { width: 16px; height: 16px; }
.ola-rss-bar__search input {
  flex: 1; background: none; border: none; color: #fff; font-size: 14px;
}
.ola-rss-bar__search input::placeholder { color: rgba(255,255,255,.8); }

/* ===== Item bài — kiểu mặc định (type 0) ===== */
.ola-rss-item {
  background: rgba(255,255,255,.9); padding: 8px 0;
  border-bottom: 1px solid #d5d5d5;
}
.ola-rss-item__inner { margin: 0 16px; min-height: 72px; }
.ola-rss-item__title { font-size: 24px; color: #000; line-height: 1.2;
  display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden; }
.ola-rss-item__row { display: flex; gap: 4px; margin-top: 8px; }
.ola-rss-item__desc { flex: 1; font-size: 17px; color: #000; line-height: 1.3;
  display: -webkit-box; -webkit-line-clamp: 5; -webkit-box-orient: vertical; overflow: hidden; }
.ola-rss-item__thumb { width: 188px; max-height: 164px; object-fit: cover; }

/* ===== Item kiểu tạp chí (type 2) — tiêu đề đè ảnh ===== */
.ola-rss-item--mag { position: relative; min-height: 72px; }
.ola-rss-item--mag img { width: 100%; object-fit: cover; }
.ola-rss-item--mag .ola-rss-item__title {
  position: absolute; left: 0; right: 0; bottom: 0;
  padding: 8px; font-size: 20px; color: #fff;
  background: rgba(0,0,0,.38);
}

/* ===== Thanh tương tác bài (comment/share/like) ===== */
.ola-rss-actions { display: flex; padding: 0 16px; }
.ola-rss-actions__btn {
  flex: 1; height: 28px; display: flex; align-items: center; justify-content: center; gap: 2px;
  background: none; border: none; font-size: 14px; color: rgba(0,0,0,.26);
}
.ola-rss-actions__btn img { height: 100%; }
.ola-rss-stats { display: flex; justify-content: flex-end; gap: 8px;
  margin: 16px 16px 0; font-size: 12px; color: rgba(0,0,0,.54); }
.ola-rss-stats__cmt { flex: 1; }
```

```html
<div class="ola-rss-bar">
  <img class="ola-rss-bar__back" src="images/icons/ic_action_search_small.png">
  <div class="ola-rss-bar__search">
    <img src="images/icons/ic_action_search_small.png"><input placeholder="Tìm kiếm">
  </div>
  <img class="ola-rss-bar__home" src="images/icons/ic_action_home.png">
  <img class="ola-rss-bar__more" src="images/icons/ic_more_white.png">
</div>

<article class="ola-rss-item">
  <div class="ola-rss-item__inner">
    <div class="ola-rss-item__title">Tiêu đề bài viết RSS</div>
    <div class="ola-rss-item__row">
      <div class="ola-rss-item__desc">Tóm tắt nội dung bài…</div>
      <img class="ola-rss-item__thumb" src="thumb.jpg">
    </div>
  </div>
</article>
```

## 10. Bảng icon

| UI | Icon | Drawable |
|----|------|----------|
| Tab RSS | ![rss](images/icons/ic_bottom_tab_rss.png) ![rss sel](images/icons/ic_bottom_tab_rss_selected.png) | `ic_bottom_tab_rss(_selected)` |
| Chỉ báo RSS | ![ind](images/icons/ic_indicate_rss.png) | `ic_indicate_rss` |
| Thumbnail mặc định | ![thumb](images/icons/ic_rss_thumbnail_icon.png) | `ic_rss_thumbnail_icon` |
| Tìm kiếm | ![search](images/icons/ic_action_search_small.png) | `ic_action_search_small` |
| Home | ![home](images/icons/ic_action_home.png) | `ic_action_home` |
| Menu ⋮ | ![more](images/icons/ic_more_white.png) | `ic_more_white` |
| Bình luận | ![cmt](images/icons/ic_action_reply_gray.png) | `ic_action_reply_gray` |
| Chia sẻ | ![share](images/icons/ic_action_share_gray.png) | `ic_action_share_gray` |
| Thích | ![like](images/icons/ic_like_gray.png) | `ic_like_gray` |

## 11. Tóm tắt token UI

| Thành phần | Giá trị |
|------------|---------|
| Action bar | nền `#7CB342`, padding 8/4/8/10dp |
| Ô tìm kiếm | viền sáng, chữ + hint **trắng**, icon 16dp |
| Drawer trái/phải | 240dp, nền trắng, divider 1dp |
| Tiêu đề bài | **24sp** đen, 3 dòng (`rss.title.text.size`) |
| Mô tả bài | **17sp** đen, 5 dòng, line ×1.3 (`rss.description.text.size`) |
| Tiêu đề tạp chí | **20sp** trắng trên nền `rgba(0,0,0,.38)` |
| Thumbnail | rộng **188dp**, cao tối đa 164dp |
| Nền item | `translucent_white_90_percent` |
| Kẻ ngăn item | `#d5d5d5`, 1px |
| Nút bình luận/chia sẻ/thích | cao 28dp, chữ `rgba(0,0,0,.26)` |
| Số bình luận/thích | caption 12sp, `rgba(0,0,0,.54)` |
| Nội dung bài | **WebView** (cỡ chữ chỉnh được) |
