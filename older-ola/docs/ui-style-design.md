# Ola 2.1.11 — UI Style / Design System

> Nguồn: phân tích ngược tài nguyên trong `apktool_out/res/` (colors, dimens, styles, drawables) và code `jadx_out/`.
> Thống kê: **186 màu**, **378 dimens**, **590 styles**, 1786 strings, hỗ trợ ~100 ngôn ngữ.

---

## 1. Triết lý thiết kế tổng thể

- **Nền tảng theme:** kế thừa `@android:style/Theme.Holo.Light.NoActionBar` — tức là **Holo (Android 4.x), KHÔNG dùng Material/AppCompat**. Đây là phong cách "flat phẳng nhẹ" thời Android cũ.
- **Action bar tự vẽ:** app tự dựng action bar riêng (không dùng ActionBar/Toolbar hệ thống), tạo bằng các attribute `actionBar.*` trong theme.
- **Theming bằng custom attributes:** Ola định nghĩa một hệ thống attribute riêng rất chi tiết (`chatView.*`, `me.*`, `vip.*`, `login.*`, `contact.*`…) trong `Theme.ola.default` → mỗi thành phần UI có style token riêng, cho phép "thay áo" toàn app từ một chỗ.
- **Font:** **không có font tùy chỉnh** (không có `.ttf/.otf`, không gọi `createFromAsset`) → dùng font hệ thống (Roboto/sans-serif mặc định).
- **Dark mode:** có thư mục `values-night/` nhưng chỉ chứa style thư viện — **app không có dark theme thực sự**, giao diện là **Light** xuyên suốt.

---

## 2. Bảng màu đầy đủ (Color Palette)

> 👉 **Xem màu trực quan:** mở [ola-color-palette.html](ola-color-palette.html) bằng trình duyệt để thấy đúng màu thật (kèm độ trong suốt).
>
> Cột "Swatch" dưới đây là ký hiệu gần đúng để hình dung; mã HEX mới là chuẩn. Màu dạng `#AARRGGBB` (8 ký tự) là **có độ trong suốt** (2 ký tự đầu = alpha).

### 2.1. Màu chính — Xanh lá (Primary / Green)
| Swatch | Token | HEX | Dùng cho |
|:--:|-------|-----|----------|
| 🟩 | `colorOlaPrimary` | `#7CB342` | **Xanh lá chủ đạo** (thương hiệu) |
| 🟢 | `colorOlaPrimaryDark` · `green_color_basic` | `#558B2F` | Xanh đậm — status bar, viền nút |
| 🌲 | `colorOlaPrimaryDarkMore` | `#33691E` | Xanh đậm hơn — nhấn mạnh |
| ⬜ | `colorOlaPrimaryLight` | `#F1F8E9` | Xanh rất nhạt — nền vùng chọn |
| 🟩 | `buttonGreen` | `#9CCC65` | Nền nút xanh (sáng hơn primary) |
| 🍏 | `green_light` | `#CDFBA4` | Xanh pastel — nền nhẹ |
| 🟢 | `vip_nick_color` | `#65B320` | Màu nickname VIP |
| 👻 | `colorOlaPrimaryShadown` | `#33·7CB342` | Xanh primary alpha 20% — đổ bóng |

> Dải **Material Light Green 600–900** — nhận diện **xanh lá tươi** xuyên suốt app.

### 2.2. Màu nhấn — Hồng / Tím (Accent)
| Swatch | Token | HEX | Dùng cho |
|:--:|-------|-----|----------|
| 🌸 | `colorOlaAccent` · `colorAccent` | `#FF4081` | **Hồng nhấn** — FAB, highlight, link nhấn |
| 🌺 | `colorOlaAccentPrimaryDark` | `#F50057` | Hồng đậm — trạng thái nhấn |
| 🩷 | `colorOlaAccentPrimaryLight` | `#FF80AB` | Hồng nhạt |
| 🟣 | `colorOlaPurple` | `#4527A0` | Tím phụ |

> ⚠️ Lưu ý: còn `colorPrimary #3F51B5` / `colorPrimaryDark #303F9F` (chàm Indigo) — đây là **giá trị mặc định của AppCompat còn sót lại, app KHÔNG dùng** (Ola theme dựa trên Holo).

### 2.3. Màu nền (Backgrounds)
| Swatch | Token | HEX | Dùng cho |
|:--:|-------|-----|----------|
| ⬜ | `app_background_color` | `#D5D5D5` | Nền màn hình chính (xám nhạt) |
| ⬜ | `background_holo_light` | `#F3F3F3` | Nền sáng Holo |
| ⬜ | `background_solid_color` | `#EEECED` | Nền đặc (panel) |
| 🫥 | `background_translucent_80_color` | `#CC·EEECED` | Nền mờ 80% |
| ⬜ | `image_background_color` | `#DDDDDD` | Nền placeholder ảnh |
| ◻️ | `bg_search_box` | `#A4A4A4` | Ô tìm kiếm (xám) |
| ⬛ | `color_slide_menu_background` | `#303030` | Nền menu trượt (tối) |

### 2.4. Văn bản (Text) — theo thang trong suốt Material
| Swatch | Token | HEX | Ý nghĩa |
|:--:|-------|-----|---------|
| ⬛ | `colorTextBlackPrimary` | `#DE·000000` | Chữ chính (đen **87%**) |
| 🔲 | `colorTextBlackSecondaryOrIcon` | `#8A·000000` | Chữ phụ / icon (đen **54%**) |
| 🔲 | `colorTextBlackHintOrDisable` | `#42·000000` | Hint / disabled (đen **26%**) |
| ▪️ | `colorTextBlackDivider` | `#1F·000000` | Đường kẻ (đen **12%**) |
| ⬜ | `colorTextWhitePrimary` | `#FFFFFF` | Chữ trắng trên nền màu |
| ◽ | `colorTextWhiteSecondary` | `#B3·FFFFFF` | Chữ trắng phụ (70%) |
| ◽ | `colorTextWhiteHintOrDisable` | `#4D·FFFFFF` | Chữ trắng disabled (30%) |

**Sắc xám phụ cho chữ** (`text_color_*`):
| Token | HEX | | Token | HEX |
|-------|-----|--|-------|-----|
| `text_color_1` | `#A29F9F` | | `text_color_5` | `#636362` |
| `text_color_2` | `#ADADAD` | | `text_color_6` | `#929191` |
| `text_color_3` | `#0075B7` (link xanh) | | `text_color_7` | `#808080` |
| `text_color_4` | `#939393` | | *gửi chat* | `#0B6FBB` (xanh dương) |

### 2.5. Màu ngữ nghĩa (Semantic / Status)
| Swatch | Token | HEX | Ý nghĩa |
|:--:|-------|-----|---------|
| 🟥 | `red` | `#E34545` | Lỗi / xoá / cảnh báo |
| 🟥 | `recording_time_remaining_text` | `#FF·FF0033` | Đỏ tươi — đang ghi âm |
| 🟧 | `light_red` | `#FFCACA` | Nền cảnh báo nhạt |
| 🟧 | `orange_color_comment_tag` | `#FFB400` | Cam — tag/bình luận |
| 🟦 | `text_color_3` | `#0075B7` | Liên kết (link) |
| 🟦 | `blue` | `#0101FF` | Xanh dương cơ bản |
| 🟦 | `com_smart_login_code` | `#3C6499` | Xanh đăng nhập nhanh |

### 2.6. Tab & Điều hướng
| Swatch | Token | HEX | Dùng cho |
|:--:|-------|-----|----------|
| ⬛ | `bottom_tab_button_selected` / `_pressed` | `#CC·1D1D1D` | Tab dưới khi chọn/nhấn (đen mờ) |
| ◻️ | `top_tab_unselect_color` | `#B2B2B2` | Tab trên chưa chọn (xám) |
| 🟩 | `translucent_top_tab_select_color_50_percent` | `#80·66AE27` | Tab trên đang chọn (xanh mờ 50%) |

### 2.7. Đường kẻ & Phân cách (Divider / Separator)
| Token | HEX | |
|-------|-----|--|
| `listDivider` | `#DEDCDC` | kẻ giữa item danh sách |
| `separator_line_color` | `#64·B2B2B2` | kẻ phân cách (mờ) |
| `separator_line_color_1` | `#E6E6E6` | kẻ phân cách nhạt |

### 2.8. Lớp phủ trong suốt (Translucent overlays)
Dùng cho lớp mờ trên ảnh, modal, badge:

| Đen (black) | Trắng (white) | Xanh (green `#6E8A4F`) | VIP (`#65B320`) |
|-------------|---------------|------------------------|------------------|
| 25% `#3F000000` | 18% `#30FFFFFF` | 10% `#19·6E8A4F` | 60% `#99·65B320` |
| 38% `#61000000` | 40% `#66FFFFFF` | 20% `#33·6E8A4F` | 80% `#CC·65B320` |
| 50% `#7F000000` | 50% `#80FFFFFF` | 80% `#CC·6E8A4F` | |
| 60% `#99000000` | 60% `#99FFFFFF` | | |
| 80% `#CC000000` | 80% `#CCFFFFFF` | | |
| | 90% `#E5FFFFFF` | | |

> Hệ độ trong suốt **87/54/26/12%** cho chữ và các nấc 25/38/50/60/80% cho overlay đều theo guideline Material Design.

---

## 3. Typography (cỡ chữ)

Hệ cỡ chữ đặt theo tên Material (token `text.size.*`):

| Token | Cỡ | Vai trò |
|-------|----:|---------|
| `text.size.caption` | 12sp | Chú thích, timestamp |
| `text.size.body1` / `body2` | 14sp | Nội dung chính, nút |
| `text.size.button` | 14sp | Chữ trên nút |
| `text.size.subhead` | 16sp | Tiêu đề action bar, label |
| `text.size.18` | 18sp | Nhấn mạnh |
| `text.size.title` | 20sp | Tiêu đề lớn |
| `text.size.headline` | 24sp | Headline |
| `text.size.32sp` / `48sp` | 32 / 48sp | Số lớn (VIP count, splash) |
| `text.size.9sp` | 9sp | Badge nhỏ nhất |

Style chữ cơ sở: `defaultStyle.text` → `.small / .medium (14sp) / .medium2 (16sp) / .large (20sp)`.

---

## 4. Spacing & kích thước (Metrics)

Hệ khoảng cách dùng token `metric.<n>dp`, theo **lưới 4dp/8dp**:

```
1, 2, 10, 12, 16, 20, 24, 28, 32, 36, 40, 56, 64, 100, 120, 164, 188, 200, 240, 280, 360, 400 (dp)
```

- Bo góc mặc định nút: **2dp** (`metric.2dp`) → gần như **vuông**, bo rất nhẹ (đặc trưng Holo, không bo tròn nhiều như Material sau này).
- minWidth nút: 56–64dp; minHeight nút: 28dp.
- Đường kẻ/divider: **1dp**.

---

## 5. Components (style các thành phần chính)

### Nút (Button)
| Style | Đặc điểm |
|-------|----------|
| `defaultStyle.button` | Nút mặc định — chữ đen, nền `btn_default_button_selector`, 14sp, single-line, ellipsize cuối |
| `defaultStyle.button.green` | **Nút xanh chủ đạo** — chữ trắng, nền `btn_green_button` (solid `#9CCC65`, viền `#558B2F` 1px, bo góc 2dp) |
| `Login.Button.Singin` | Nút Đăng nhập — chữ **trắng đậm (bold)** 20sp, padding ngang 20dp |

Nút dùng **selector 4 trạng thái** (normal / pressed / selected / selected-pressed) → có hiệu ứng nhấn rõ ràng.

### Action Bar (tự vẽ)
- Nền `bg_action_bar`: **layer-list nhiều lớp đen mờ** (`#11000000`, `#12000000`…) tạo **đổ bóng/gờ mảnh 1dp** ở mép dưới — kiểu thanh bar phẳng có shadow nhẹ.
- Tiêu đề: chữ **trắng** 16sp, chạy chữ (marquee) khi quá dài.

### Khung chat (Chat View)
| Phần tử | Style |
|---------|-------|
| Nội dung tin nhắn | chữ **đen** 14sp |
| Tên người gửi | chữ xanh dương `#0B6FBB`, cỡ small |
| Trạng thái gửi (deliver) | xám `#A29F9F`, cỡ nhỏ nhất |
| Status bar chat | chữ trắng 14sp |

> Chat dùng **bong bóng tin nhắn (balloon)** — có cả `OlaBalloonChatViewActivity` và token `chatView.item.*` riêng cho media/text.

### Ô nhập liệu & Form
- Input: `bg_input_box` (login), `common.editText`.
- Form có `form.header`, `form.text.lable` (label) — phân cấp tiêu đề/nhãn rõ ràng.

### Các module có style riêng
Theme định nghĩa nhóm token cho từng tính năng: **`me.*`** (trang cá nhân/nhật ký), **`vip.*`** (cửa hàng VIP, chuyển KEN), **`contact.*`** (danh bạ), **`login.*` / `register.*`**, **`tab.*`**, **`menu.*`**, **`history.*`**, **`home.shortcutTitle`** (icon trang chủ).

---

## 6. Tóm tắt "chất" thiết kế của Ola

1. **Phong cách Holo Light** thời Android 4.x — phẳng, gọn, viền/divider mảnh, **bo góc rất nhẹ (2dp)**, KHÔNG phải Material Design hiện đại.
2. **Nhận diện màu: xanh lá `#7CB342` + nhấn hồng `#FF4081`** trên nền xám nhạt `#D5D5D5`, chữ đen theo thang trong suốt Material.
3. **Font hệ thống**, cỡ chữ chuẩn 12/14/16/20/24sp.
4. **Theming tập trung bằng custom attributes** — toàn bộ UI map qua `Theme.ola.default`, dễ đổi đồng loạt; mỗi tính năng (chat, me, vip, login…) có bộ style riêng.
5. **Chỉ có Light theme**, không dark mode.
6. Hiệu ứng tương tác qua **state selector** (nhấn/chọn) thay vì ripple Material.

---

## Phụ lục — file tham chiếu

| Nội dung | Đường dẫn |
|----------|-----------|
| Màu | `apktool_out/res/values/colors.xml` |
| Cỡ chữ & spacing | `apktool_out/res/values/dimens.xml` |
| Styles & themes | `apktool_out/res/values/styles.xml` |
| Custom attributes | `apktool_out/res/values/attrs.xml` |
| Drawable nút/nền | `apktool_out/res/drawable*/btn_green_button.xml`, `bg_action_bar.xml` |
| Theme áp cho từng màn | `apktool_out/AndroidManifest.xml` |
