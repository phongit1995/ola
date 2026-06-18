# Màn hình Chat — khung 2 tab (TIN NHẮN + DANH BẠ)

- **Activity:** `chat.ola.vn.activity.OlaBottomTabActivity` — tab **Chat** (index 0)
- **Fragment container:** `chat.ola.vn.m.e` → layout `apktool_out/res/layout/contact_view_layout.xml` (action bar + `OlaViewPager` 2 trang)
- **Chức năng:** tab đầu tiên sau đăng nhập — 2 tab con trong 1 ViewPager.

## 📑 Tài liệu tách theo từng tab

| Tab | Fragment | Tài liệu |
|-----|----------|----------|
| 📨 **TIN NHẮN** (danh sách hội thoại) | `m.o` | **[tin-nhan.md](tin-nhan.md)** |
| 👥 **DANH BẠ** (danh bạ bạn bè + info cá nhân) | `m.n` | **[danh-ba.md](danh-ba.md)** |
| 💬 Khung hội thoại 1-1 (mở 1 cuộc chat) | `OlaChatViewActivity` | [../chat-hoi-thoai/](../chat-hoi-thoai/README.md) |

> **Nguồn:** cấu trúc tab từ `jadx_out/.../m/e.java`; TIN NHẮN từ `m/o.java`; DANH BẠ từ `m/n.java`. Layout từ `apktool_out/res/layout/`.

## Ảnh chụp (thiết bị thật + fake server)

| TIN NHẮN | DANH BẠ | Khung chat | Auto-reply |
|---|---|---|---|
| ![tin-nhan](images/01-tin-nhan.png) | ![danh-ba](images/02-danh-ba.png) | ![chat](images/03-khung-chat.png) | ![reply](images/04-auto-reply.png) |

> Avatar hiển thị chữ cái đầu của nick (màu nền ngẫu nhiên) khi chưa có ảnh.

---

## 1. Khung tab container — `contact_view_layout.xml` (fragment `m.e`)

```
FrameLayout
├─ OlaViewPager  contactFragmentHolder   paddingTop 42dp   ← 2 trang: [TIN NHẮN(0)] | [DANH BẠ(1)]
├─ Action bar (LinearLayout, style actionBar.background — nền xanh #7CB342, gravity center_vertical)
│   ├─ conversationTabLeftButton   (ImageView, invisible mặc định — nút trái ĐỘNG theo tab)
│   ├─ [LinearLayout weight 1 — 2 tab]
│   │   ├─ FrameLayout (weight 1)
│   │   │   ├─ btnTabConversation   "TIN NHẮN"   ← tab TRÁI = trang 0
│   │   │   └─ txtTabConversationInfo  badge tổng chưa đọc (right|top, marginTop 4dp, GONE mặc định)
│   │   └─ btnTabContactList   "DANH BẠ"   (weight 1)   ← tab PHẢI = trang 1
│   └─ conversationTabRightButton  ⋮  (ic_more_white, marginLeft 32dp)
└─ ProgressBar  loadingProgressBar   (giữa màn, GONE mặc định)
```

- Tab dùng style `?actionBar.tab.button` (in **đậm**, **14sp**, **gạch chân trắng** khi chọn). Bấm tab → `viewPager.setCurrentItem(0|1)`; bấm lại tab đang mở → cuộn list lên đầu (`f_()`).
- Tab chọn: chữ `#FFFFFF` (`f.C`). Không chọn: `rgba(255,255,255,.70)` (`f.D`). Đổi màu trong `m/e.java#j()`.

### Badge & nút động trên action bar (`m/e.java#e()`)
| Thành phần | Hiện khi | Ghi chú |
|------------|----------|---------|
| Badge `txtTabConversationInfo` | tổng chưa đọc `h.t.q() > 0` | **CHỈ trên tab TIN NHẮN** (không phải mỗi tab 1 badge). Nền hồng `bg_uread_notify` `#FF4081`. Ảnh `02-danh-ba.png` thấy badge **"2"** trên TIN NHẮN. |
| Nút ⋮ `conversationTabRightButton` | fragment hiện tại `i() == true` | Cả `o` và `n` đều `i()=true` → ⋮ luôn hiện. Bấm → `h_()` của fragment đang xem → **popup menu KHÁC nhau theo tab** (xem tài liệu từng tab). |
| Nút trái `conversationTabLeftButton` | fragment cấp `b(context)` ≠ null | Ở 2 tab này `b()` trả null nên **ẩn**. |

---

## 2. CSS — action bar 2 tab (dùng chung)

```css
.ola-chat-tabs {
  display: flex; align-items: center;
  height: 48px; background: #7CB342; padding: 0 8px;
  font-family: Roboto, "Helvetica Neue", Arial, sans-serif;
}
.ola-chat-tabs__btn {
  flex: 1; height: 100%;
  display: flex; align-items: center; justify-content: center;
  font-size: 14px; font-weight: bold;
  color: rgba(255,255,255,.70);              /* tab không chọn */
  background: none; border: none; position: relative;
}
.ola-chat-tabs__btn.is-active {
  color: #FFFFFF;
  box-shadow: inset 0 -2px 0 #FFFFFF;        /* gạch chân trắng */
}
.ola-chat-tabs__badge {                       /* chỉ ở TIN NHẮN */
  position: absolute; top: -2px; right: -20px;
  min-width: 16px; height: 16px; padding: 0 4px; border-radius: 999px;
  background: #FF4081; color: #fff; font-size: 10px; font-weight: bold;
  display: flex; align-items: center; justify-content: center;
}
.ola-chat-tabs__more { width: 24px; color: #fff; }   /* ⋮ */
```

---

## 3. Token & màu dùng chung

| Thành phần | Giá trị |
|------------|---------|
| Action bar | nền `#7CB342`, cao 48dp |
| Tab chọn / không chọn | `#FFFFFF` (đậm 14sp) gạch chân trắng / `rgba(255,255,255,.70)` |
| Nền dòng list (cả 2 tab) | `rgba(255,255,255,.8)` (`#CCFFFFFF`) |
| Dòng | min-height 72dp, padding 16dp |
| Avatar | 40×40dp, bo tròn, `centerCrop` |
| Badge chưa đọc | nền `#FF4081`, chữ trắng đậm |
| Divider | `#1F000000`, 1dp, margin ngang 16dp |
| FAB | 56dp, `floating_action_bar_shape` (oval xanh), tint trắng — TIN NHẮN: ✎ `ic_action_compose_message`; DANH BẠ: 👤+ `ic_add_friend` |

Bảng màu đầy đủ: [../README.md](../README.md#bảng-màu-tham-chiếu-nhanh) · [../../ola-color-palette.html](../../ola-color-palette.html)

> Chi tiết item, menu ⋮, dialog, strings, icon của **từng tab** nằm trong [tin-nhan.md](tin-nhan.md) và [danh-ba.md](danh-ba.md).
