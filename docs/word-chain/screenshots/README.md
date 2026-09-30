# Ảnh chụp màn phòng nối từ (web)

Chụp từ component thật `WordChainView` với dữ liệu giả, khung 430×932 @2x. Người đang xem là `phong`. Tên người chơi, điểm và từ đều là dữ liệu mẫu.

| Ảnh | Case |
|---|---|
| [00-tong-hop.png](00-tong-hop.png) | Cả một ván liền: nối đúng, sai định dạng, từ đã dùng, sai âm đầu, không có trong từ điển, thắng ván và bot mở ván mới |
| [01-noi-tu-dung.png](01-noi-tu-dung.png) | Bot mở phiên, các người chơi lần lượt nối đúng (✅) |
| [02-sai-dinh-dang.png](02-sai-dinh-dang.png) | Gõ 1 âm tiết: `invalid_format` (⚠️), trọng tài trả lời, còn 2/3 lượt |
| [03-sai-am-dau.png](03-sai-am-dau.png) | Âm tiết đầu không khớp: `mismatch` (❌) |
| [04-tu-da-dung.png](04-tu-da-dung.png) | Điền trùng từ đã dùng trong ván: `repeated` (❌) |
| [05-khong-co-trong-tu-dien.png](05-khong-co-trong-tu-dien.png) | Từ không có trong từ điển: `not_in_dict` (❌) |
| [06-het-luot-doan.png](06-het-luot-doan.png) | Sai 3 lần: còn 0/3 lượt (chữ đỏ), ô nhập bị khoá |
| [07-thang-van.png](07-thang-van.png) | Nối từ không còn từ nào nối tiếp: thắng (🏆), trọng tài báo thắng, bot mở ván mới |
| [08-bot-thay-tu-sau-12h.png](08-bot-thay-tu-sau-12h.png) | Từ của bot 12 giờ không ai nối: tin bot cũ được ghi đè thành từ mới ở cuối danh sách, tin người chơi giữ nguyên |
| [09-luat-choi.png](09-luat-choi.png) | Dialog luật chơi (7 luật) |
| [10-bang-xep-hang.png](10-bang-xep-hang.png) | Dialog bảng xếp hạng |
| [11-cho-nguoi-khac-noi.png](11-cho-nguoi-khac-noi.png) | Vừa nối đúng: ô nhập và nút gợi ý bị khoá, chờ người khác nối tiếp |
| [12-bang-goi-y.png](12-bang-goi-y.png) | Bấm nút 💡: bảng gợi ý, giá 500 KEN, số dư, tuỳ chọn tự động gửi đang tắt |
| [13-bang-goi-y-tu-dong-gui.png](13-bang-goi-y-tu-dong-gui.png) | Bảng gợi ý với tự động gửi đang bật: bấm dùng là gửi luôn từ đầu tiên |
| [14-danh-sach-goi-y.png](14-danh-sach-goi-y.png) | Không tự động gửi: sau khi trừ KEN hiện danh sách gợi ý, mỗi từ có nút Gửi |
