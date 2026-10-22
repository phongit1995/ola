# O5 — Đối chiếu ảnh mẫu và CSS, 22/10/2026

**Kết luận:** bản CSS trước khác rõ ở cấu tạo viền/cạnh nổi, kích thước nút và chữ. Nhận xét trước đó rằng chỉ còn khác nhỏ là chưa đủ căn cứ. Đã sửa preview; chưa xác nhận giống hoàn toàn, chưa tích hợp vào game.

Nguồn đối chiếu: bốn [WebP example](../examples/) trong repo. Mở [preview](./index.html), chọn **Cạnh nhau** hoặc **Chồng ảnh**. Style modal nằm riêng ở [modal.css](./modal.css); CSS bố cục trang ở [style.css](./style.css). Không sửa bộ nút dùng chung hoặc token production để khớp một ảnh AI.

## Vì sao nhìn khác

| Phần | CSS trước | Sửa trong preview |
|---|---|---|
| Khung modal | Viền navy 2px cộng bóng đen đặc lệch xuống 4px làm đáy quá nặng; mọi mẫu đều có cạnh kem 5px | Viền 1px + nét trong 0,5px, bóng sâu 2px; cạnh kem theo từng mẫu, không áp dải kem dày cho thông báo/lỗi |
| Thân nút | `radius:999px`, bóng màu 4px nằm ngoài outline | Bo 23–27px theo mẫu, cạnh màu 4px nằm trong outline, bóng ngoài mềm 2px |
| Kích thước nút | Nút xác nhận rộng 139px, nguy hiểm 136px, thông báo 270px, lỗi 138px | Lần lượt 142,5 / 143 / 274 / 144px; giữ kích thước khác nhau của bốn reference |
| Độ bóng | Một cung trắng chạy gần kín phía trên cho mọi nút | Hai đốm sáng ngắn cho xác nhận; cung cho nút thông báo; nét mảnh cho lỗi; giấy không có cung trắng đậm |
| Chữ nội dung | Nunito 14,5–15px / 600, rộng hơn mẫu; dòng cao 21–21,75px | 13,5–14,3px / 700, dòng 20px; canh khoảng chữ và vị trí riêng từng mẫu |
| Tiêu đề | Dùng cỡ gần đúng nhưng nét mảnh hơn mẫu | Giữ Nunito local, chỉnh cỡ/vị trí và thêm nét 0,35px; cỡ 24,5 / 30 / 22 / 29,5px theo bốn mẫu |
| Nhãn nút | Nét chữ và chiều ngang chưa khớp | 20 / 21 / 22 / 20px; thu chiều ngang nhãn 90%, giữ nút nguyên kích thước |
| Đỏ nguy hiểm | Đỏ gạch `#b3261e → #a81e17` theo token | Đỏ sáng `#f51e1a → #ce0b15` theo example; đây là ngoại lệ mỹ thuật trong preview, chưa thay token/khẳng định tương phản production |

Chrome xác nhận chữ dùng **font Nunito local**, không rơi về font hệ thống. Không biết tên/font-size gốc của chữ do AI vẽ; các giá trị CSS trên là kết quả canh theo nét chữ nhìn thấy, không phải metadata của ảnh.

## Số đo trước và sau

Đo trên bản render cùng chiều rộng **390px**, device scale 1. Ảnh gốc 853 × 1844 được browser thu về cùng tỷ lệ. Đo hộp bao pixel chữ tối trong vùng text cố định (`R < 100, G < 110, B < 160`), không lấy chiều rộng `<p>` làm chiều rộng chữ. Các số được làm tròn theo pixel và chịu ảnh hưởng của anti-alias/WebP; đây không phải điểm tương đồng tổng thể.

| Chiều rộng phần chữ nội dung | Ảnh mẫu | Trước | Sau |
|---|---:|---:|---:|
| Xác nhận | 170px | 188px | 170px |
| Bỏ cuộc | 205px | 221px | 205px |
| Thông báo | 207px | 225px | 207px |
| Mất kết nối | 187px | 199px | 187px |

| Chiều rộng phần chữ tiêu đề | Ảnh mẫu | Trước | Sau |
|---|---:|---:|---:|
| Thoát game | 135px | 134px | 133px |
| Bỏ cuộc | 99px | 94px | 101px |
| Bạn đã rời bàn | 135px | 141px | 136px |
| Mất kết nối | 131px | 136px | 132px |

Nút xác nhận trong ảnh có vùng viền khoảng 143 × 50px, CSS sau 142,5 × 50px. Nút nguy hiểm khoảng 143 × 53px, CSS 143 × 53px. Nút thông báo khoảng 275 × 52px, CSS 274 × 52px. Nút lỗi khoảng 145 × 45px, CSS 144 × 46px. Vùng viền ảnh lấy từ các pixel tối liên thông; sai số khoảng 1px ở mép khử răng cưa.

## Chưa giống và chưa duyệt

- Dáng chữ Nunito tròn hơn chữ AI; nét, dấu tiếng Việt và tỷ lệ từng ký tự vẫn khác. Khớp chiều rộng cả dòng không chứng minh khớp từng glyph. Ví dụ nội dung thông báo cao 33px so với khoảng 30px trong ảnh.
- Icon check/cảnh báo/info/Wi-Fi dựng CSS còn khác độ tròn đầu nét và đường cong. Chưa coi icon là bản sao chính xác.
- Ảnh có viền, gradient và phản sáng mềm, không đều; CSS dùng hình học và gradient đều. Cạnh sáng, mép nút và độ chuyển bóng vẫn khác khi phóng lớn.
- Chính ảnh AI thay đổi một số chi tiết nền lobby, nhất là tia trang trí cạnh popup thông báo. Preview dùng concept S2 gốc nên phần nền này vẫn khác; không phải lỗi CSS modal.
- Đây là artboard cố định phục vụ đối chiếu, không phải chứng nhận modal dùng được với nội dung tùy ý hoặc font phóng 200% trong game.

## Bằng chứng kiểm tra

- Đã xem ảnh cạnh nhau phóng 2× cho cả bốn mẫu sau sửa; kiểm lại vị trí chữ, lớp viền, mép nút và highlight.
- Kiểm bốn mẫu ở width 360/390/520: không tràn/cắt nhãn, chuyển ảnh/CSS/chồng ảnh hoạt động.
- Kiểm pending khóa nút phụ và phục hồi; không có JavaScript exception; foreground modal không chứa SVG/image.
- Kiểm focus bàn phím cả bốn mẫu: một outline 2px, offset 3px, không chồng cạnh nổi; spinner dừng khi reduced motion; forced colors bỏ bóng.
- Ảnh chụp, số đo và script kiểm chỉ chạy local, không lưu trong repo. Các kết quả này không thay cho duyệt mỹ thuật của người dùng.
