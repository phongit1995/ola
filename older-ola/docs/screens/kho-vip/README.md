# Màn hình Kho VIP (VIP icon collection)

- **Activity:** `chat.ola.vn.activity.OlaVipStoreActivity` — `jadx_out/sources/chat/ola/vn/activity/OlaVipStoreActivity.java` (498 dòng)
- **Layout màn (scaffold):** `apktool_out/res/layout/vip_manager_layout.xml` (ListView toàn màn + action bar nổi + thanh "Thời hạn VIP" đáy + overlay loading)
- **Layout header (chỉ kho của mình):** `vip_storage_header_layout.xml` (VIP đang dùng + quyền xem + Đăng ký/Gia hạn + nhãn số lượng)
- **Layout 1 dòng kho:** `vip_info_item_layout.xml` (icon VIP + tên + trạng thái) — **dùng chung** cho cả header (mục "VIP icon đang dùng") lẫn từng dòng list
- **Action bar:** `ola_top_action_bar_layout.xml` (back + tiêu đề + nút more)
- **Adapter list:** `chat.ola.vn.b.ad` (1 view type duy nhất) · **Entity:** `chat.ola.vn.entity.ah` (1 icon VIP)
- **Menu/Dialog:** `chat.ola.vn.i.m` (menu danh sách — layout `list_option_dialog_layout`), `chat.ola.vn.i.e` (xác nhận Dùng VIP), `chat.ola.vn.i.f` (xác nhận Xoá VIP)
- **Chức năng:** xem **bộ sưu tập icon VIP** của một người (mình hoặc người khác): icon đang dùng, danh sách icon, đổi quyền xem kho, mua/gia hạn VIP; với kho của mình còn cho **Dùng / Khoá / Mở khoá / Giao dịch / Xoá** từng icon.
- **Mở từ:** tab **Ứng dụng → "Kho VIP"** (`general_tab_vipstore`), hoặc `OlaVipStoreActivity.a(context, nick)` — gọi từ `m/d`, `me/OlaUserMePageActivity`, `q/b`, `m/y`, `c`. Mở có animation `push_left`, cờ `FLAG_ACTIVITY_REORDER_TO_FRONT` (131072); `finish()` chạy animation `push_right`.

> **Kho của mình vs người khác — quyết định bởi `D()`:** `D()` = true khi `nick == null` **hoặc** `nick == nick của mình` (`m.b(j, h.a())`) → **kho của mình**; ngược lại → **kho người khác**.
> - **Kho của mình:** có **header** (VIP đang dùng + quyền + Đăng ký/Gia hạn + nhãn số lượng); **bấm dòng → menu Dùng/Khoá/Giao dịch/Xoá**.
> - **Kho người khác:** **KHÔNG có header**; tiêu đề = tên người đó; bấm dòng **không làm gì** (menu bị `if (D())` chặn). Nếu không có quyền xem → server trả mã `38` → dialog `message_fail_permission_access_format`.

> Dựng từ **code + XML thật**. Icon UI trích sẵn vào [images/icons/](images/icons/); **toàn bộ 120 icon VIP** đóng gói trong asset `assets/vipicon.dat`, render theo id từ cache `chat.ola.vn.j` — đã bóc đủ ra [images/vip-icons/](images/vip-icons/) (xem **§7**).

> **Cỡ chữ chuẩn (resolve từ `styles.xml`/`dimens.xml`):** caption **12sp** `#8A000000` · subhead **16sp** `#DE000000` · title **20sp bold** `#DE000000` · button (tiêu đề action bar) **14sp bold** (đè màu trắng) · nút xanh **14sp** trắng.

## Ảnh chụp

> ⚠️ **Chưa có ảnh chụp thật** của màn này (chưa chạy fake server cho luồng VIP). Mọi mô tả dựng từ layout + code.

### Assets dùng trong màn (ảnh gốc trích từ APK)

| Asset | Ảnh | Dùng cho |
|-------|-----|----------|
| `ic_tab_vip_store` | ![vip](images/icons/ic_tab_vip_store.png) | Icon mục "Kho VIP" ở tab Ứng dụng (điểm vào) |
| `ic_action_back` | ![back](images/icons/ic_action_back.png) | Nút back trên action bar |
| `ic_action_quit` | ![quit](images/icons/ic_action_quit.png) | Nút phải action bar (onCreate **ghi đè** `ic_more_white` thành icon × này) |
| `ic_arrow_right` | ![arrow](images/icons/ic_arrow_right.png) | Mũi tên ở dòng "Ai có thể xem" (mở chọn quyền) |
| Icon VIP trong kho | (120 icon trong `assets/vipicon.dat` — xem §7) | `vipIconImageView` 40dp — `chat.ola.vn.j.a().a(ah.b())` (theo id từ cache) |

---

## 1. Bố cục (top → bottom)

### Khung màn (`vip_manager_layout.xml`)

`FrameLayout` nền trắng `#FFFFFF`, 4 lớp xếp chồng:

```
FrameLayout (nền #FFFFFF)
├─ [NỘI DUNG] ListView @id/listView
│     paddingTop 42dp (chừa action bar nổi) · layout_marginBottom 48dp (chừa thanh đáy)
│     style defaultStyle.list.noDivider (không divider, không scrollbar, cacheColorHint trong suốt)
│     ├─ headerView = vip_storage_header_layout   ← CHỈ add khi D()=true (kho của mình)
│     └─ N dòng = vip_info_item_layout            ← mỗi icon VIP trong kho (adapter ad)
├─ [THANH ĐÁY] LinearLayout  layout_gravity=bottom, cao 48dp
│     nền bg_white_with_top_border (trắng + viền trên 1px #1F000000), padding 8dp, gravity center_vertical
│     ├─ TextView "Thời hạn VIP"      caption 12sp
│     ├─ vipDurationTextView          title 20sp bold, width 0 weight 1, marginLeft 8dp   ← số ngày / hết hạn / vô hạn
│     └─ Button extendVipButton "Gia hạn VIP"   button.green, marginLeft 16dp            ← luôn mở BuyVipActivity.b
├─ [ACTION BAR] <include ola_top_action_bar_layout>   ← nổi đè trên cùng (xem §4 action bar)
└─ [OVERLAY LOADING] FrameLayout @id/wattingProgressBar
      nền #61000000 (translucent_black_38_percent), clickable, visibility=GONE mặc định
      └─ ProgressBar 48dp ở giữa        ← hiện khi đang tải (c(true)), timeout 60s
```

### Header (`vip_storage_header_layout.xml`) — **chỉ kho của mình**

`LinearLayout` vertical, nền **trắng mờ 80%** `#CCFFFFFF` (`translucent_white_80_percent`):

```
LinearLayout vertical (nền #CCFFFFFF)
├─ LinearLayout vertical
│   ├─ TextView "VIP icon đang dùng"   caption 12sp, padding L/T/R 16dp, B 0   (string_using_vip_icon)
│   └─ <include vip_info_item_layout>  marginTop 4dp    ← VIP ĐANG DÙNG (icon o + tên k + NGÀY l)
├─ LinearLayout @id/policyViewLayout  minHeight 48dp     ← QUYỀN XEM KHO (bấm → E())
│   ├─ LinearLayout padding 16dp
│   │   ├─ TextView "Ai có thể xem"   subhead 16sp, weight 1            (string_who_can_see)
│   │   ├─ policyTextView "Cộng đồng" caption 12sp, marginL/R 8dp       ← Cộng đồng/Bạn bè/Riêng tư
│   │   └─ ImageView ic_arrow_right
│   └─ divider 1px #1F000000, margin ngang 16dp
├─ TextView @id/buyVipTextView "Đăng ký VIP"   subhead 16sp, padding 16dp, minHeight 48dp   → BuyVipActivity.a
├─ divider 1px #1F000000, margin ngang 16dp
├─ TextView @id/extendVipTextView "Gia hạn VIP" subhead 16sp, padding 16dp, minHeight 48dp   → BuyVipActivity.b
└─ TextView @id/labelTextView    cao 36dp, nền #D5D5D5 (app_background_color), chữ TRẮNG subhead 16sp, gravity center
        XML mặc định text "Kho VIP"; sau khi tải B() ghi đè = "Số lượng VIP icon: N"   (string_vip_icon_quantity)
```

### 1 dòng kho VIP (`vip_info_item_layout.xml`)

Mỗi dòng cao **72dp**, nền trắng mờ 80% `#CCFFFFFF`, root `@id/vipIconViewLayout`:

```
LinearLayout vertical @id/vipIconViewLayout (cao 72dp, nền #CCFFFFFF; bg bị adapter ĐỔI theo trạng thái)
├─ LinearLayout padding 16dp, height 0 weight 1
│   ├─ ImageView @id/vipIconImageView  40×40dp, scaleType=centerCrop, focusable=false   ← ICON VIP (bitmap server)
│   └─ LinearLayout vertical (giữa, marginLeft 8dp)
│       ├─ TextView @id/vipNameTextView   subhead 16sp, maxLines 1, ellipsize end    ← TÊN VIP (ah.d())
│       └─ TextView @id/vipStateTextView  caption 12sp, marginTop 2dp, maxLines 1    ← TRẠNG THÁI (xem bảng dưới)
└─ View @id/listViewBottomDividerView  1px #1F000000, margin ngang 16dp
```

> `vipIconImageView` đặt `focusable=false` → **không nuốt sự kiện**, cả dòng nhận click qua `ListView.onItemClick`. Adapter `ad` **không** gán listener riêng cho icon (field `b` không bao giờ được set) → bấm icon trong dòng = bấm cả dòng.

### Các loại dòng & view type

| View type | Builder/Holder | Layout | Vai trò | Hiện khi |
|-----------|----------------|--------|---------|----------|
| **(duy nhất)** | adapter `ad` → holder nội `ad.a` | `vip_info_item_layout.xml` | 1 icon VIP trong kho | luôn (mỗi phần tử của `List<ah>` server trả về) |

> Adapter `ad` **không** override `getViewTypeCount()/getItemViewType()` → mặc định **1 view type**, list phẳng. `getCount()` = số phần tử `List<ah>`; `getItem(i)` = `list.get(i)`. **Header không thuộc adapter** — là `addHeaderView(...)` riêng (nên trong `onItemClick` phải lấy `getItem(i - 1)` để trừ header).

**Trạng thái + màu nền mỗi dòng** (adapter `ad.a(...)` getView; cờ `c` = có hiện trạng thái không, luôn `true` ở màn này vì `r.a(true)`; `h` = id VIP đang dùng):

| Điều kiện | `vipStateTextView` | Màu chữ trạng thái | Nền dòng `vipIconViewLayout` |
|-----------|--------------------|--------------------|------------------------------|
| icon **đang dùng** (`item.e()` == `h`) | "Đang dùng" (`string_using`) | `#8A000000` (`f.z`) | **#F1F8E9** sáng xanh nhạt (`f.I` = `colorOlaPrimaryLight`) |
| icon **đang khoá** (`item.f()`) | "Đang khóa" (`string_locked`) | **#FF4081** hồng (`f.L` = `colorOlaAccent`) | `#CCFFFFFF` (`f.d`) |
| còn lại | (ẩn — GONE) | — | `#CCFFFFFF` (`f.d`) |

> Dòng "đang dùng" được **tô nền xanh nhạt** để nổi bật; dòng "đang khoá" hiện chữ hồng. `listViewBottomDividerView` luôn hiển thị (adapter không ẩn).

## 2. Bảng style chi tiết từng phần

| Thành phần | id | Màu chữ / nền | Cỡ chữ | Kích thước / khoảng cách | Ghi chú (điều kiện) |
|------------|----|---------------|--------|--------------------------|---------------------|
| Nền màn | (FrameLayout) | nền `#FFFFFF` (`white`) | — | full | |
| ListView | `listView` | — | — | paddingTop 42dp, marginBottom 48dp | `list.noDivider`: không divider/scrollbar |
| Action bar | `olaTopActionBarViewLayout` | nền `#7CB342` (`colorOlaPrimary`) + bóng đáy ~6dp | — | cao 48dp, padding ngang 8dp, đáy 6dp | `bg_action_bar` (layer-list) — nổi đè list |
| ↳ Back | `olaActionBarBackViewLayout` | icon trắng | — | wrap, cao full | `ic_action_back` (+ badge `…BackNotificationTextView` ẩn) |
| ↳ Tiêu đề | `olaActionBarTitleTextView` | chữ `#FFFFFF` (đè) | **14sp bold** | weight 1, marginL 8dp | own→"Kho VIP của bạn"; người khác→tên người đó |
| ↳ Subtitle | `olaActionBarSubTitleTextView` | trắng 70% | 12sp | — | **GONE** (không dùng) |
| ↳ Nút phải (more) | `olaActionBarMoreButtonImageView` | icon trắng | — | 48dp, padding 8dp | XML `ic_more_white` + GONE; onCreate **set VISIBLE + `ic_action_quit`** → bấm `finish()` |
| **Header — nhãn dùng** | — | chữ `#8A000000` | 12sp | padding L/T/R 16dp | "VIP icon đang dùng" |
| **Header — VIP đang dùng icon** | `vipIconImageView` (`o`) | — | — | 40×40dp centerCrop | bitmap VIP hiện hành (`j.a().a(e.b())`; không có cache → fallback `smiles_online`); **bấm = no-op** (`c(ah)` rỗng) |
| **Header — VIP đang dùng tên** | `vipNameTextView` (`k`) | chữ `#DE000000` | 16sp | maxLines 1 | = `e.d()` tên VIP hiện hành |
| **Header — VIP đang dùng ngày** | `vipStateTextView` (`l`) | chữ `#8A000000` | 12sp | marginTop 2dp | = ngày `dd-MM-yyyy` (`q.format(new Date(h))`) — mốc thời gian VIP hiện hành |
| **Header — Ai có thể xem** | (trong `policyViewLayout`) | chữ `#DE000000` | 16sp | weight 1 | nhãn "Ai có thể xem" |
| **Header — giá trị quyền** | `policyTextView` (`m`) | chữ `#8A000000` | 12sp | marginL/R 8dp | Cộng đồng/Bạn bè/Riêng tư theo `g` |
| ↳ mũi tên quyền | — | — | — | wrap | `ic_arrow_right` |
| **Header — Đăng ký VIP** | `buyVipTextView` | chữ `#DE000000` | 16sp | padding 16dp, minHeight 48dp | → `BuyVipActivity.a(this)` |
| **Header — Gia hạn VIP** | `extendVipTextView` | chữ `#DE000000` | 16sp | padding 16dp, minHeight 48dp | → `BuyVipActivity.b(this)` |
| **Header — nhãn số lượng** | `labelTextView` (`u`) | chữ `#FFFFFF`, nền `#D5D5D5` | 16sp | cao 36dp, gravity center, maxLines 1 | XML "Kho VIP"; B() ghi đè "Số lượng VIP icon: N" |
| Dòng kho (root) | `vipIconViewLayout` | nền `#CCFFFFFF` (đổi theo trạng thái → §1) | — | cao 72dp | nền sáng `#F1F8E9` nếu đang dùng |
| ↳ icon | `vipIconImageView` | — | — | 40×40dp centerCrop | bitmap VIP |
| ↳ tên | `vipNameTextView` | chữ `#DE000000` | 16sp | maxLines 1 | `ah.d()` |
| ↳ trạng thái | `vipStateTextView` | "Đang dùng" `#8A000000` / "Đang khóa" `#FF4081` | 12sp | marginTop 2dp | ẩn nếu không thuộc 2 trạng thái |
| ↳ divider | `listViewBottomDividerView` | `#1F000000` | — | 1px, margin ngang 16dp | luôn hiện |
| **Thanh đáy** | (LinearLayout) | nền `#FFFFFF` + viền trên 1px `#1F000000` | — | cao 48dp, padding 8dp | `bg_white_with_top_border` |
| ↳ nhãn | — | chữ `#8A000000` | 12sp | wrap | "Thời hạn VIP" |
| ↳ số ngày | `vipDurationTextView` (`v`) | chữ `#DE000000` | **20sp bold** | weight 1, marginL 8dp | "N Ngày" (số **> 9 → "9+"**, `m.a` cap=9) / "VIP đã hết hạn" / "VIP không thời hạn"; **trống nếu chưa có VIP** (`e==null`) |
| ↳ nút Gia hạn | `extendVipButton` | chữ `#FFFFFF`, nền xanh | 14sp | marginL 16dp, cao full | `button.green` (`btn_green_button_selector`) → `BuyVipActivity.b` |
| Overlay loading | `wattingProgressBar` | nền `#61000000` | — | full, clickable | spinner 48dp; ẩn mặc định |

## 3. CSS tương đương (dựng lại trên web)

```css
.vip-store { position: relative; min-height: 100vh; background: #fff;
  font-family: Roboto, "Helvetica Neue", Arial, sans-serif; }

/* ===== Action bar nổi ===== */
.vip-store__bar {
  position: fixed; top: 0; left: 0; right: 0; height: 48px;
  display: flex; align-items: center; gap: 8px; padding: 0 8px;
  background: #7CB342;                                  /* colorOlaPrimary */
  box-shadow: 0 1px 0 rgba(0,0,0,.08);                  /* mô phỏng bóng đáy bg_action_bar */
}
.vip-store__bar-title { flex: 1; color: #fff; font-size: 14px; font-weight: bold; }
.vip-store__bar-icon { width: 48px; height: 48px; padding: 8px; box-sizing: border-box; }

/* ===== List ===== */
.vip-store__list { padding-top: 42px; padding-bottom: 48px; }       /* chừa bar + thanh đáy */

/* Header (chỉ kho của mình) */
.vip-store__card { background: rgba(255,255,255,.8); }              /* translucent_white_80_percent */
.vip-store__caption { padding: 16px 16px 0; font-size: 12px; color: rgba(0,0,0,.54); }
.vip-store__row {                                                   /* Ai có thể xem / Đăng ký / Gia hạn */
  display: flex; align-items: center; min-height: 48px; padding: 16px;
  font-size: 16px; color: rgba(0,0,0,.87);
}
.vip-store__row .grow { flex: 1; }
.vip-store__row .value { margin: 0 8px; font-size: 12px; color: rgba(0,0,0,.54); }
.vip-store__divider { height: 1px; margin: 0 16px; background: rgba(0,0,0,.12); }  /* colorTextBlackDivider */
.vip-store__label {                                                 /* labelTextView */
  height: 36px; display: flex; align-items: center; justify-content: center;
  background: #D5D5D5; color: #fff; font-size: 16px;
}

/* 1 dòng icon VIP */
.vip-store__item { height: 72px; display: flex; flex-direction: column; background: rgba(255,255,255,.8); }
.vip-store__item.is-using { background: #F1F8E9; }                  /* colorOlaPrimaryLight */
.vip-store__item-main { flex: 1; display: flex; align-items: center; padding: 16px; }
.vip-store__item-icon { width: 40px; height: 40px; object-fit: cover; }
.vip-store__item-text { margin-left: 8px; display: flex; flex-direction: column; justify-content: center; }
.vip-store__item-name { font-size: 16px; color: rgba(0,0,0,.87); }
.vip-store__item-state { margin-top: 2px; font-size: 12px; }
.vip-store__item-state.using  { color: rgba(0,0,0,.54); }          /* "Đang dùng" */
.vip-store__item-state.locked { color: #FF4081; }                  /* "Đang khóa" */
.vip-store__item-divider { height: 1px; margin: 0 16px; background: rgba(0,0,0,.12); }

/* ===== Thanh đáy "Thời hạn VIP" ===== */
.vip-store__bottom {
  position: fixed; left: 0; right: 0; bottom: 0; height: 48px;
  display: flex; align-items: center; gap: 8px; padding: 8px;
  background: #fff; box-shadow: 0 -1px 0 rgba(0,0,0,.12);           /* viền trên */
}
.vip-store__bottom .caption { font-size: 12px; color: rgba(0,0,0,.54); }
.vip-store__duration { flex: 1; margin-left: 8px; font-size: 20px; font-weight: bold; color: rgba(0,0,0,.87); }
.vip-store__extend {                                                /* button.green */
  margin-left: 16px; height: 100%; padding: 0 16px; min-width: 64px;
  background: #9CCC65; color: #fff; border: 1px solid #558B2F; border-radius: 2px; font-size: 14px;
}

/* ===== Overlay loading ===== */
.vip-store__overlay { position: fixed; inset: 0; background: rgba(0,0,0,.38);
  display: none; align-items: center; justify-content: center; }
```

```html
<div class="vip-store">
  <div class="vip-store__bar">
    <img class="vip-store__bar-icon" src="images/icons/ic_action_back.png">
    <div class="vip-store__bar-title">Kho VIP của bạn</div>
    <img class="vip-store__bar-icon" src="images/icons/ic_action_quit.png">
  </div>

  <div class="vip-store__list">
    <!-- HEADER (chỉ kho của mình) -->
    <div class="vip-store__card">
      <div class="vip-store__caption">VIP icon đang dùng</div>
      <div class="vip-store__item">
        <div class="vip-store__item-main">
          <img class="vip-store__item-icon">
          <div class="vip-store__item-text">
            <div class="vip-store__item-name">Tên VIP hiện hành</div>
            <div class="vip-store__item-state using">19-06-2026</div>
          </div>
        </div>
        <div class="vip-store__item-divider"></div>
      </div>
      <div class="vip-store__row"><span class="grow">Ai có thể xem</span>
        <span class="value">Cộng đồng</span>
        <img src="images/icons/ic_arrow_right.png"></div>
      <div class="vip-store__divider"></div>
      <div class="vip-store__row">Đăng ký VIP</div>
      <div class="vip-store__divider"></div>
      <div class="vip-store__row">Gia hạn VIP</div>
      <div class="vip-store__label">Số lượng VIP icon: 5</div>
    </div>

    <!-- DÒNG KHO -->
    <div class="vip-store__item is-using">
      <div class="vip-store__item-main">
        <img class="vip-store__item-icon">
        <div class="vip-store__item-text">
          <div class="vip-store__item-name">VIP Hoa hồng</div>
          <div class="vip-store__item-state using">Đang dùng</div>
        </div>
      </div>
      <div class="vip-store__item-divider"></div>
    </div>
  </div>

  <div class="vip-store__bottom">
    <span class="caption">Thời hạn VIP</span>
    <span class="vip-store__duration">30 Ngày</span>
    <button class="vip-store__extend">Gia hạn VIP</button>
  </div>
</div>
```

## 4. Hành vi & luồng

### 4.1. Khởi tạo (`onCreate`)

1. `setContentView(vip_manager_layout)`; ánh xạ tiêu đề `s`, nút back (click→`finish`), nút more `t` → **set VISIBLE + `ic_action_quit`**, overlay `w`, ListView `n`, số ngày `v`, nút `extendVipButton` (click).
2. **Nếu `D()`** (kho của mình): inflate `vip_storage_header_layout`, gán `o`(icon đang dùng, click), `buyVipTextView`(click), `extendVipTextView`(click), `k`(tên), `l`(ngày), `policyViewLayout`(click), `m`(quyền), `u`(nhãn = "Kho VIP" tạm); `n.addHeaderView(header)`. **Nếu không** → bỏ qua, không có header.
3. `n.setOnItemClickListener(this)`; nạp mảng quyền `p = R.array.privacy_lable` (Cộng đồng/Bạn bè/Riêng tư); `q` = `SimpleDateFormat("dd-MM-yyyy")`; tạo adapter `r = new ad(this)`, `r.a(true)` (bật cột trạng thái), `n.setAdapter(r)`.
4. **Tải dữ liệu:** `f(j không rỗng ? j : h.a())` → `OlaApplication.b.j(str, callback#22)`; đồng thời `c(true)` bật overlay loading (timeout **60s** → dialog `message_fail_load_vipstore`). `B()` chạy lần đầu (chưa có data nên hầu như no-op).

### 4.2. Nạp & dựng dữ liệu (`f` → callback → `a(...)` → `B()`)

- **Callback opcode 22** (`f(str)`): thành công → `a(nick, days, privacy, currentVipId, time, List<ah>)`. Lỗi: mã `38` → `message_fail_permission_access_format` (không có quyền xem kho người %1$s); mã khác → `message_fail_load_vipstore`. Luôn `c(false)` tắt loading.
- **`a(...)`**: lưu `f`=số ngày (`days==0 → null`), `g`=quyền (short), `h`=mốc thời gian (Long), `i`=`List<ah>`; tìm `e` = icon có `e()` == currentVipId (**icon đang dùng**); với mỗi icon, lấy tên hiển thị từ cache `chat.ola.vn.j.a().b(...)`. Gọi `B()`.
- **⚠️ `B()` THOÁT SỚM nếu `this.e == null`:** dòng đầu `if (this.e == null) return;`. `e` chỉ ≠ null khi server báo **đang dùng 1 icon** (currentVipId khớp 1 phần tử list). Vì thế:
  - **Đã/đang dùng VIP** (`e ≠ null`) → `B()` dựng đầy đủ: list + header + số ngày + tiêu đề.
  - **Chưa dùng VIP nào** (`e == null`) → `B()` trả về ngay: `r.a(i)` không được gọi → **list RỖNG** (`getCount()=0`), header để trống, `vipDurationTextView` trống, tiêu đề chưa set. (Toàn bộ phần dưới đây chỉ áp dụng cho trạng thái "đã có VIP".)
- **`B()` cập nhật UI (khi `e ≠ null`):**
  - `r.a(i)` + `notifyDataSetChanged`; `r.a(e.b())`/`r.a(e.e())` (báo id icon đang dùng để adapter tô nền `#F1F8E9` & gán "Đang dùng").
  - **Nếu `D()`:** icon header `o` = `j.a().a(e.b())` (bitmap VIP đang dùng; không có trong cache → fallback `smiles_online`); `k` = tên `e.d()`; `l` = ngày `dd-MM-yyyy`; `u` (nhãn) = **"Số lượng VIP icon: " + size**; `m` (quyền) = `p[g]` (theo `g` 0/1/2); tiêu đề `s` = "Kho VIP của bạn".
  - **Nếu không (người khác):** tiêu đề `s` = tên người (`h.t.d(j).L()`), không động tới header.
  - **Thanh đáy `v`:** `f==null` → "VIP đã hết hạn"; `f>0` → **"`m.a(f)` Ngày"** (`string_days`/`string_day`); `f<=0` (âm) → "VIP không thời hạn". **`m.a(f)` chặn ở "9+"** (`m.a(int)` = `a(9, f)`: `f ≤ 9` → số thật; `f > 9` → "9+"). Vd 30 ngày → hiển thị **"9+ Ngày"**.

### 4.2b. Trạng thái hiển thị khi ĐÃ có VIP đang dùng (mockup)

Kho của mình, `e ≠ null`, ví dụ: đang dùng "Hoa Hồng" (còn 30 ngày), quyền Cộng đồng, có 3 icon (1 đang dùng, 1 khoá, 1 thường):

```
┌───────────────────────────────────────────────┐ ← action bar #7CB342
│ ←   Kho VIP của bạn                          ✕ │   title 14sp bold trắng (✕ = ic_action_quit)
├───────────────────────────────────────────────┤
│▒ HEADER — nền trắng mờ 80% #CCFFFFFF ▒▒▒▒▒▒▒▒▒▒│ (chỉ khi D()=kho của mình)
│  VIP icon đang dùng                  caption 12sp│  ← string_using_vip_icon
│  ┌────┐                                          │
│  │ 🌹 │  Hoa Hồng              subhead 16sp #DE…│  ← k = e.d()
│  └40dp┘  19-06-2026            caption 12sp #8A…│  ← l = q.format(new Date(h)) dd-MM-yyyy
│  ─────────────────────────────────── divider    │
│  Ai có thể xem           Cộng đồng           ›  │  ← m = p[g] + ic_arrow_right
│  ───────────────────────────────────            │
│  Đăng ký VIP                                     │  → BuyVipActivity.a
│  ───────────────────────────────────            │
│  Gia hạn VIP                                     │  → BuyVipActivity.b
│ ▓▓ Số lượng VIP icon: 3 ▓▓ nền #D5D5D5, chữ trắng│  ← u (B() ghi đè)
├───────────────────────────────────────────────┤
│  ┌────┐                       nền #F1F8E9 (xanh)│ ← DÒNG ĐANG DÙNG (tô sáng)
│  │ 🌹 │  Hoa Hồng                                │
│  └────┘  Đang dùng                  #8A000000   │  ← string_using
│  ───────────────────────────────────            │
│  ┌────┐                       nền #CCFFFFFF      │ ← DÒNG KHOÁ
│  │ 👑 │  Vương Miện                              │
│  └────┘  Đang khóa                  #FF4081 hồng│  ← string_locked
│  ───────────────────────────────────            │
│  ┌────┐                       nền #CCFFFFFF      │ ← DÒNG THƯỜNG (vipStateTextView GONE)
│  │ ❤️ │  Trái Tim                                │
│  └────┘                                          │
│  ───────────────────────────────────            │
├───────────────────────────────────────────────┤
│ Thời hạn VIP   9+ Ngày            [ Gia hạn VIP ]│ ← thanh đáy; 30 ngày → "9+" (m.a cap=9)
└───────────────────────────────────────────────┘   nút xanh button.green #9CCC65
```

> **Khi `e == null` (chưa dùng VIP nào):** header vẫn được add (nếu là kho của mình) nhưng các ô `k/l/m/u` để **trống** (B() chưa chạy), **không có dòng icon nào** (list rỗng), `vipDurationTextView` trống. Người dùng vẫn bấm được "Đăng ký VIP"/"Gia hạn VIP".

### 4.3. Bảng tương tác (mọi cử chỉ)

| Thành phần | Cử chỉ | Hành vi | Loại |
|------------|--------|---------|------|
| Back `olaActionBarBackViewLayout` / Nút × `olaActionBarMoreButtonImageView` | click | `finish()` (animation push_right) | nội bộ |
| Icon VIP đang dùng (header) `vipIconImageView` (`o`) | click | `c(ah)` — **rỗng, không làm gì** | nội bộ (no-op) |
| "Ai có thể xem" `policyViewLayout` | click | `E()` → mở **menu chọn quyền** (xem 4.4 #1) | modal trong màn |
| "Đăng ký VIP" `buyVipTextView` | click | `BuyVipActivity.a(this)` → màn mua VIP | sang màn khác |
| "Gia hạn VIP" `extendVipTextView` **và** nút đáy `extendVipButton` | click | `BuyVipActivity.b(this)` → màn gia hạn VIP | sang màn khác |
| 1 dòng kho (ListView item) | **click (onItemClick)** | **chỉ khi `D()`**: lấy `getItem(i-1)` → `a(item, view)` mở **menu thao tác icon** (4.4 #2). Kho người khác: không làm gì | modal trong màn |
| 1 dòng kho | **long-press** | **không xử lý** (không đăng ký `OnItemLongClickListener`) | — |
| Overlay loading `wattingProgressBar` | chạm | `clickable=true` nuốt chạm (chặn thao tác khi đang tải) | nội bộ |
| Phím Back | hệ thống | `finish()` | nội bộ |

> **Không có long-press / swipe** ở màn này; toàn bộ thao tác icon đi qua **click dòng** (chỉ kho của mình).

### 4.4. Modal / Menu mở trong màn (chi tiết)

Cả 2 menu dùng chung dialog `chat.ola.vn.i.m` — layout `list_option_dialog_layout`: tiêu đề (ẩn nếu trống) + ListView (item `iconable_text_list_item` = icon trái + chữ), divider 1px `#DEDCDC` (`f.w`), bo `setCanceledOnTouchOutside(true)`, làm mờ nền 0.7. Vì không gọi `m.a(int)` nên **không hiện icon ngôi sao** — chỉ là danh sách chữ. Chạm 1 mục → dialog **đóng** rồi gọi listener.

1. **Menu "Ai có thể xem" (`E()`)** — mở từ `policyViewLayout`.
   - **Không tiêu đề.** 3 mục từ `privacy_lable`: **Cộng đồng / Bạn bè / Riêng tư** (index 0/1/2).
   - Chạm mục `i2` → gửi `OlaApplication.b.a((short) i2, callback#27)` đổi quyền + gọi `C()` (tải lại). Callback thành công → toast `message_change_vip_store_privacy` ("Đã thay đổi quyền truy cập kho VIP") + `B()`.

2. **Menu thao tác 1 icon (`a(ahVar, view)`)** — mở khi **bấm 1 dòng kho** (kho của mình).
   - **Tiêu đề menu = tên VIP** (`ahVar.d()`). Các mục dựng **động**:

   | Mục | String (EN / VI) | Điều kiện hiện | Hành động khi chạm |
   |-----|------------------|----------------|--------------------|
   | **Dùng VIP** | Use VIP / **Dùng VIP** | chỉ khi icon **chưa dùng** (`!ahVar.g()`) | `a(ahVar)` → dialog xác nhận "Dùng VIP" (#3) |
   | **Mở khoá** *hoặc* **Khoá** | Unlock/Lock / **Mở khoá**/**Khoá** | luôn có — **1 mục toggle** theo `ahVar.f()` (đang khoá → "Mở khoá", ngược lại → "Khoá") | "Mở khoá" → `OlaApplication.b.b([id])`; "Khoá" → `OlaApplication.b.a([id])`; rồi `F()` tải lại |
   | **Giao dịch VIP** | VIP transaction / **Giao dịch VIP** | luôn có | nếu **chưa khoá** → `OlaTraddingVipActivity.a(this, null, ahVar)` (chuyển/tặng VIP); nếu **đang khoá** → dialog `message_vip_is_locked` ("VIP đang bị khoá") |
   | **Xoá VIP** | Delete VIP / **Xoá VIP** | luôn có | nếu **chưa khoá** → `b(ahVar)` dialog xác nhận xoá (#4); nếu **đang khoá** → dialog `message_vip_is_locked` |

   > ⚠️ Icon **đang khoá** **không** Giao dịch / Xoá được — chỉ báo "VIP đang bị khoá". Phải **Mở khoá** trước.

3. **Dialog "Dùng VIP" (`a(ahVar)`, lớp `i.e`)** — xác nhận kích hoạt icon.
   - Tiêu đề "Dùng VIP", có **ảnh icon** (`j.a().a(ah.b())`), nội dung `message_active_vipicon_confirm` = *"Bạn sẽ mất một ngày VIP khi kích hoạt VIP %1$s. Bạn có muốn tiếp tục"*.
   - Nút **"Dùng VIP"** (index 0) → `OlaApplication.b.p(ahVar.e())` (kích hoạt) + `C()` tải lại; nút **"Huỷ"** (`string_cancel`) → đóng.

4. **Dialog "Xoá VIP" (`b(ahVar)`, lớp `i.f`)** — xác nhận xoá icon.
   - Tiêu đề "Xoá VIP", có ảnh icon, nội dung `message_delete_vipicon_confirm` = *"Bạn có chắc muốn xoá VIP %1$s không ?"*.
   - Nút **"Xoá VIP"** (index 0) → `OlaApplication.b.c([id])` + `C()` tải lại; nút **"Huỷ"** → đóng.

5. **Dialog báo lỗi tải kho (`i.b(...)`)** — khi callback#22 lỗi hoặc timeout 60s: tiêu đề "Thông báo" (`dialog_title_inform`), nội dung `message_fail_load_vipstore` (hoặc `message_fail_permission_access_format` nếu mã 38).

### 4.5. Luồng mạng (socket)

Toàn bộ qua `OlaApplication.b` (`OlaNetworkService`, socket — xem [../../api/socket-protocol.md](../../api/socket-protocol.md)), **không phải REST**:

| Thao tác | Lời gọi | Callback opcode |
|----------|---------|-----------------|
| Tải kho VIP | `b.j(nick, cb)` | 22 |
| Đổi quyền xem | `b.a((short) quyền, cb)` | 27 |
| Khoá icon | `b.a(String[]{id})` | — (rồi `F()` tải lại) |
| Mở khoá icon | `b.b(String[]{id})` | — |
| Kích hoạt (Dùng) | `b.p(id)` | — |
| Xoá icon | `b.c(String[]{id})` | — |

### 4.6. Đối chiếu web (`web/src/pages/`)

> **Chưa có** trang Kho VIP tương ứng bên `web/src/pages/` (web hiện chưa dựng luồng VIP icon). Khi dựng lại, bám bố cục §1 + style §2 và CSS §3. Lưu ý: web nên dùng **REST** thay socket; phần mua/gia hạn (`BuyVipActivity`) và giao dịch (`OlaTraddingVipActivity`) là **màn riêng**.

## 5. Strings (đa ngôn ngữ)

| Resource | EN (`values/strings.xml`) | VI (`values-vi/strings.xml`) |
|----------|---------------------------|------------------------------|
| `general_tab_vipstore` | VIP icon collection | Kho VIP |
| `string_vip_store` | VIP icon collection | Kho VIP |
| `message_your_vip_store` | Your VIP icon collection | Kho VIP của bạn |
| `string_using_vip_icon` | Using VIP icon | VIP icon đang dùng |
| `string_who_can_see` | Who can see | Ai có thể xem |
| `R.array.privacy_lable` | Public / Friends / Private | Cộng đồng / Bạn bè / Riêng tư |
| `string_public` / `string_friend` | Public / Friends | Cộng đồng / Bạn Bè |
| `string_buy_vip` | Buy VIP | Đăng ký VIP |
| `string_extend_vip` | Extend VIP | Gia hạn VIP |
| `string_vip_icon_quantity` | VIP icon quantity | Số lượng VIP icon |
| `string_vip_duration` | VIP duration | Thời hạn VIP |
| `string_day` / `string_days` | Day / Days | Ngày / Ngày |
| `string_vip_expired` | VIP expired | VIP đã hết hạn |
| `string_vip_duration_unlimited` | VIP duration unlimited | VIP không thời hạn |
| `string_use_vip` | Use VIP | Dùng VIP |
| `string_lock` / `string_unlock` | Lock / Unlock | Khoá / Mở khoá |
| `string_using` / `string_locked` | Using / Locked | Đang dùng / Đang khóa |
| `string_transfer_vip` | VIP transaction | Giao dịch VIP |
| `string_delete_vip` | Delete VIP | Xoá VIP |
| `string_cancel` | Cancel | Huỷ |
| `dialog_title_inform` | Inform | Thông báo |
| `message_active_vipicon_confirm` | Cost 1 VIP day to activate VIP %1$s. Do you want to continue | Bạn sẽ mất một ngày VIP khi kích hoạt VIP %1$s. Bạn có muốn tiếp tục |
| `message_delete_vipicon_confirm` | Do you want to delete VIP %1$s? | Bạn có chắc muốn xoá VIP %1$s không ? |
| `message_vip_is_locked` | VIP is locked | VIP đang bị khoá |
| `message_change_vip_store_privacy` | VIP icon collection privacy changed | Đã thay đỗi quyền truy cập kho VIP |
| `message_fail_load_vipstore` | Cannot load VIP store | Không thể tải thông tin kho VIP |
| `message_fail_permission_access_format` | You do not have permission to view VIP store of %1$s | Bạn không có quyên xem Thông tin kho vip của %1$s |

## 6. Màn mở ra từ đây (điều hướng)

| Từ (nút/cử chỉ) | Màn đích (class) | Doc |
|-----------------|------------------|-----|
| "Đăng ký VIP" `buyVipTextView` | `chat.ola.vn.activity.BuyVipActivity` (`BuyVipActivity.a`) — mua VIP | (chưa có doc — cần làm) |
| "Gia hạn VIP" `extendVipTextView` / nút đáy `extendVipButton` | `chat.ola.vn.activity.BuyVipActivity` (`BuyVipActivity.b`) — gia hạn VIP | (chưa có doc — cần làm) |
| Menu icon → "Giao dịch VIP" (khi chưa khoá) | `chat.ola.vn.tradingvip.OlaTraddingVipActivity` — chuyển/tặng VIP (3 bước `ola_tradding_vip_step1..3`) | (chưa có doc — cần làm) |
| Back / Nút × | (đóng — về màn gọi: tab Ứng dụng / Trang cá nhân…) | — |

## 7. Danh mục TOÀN BỘ VIP (bóc từ `assets/vipicon.dat`)

> **Lấy được hết** — danh mục VIP **đóng gói sẵn trong APK** tại `apktool_out/assets/vipicon.dat` (~1.02 MB), KHÔNG phải tải runtime. Cache `chat.ola.vn.j` (`j.a[255]`) được seed **một lần** từ file này (`j()→b()→a(h.b.d())`); màn Kho VIP render mỗi dòng theo **id → cache** (`j.a().a(ah.b())`), id không có trong cache → fallback `smiles_online`.

- **Số lượng:** **120 loại VIP** (id 1–120), mỗi icon **85×85 PNG**.
- **Định dạng file** (`chat.ola.vn.entity.ah.b(byte[])`, số **big-endian**): `count(2B)` rồi lặp `id(2B) · nameLen(4B) · name(UTF-8) · imgLen(4B) · imgBody`. `imgBody` là PNG **đã cắt 8 byte chữ ký** — parser dựng lại bằng cách chèn `89 50 4E 47 0D 0A 1A 0A` vào đầu. Parse đúng khít **1.024.686/1.024.686 byte**.
- **Đã trích sẵn:** [images/vip-icons/](images/vip-icons/) → `vip_<id>.png` (vd `vip_004.png`) + bảng kê [images/vip-icons/_manifest.tsv](images/vip-icons/_manifest.tsv).
- **Bóc lại** (nếu cần): chạy script Python đọc `assets/vipicon.dat` theo định dạng trên (đã lưu cách dựng PNG ở trên).

### Cơ chế render (render theo id nào, lấy từ đâu — KHÔNG có DB)

`ah` mang **2 id**: `ah.b()` = **int type-id** (1–120, id loại VIP) — dùng RENDER; `ah.e()` = **String instance-id** (bản VIP cụ thể bạn sở hữu) — dùng thao tác server + so `currentVipId`. Tên = `ah.d()`, ảnh = `ah.c()` (chỉ dùng lúc seed cache).

VIP icon **không lưu DB/SQLite**. Luồng: asset → cache RAM → render theo type-id:

```
[1] j.a() lần đầu → new j() → b() → a( h.b.d() )      // h.b.d() đọc assets/vipicon.dat (h/b.java:1502)
[2] j.a(List<ah>)  (j.java:44):  for each ah:
        bitmap = decodeByteArray(ah.c());  this.a[ ah.b() ] = {type-id, name, bitmap}   // INDEX = type-id
        this.a[0] = "Online"/smiles_online                                              // slot mặc định
        → 120 icon nằm sẵn trong RAM a[1..120], id = chỉ số mảng
[3] Mở kho: socket opcode 22 (b.j(nick,cb)) trả DANH SÁCH VIP BẠN SỞ HỮU
        mỗi item = ah{ b()=type-id, e()=instance-id, d()=tên, f()=khoá }  (server KHÔNG cần gửi ảnh)
[4] Activity.a(...): j.b(item.b()) → COPY tên cache vào item; item.e()==currentVipId → đánh dấu "đang dùng"
[5] ad.getView: imageView.setImageBitmap( j.a().a( item.b() ) )   // tra a[type-id]; thiếu → smiles_online
```

Tức **server chỉ báo "sở hữu type-id nào"; ảnh + tên app tra từ cache RAM (seed từ `vipicon.dat`) bằng chính type-id làm chỉ số `a[id]`** (`j.java:33`). `j.b(id)` trả entry theo id, miss → `a[0]`; `j.a(id)` trả bitmap theo id, miss → `smiles_online`.

**"Đang dùng VIP nào" — 2 key, đều do SERVER cấp, KHÔNG lưu local (không DB/prefs):**
- **Badge VIP toàn app** (cạnh avatar/nick chat, profile): theo **type-id** = global `chat.ola.vn.h.H` (`short`, `0` = không đeo). Render `j.a().a(h.H)` (vd `g/m.java:209`). Gán từ server lúc login/online (`h.H = entity.m()` — `network/e.java:708`, `OlaNetworkService.java:2132`); logout reset `H=0` (`h.java:188`); tắt app là mất, phiên sau server gửi lại.
- **Dòng "Đang dùng" trong màn kho**: theo **instance-id** (`String`) = `currentVipId` (param `str2` của response opcode 22); khớp `ah.e() == str2` (`m.a()` = equals null-safe). Cần instance-id vì 1 người có thể sở hữu nhiều bản cùng 1 loại VIP.
- `vipicon.dat` chỉ chứa **catalog type-id 1–120**; không chứa thông tin "ai đang đeo gì".

> Một số nhóm dễ nhận: **Nhân Viên Ola** (1–3), **Zakumi** (nhiều), **Doraemon** (Đô-rê-mon/Nô-bi-ta/Xê-ko/Xu-ka/Chai-en…), **Thần Hy Lạp** (Zeus/Hermes/Hades/Athena/Aphrodite/Apollo/Ares/Hera/Artemis/Poseidon), **Conan/InuYasha** (86–90), **12 Cung Hoàng Đạo** (101–112), **Long/Điêu/Phượng Hoàng** (113–120).

|  |  |  |  |  |  |
|---|---|---|---|---|---|
| <img src="images/vip-icons/vip_001.png" width="48" height="48"><br>**1.** Nhan Vien Ola Cap 1 | <img src="images/vip-icons/vip_002.png" width="48" height="48"><br>**2.** Nhan Vien Ola Cap 2 | <img src="images/vip-icons/vip_003.png" width="48" height="48"><br>**3.** Nhan Vien Ola Cap 3 | <img src="images/vip-icons/vip_004.png" width="48" height="48"><br>**4.** Zakumi Đại Đế | <img src="images/vip-icons/vip_005.png" width="48" height="48"><br>**5.** VIP Iphone 5s | <img src="images/vip-icons/vip_006.png" width="48" height="48"><br>**6.** Tử Thần |
| <img src="images/vip-icons/vip_007.png" width="48" height="48"><br>**7.** Emperor Fuleco | <img src="images/vip-icons/vip_008.png" width="48" height="48"><br>**8.** Empress Fuleco | <img src="images/vip-icons/vip_009.png" width="48" height="48"><br>**9.** Khỉ Đột | <img src="images/vip-icons/vip_010.png" width="48" height="48"><br>**10.** Zakumi Gao Cam | <img src="images/vip-icons/vip_011.png" width="48" height="48"><br>**11.** Cool Boy | <img src="images/vip-icons/vip_012.png" width="48" height="48"><br>**12.** Tí Papa |
| <img src="images/vip-icons/vip_013.png" width="48" height="48"><br>**13.** Zakumi Gao Đen | <img src="images/vip-icons/vip_014.png" width="48" height="48"><br>**14.** Dũng Sĩ Huyền Thoại Hercules (Hec-Quyn) | <img src="images/vip-icons/vip_015.png" width="48" height="48"><br>**15.** Vương Hậu | <img src="images/vip-icons/vip_016.png" width="48" height="48"><br>**16.** Nguyên Soái | <img src="images/vip-icons/vip_017.png" width="48" height="48"><br>**17.** Đô-rê-mi | <img src="images/vip-icons/vip_018.png" width="48" height="48"><br>**18.** Cục... Cưng |
| <img src="images/vip-icons/vip_019.png" width="48" height="48"><br>**19.** Thiết Phiến Công Chúa | <img src="images/vip-icons/vip_020.png" width="48" height="48"><br>**20.** Xê-ko | <img src="images/vip-icons/vip_021.png" width="48" height="48"><br>**21.** Xu-ka | <img src="images/vip-icons/vip_022.png" width="48" height="48"><br>**22.** Zakumi Đại Ca | <img src="images/vip-icons/vip_023.png" width="48" height="48"><br>**23.** Tiểu Thư | <img src="images/vip-icons/vip_024.png" width="48" height="48"><br>**24.** Trái Tim Ngục Tù |
| <img src="images/vip-icons/vip_025.png" width="48" height="48"><br>**25.** Zakumi Gao Đội  Trưởng | <img src="images/vip-icons/vip_026.png" width="48" height="48"><br>**26.** Trái Tim Tự Do | <img src="images/vip-icons/vip_027.png" width="48" height="48"><br>**27.** Tí Cận | <img src="images/vip-icons/vip_028.png" width="48" height="48"><br>**28.** Zakumi Gao Trắng | <img src="images/vip-icons/vip_029.png" width="48" height="48"><br>**29.** Garu | <img src="images/vip-icons/vip_030.png" width="48" height="48"><br>**30.** Yêu Nhền Nhện |
| <img src="images/vip-icons/vip_031.png" width="48" height="48"><br>**31.** Zakumi Thiên Thần | <img src="images/vip-icons/vip_032.png" width="48" height="48"><br>**32.** Zakumi Tam Ca | <img src="images/vip-icons/vip_033.png" width="48" height="48"><br>**33.** Yahoo | <img src="images/vip-icons/vip_034.png" width="48" height="48"><br>**34.** Offline | <img src="images/vip-icons/vip_035.png" width="48" height="48"><br>**35.** Chai-en | <img src="images/vip-icons/vip_036.png" width="48" height="48"><br>**36.** Rắn Vàng Quý Tỵ |
| <img src="images/vip-icons/vip_037.png" width="48" height="48"><br>**37.** Cánh Cụt Kute | <img src="images/vip-icons/vip_038.png" width="48" height="48"><br>**38.** Zakumi Út | <img src="images/vip-icons/vip_039.png" width="48" height="48"><br>**39.** Vô Ảnh Tử Thần | <img src="images/vip-icons/vip_040.png" width="48" height="48"><br>**40.** Trứng Apple(nở ra iPhone5s hoặc VIP Độc) | <img src="images/vip-icons/vip_041.png" width="48" height="48"><br>**41.** Lão Gà-mên | <img src="images/vip-icons/vip_042.png" width="48" height="48"><br>**42.** Cậu Bé Đại Dương |
| <img src="images/vip-icons/vip_043.png" width="48" height="48"><br>**43.** Tí Điệu | <img src="images/vip-icons/vip_044.png" width="48" height="48"><br>**44.** Đại Hiệp Phu Nhân | <img src="images/vip-icons/vip_045.png" width="48" height="48"><br>**45.** Zakumi Gao Vàng | <img src="images/vip-icons/vip_046.png" width="48" height="48"><br>**46.** Zakumi Gao Xanh | <img src="images/vip-icons/vip_047.png" width="48" height="48"><br>**47.** Đô-rê-mon | <img src="images/vip-icons/vip_048.png" width="48" height="48"><br>**48.** Zakumi Võ Sư |
| <img src="images/vip-icons/vip_049.png" width="48" height="48"><br>**49.** Pucca | <img src="images/vip-icons/vip_050.png" width="48" height="48"><br>**50.** Zakumi Ác Thần | <img src="images/vip-icons/vip_051.png" width="48" height="48"><br>**51.** Vua Của Các Vị Thần Zeus | <img src="images/vip-icons/vip_052.png" width="48" height="48"><br>**52.** Zakumi Omar | <img src="images/vip-icons/vip_053.png" width="48" height="48"><br>**53.** Tiên Đế | <img src="images/vip-icons/vip_054.png" width="48" height="48"><br>**54.** Thiếu Gia |
| <img src="images/vip-icons/vip_055.png" width="48" height="48"><br>**55.** Zakumi Idol (Đại Gia) | <img src="images/vip-icons/vip_056.png" width="48" height="48"><br>**56.** Ngựa Bay Tí Hon | <img src="images/vip-icons/vip_057.png" width="48" height="48"><br>**57.** Hoàng Hậu | <img src="images/vip-icons/vip_058.png" width="48" height="48"><br>**58.** Đại Hiệp | <img src="images/vip-icons/vip_059.png" width="48" height="48"><br>**59.** Hắc Miu | <img src="images/vip-icons/vip_060.png" width="48" height="48"><br>**60.** Zakumi Hoàng Tử Arap |
| <img src="images/vip-icons/vip_061.png" width="48" height="48"><br>**61.** Zakumi Thống Lĩnh | <img src="images/vip-icons/vip_062.png" width="48" height="48"><br>**62.** Đức Vua | <img src="images/vip-icons/vip_063.png" width="48" height="48"><br>**63.** Nô-bi-ta | <img src="images/vip-icons/vip_064.png" width="48" height="48"><br>**64.** Zakumi Nhị Ca | <img src="images/vip-icons/vip_065.png" width="48" height="48"><br>**65.** Tí Đô (Lực Sĩ) | <img src="images/vip-icons/vip_066.png" width="48" height="48"><br>**66.** Thần Khôn Ngoan Hermes |
| <img src="images/vip-icons/vip_067.png" width="48" height="48"><br>**67.** Hoàng Tử | <img src="images/vip-icons/vip_068.png" width="48" height="48"><br>**68.** Đắc Kỷ | <img src="images/vip-icons/vip_069.png" width="48" height="48"><br>**69.** Quận Chúa | <img src="images/vip-icons/vip_070.png" width="48" height="48"><br>**70.** Hồ Ly Tinh | <img src="images/vip-icons/vip_071.png" width="48" height="48"><br>**71.** Ghost Rider | <img src="images/vip-icons/vip_072.png" width="48" height="48"><br>**72.** Công Chúa |
| <img src="images/vip-icons/vip_073.png" width="48" height="48"><br>**73.** Chó Puppy | <img src="images/vip-icons/vip_074.png" width="48" height="48"><br>**74.** Phó Tướng Phu Nhân | <img src="images/vip-icons/vip_075.png" width="48" height="48"><br>**75.** Phó Tướng | <img src="images/vip-icons/vip_076.png" width="48" height="48"><br>**76.** Tí Lười | <img src="images/vip-icons/vip_077.png" width="48" height="48"><br>**77.** Tí Cô Nương | <img src="images/vip-icons/vip_078.png" width="48" height="48"><br>**78.** Heo Hồng Boorin |
| <img src="images/vip-icons/vip_079.png" width="48" height="48"><br>**79.** Chiến Binh Bất Tử Achilles | <img src="images/vip-icons/vip_080.png" width="48" height="48"><br>**80.** Quân Sư Phu Nhân | <img src="images/vip-icons/vip_081.png" width="48" height="48"><br>**81.** Nữ Thần Toàn Năng Athena | <img src="images/vip-icons/vip_082.png" width="48" height="48"><br>**82.** Quân Sư | <img src="images/vip-icons/vip_083.png" width="48" height="48"><br>**83.** Zakumi Tiên Tri | <img src="images/vip-icons/vip_084.png" width="48" height="48"><br>**84.** Zakumi Sắt |
| <img src="images/vip-icons/vip_085.png" width="48" height="48"><br>**85.** Vương Thần Địa Ngục Hades | <img src="images/vip-icons/vip_086.png" width="48" height="48"><br>**86.** Conan | <img src="images/vip-icons/vip_087.png" width="48" height="48"><br>**87.** InuYasha | <img src="images/vip-icons/vip_088.png" width="48" height="48"><br>**88.** Sesumarou | <img src="images/vip-icons/vip_089.png" width="48" height="48"><br>**89.** Kagome | <img src="images/vip-icons/vip_090.png" width="48" height="48"><br>**90.** Ran Mori |
| <img src="images/vip-icons/vip_091.png" width="48" height="48"><br>**91.** Zakumi Vương Tử | <img src="images/vip-icons/vip_092.png" width="48" height="48"><br>**92.** Diêm Đế | <img src="images/vip-icons/vip_093.png" width="48" height="48"><br>**93.** Diêm Thiếu Gia | <img src="images/vip-icons/vip_094.png" width="48" height="48"><br>**94.** Ma Kute | <img src="images/vip-icons/vip_095.png" width="48" height="48"><br>**95.** Nữ Thần Tình Yêu Aphrodite | <img src="images/vip-icons/vip_096.png" width="48" height="48"><br>**96.** Thần Mặt Trời Apollo |
| <img src="images/vip-icons/vip_097.png" width="48" height="48"><br>**97.** Thần Chiến Tranh Ares | <img src="images/vip-icons/vip_098.png" width="48" height="48"><br>**98.** Nữ Thần Hôn Nhân Hera | <img src="images/vip-icons/vip_099.png" width="48" height="48"><br>**99.** Nữ Thần Săn Bắn Artemis | <img src="images/vip-icons/vip_100.png" width="48" height="48"><br>**100.** Vương Thần Biển Cả Poseidon | <img src="images/vip-icons/vip_101.png" width="48" height="48"><br>**101.** Bạch Dương (21.3-19.4) | <img src="images/vip-icons/vip_102.png" width="48" height="48"><br>**102.** Kim Ngưu (20.4-20.5) |
| <img src="images/vip-icons/vip_103.png" width="48" height="48"><br>**103.** Song Tử (21.5-21.6) | <img src="images/vip-icons/vip_104.png" width="48" height="48"><br>**104.** Cự Giải (22.6-22.7) | <img src="images/vip-icons/vip_105.png" width="48" height="48"><br>**105.** Sư Tử (23.7-22.8) | <img src="images/vip-icons/vip_106.png" width="48" height="48"><br>**106.** Xử Nữ (23.8-22.9) | <img src="images/vip-icons/vip_107.png" width="48" height="48"><br>**107.** Thiên Bình (23.9-23.10) | <img src="images/vip-icons/vip_108.png" width="48" height="48"><br>**108.** Hổ Cáp (24.10-22.11) |
| <img src="images/vip-icons/vip_109.png" width="48" height="48"><br>**109.** Nhân Mã (23.11-21.12) | <img src="images/vip-icons/vip_110.png" width="48" height="48"><br>**110.** Ma Kết (22.12-19.1) | <img src="images/vip-icons/vip_111.png" width="48" height="48"><br>**111.** Bảo Bình (20.1-18.2) | <img src="images/vip-icons/vip_112.png" width="48" height="48"><br>**112.** Song Ngư (19.2-20.3) | <img src="images/vip-icons/vip_113.png" width="48" height="48"><br>**113.** Thủy Long | <img src="images/vip-icons/vip_114.png" width="48" height="48"><br>**114.** Địa Long |
| <img src="images/vip-icons/vip_115.png" width="48" height="48"><br>**115.** Hỏa Long | <img src="images/vip-icons/vip_116.png" width="48" height="48"><br>**116.** Linh Điêu | <img src="images/vip-icons/vip_117.png" width="48" height="48"><br>**117.** Thần Điêu | <img src="images/vip-icons/vip_118.png" width="48" height="48"><br>**118.** Phượng Hoàng Trí Tuệ | <img src="images/vip-icons/vip_119.png" width="48" height="48"><br>**119.** Phượng Hoàng Toàn Năng | <img src="images/vip-icons/vip_120.png" width="48" height="48"><br>**120.** Phượng Hoàng Sắc Đẹp |
