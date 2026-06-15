# Màn hình Kho VIP (VIP icon collection)

- **Activity:** `chat.ola.vn.activity.OlaVipStoreActivity` — `jadx_out/sources/chat/ola/vn/activity/OlaVipStoreActivity.java` (498 dòng)
- **Layout màn (scaffold):** `apktool_out/res/layout/vip_manager_layout.xml` (action bar nổi + ListView + thanh "VIP duration" dưới đáy)
- **Layout header:** `vip_storage_header_layout.xml` (VIP đang dùng + quyền riêng tư + Buy/Extend + nhãn kho)
- **Layout item:** `vip_info_item_layout.xml` (1 icon VIP trong kho: icon + tên + trạng thái)
- **Action bar:** `ola_top_action_bar_layout.xml` (back + tiêu đề + nút more)
- **Mở từ:** tab **Ứng dụng → "Kho VIP"** (`general_tab_vipstore`), hoặc `OlaVipStoreActivity.a(context, nick)` — gọi từ `m/d`, `me/OlaUserMePageActivity`, `q/b`, `m/y`, `c`.

> **Kho VIP = bộ sưu tập icon VIP của người dùng.** `nick == null` → kho **của mình** (tiêu đề "Your VIP icon collection"); `nick != null` → xem kho **người khác** (tiêu đề = tên người đó). Mở có animation `push_left`, cờ `REORDER_TO_FRONT`.

> Dựng từ **code + XML**. Icon trích sẵn vào [images/icons/](images/icons/).

> **Cỡ chữ chuẩn:** caption 12sp `#8A000000` · subhead 16sp `#DE000000` · title 20sp **bold** · button (action bar) chữ trắng.

---

## 1. Khung màn (`vip_manager_layout.xml`)

`FrameLayout` nền trắng, 4 lớp:

```
FrameLayout (nền #FFFFFF)
├─ [NỘI DUNG] ListView @id/listView
│     paddingTop 42dp (chừa action bar nổi) · marginBottom 48dp (chừa thanh đáy)
│     style list.noDivider (không divider, không scrollbar)
│     ├─ headerView = vip_storage_header_layout (§2)
│     └─ các dòng = vip_info_item_layout (§3)  ← icon VIP trong kho
├─ [THANH ĐÁY] LinearLayout (bottom, cao 48dp, nền bg_white_with_top_border, padding 8dp)
│     ├─ "VIP duration" (caption)
│     ├─ vipDurationTextView (title 20sp bold, weight 1)        ← số ngày VIP còn lại
│     └─ Button "Extend VIP" (button.green)  → BuyVipActivity.b  ← GIA HẠN
├─ [ACTION BAR] <include ola_top_action_bar_layout> (§4)  ← nổi trên cùng
└─ [OVERLAY LOADING] FrameLayout @id/wattingProgressBar
      nền translucent_black_38_percent (rgba(0,0,0,.38)), clickable, ẩn
      └─ ProgressBar 48dp center
```

## 2. Header (`vip_storage_header_layout.xml`)

Nền **trắng mờ 80%** (`translucent_white_80_percent` = `#CCFFFFFF`):

| # | Vùng | id | Chi tiết / hành động |
|---|------|----|----------------------|
| 1 | Nhãn "Using VIP icon" | — | caption, padding 16dp |
| 2 | **VIP icon đang dùng** | `<include vip_info_item_layout>` | icon 40dp + tên + trạng thái (xem §3) |
| 3 | **Quyền xem kho** | `policyViewLayout` | "Who can see" (subhead) + `policyTextView` (Public/Friends/Private) + `ic_arrow_right` → bấm gọi `E()` mở chọn quyền |
| — | divider 1px (margin ngang 16dp) | | |
| 4 | **Buy VIP** | `buyVipTextView` | subhead, minHeight 48dp → `BuyVipActivity.a(this)` (mua VIP) |
| — | divider | | |
| 5 | **Extend VIP** | `extendVipTextView` | subhead, minHeight 48dp → `BuyVipActivity.b(this)` (gia hạn) |
| 6 | Nhãn kho | `labelTextView` | "VIP icon collection" — subhead **chữ trắng**, nền `app_background_color` `#D5D5D5`, cao 36dp → tiêu đề cho danh sách bên dưới |

> Quyền riêng tư lấy từ `R.array.privacy_lable` = **Public / Friends / Private** (`this.p[0..2]`).

## 3. Item kho VIP (`vip_info_item_layout.xml`)

Mỗi dòng cao **72dp**, nền trắng mờ 80%, `@id/vipIconViewLayout`:

```
LinearLayout (cao 72dp)
├─ LinearLayout (padding 16dp, weight 1)
│   ├─ vipIconImageView  40×40dp (centerCrop)          ← ICON VIP
│   └─ cột dọc (giữa, marginLeft 8dp)
│       ├─ vipNameTextView   (subhead)                  ← TÊN VIP
│       └─ vipStateTextView  (caption, marginTop 2dp)   ← TRẠNG THÁI
└─ listViewBottomDividerView  1px (margin ngang 16dp)
```

**Bấm icon** (`vipIconImageView` → `c(ah)` → dựng menu trong `a(ah, view)`): mở **menu ngữ cảnh** thay đổi theo trạng thái icon:

| Mục | String | Điều kiện hiện / Hành động |
|-----|--------|---------------------------|
| **Use VIP** | `string_use_vip` = "Use VIP" | chỉ hiện khi icon **chưa dùng** (`!ah.g()`); kích hoạt **tốn 1 ngày VIP** (`message_active_vipicon_confirm` = "Cost 1 VIP day to activate VIP …") |
| **Unlock / Lock** | `string_unlock` / `string_lock` | **1 mục toggle** theo `ah.f()`: đang khoá → "Unlock", ngược lại → "Lock" |
| **VIP transaction** | `string_transfer_vip` = "VIP transaction" | → `OlaTraddingVipActivity` (chuyển/tặng VIP) |
| **Delete VIP** | `string_delete_vip` = "Delete VIP" | xoá icon (xác nhận `message_delete_vipicon_confirm`) |

> Menu dựng động: `Use VIP` (nếu chưa dùng) → `Unlock`/`Lock` (toggle) → `VIP transaction` → `Delete VIP`.

## 4. Action bar (`ola_top_action_bar_layout.xml`)

`LinearLayout` ngang, nền `bg_action_bar` (xanh `#7CB342`), chữ trắng:

| # | id | Thành phần | Hành động |
|---|----|-----------|-----------|
| 1 | `olaActionBarBackViewLayout` | back `ic_action_back` (+ badge ẩn) | `finish()` |
| 2 | `olaActionBarTitleTextView` | tiêu đề (style button, chữ trắng) | own → "Your VIP icon collection" (`message_your_vip_store`); người khác → tên người đó |
| 3 | `olaActionBarMoreButtonImageView` | nút phải | layout mặc định `ic_more_white`, `onCreate` **ghi đè** thành `ic_action_quit`; bấm → `finish()` |

## 5. Tính năng (onClick — `OlaVipStoreActivity.onClick`)

| Vùng | id | Hành động |
|------|----|-----------|
| Mua VIP | `buyVipTextView` (425) | `BuyVipActivity.a(this)` |
| Gia hạn VIP | `extendVipButton` / `extendVipTextView` (428) | `BuyVipActivity.b(this)` |
| Back / More | `olaActionBarBackViewLayout` / `olaActionBarMoreButtonImageView` (432) | `finish()` |
| Đổi quyền xem kho | `policyViewLayout` (436) | `E()` → chọn Public/Friends/Private |
| Bấm 1 icon VIP | `vipIconImageView` (439) | `c(ah)` → menu Unlock/Lock/Transaction/Delete |

> **Màn liên quan:** [BuyVipActivity](#) (mua/gia hạn VIP — layout `vip_purchase_layout`) và `OlaTraddingVipActivity` (chuyển/tặng VIP — flow 3 bước `ola_tradding_vip_step1..3`). Có thể phân tích riêng sau.

## 6. Strings (EN)

| Key | EN |
|-----|----|
| `general_tab_vipstore` | VIP icon collection |
| `string_vip_store` | VIP icon collection |
| `message_your_vip_store` | Your VIP icon collection |
| `string_using_vip_icon` | Using VIP icon |
| `string_who_can_see` | Who can see |
| `string_public` | Public |
| `string_buy_vip` | Buy VIP |
| `string_extend_vip` | Extend VIP |
| `string_vip_duration` | VIP duration |
| `string_use_vip` | Use VIP |
| `message_active_vipicon_confirm` | Cost 1 VIP day to activate VIP %1$s. Do you want to continue |
| `string_unlock` / `string_lock` | Unlock / Lock |
| `string_transfer_vip` | VIP transaction |
| `string_delete_vip` | Delete VIP |
| `message_empty_vip` | No VIP |

## 7. Icon & token UI

| UI | Icon | Drawable |
|----|------|----------|
| Tab "Kho VIP" (Ứng dụng) | ![vip](images/icons/ic_tab_vip_store.png) | `ic_tab_vip_store` |
| Mũi tên quyền xem | ![arrow](images/icons/ic_arrow_right.png) | `ic_arrow_right` |
| Back (action bar) | ![back](images/icons/ic_action_back.png) | `ic_action_back` |
| More → thoát | ![quit](images/icons/ic_action_quit.png) | `ic_action_quit` (ghi đè `ic_more_white`) |
| Icon VIP trong kho | (tải từ URL) | `vipIconImageView` 40dp |

| Thành phần | Giá trị |
|------------|---------|
| Nền màn | `#FFFFFF` |
| Action bar | nền `#7CB342`, chữ trắng, nổi đè (paddingTop list 42dp) |
| ListView | `list.noDivider` (không divider/scrollbar); marginBottom 48dp chừa thanh đáy |
| Thanh đáy | cao 48dp, nền `bg_white_with_top_border`, padding 8dp; nhãn caption + số ngày title 20sp bold + nút "Extend VIP" (button.green `#9CCC65`) |
| Header/Item | nền trắng mờ 80% `rgba(255,255,255,.8)` (`#CCFFFFFF`) |
| Item | cao 72dp; icon 40dp; tên subhead 16sp; trạng thái caption 12sp; divider 1px margin ngang 16dp |
| Nhãn kho (labelTextView) | cao 36dp, nền `#D5D5D5`, chữ trắng subhead, gravity center |
| Mục Buy/Extend/Policy | subhead, minHeight 48dp, divider 1px ngăn cách |
| Overlay loading | full-screen `rgba(0,0,0,.38)` + spinner 48dp |

## 8. CSS tương đương (rút gọn)

```css
.vip-store { background: #fff; font-family: Roboto, sans-serif; }
.vip-store__card { background: rgba(255,255,255,.8); }            /* header + item */
.vip-store__row {                                                 /* Buy / Extend / Policy */
  display: flex; align-items: center; min-height: 48px; padding: 16px; font-size: 16px;
}
.vip-store__divider { height: 1px; margin: 0 16px; background: rgba(0,0,0,.12); }
.vip-store__label {                                               /* labelTextView */
  height: 36px; display: flex; align-items: center; justify-content: center;
  background: #D5D5D5; color: #fff; font-size: 16px;
}
.vip-store__item { height: 72px; display: flex; flex-direction: column; background: rgba(255,255,255,.8); }
.vip-store__item-main { flex: 1; display: flex; align-items: center; padding: 16px; }
.vip-store__item-icon { width: 40px; height: 40px; object-fit: cover; }
.vip-store__item-text { margin-left: 8px; display: flex; flex-direction: column; justify-content: center; }
.vip-store__item-name { font-size: 16px; color: rgba(0,0,0,.87); }
.vip-store__item-state { margin-top: 2px; font-size: 12px; color: rgba(0,0,0,.54); }
.vip-store__bottom {                                              /* thanh "VIP duration" */
  position: fixed; left: 0; right: 0; bottom: 0; height: 48px;
  display: flex; align-items: center; gap: 8px; padding: 8px;
  background: #fff; box-shadow: 0 -1px 0 rgba(0,0,0,.12);
}
.vip-store__duration { flex: 1; font-size: 20px; font-weight: bold; color: rgba(0,0,0,.87); }
.vip-store__extend { background: #9CCC65; color: #fff; border: 1px solid #558B2F; border-radius: 4px; padding: 0 16px; }
```
