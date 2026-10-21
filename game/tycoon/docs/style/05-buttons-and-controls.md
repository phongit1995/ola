# 05 — Button và control

## 1. `.ty-btn` base

- Cao `--ty-btn-h` 52 (`-big` 64, `-small` 40), padding ngang 20, radius pill (ảnh mẫu; nút đứng pha jail radius 16), chữ 17/700 (small 15/700), viền 2, shadow md, gap icon-chữ 8, icon 20 (big 24).
- Full-width trong modal/sheet; trong cụm lượt giữa bàn CTA đơn rộng 196 (390), hai nút chia 40/60. Lobby S2 có biến thể riêng theo [S2 lobby §6](./screens/s2-lobby/README.md#6-nút-và-minh-họa): rộng 280 tại 390 (responsive 256–320), cao 80/56/56/44, font 32/24/24/22, minh họa màu `lobby/ill-*`. Không áp size/icon base của nút thường vào S2.
- Mọi state theo `01-foundations.md` §9. Loading: spinner thay icon, giữ chiều rộng.

| Biến thể | Nền | Chữ | Viền | Dùng |
|---|---|---|---|---|
| `.ty-btn-gold` | gradient `#FFD34D → #F2B807` + mép dưới 4 px gold-deep (`--ty-sh-raise-gold`); nhấn: dịch xuống 2 px | navy 800 | gold-deep | hành động chính duy nhất của pha/màn |
| `.ty-btn-paper` | paper | navy | navy | hành động phụ |
| `.ty-btn-jade` | jade | cream | navy | Sẵn sàng |
| `.ty-btn-danger` | danger | cream | navy | Phá sản, xác nhận Bỏ cuộc |
| `.ty-btn-text` | trong suốt | navy (trên nền trời và paper); cream chỉ trên surface navy | — | Hủy, Luật chơi |

Quy tắc: tối đa **1** nút gold hiển thị cùng lúc trên màn (CTA của pha). Mặc định nó ở hàng 3 của cụm lượt giữa bàn (02 §6.3). Ngoại lệ: pha `festival`/`travel` nút gold nằm trong sheet S7 (`Tổ chức Lễ hội ở đây` / `Bay tới đây`), cụm lượt chỉ có nút paper; pha `debt` nút gold nằm trong O3. Nếu cụm lượt đang có gold thì sheet đang mở không có gold thứ hai — sheet dùng paper/jade.

## 2. Cụm lượt theo pha — màu nút

Vị trí nút từng pha ở 02 §6.3; bảng dưới chỉ quy định biến thể màu.

| Pha | Nút | Biến thể |
|---|---|---|
| roll | Gieo xúc xắc | gold + `ic-dice` |
| jail | Gieo đôi / Nộp 50 tr / Dùng thẻ | gold / paper / paper |
| decide | Mua {giá} | gold (chữ giá tabular); không đủ tiền → disabled + giá coral |
| decide | Bỏ qua | paper |
| takeover | Mua lại {giá} | gold (chữ giá tabular) |
| takeover | Bỏ qua | paper |
| festival | Bỏ qua (cụm lượt) / Tổ chức Lễ hội ở đây (S7) | paper / gold |
| travel | Không bay, gieo xúc xắc (cụm lượt) / Bay tới đây (S7) | paper / gold |
| manage | Xây / bán | paper + `ic-house` jade |
| manage | Kết thúc lượt / Gieo tiếp | gold |
| debt | Bán nhà / Trả {x} tr / Phá sản | paper + `ic-minus` coral / gold + `ic-coins` / danger |
| chờ người khác | chip `(avatar VIP) Lượt của @username` + dòng pha | chip paper viền màu ghế, chữ navy; 3 chấm thay đồng hồ; không nút |

## 3. `.ty-icon-btn`

- 44 × 44, radius pill, nền paper, viền navy 1.5, icon navy 24 — kể cả khi nằm trên nền trời (header, footer S6). `.ty-icon-btn-dark` (viền cream 30%) chỉ dùng trên surface navy.
- Có badge: chấm coral 8 px góc trên-phải, viền nền 1.5 px.
- Toggle (âm thanh): `aria-pressed`; trạng thái off icon 70%.

## 4. Chip-btn (chọn số người, tab BXH)

- 40 cao, padding 16, radius pill, viền navy 1.5, chữ 15/600; active: nền gold, viền gold-deep, chữ navy; `role="radio"`.

## 5. Nút +/− trong S8 và O3

- 36 × 36, radius 12, viền navy 1.5, nền paper; `+` icon jade, `−` icon coral; giá 13.5/800 tabular bên cạnh (`150 tr` / `+75 tr`).
- Disabled: icon navy 45%, giá navy 45%, tooltip lý do (long-press/hover) 12.5 coral.
- Pending (đã gửi, chờ STATE): spinner 14 thay icon, cả hàng 60%.

## 6. Input

- Cao 48, radius 12, viền navy 1.5, nền paper, chữ 15/600, placeholder navy 45%; focus viền gold 2; lỗi viền coral 2 + text lỗi 12.5 coral dưới + shake 2 px 240 ms.
- Mật khẩu bàn: hiện dạng text thường, không có toggle ẩn/hiện (mật khẩu bàn chơi không phải thông tin bảo mật; inventory icon không có `ic-eye`).

## 7. Sheet handle và nút dính đáy

- Handle 36 × 4 navy 30%, vùng kéo 44 cao.
- Nút dính đáy: nền paper, border-top line 1 px, padding 12 + safe-area, 1–2 nút theo §1.

## 8. Chip trạng thái

| Chip | Nền | Chữ/icon | Dùng |
|---|---|---|---|
| `.ty-chip` | paper, viền navy 1.5 | navy | mặc định, số đất |
| `.ty-chip-gold` | gold-soft `#FBE9A6`, viền gold-deep | navy | Chủ bàn, Đôi!, có thẻ ra tù |
| `.ty-chip-jade` | jade | cream | Sẵn sàng, Đã mua |
| `.ty-chip-coral` | coral | cream | Phá sản, Vòng 28–29 |
| `.ty-chip-danger` | danger | cream | Vòng cuối |
| `.ty-chip-seat[data-seat]` | seat-n-soft, viền seat-n 1.5 | navy | tên trong chat/log |
| `.ty-chip-group[data-group]` | paper, ô màu 12 px | navy | nhóm đất |

## 9. Header S6

- Trái: logo `CỜ TỶ PHÚ` (cao 32). Giữa màn: `.ty-round-chip`. Phải: nút âm thanh rồi nút menu, đều `.ty-icon-btn` tròn 44.
- TurnClock **không** nằm ở header: nó ở bên phải chip lượt, giữa bàn (03 §7).
- Nút menu (concept vẽ ☰; inventory hiện có `ic-more`, nếu đổi sang ☰ thì thêm `ic-menu` vào 06) mở popover paper (radius 16, shadow lg), neo dưới nút, căn phải: `Về sảnh` (navy, `ic-exit-door`), `Luật chơi` (navy), `Bỏ cuộc` (coral, `ic-flag`).
- Cài đặt `Hiệu ứng: Đầy đủ / Nhẹ / Tắt` nằm trong menu này theo [08 §5](../08-fx-and-animation.md), dùng radio có nhãn; không thêm nút vào topbar lobby S2 đã chốt.

## 10. Accessibility control

- Tất cả control có accessible name tiếng Việt; nút icon-only `aria-label`.
- Focus order trong S6: header → cụm lượt (nút chính trước) → hàng pod → footer → bàn. Bàn là **một** tab stop, dùng phím mũi tên duyệt 32 ô theo idx (roving tabindex), để không phải tab qua 32 ô mới tới nút.
- `Escape` đóng sheet/popover/modal thường; không đóng S9/O3.
