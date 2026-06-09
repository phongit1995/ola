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
└── dang-ky/               ← màn Đăng ký
    └── README.md                tài liệu chi tiết
```

> Mỗi màn = **1 folder riêng** chứa `README.md` + folder `images/` (ảnh chụp của riêng màn đó). Ảnh **dùng chung** (logo, icon…) đặt ở [images/](images/) cấp screens.

## Danh sách màn hình

| # | Màn hình | Tài liệu | Activity | Trạng thái ảnh |
|---|----------|----------|----------|----------------|
| 1 | Đăng nhập | [dang-nhap/](dang-nhap/README.md) | `OlaLoginActivity` | ✅ chụp thật |
| 2 | Đăng ký | [dang-ky/](dang-ky/README.md) | `OlaSignUpActivity` (qua Facebook AccountKit) | ⚠️ dựng từ layout (cần FB AccountKit) |

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
