# 09 — Kinh tế bàn 32 ô: giá thành phố, 3 cấp nhà, dòng tiền

Chốt ngày 19/10/2026. Dữ liệu nằm ở `logic/board.json`, `logic/cards.json`, `logic/constants.ts`. Luật chi tiết ở [05 §1, §4.4](./05-gameplay-rules-and-protocol.md).

## 1. Quyết định

| Hạng mục | Giá trị |
|---|---|
| Số ô | **32** (lưới 9 × 9: 4 góc + 7 ô mỗi cạnh) |
| Chiều đi | Xuất phát ở **góc dưới-trái**, đi **thuận kim đồng hồ**: lên cột trái → hàng trên → xuống cột phải → hàng dưới |
| Góc | 0 Xuất phát (dưới-trái) · 8 Nhà tù (trên-trái) · 16 Lễ hội (trên-phải) · 24 Du lịch (dưới-phải) |
| Ô đất | 16 thành phố Việt Nam, 8 nhóm × 2 thành phố |
| Ô khác | 4 sân bay · 4 Cơ hội · 3 Khí vận · 1 Thuế (10% tổng tài sản) · không còn tiện ích |
| Cấp nhà | 3 cấp: Cấp 1 Nhà → Cấp 2 Biệt thự → Cấp 3 Khách sạn |
| Vốn đầu | 1.500 tr |
| Qua Xuất phát | **+160 tr** (200 × 32/40 vì bàn ngắn hơn, qua Xuất phát thường hơn) |
| Mua lại đất | trả thuê xong được mua lại thành phố chưa lên Khách sạn, giá ×2 (đất + nâng cấp), trả cho chủ cũ — chốt 20/10/2026 |
| Thắng ngay | trọn 3 nhóm màu, trọn 4 thành phố một cạnh bàn, hoặc cả 4 sân bay |
| Giới hạn ván | 30 vòng hoặc 25 phút (kiểu ZingPlay), sau đó xếp theo tổng tài sản |
| Ô đặc biệt kiểu ZingPlay | Lễ hội: thuê 1 thành phố ×2 · Du lịch: lượt sau bay tới ô bất kỳ · Thuế 10% tài sản — chốt 20/10/2026, danh sách ô ở [10-board-tiles.md](./10-board-tiles.md) |

Ô cạnh tại màn 390 rộng 38 px (bàn 40 ô chỉ 29,6 px), đủ chỗ cho tên thành phố, tranh nhỏ và giá.

## 2. Vì sao bỏ bàn 40 ô

Mô phỏng 2.000 ván bot/cấu hình, 4 người, 20 vòng:

| Cấu hình | Ván có người gom đủ nhóm | Cấp nhà cả bàn cuối ván | Thuê trung bình/lần | Ván có người phá sản | Hạng 1 hơn hạng 2 |
|---|---|---|---|---|---|
| 40 ô cũ (nhóm 3 ô, 4 nhà + KS) | 36% | 2,7 | 27 tr | 5,5% | 10% |
| 32 ô nhưng nhóm vẫn 3 ô | 39% | 4,1 | 26 tr | 6% | 9% |
| **32 ô, nhóm 2 ô, 3 cấp (bản chốt)** | **77%** | **9,7** | **62 tr** | **40%** | **29%** |

Nguyên nhân gốc: v1 không có trao đổi đất và đấu giá, nên nhóm 3 ô gần như không ai gom đủ → không ai xây → tiền thuê bằng tiền lẻ, thắng thua do may mắn mua trúng đất đắt. Bỏ giới hạn vòng thì hơn nửa số ván 40 ô 4 người không kết thúc sau 200 vòng. Rút xuống nhóm 2 ô mới là thứ làm game có tương tác; giảm số ô chủ yếu để ô to hơn và bàn gọn hơn.

## 3. Bảng giá 16 thành phố

Giá tăng dần theo chiều đi. Thuê đất trống ×2 khi sở hữu trọn nhóm.

| Ô | Nhóm (màu) | Thành phố | Giá | Giá mỗi cấp | Đất trống | Cấp 1 · Nhà | Cấp 2 · Biệt thự | Cấp 3 · Khách sạn | Vốn tới cấp 3 |
|---|---|---|---|---|---|---|---|---|---|
| 1 | Bắc Trung Bộ (nâu) | Thanh Hóa | 60 | 50 | 6 | 40 | 145 | 320 | 210 |
| 3 | Bắc Trung Bộ (nâu) | Vinh | 80 | 50 | 8 | 45 | 160 | 340 | 230 |
| 5 | Tây Nguyên (xanh trời) | Buôn Ma Thuột | 100 | 50 | 10 | 50 | 180 | 380 | 250 |
| 7 | Tây Nguyên (xanh trời) | Đà Lạt | 120 | 50 | 12 | 60 | 200 | 400 | 270 |
| 9 | Miền Tây (hồng) | Cần Thơ | 140 | 100 | 14 | 85 | 310 | 660 | 440 |
| 11 | Miền Tây (hồng) | Phú Quốc | 160 | 100 | 16 | 90 | 320 | 690 | 460 |
| 13 | Nam Trung Bộ (cam) | Quy Nhơn | 180 | 100 | 18 | 100 | 340 | 720 | 480 |
| 15 | Nam Trung Bộ (cam) | Nha Trang | 200 | 100 | 20 | 105 | 360 | 750 | 500 |
| 17 | Di sản miền Trung (đỏ) | Hội An | 220 | 150 | 22 | 130 | 470 | 1.000 | 670 |
| 19 | Di sản miền Trung (đỏ) | Huế | 240 | 150 | 24 | 135 | 490 | 1.040 | 690 |
| 21 | Duyên hải Bắc Bộ (vàng) | Hạ Long | 260 | 150 | 26 | 145 | 500 | 1.060 | 710 |
| 23 | Duyên hải Bắc Bộ (vàng) | Hải Phòng | 280 | 150 | 28 | 150 | 520 | 1.100 | 730 |
| 25 | Thành phố biển (xanh lá) | Vũng Tàu | 300 | 200 | 30 | 175 | 630 | 1.350 | 900 |
| 27 | Thành phố biển (xanh lá) | Đà Nẵng | 320 | 200 | 32 | 180 | 650 | 1.380 | 920 |
| 30 | Đô thị đặc biệt (xanh đậm) | Hà Nội | 350 | 200 | 35 | 190 | 680 | 1.420 | 950 |
| 31 | Đô thị đặc biệt (xanh đậm) | TP. Hồ Chí Minh | 400 | 200 | 40 | 210 | 720 | 1.500 | 1.000 |

Tổng giá 16 thành phố 3.410 tr; cả bàn (thêm 4 sân bay × 200) 4.210 tr — gần gấp 3 vốn một người.

Ô còn lại: 4 ô Sân bay 6, 10, 22, 26 (mỗi cạnh một ô, lệch khỏi giữa cạnh — đổi chỗ 20/10/2026) giá 200, thuê 25 / 50 / 100 / 200 theo số sân bay sở hữu. Thuế (ô 12) = 10% tổng tài sản, làm tròn. Lễ hội nhân đôi thuê một thành phố (cộng dồn với ×2 trọn nhóm: đất trống trọn nhóm có Lễ hội = ×4 giá thuê gốc).

## 4. Công thức

Giá trị trong bảng §3 sinh từ công thức. Thuê các cấp làm tròn (dưới 200 → bội 5, từ 200 → bội 10), số đúng nửa bước thì làm tròn về **bội chẵn** (vd. Vinh cấp 3: 1,5 × 230 = 345 → 340):

- **Giá đất**: 2 thành phố mỗi nhóm, bước 20 tr (nhóm cuối 350/400).
- **Giá mỗi cấp** theo cạnh bàn: cột trái 50 · hàng trên 100 · cột phải 150 · hàng dưới 200.
- **Đất trống** = đúng 10% giá, không làm tròn.
- **Cấp n** = kₙ × (giá đất + n × giá mỗi cấp), với k₁ = 0,35 · k₂ = 0,90 · k₃ = 1,50.

Vì tính trên tổng vốn đã bỏ ra, mọi nhóm có cùng "tỷ suất": một lần khách đáp vào ô Khách sạn trả khoảng 1,5 lần số vốn chủ đã đổ vào ô đó; ô Nhà trả ~35%, Biệt thự ~90%. Nhóm đắt chỉ khác ở số tuyệt đối — thuê lớn hơn nhưng cũng tốn nhiều vốn hơn và khó gom đủ hơn vì nằm cuối bàn.

Hạ cấp hoàn 50% giá mỗi cấp. Thẻ sửa nhà tính theo **tổng số cấp** người rút đang có: ch10 25 tr/cấp, cm12 40 tr/cấp.

Hiển thị cấp trên ô: cấp 1 = 1 nhà xanh ngọc, cấp 2 = 2 nhà, cấp 3 = 1 khách sạn san hô (`MAX_HOUSES = 3`).

## 5. Kết quả mô phỏng — luật hiện tại (mua lại ×2, thắng ngay, Lễ hội / Du lịch / Thuế, 30 vòng / 25 phút)

1.000 ván bot mỗi cấu hình, chốt 20/10/2026 sau khi đổi 4 ô (Lễ hội, Du lịch, Thuế, thêm Cơ hội). Thời gian theo giả định ở cuối §5b. Cột "trước" là bàn ngay trước đó (Bãi đỗ xe, Vào tù, 2 tiện ích) cùng luật mua lại / thắng ngay / 4 sân bay. Sau khi dời 4 sân bay khỏi giữa cạnh (6, 10, 22, 26) chạy lại 1.000 ván: số vòng 18 / 16 / 15, online nhanh 6,6 / 8,9 / 10,9 phút, tỉ lệ các cách kết thúc lệch ≤ 2 điểm % — coi như không đổi.

| | 2 người | 3 người | 4 người |
|---|---|---|---|
| Thời gian · 1 người + máy (trung vị, 90% ván dưới) | 4,9 · < 7,7 phút | 5,9 · < 9,4 phút | 7,1 · < 10,7 phút |
| Thời gian · online, bấm nhanh | 6,6 · < 10,4 phút | 8,8 · < 13,2 phút | 11,1 · < 17,6 phút |
| Thời gian · online, bấm vừa (×1,4) | 8,3 · < 13,0 phút | 11,0 · < 16,5 phút | 14,0 · < 22,0 phút |
| Thời gian · online, bấm chậm (×1,8) | 10,0 · < 15,6 phút | 13,2 · < 19,9 phút | 16,8 · < 25 phút (chạm giới hạn) |
| Chạy thật trên Chrome (1 ván, máy tự bấm thay người) | 6,7 phút · phá sản | 9,2 phút · trọn 3 nhóm | 8,3 phút · trọn 3 nhóm |
| Chờ giữa 2 lượt của mình · 1 người + máy (trung vị, 90% dưới) | 5 · < 10 giây | 10 · < 17 giây | 16 · < 24 giây |
| Chờ giữa 2 lượt của mình · online, chơi nhanh | 10 · < 19 giây | 20 · < 34 giây | 30 · < 48 giây |
| Một lượt online (trung vị, 90% dưới) · trong đó animation | 10 · < 19 giây · 3 giây | 10 · < 20 giây · 3 giây | 10 · < 19 giây · 3 giây |
| Số vòng (trung vị) · trước | 18 · 22 | 16 · 20 | 16 · 18 |
| Kết thúc vì: phá sản hết | 52% | 11% | 2% |
| · trọn 3 nhóm màu | 22% | 66% | 77% |
| · trọn một cạnh bàn | 10% | 14% | 13% |
| · cả 4 sân bay | 5% | 5% | 5% |
| · hết 30 vòng · trước | 10% · 24% | 5% · 12% | 3% · 8% |
| · hết 25 phút (bấm vừa · bấm chậm) | 0% · 0% | 0% · 0% | 4% · 12% |
| Lễ hội / Du lịch / Thuế mỗi ván (trung bình) | 1,6 / 1,4 / 1,4 | 2,1 / 1,8 / 1,8 | 2,8 / 2,3 / 2,3 |
| Lần mua lại / ván (trung bình) | 0,7 | 1,7 | 2,7 |
| Lần thuê lớn nhất (trung vị) | 135 tr | 400 tr | 690 tr |
| Hạng 1 hơn hạng 2 (trung vị) | 100% (đa số ván có người phá sản) | 49% | 49% |

So với bàn trước: ván ngắn hơn 2–4 vòng (~20% thời gian) và rất ít ván phải chơi hết 30 vòng, vì Du lịch cho phép bay thẳng tới ô cần để gom nhóm / chặn đối thủ / thắng ngay, Lễ hội làm tiền thuê đột biến, Thuế rút tiền của người giàu. Cách thắng không đổi tỉ lệ nhiều — vẫn chủ yếu là trọn 3 nhóm màu khi 3–4 người.

So với luật cũ (§5b): ván phân thắng bại rõ hơn hẳn (4 người: ~95% thắng ngay thay vì 90% phải chơi hết vòng). Bỏ giới hạn vòng ở luật cũ thì ~1/4 ván 4 người kẹt quá 300 vòng do các nhóm bị chia cho nhiều chủ; mua lại đất phá thế kẹt đó.

## 5b. Luật cũ — tham khảo (3.000 ván bot mỗi cấu hình, 20 vòng, chưa có mua lại / thắng ngay)

| | 2 người | 3 người | 4 người |
|---|---|---|---|
| Thời gian · 1 người + máy | 5,4 phút | 7,1 phút | 8,7 phút |
| Thời gian · online, chơi nhanh | 7,2 phút | 10,4 phút | 13,4 phút |
| Thời gian · online, chơi chậm (×1,8) | 10,5 phút | 15,1 phút | 19,2 phút |
| Ván có người gom đủ nhóm | 90% | 84% | 77% |
| Ván có người phá sản | 24% | 39% | 40% |
| Ván kết thúc sớm (còn 1 người) | 24% | 14% | 10% |
| Người phá sản đầu tiên (trung vị) | vòng 15 | vòng 15 | vòng 15 |
| Cấp nhà cả bàn cuối ván | 5,4 | 8,1 | 9,7 |
| Thuê trung bình / lần | 58 tr | 62 tr | 62 tr |
| Lần thuê lớn nhất (trung vị) | 100 tr | 340 tr | 400 tr |
| Tiền mặt / người · vòng 5 → 10 → 20 | 876 → 554 → 405 | 942 → 720 → 704 | 1.005 → 881 → 1.032 |
| Đất đã có chủ · vòng 5 → 10 → 20 | 33 → 53 → 73% | 46 → 69 → 88% | 56 → 80 → 95% |
| Tài sản hạng 1 / hạng 2 / hạng cuối | 2.570 / 1.947 | 3.002 / 2.162 / 1.592 | 3.450 / 2.295 / 1.365 |
| Hạng 1 hơn hạng 2 | 21% | 26% | 29% |

Dòng tiền mỗi ván 4 người (trung bình): vốn 6.000 · lương Xuất phát +2.786 · mua đất −4.251 · nâng cấp −1.265 · thẻ phạt −334 · tiền thuê chuyển giữa người chơi 1.853.

Nếu đổi `MAX_ROUNDS` xuống 15: online nhanh 5,6 / 8,1 / 10,4 phút (2 / 3 / 4 người), nhưng chỉ 13–25% số ván có người phá sản và hạng 1 hơn hạng 2 ~15–17% — ván kết thúc trước khi khách sạn kịp phát huy. Không giới hạn vòng: trung vị 30 / 36 / 41 vòng thì còn một người (74–98% số ván tự kết thúc), nên 20 vòng là điểm cắt hợp lý.

Giả định thời gian: bấm gieo 1,5 s, quyết định mua 4 s, bỏ qua 3,5 s, xác nhận thẻ 2,5 s, mỗi lần nâng cấp 2,5 s, chọn Lễ hội 4 s, chọn ô Du lịch 5 s, kết thúc lượt 1,5 s, thời gian ván = tổng animation mọi bước của mọi người (ai cũng xem cùng replay) + thời gian nghĩ của người đang tới lượt, mạng 0,15 s/nước, animation lấy đúng `STEP_MS` trong `store/useTycoon.ts`, bot nghĩ 0,65 s.

## 5c. Thời gian chờ khi chơi với người thật (online)

Mô phỏng 300 ván mỗi cấu hình, cùng giả định §5b. "Chờ" = từ lúc mình kết thúc lượt đến lúc tới lượt lại, gồm animation và thời gian người khác bấm. Mỗi thao tác có 30 giây (`TURN_SECONDS`), mỗi nước hợp lệ cấp lại 30 giây.

| Kịch bản | Ván (trung vị) | Chờ giữa 2 lượt của mình (trung vị · 90% dưới · lâu nhất) | Một lượt có nâng cấp (trung vị · 90% dưới) |
|---|---|---|---|
| 2 người, bấm bình thường | 6,5 phút | 10 · 19 · 42 giây | 19 · 34 giây (2,7 lần nâng) |
| 4 người, bấm bình thường | 10,7 phút | 30 · 48 · 88 giây | 23 · 34 giây (3,3 lần nâng) |
| 2 người, bấm chậm (×1,8) | 9,8 phút | 16 · 29 · 64 giây | 29 · 54 giây |
| 4 người, bấm chậm (×1,8) | 16,0 phút | 46 · 73 · 135 giây | 35 · 54 giây |

Một lần mua đất người khác phải chờ ~5 giây (nghĩ 4 s + animation trả tiền, mua 0,8 s); một lần nâng cấp ~3,3 giây (2,5 s + 0,8 s). Nâng cấp chỉ chiếm 8–9% thời gian ván — không phải nút thắt; phần lớn thời gian là gieo, đi và bấm kết thúc lượt.

Người treo máy: mỗi thao tác hết 30 giây, một lượt treo ≈ gieo 30 + mua/bỏ 30 + kết thúc 30 = **~90 giây**. Bản online loại người hết giờ 3 lần liên tiếp (05 §4.6), nên cả bàn chỉ phải chờ một lần như vậy. Bản chơi với máy không loại, nhưng chỉ có mình người chơi chờ chính mình.

**Đánh giá:**

- 2–3 người: chờ 10–20 giây, ổn.
- 4 người bấm bình thường: chờ ~30 giây, chấp nhận được nhưng ở ngưỡng; 10% số lần chờ gần 50 giây.
- 4 người có người bấm chậm: chờ ~46 giây, có lúc hơn 2 phút — dễ chán. Lý do chính: 30 giây được cấp lại sau **mỗi** thao tác, nên một người chậm có thể kéo một lượt (gieo → mua → nâng 3 lần → kết thúc) tới vài phút.

**Đề xuất (chưa làm):**

1. Đổi đồng hồ theo thao tác sang theo pha: gieo 10 s (hết thì tự gieo), mua / mua lại / Lễ hội / Du lịch 15 s, pha `manage` 20 s cho tất cả lần nâng cấp.
2. Nút "Nâng cấp tối đa" một chạm trong pha `manage`: nâng đều các nhóm trọn tới khi hết tiền hoặc chạm cấp 3 — gom 3 lần bấm thành 1.
3. Tuỳ chọn tự gieo khi tới lượt.
4. Bản online ghi log thời gian từng thao tác của người thật để thay các giả định ở §5b.

## 5d. Rà soát giá với luật hiện tại (20/10/2026)

1.000 ván bot mỗi cấu hình, luật đầy đủ (mua lại ×2, Lễ hội, Du lịch, Thuế, thắng ngay). Kết luận: **giữ nguyên bảng giá §3**.

| | 2 người | 4 người |
|---|---|---|
| Dòng tiền / ván | lương +1.557 · mua đất −2.793 · nâng cấp −930 · Thuế −263 · thẻ +126 | lương +2.542 · mua đất −3.778 · nâng cấp −1.816 · Thuế −431 · thẻ +236 |
| Tiền thuê chuyển tay / ván · mua lại / ván | 475 · 215 | 2.073 · 1.134 |
| Tiền mặt / người vòng 5 → 10 → 15 → 20 | 970 → 468 → 318 → 282 | 1.060 → 818 → 708 → 732 |
| Lần trả thuê: trung vị · 90% · 99% · lớn nhất | 28 · 320 · 720 · 1.380 | 28 · 380 · 1.000 · 1.500 |
| Thuế: lần / ván · trung bình mỗi lần | 1,4 · 191 | 2,3 · 189 |
| Lễ hội: lần có người trả thuê / ván · trung bình | 0,2 · 150 | 0,9 · 180 |
| Phá sản vì nợ ngân hàng (Thuế, thẻ) / 1.000 ván | 18 | 12 |

Theo nhóm (4 người): tỉ lệ có Khách sạn nâu / xanh trời / hồng / cam / đỏ / vàng / xanh lá / xanh đậm = 36 / 47 / 47 / 34 / 33 / 21 / 11 / 10%; người thắng sở hữu trọn nhóm đó 35 / 44 / 50 / 42 / 45 / 36 / 29 / 30%; tiền thuê thu về trên vốn bỏ ra 0,70 / 0,82 / 0,60 / 0,41 / 0,34 / 0,21 / 0,14 / 0,14. Sân bay: trọn 4 chỉ 9% số ván, thu về 0,28 vốn.

Nhận xét:

- **Dòng tiền ổn**: 4 người tiền mặt giữ quanh 700–1.000; 2 người cạn dần (~300 từ vòng 15) nên đa số ván 2 người kết thúc bằng phá sản — đúng ý đồ.
- **Nhóm rẻ mạnh hơn nhóm đắt**, rõ nhất ở 2 người (người thắng có xanh trời 54% so với xanh đậm 18%): ván giờ chỉ ~16–18 vòng, nhóm cuối bàn cần ~2.000 tr để lên Khách sạn nên hiếm khi kịp xây; luật thắng ngay 3 nhóm không phân biệt nhóm rẻ hay đắt. Ở 4 người lệch ít (30–50%).
- **Đã thử chỉnh giá, không đáng đổi** (600 ván mỗi phương án): giá nâng mỗi cấp theo cạnh 50/75/100/125 thay cho 50/100/150/200 → tỉ lệ Khách sạn nhóm đắt 12 → 18% (4 người) nhưng người thắng theo nhóm gần như không đổi; nén giá đất về 100–400 bước 20 → không đổi; làm cả hai → không đổi. Số vòng, tỉ lệ phân thắng bại giữ nguyên ±1 vòng / ±5%.
- **Lần trả lớn nhất** = Khách sạn TP. HCM 1.500 tr (bằng vốn đầu). Có Lễ hội thì tới 3.000 tr — một lần đáp là phá sản, nhưng Lễ hội hiếm khi trúng (≤ 0,9 lần thu / ván) nên chấp nhận như một khoảnh khắc kịch tính kiểu ZingPlay. Nếu thấy quá gắt: giới hạn Lễ hội chỉ cho ô dưới cấp 3, hoặc Lễ hội ×1,5.
- **Thuế 10%** ~190 tr / lần, hiếm khi làm phá sản — vừa phải.
- **Sân bay 200 tr** là khoản đầu tư kém (thu 0,28 vốn) nhưng giữ vai trò chặn / dọa thắng 4 sân bay; không cần đổi.
- **Mua lại ×2** chuyển ~1.100 tr / ván 4 người — động lực chính phá thế kẹt, giữ nguyên.

## 6. Các phương án đã thử

Cùng bàn 32 ô, 4 người, 20 vòng; chỉ đổi hệ số tiền thuê (k₁ / k₂ / k₃, đất trống):

| Bảng | Hệ số | Ván có phá sản | Kết thúc sớm | Thuê lớn nhất | Hạng 1 hơn hạng 2 |
|---|---|---|---|---|---|
| D | 0,20 / 0,50 / 0,85 · 8% | 19% | 1% | 290 | 19% |
| B | 0,25 / 0,60 / 1,00 · 8% | 26% | 3% | 350 | 21% |
| A | 0,30 / 0,75 / 1,25 · 8% | 34% | 8% | 420 | 26% |
| **C (chốt)** | **0,35 / 0,90 / 1,50 · 10%** | **41%** | **11%** | **470** | **30%** |

Đòn bẩy khi cần chỉnh:

- **k₃** (Khách sạn) quyết định độ "căng": tăng → nhiều phá sản, ván kết thúc sớm hơn.
- **Lương Xuất phát**: 200 làm tiền mặt cuối ván 4 người phình lên ~1.100; 160 giữ quanh mức đầu ván.
- **Số vòng**: chỉ đổi thời gian; dưới 15 vòng thì nâng cấp chưa kịp có tác dụng.

## 7. Kiểm tra tự động

`logic/economy.test.ts` chạy 300 ván bot với seed cố định cho 2 và 4 người, kiểm:

| | 2 người | 4 người |
|---|---|---|
| Ván gom được nhóm | > 85% | — |
| Ván phân thắng bại trước 30 vòng | > 60% | > 80% |
| Ván thắng ngay (3 nhóm / một cạnh / 4 sân bay) | — | > 70% |
| Ván có ít nhất một lần mua lại | > 30% | > 70% |
| Lần thuê lớn nhất (trung vị) | — | ≥ 300 tr |
| Hạng 1 hơn hạng 2 (trung vị) | — | > 25% |

Sửa giá trong `board.json` mà test đỏ nghĩa là cân bằng đã lệch khỏi bảng §5 — chạy lại mô phỏng trước khi nới dải.

## 8. Giới hạn

- Bot mua đất khi mua xong vẫn còn ≥ 120 tr và nâng cấp khi còn ≥ 240 tr; người thật có thể giữ tiền hoặc mạo hiểm hơn.
- Bot mua lại đất chỉ khi gom trọn nhóm (còn ≥ 120 tr) hoặc phá nhóm trọn của đối thủ (còn ≥ 360 tr); người thật mua lại nhiều hơn thì ván còn ngắn hơn.
- Bot tổ chức Lễ hội ở thành phố đang có tiền thuê cao nhất; khi Du lịch, bot bay tới ô giúp nó thắng ngay, rồi ô chặn đối thủ thắng ngay, ô gom trọn nhóm, ô trống mua được, tránh ô có chủ và ô Thuế. Người thật chọn kém hơn thì Du lịch ít tác dụng hơn mô phỏng.
- v1 không có trao đổi đất, đấu giá, thế chấp — nếu thêm ở v2 phải mô phỏng lại (trao đổi làm gom nhóm dễ hơn nhiều).
- Thời gian online là ước lượng theo giả định §5b, chưa đo người thật; thời gian chờ và đề xuất rút ngắn ở §5c.
