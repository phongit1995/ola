# Tài liệu chi tiết từng màn hình (Screens)

Mô tả chi tiết **UI/UX + style cụ thể** của từng màn hình Ola 2.1.11: bố cục, màu sắc, kích thước, font, và **CSS tương đương** để dựng lại trên web.

> Style được trích **trực tiếp** từ resource thật của APK (`apktool_out/res/`): `layout/*.xml`, `values/colors.xml`, `values/styles.xml`, `values/dimens.xml`. Ảnh chụp lấy từ thiết bị thật chạy fake server.

## Cấu trúc thư mục

```
screens/
├── README.md              ← file này (index + bảng màu chung)
├── images/                ← ẢNH ASSET DÙNG CHUNG (trích từ APK)
│   ├── ola_logo_trans.png       logo mặt cười Ola
│   ├── ic_input_clear.png       icon × xoá ô nhập
│   └── ic_expander_show_span.png  icon ▾ dropdown
├── dang-nhap/             ← màn Đăng nhập
│   ├── README.md                tài liệu chi tiết
│   └── images/                  ảnh chụp riêng (01-login-prefilled, 02-login-empty)
├── dang-ky/               ← màn Đăng ký
│   └── README.md                tài liệu chi tiết
├── trang-chu/             ← màn Trang chủ (bottom tab)
│   ├── README.md                tài liệu chi tiết (bottom bar 5 tab)
│   └── images/                  ảnh chụp 5 tab + 10 icon bottom bar
├── chat/                  ← màn Chat (tab 1: TIN NHẮN + DANH BẠ)
│   ├── README.md                list hội thoại + danh bạ + khung chat + CSS
│   └── images/                  ảnh chụp TIN NHẮN, DANH BẠ, bong bóng chat
├── phong-chat/            ← màn Phòng chat (tab 2: public chat room)
│   ├── README.md                list phòng + số người + filter + loa loa + CSS
│   └── images/                  ảnh chụp + icon phòng chat
├── me/                    ← màn Me (tab 3: bảng tin / newsfeed)
│   ├── README.md                flow + feed + bài đăng + đăng bài + 2 drawer + CSS
│   └── images/                  icon (chưa chụp màn)
├── trang-ca-nhan/         ← Trang cá nhân / Thông tin người dùng (OlaUserMePageActivity)
│   ├── README.md                header hồ sơ + 5 nút quan hệ + menu Khác + tính năng + icon
│   └── images/                  icon hồ sơ
├── rss/                   ← màn RSS (tab 4: trình đọc tin tức)
│   ├── README.md                flow + list bài + WebView + bookmark/lịch sử + CSS
│   └── images/                  icon RSS
├── cai-dat/               ← màn Cài đặt (Settings — app trong tab Ứng dụng)
│   ├── README.md                5 nhóm + mọi mục + đăng xuất + CSS + icon
│   └── images/                  icon
├── thong-tin-ca-nhan/     ← Hồ sơ bản thân / sửa thông tin (OlaUserProfileActivity)
│   ├── README.md                7 trường sửa + auto-save + FB link + CSS + icon
│   └── images/                  icon
├── ung-dung/              ← màn Ứng dụng (tab 5: list tiện ích)
│   ├── README.md                10 tiện ích + style item + CSS
│   └── images/                  ảnh chụp + 10 icon tiện ích
├── kho-vip/               ← màn Kho VIP (OlaVipStoreActivity)
│   ├── README.md                scaffold + header (VIP đang dùng/quyền/buy/extend) + item + CSS
│   └── images/                  icon (tab vip, mũi tên, back, quit)
└── modal-dialog/          ← Modal/Dialog kiểu chung (confirm, nhập, progress…)
    └── README.md                khung 3 phần + màu/size/nút/icon + CSS
```

> Mỗi màn = **1 folder riêng** chứa `README.md` + folder `images/` (ảnh chụp của riêng màn đó). Ảnh **dùng chung** (logo, icon…) đặt ở [images/](images/) cấp screens.

## Danh sách màn hình

| # | Màn hình | Tài liệu | Activity | Trạng thái ảnh |
|---|----------|----------|----------|----------------|
| 1 | Đăng nhập | [dang-nhap/](dang-nhap/README.md) | `OlaLoginActivity` | ✅ chụp thật |
| 2 | Đăng ký | [dang-ky/](dang-ky/README.md) | `OlaSignUpActivity` (qua Facebook AccountKit) | ⚠️ dựng từ layout (cần FB AccountKit) |
| 3 | Trang chủ (bottom tab) | [trang-chu/](trang-chu/README.md) | `OlaBottomTabActivity` | ✅ chụp thật cả 5 tab |
| 3a | Chat (TIN NHẮN + DANH BẠ) | [chat/](chat/README.md) | `OlaBottomTabActivity` (frag `e`) + `OlaChatViewActivity` | ✅ chụp thật |
| 3b | Phòng chat (tab 2) | [phong-chat/](phong-chat/README.md) | `OlaBottomTabActivity` (frag `l`) + `OlaChatViewActivity` | ✅ chụp (list trống) |
| 3c | Me (tab 3 — newsfeed) | [me/](me/README.md) | `OlaBottomTabActivity` (frag `me.c`) + `OlaMeComposerActivity` / `OlaUserMePageActivity` | 📐 từ code/XML (chưa chụp) |
| 3d | Trang cá nhân (User Info) | [trang-ca-nhan/](trang-ca-nhan/README.md) | `OlaUserMePageActivity` | 📐 từ code/XML (chưa chụp) |
| 3e | RSS (tab 4 — tin tức) | [rss/](rss/README.md) | `OlaBottomTabActivity` (frag `m.j`) + WebView | 📐 từ code/XML (chưa chụp) |
| 5 | Cài đặt (Settings) | [cai-dat/](cai-dat/README.md) | `OlaAppSettingActivity` | 📐 từ code/XML (chưa chụp) |
| 3f | Hồ sơ bản thân (sửa thông tin) | [thong-tin-ca-nhan/](thong-tin-ca-nhan/README.md) | `OlaUserProfileActivity` | 📐 từ code/XML (chưa chụp) |
| 4 | Ứng dụng (tab 5) | [ung-dung/](ung-dung/README.md) | `OlaBottomTabActivity` + fragment `m/d` | ✅ chụp thật + 10 icon |
| 4a | Kho VIP | [kho-vip/](kho-vip/README.md) | `OlaVipStoreActivity` | 📐 từ code/XML (chưa chụp) |
| — | Modal / Dialog (kiểu chung) | [modal-dialog/](modal-dialog/README.md) | dùng chung (confirm, nhập, progress, chọn) | 📐 trích từ layout/style |

## Quy ước trong tài liệu

- **dp → px**: thiết bị test mật độ `xxhdpi` (×3). Ví dụ `16dp = 48px`. Phần CSS dùng `px` ở mật độ chuẩn (mdpi, `1dp = 1px`) cho dễ đọc — scale theo nhu cầu.
- **Màu**: định dạng Android là `#AARRGGBB` (alpha đứng trước). Phần CSS đã chuyển sang `#RRGGBB` + `rgba()`.
- **Font**: app dùng font hệ thống (Roboto trên Android). Không nhúng font riêng.

## Bảng màu tham chiếu nhanh

| Token | HEX | Dùng cho |
|-------|-----|----------|
| `colorOlaPrimary` | `#7CB342` | Nền chính (xanh lá Ola) |
| `colorOlaPrimaryDark` | `#558B2F` | Viền nút, status bar |
| `colorOlaPrimaryDarkMore` | `#33691E` | Nhấn đậm |
| `colorOlaPrimaryLight` | `#F1F8E9` | Nền nhạt |
| `buttonGreen` | `#9CCC65` | Nền nút "Đăng nhập" |
| `colorAccent` | `#FF4081` | Màu nhấn (hồng) |
| `colorTextWhitePrimary` | `#FFFFFF` | Chữ trắng chính |
| `colorTextWhiteSecondary` | `rgba(255,255,255,.70)` | Chữ trắng phụ (`#B3FFFFFF`) |
| `colorTextBlackPrimary` | `rgba(0,0,0,.87)` | Chữ đen chính (`#DE000000`) |
| `colorTextBlackSecondaryOrIcon` | `rgba(0,0,0,.54)` | Chữ đen phụ (`#8A000000`) |
| `colorTextBlackDivider` | `rgba(0,0,0,.12)` | Đường kẻ phân cách (`#1F000000`) |
| `red` | `#E34545` | Thông báo lỗi |
| `translucent_black_38_percent` | `rgba(0,0,0,.38)` | Lớp phủ loading (`#61000000`) |

Xem thêm bảng màu đầy đủ: [../ui-style-design.md](../ui-style-design.md) · [../ola-color-palette.html](../ola-color-palette.html)
