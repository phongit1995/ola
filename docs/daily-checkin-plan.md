# Plan: Điểm danh hằng ngày

Ngày lập: 19/11/2026 · Trạng thái: **server, admin, web, mobile đã code và chạy thử local 20/11 (chưa commit). Ảnh hộp quà và icon đã vẽ 20/11 (mục 10.3)** · Mock UI app: `~/Desktop/checkin-mock/index.html` (không commit)

Liên quan: [Vé loa](megaphone-feature-plan.md#15-vé-loa-plan--code-19112026) (đã xong, commit `72ee0c95c`) · [Thẻ VIP và khung khoá + có hạn](vip-frame-lock-expiry-plan.md) · [Nhiệm vụ](mission-feature-plan.md) (plan, chưa code)

## 1. Tóm tắt

- Lịch điểm danh chạy **theo tháng dương lịch**. Mỗi tháng có một lịch do admin tạo, **admin tự đặt số ô** (ví dụ 28), không vượt số ngày của tháng.
- Ô là **lần điểm danh thứ mấy trong tháng**: lần đầu là ô 1, mỗi ngày điểm danh một lần để đi tiếp 1 ô, nhận lần lượt từ ô 1. Ngày 1 mọi người về ô 1 của lịch tháng mới.
- **Nghỉ ngày nào không mất gì**: hôm sau vào nhận tiếp ô kế. Chỉ khi nghỉ quá nhiều, không còn đủ ngày trong tháng để đi hết, thì không tới được các ô cuối.
- **Ô cuối là ô bình thường**: ô nào là hộp đặc biệt do admin bật công tắc Đặc biệt. Nên đặt hộp đặc biệt lớn nhất ở ô cuối (cấu hình gợi ý ở mục 3) để ai muốn nhận phải điểm danh gần như hằng ngày. Tháng 30 ngày với lịch 28 ô thì được nghỉ 2 ngày.
- **Không phải ô nào cũng có quà.** Ô không có quà chỉ cần điểm danh để đi tiếp.
- Lưới chỉ hiện **hộp quà** (hộp thường hoặc hộp đặc biệt), không hiện quà bên trong. **Mở hộp mới biết được gì**. Ô đã mở hiện ảnh **hộp đã mở** + dấu ✓, lưới không lộ quà; bấm vào ô mới xem món đã nhận.
- **Quà random**: mỗi hộp có 1 tới 5 quà, mỗi quà có danh sách món kèm tỉ lệ và bốc ra 1 món. Mở hộp nhận đủ các quà, luôn có quà.
- **Hộp nào có quà cũng có nhiệm vụ**, ô chỉ điểm danh thì không có nhiệm vụ. Bấm Điểm danh xong mới hiện nhiệm vụ, **làm xong nhiệm vụ mới mở được hộp**. Admin chọn nhiệm vụ cho từng hộp, hoặc để **Ngẫu nhiên** cho mỗi người bốc một nhiệm vụ.
- **Cần VIP** do admin bật cho từng hộp (công tắc **Có VIP để mở**): vẫn điểm danh được, nhưng phải có VIP lúc bấm **Mở quà**.
- **Xác thực email** (công tắc trong cài đặt, mặc định bật): bật thì chưa xác thực email không điểm danh được.
- Hộp chưa mở được trong ngày (chưa làm nhiệm vụ, chưa có VIP) thì **qua 0h mất hộp ô đó**, hôm sau đi tiếp ô kế.
- **Tháng nào admin chưa tạo lịch, hoặc lịch còn nháp chưa phát hành, thì tháng đó tắt điểm danh.**
- Thẻ VIP và khung phát ra luôn **khoá** (không chuyển được), vé loa cũng không chuyển được, nên nuôi nhiều nick không gom được đồ về nick chính. Chỉ ngày VIP chuyển được, nên giữ ở mức nhỏ.

## 2. Luật

### 2.1 Lịch tháng

| Hạng mục | Luật |
|---|---|
| Lịch | Mỗi tháng dương lịch (giờ VN) một lịch riêng |
| Số ô | Admin đặt lúc tạo lịch, từ 1 tới số ngày của tháng, mặc định 28. Số ô nhỏ hơn số ngày thì có ngày được nghỉ mà vẫn tới ô cuối |
| Ô | Ô 1 là lần điểm danh đầu tiên trong tháng, mỗi lần điểm danh đi tiếp đúng 1 ô. Không nhảy cóc, không chọn ô |
| Mỗi ngày | Điểm danh **1 lần**, ngày tính theo 0h giờ VN ở phía server |
| Nghỉ | Không vào thì **đứng yên ở ô cũ**, không mất ô nào. Hôm sau điểm danh tiếp ô kế |
| Đi hết lịch | Điểm danh tới ô cuối là **đã điểm danh đủ**: các ngày sau không còn ô, popup không hiện. Hôm điểm danh ô cuối mà hộp còn chờ (chưa làm nhiệm vụ, chưa có VIP) thì **hộp chờ luôn hiện trước**: vẫn có nút Đi làm / Mở quà như mọi ngày. Chỉ khi hộp đã mở hoặc đã mất mới hiện "Đã điểm danh đủ 28/28 ô". Không dùng câu "nhận đủ quà" vì người từng mất hộp chưa nhận đủ |
| Sang tháng | 0h ngày 1 mọi người về ô 1 của lịch tháng mới. Ô chưa tới của tháng cũ bỏ luôn |
| Vào giữa tháng | Bắt đầu từ ô 1 như mọi người. Còn bao nhiêu ngày thì đi được bấy nhiêu ô |
| Tháng chưa có lịch | Chưa tạo lịch, hoặc lịch còn **nháp**, thì tháng đó **tắt điểm danh** (ẩn dòng Điểm danh và popup). Lịch tạo ra luôn là nháp, admin bấm **Phát hành** mới chạy. Phát hành giữa tháng thì mở từ lúc phát hành, ai cũng bắt đầu từ ô 1 |
| Sửa lịch | Lịch nháp và lịch tháng sau sửa được mọi ô. Tháng đang chạy (đã phát hành) **khoá các ô có thể đã có người nhận**: ô 1 tới ô K, K = số ngày từ ngày lịch bắt đầu chạy (ngày 1 nếu phát hành trước tháng, hoặc ngày phát hành nếu phát hành giữa tháng) tới hôm nay, tính cả hôm nay. Ví dụ lịch phát hành từ tháng trước, hôm nay 19/11 thì ô 1–19 khoá, chỉ sửa được ô 20 trở đi. Lịch nháp không khoá ô nào, nên tháng đầu tiên admin tạo nháp, nhập đủ các ô rồi mới phát hành. Ô khoá không sửa và không đổi chỗ được. Ai đã điểm danh ô đó giữ đúng cấu hình lúc điểm danh. Số ô của tháng đang chạy **chỉ được tăng** (giảm sẽ cắt mất ô của người đã đi xa), lịch nháp đổi tự do. Phát hành rồi không quay lại nháp được. Tháng đã qua chỉ xem |

**Ví dụ tháng 11 (30 ngày), lịch 28 ô:**

| Ngày thật | Ô | Ghi chú |
|---|---|---|
| 01/11 | ô 1 | |
| 02/11 | ô 2 | |
| 03/11 | — | nghỉ, không mất gì, vẫn đứng ở ô 2 |
| 04/11 | ô 3 | |
| … | … | |
| 16/11 | — | nghỉ lần 2, từ giờ không nghỉ thêm được nữa nếu muốn tới ô 28 |
| … | … | |
| 30/11 | ô 28 | nghỉ 2 ngày vẫn tới ô cuối (theo cấu hình gợi ý là hộp đặc biệt lớn nhất tháng) |
| 01/12 | ô 1 | lịch tháng 12 |

**Người vào ngày 15/11, cùng lịch 28 ô:** 15/11 là ô 1, 16/11 ô 2 … 30/11 là ô 16. Ô 17–28 hiện "không kịp". Tháng 12 bắt đầu lại từ ô 1 như mọi người.

### 2.2 Hộp quà ẩn và quà random

| Hạng mục | Luật |
|---|---|
| Lưới | Ô có quà hiện hộp: **hộp thường**, hoặc **hộp đặc biệt** (vàng, to hơn) ở ô admin bật Đặc biệt. **Ô không có quà chỉ hiện số ô**, đã điểm danh thì thêm ✓ |
| Trước khi mở | Không biết bên trong. Bấm vào ô chưa mở thì hiện "Hộp quà bí mật", số ô, và **Cần VIP** nếu có. **Nhiệm vụ không hiện trước**, chỉ hiện sau khi điểm danh |
| Mở hộp | Hiệu ứng mở hộp, rồi popup "Bạn nhận được …" |
| Sau khi mở | Ô đổi sang ảnh hộp đã mở + ✓, không hiện món trên lưới. Bấm vào ô xem đủ các món đã nhận. Hiệu ứng mở hộp vẫn hiện món đẹp nhất (khung > thẻ VIP > vé loa > ngày VIP > KEN) |
| Hộp mất | Hộp xám, không lộ quà bên trong |
| Random | Mỗi ô có **1 tới 5 quà**. Mỗi quà có **danh sách món riêng** kèm tỉ lệ % (tổng 100%), các quà bốc độc lập. Mở hộp nhận **đủ các quà, mỗi quà 1 món**. Muốn quà cố định thì để danh sách 1 món 100%. Ví dụ ô 7: Quà 1 = 60% thẻ VIP 3 ngày · 40% khung 7 ngày, Quà 2 = 70% 1 vé loa · 30% 2 vé loa → mở hộp nhận 2 món, ví dụ khung 7 ngày + 1 vé loa |
| Luôn có quà | Không có dòng "không có gì". Hộp đã mở được là chắc chắn có quà |
| Bốc lúc nào | Lúc mở hộp, server bốc theo bảng tỉ lệ đã chụp lúc điểm danh. Kết quả lưu lại, bấm lại hay mất mạng gửi lại cũng không bốc lại |
| Ẩn cả ở API | API **không trả** bảng quà và nhiệm vụ của ô chưa mở. Chỉ ẩn ở giao diện thì xem network là thấy hết. Admin thấy đủ |
| Tỉ lệ | Không hiện trong app. Hộp miễn phí, không bán bằng tiền hay KEN. Hộp cần VIP là quyền lợi VIP (có VIP mới nhận được thưởng), không phải mua để mở: hộp thoại Cần VIP **không có nút Mua VIP** (mục 2.5) để không bị hiểu là mua để mở quà ngẫu nhiên. Chưa khẳng định chắc là được miễn công bố tỉ lệ: trước khi phát hành mobile đối chiếu lại Apple §3.1.1 và chính sách Google Play về vật phẩm ngẫu nhiên, store hỏi thì hiện tỉ lệ cho hộp cần VIP |

### 2.3 Mở hộp

| Hạng mục | Luật |
|---|---|
| Ô không có quà | Bấm **Điểm danh** chỉ hiện "Đã điểm danh" kèm "Hộp quà tiếp theo: ô 19". Vẫn phải điểm danh để đi tiếp. Popup vẫn tự hiện như ngày có quà |
| Ô có hộp | Bấm **Điểm danh** xong hiện nhiệm vụ của hộp (mục 2.4). Làm xong nhiệm vụ, đủ VIP nếu hộp cần VIP thì mới mở được |
| Trong ngày | Hộp chỉ mở được trong **đúng ngày** điểm danh ô đó. Qua 0h chưa mở là **mất hộp ô đó**, hôm sau đi tiếp ô kế |
| Không treo | Không có hộp treo, không mở lại ô cũ, không điểm danh bù |
| Một lần | Mỗi hộp mở một lần, nhận đủ các món đã bốc (mỗi quà 1 món) |

### 2.4 Nhiệm vụ của hộp quà

**Hộp nào có quà cũng có đúng 1 nhiệm vụ. Ô không có quà không có nhiệm vụ**, chỉ cần điểm danh.

Flow: **điểm danh trước → hiện nhiệm vụ → làm xong → mở hộp.**

1. Trên lưới chưa biết nhiệm vụ của hộp là gì.
2. User bấm **Điểm danh**. Ô tiến lên như mọi ngày.
3. Lúc này mới hiện "Nhiệm vụ hôm nay: Đăng 1 bài Me" kèm nút **Đi làm** mở thẳng chỗ cần làm. Hộp khoá. Dòng Điểm danh và tab Cá nhân có chấm đỏ.
4. Nếu từ 0h hôm nay user đã làm việc đó rồi thì hiện "Đã xong nhiệm vụ" và hộp mở luôn.
5. Làm xong, quay lại màn Điểm danh: nút **Mở quà** sáng lên (server báo `canOpen`). Chưa làm thì chỉ có nút **Đi làm**.
6. Qua 0h chưa làm thì mất hộp ô đó, hôm sau đi tiếp ô kế.

- Nhiệm vụ của hộp do admin chọn, bắt buộc với ô có quà: **một nhiệm vụ cụ thể**, hoặc **Ngẫu nhiên**. Ngẫu nhiên: lúc điểm danh server bốc 1 nhiệm vụ trong **danh sách nhiệm vụ ngẫu nhiên** (admin chọn ở tab Cài đặt), mỗi người một nhiệm vụ, giữ nguyên tới 0h, không đổi được.
- Danh sách ngẫu nhiên mặc định **bỏ các nhiệm vụ tốn KEN** (tặng quà, phát loa) để không ép user tiêu tiền mới mở được hộp.
- Chỉ giao nhiệm vụ mà nền tảng đang điểm danh làm được: Truyện, Khoảnh khắc, Tặng quà, Loa đang tắt cho nền tảng/phiên bản app đó (theo `X-Platform`, `X-App-Version`) thì server bỏ nhiệm vụ tương ứng khỏi danh sách bốc. Ô đặt nhiệm vụ cụ thể mà nền tảng không làm được thì bốc ngẫu nhiên trong các nhiệm vụ làm được. Danh sách ngẫu nhiên của admin không còn nhiệm vụ nào làm được thì bốc trong danh sách mặc định (luôn còn các nhiệm vụ Me).
- Làm nhiệm vụ trước hay sau khi điểm danh đều được, miễn trong cùng ngày (tính từ 0h VN). Ô Ngẫu nhiên chỉ biết nhiệm vụ sau khi điểm danh, nhưng việc đã làm từ 0h vẫn được tính.
- Hộp có thể kèm **Cần VIP**.
- Server tự kiểm tra trong dữ liệu sẵn có, user không cần báo đã làm. Danh sách nhiệm vụ ở mục 5.

### 2.5 Hộp cần VIP

Admin bật **Có VIP để mở** cho từng hộp, app hiện là **Cần VIP**. Trên lưới hộp cần VIP trông như hộp thường (không có vương miện), bấm vào ô mới hiện **Cần VIP**; tới ngày đó thẻ Hôm nay cũng báo Cần VIP. Điểm danh **luôn được**, ô vẫn tiến lên. VIP chỉ xét **lúc bấm Mở quà**.

1. Chưa làm nhiệm vụ thì chỉ có nút **Đi làm**.
2. Làm xong nhiệm vụ mà đang có VIP → hộp mở luôn.
3. Làm xong nhiệm vụ mà chưa có VIP → hiện nút **Mở quà**. Bấm vào thì hộp thoại "Hộp này dành cho VIP" chỉ có nút **Đóng**, **không có nút Mua VIP** (mục 2.2, Tỉ lệ).
4. Có VIP trong ngày (tự vào màn VIP, được tặng, mã quà…) rồi bấm **Mở quà** lại → mở được.
5. Qua 0h vẫn chưa mở → mất hộp ô đó. Hôm sau có VIP cũng không mở lại.

### 2.6 Xác thực email

Công tắc **Xác thực email** ở tab Cài đặt của admin, **mặc định bật**:

| Công tắc | Luật |
|---|---|
| Bật | Chưa xác thực email thì **không điểm danh được**: popup và màn Điểm danh vẫn hiện nút **Điểm danh** như thường, bấm vào thì server trả `CHECKIN_EMAIL_NOT_VERIFIED` và app mở hộp thoại xác thực email (câu hướng dẫn + nút Xác thực email), ô không tiến lên. Xác thực xong điểm danh bình thường |
| Tắt | Ai cũng điểm danh được |

- Chỉ xét lúc bấm Điểm danh. Đã điểm danh rồi thì mở hộp không xét email nữa (kể cả khi admin bật công tắc giữa ngày).
- Dùng cột `users.email_verified` có sẵn, giống mã quà tặng (`requireEmailVerified`, cũng mặc định bật).
- Nút **Xác thực email** mở thẳng chỗ xác thực email ở Trang cá nhân, kèm câu hướng dẫn đang dùng cho mã quà tặng ("Cá nhân → Trang cá nhân → Email → Xác thực").

### 2.7 Loại quà

| Quà | Ghi chú |
|---|---|
| Ngày VIP | Cộng thẳng vào hạn VIP |
| Thẻ VIP | Luôn **khoá**, có hạn hoặc vĩnh viễn. Mỗi lần phát tạo thêm 1 thẻ mới, giống vòng quay và đập trứng |
| Khung avatar | Luôn **khoá**, có hạn hoặc vĩnh viễn. **Phát vào kho như mọi nguồn khác**, không bỏ qua: đã có bản có hạn thì cộng dồn hạn; đã có bản vĩnh viễn mà quà là bản có hạn thì thêm bản có hạn nằm cạnh (kho khung cho phép cùng lúc 1 bản vĩnh viễn + 1 bản có hạn của cùng khung); quà vĩnh viễn mà đã có bản vĩnh viễn thì không thêm dòng mới. Hộp vẫn tính đã mở và kết quả vẫn ghi món đó, nên **mở hộp luôn có quà** và ô luôn có ảnh |
| Vé loa | Hạn tính bằng ngày, để 0 là không hạn. Luật dùng vé theo [plan vé loa](megaphone-feature-plan.md#15-vé-loa-plan--code-19112026) |
| KEN | Cộng thẳng vào số dư KEN, tối đa 10.000 KEN mỗi món. Admin chọn **Cố định** (nhập một số) hoặc **Ngẫu nhiên** (nhập khoảng, mặc định 100–1.000): ngẫu nhiên bốc một số tròn 100 trong khoảng, mỗi mức có cơ hội như nhau (100–1.000 là 10 mức, mỗi mức 10%, trung bình 550 KEN). Lịch sử KEN ghi loại mới **Điểm danh**. KEN chuyển được và tiêu được (tặng quà, chuyển KEN), nên là món dễ bị nuôi nick gom nhất |
| Điểm hoạt động | Chỉ bật khi đã có tính năng Nhiệm vụ |

### 2.8 Nơi vào và nền tảng

| Hạng mục | Luật |
|---|---|
| Popup | **Tự hiện** khi mở app lần đầu trong ngày mà chưa điểm danh (và tháng chưa đi hết lịch). Đã điểm danh mà hộp còn chờ nhiệm vụ thì **không hiện lại**, chỉ có chấm đỏ. Admin tắt được ở tab Cài đặt, user không tự tắt. Thứ tự với các popup khác ở mục 10.2 |
| Dòng Điểm danh | Trong danh sách tab Cá nhân, ngay sau **Thông tin cá nhân**, phụ đề "Hôm nay chưa điểm danh" / "Còn hộp quà chưa mở" / "Đã điểm danh đủ tháng 11". "Còn hộp quà chưa mở" luôn ưu tiên hơn "Đã điểm danh đủ" |
| Chấm đỏ | Ở **dòng Điểm danh** và **icon tab Cá nhân** trên thanh dưới, khi chưa điểm danh hoặc hộp hôm nay chưa mở được (chờ nhiệm vụ hoặc VIP) |
| Nền tảng | Web + Android + iOS, bật/tắt theo nền tảng trong admin, thêm công tắc tổng **mặc định tắt**. Điểm danh chỉ chạy khi công tắc tổng bật, nền tảng bật **và** tháng hiện tại đã phát hành lịch. App cũ không có điểm danh, không lỗi gì |

### 2.9 Quyết định khác

| Hạng mục | Chốt |
|---|---|
| Chuyên cần | **Không có.** Nghỉ ngày nào cũng không bị phạt. Muốn thưởng người điểm danh đều thì admin đặt hộp đặc biệt ở các ô cuối (cấu hình gợi ý đặt ở ô cuối), chỉ người điểm danh gần như hằng ngày mới tới |
| Nuôi nick | **Không chặn** nick mới, không có điều kiện tuổi tài khoản. Ngày VIP chuyển được (Chuyển NSD) và KEN chuyển được nên chỉ để số nhỏ, tỉ lệ thấp. Quà lớn dồn vào thẻ VIP, khung, vé loa (khoá, có hạn, không chuyển được) |
| Với tính năng Nhiệm vụ | Khi làm Nhiệm vụ, điểm danh **vẫn là dòng riêng** và popup riêng, không gộp vào màn Nhiệm vụ |
| Bài Me riêng tư | Nhiệm vụ đăng bài Me tính **cả bài "Chỉ mình tôi"** |

### 2.10 Ngoài phạm vi (để sau)

- Điểm danh bù, push nhắc chưa điểm danh, thưởng ×2 cho VIP.
- Đổi nhiệm vụ khác, nhiều nhiệm vụ trong một ô.
- Bảo hiểm quà (mở N hộp chưa ra món hiếm thì chắc chắn ra), hiện tỉ lệ trong app.
- Nhiệm vụ gửi tin nhắn 1-1 hoặc trong phòng: tin nhắn nằm ở ScyllaDB, không đếm theo ngày được, phải chờ bộ đếm `Tracker` của [plan Nhiệm vụ](mission-feature-plan.md).
- Vé loa từ vòng quay, đập trứng.

## 3. Cấu hình gợi ý cho một tháng

Admin tạo lịch tháng bằng **chép từ tháng khác** hoặc **để trống rồi tự nhập**, và nhập số ô `N` (mặc định 28). **Không có mẫu dựng sẵn**: mã thẻ VIP và khung khác nhau giữa local, dev và prod, mà ô chỉ lưu được khi mọi món đã chọn đủ thẻ VIP / khung (mục 9). Bảng dưới là cấu hình gợi ý cho tháng đầu tiên, admin tự nhập từng ô theo, các tháng sau chép lại. Với `N = 28` có 12 ô có hộp (8 hộp thường + 4 hộp đặc biệt), các ô còn lại chỉ điểm danh. `N` nhỏ hơn thì bỏ các ô vượt `N`, vẫn đặt hộp đặc biệt lớn nhất ở ô `N`.

| Ô | Hộp | Quà (mỗi quà bốc 1 món) | Điều kiện |
|---|---|---|---|
| 3, 5, 10, 12, 17, 19, 24, 26 | thường | 1 quà: 40% 1 vé loa · 25% thẻ VIP loại thấp 3 ngày · 25% khung 3 ngày · 10% 1 ngày VIP | nhiệm vụ: Ngẫu nhiên |
| 7 | đặc biệt | Quà 1: 60% thẻ VIP loại giữa 3 ngày · 40% khung 7 ngày. Quà 2: 70% 1 vé loa · 30% 2 vé loa | nhiệm vụ: Ngẫu nhiên |
| 14 | đặc biệt | Quà 1: 60% khung 7 ngày · 40% thẻ VIP loại giữa 7 ngày. Quà 2: 70% 1 ngày VIP · 30% 2 ngày VIP | nhiệm vụ: Đăng 1 bài Me |
| 21 | đặc biệt | Quà 1: 50% thẻ VIP loại giữa 7 ngày · 30% khung 7 ngày · 20% thẻ VIP loại cao 7 ngày. Quà 2: 2 vé loa (cố định) | cần VIP, nhiệm vụ: Ngẫu nhiên |
| N (ô cuối) | đặc biệt, quà lớn nhất | Quà 1: 40% khung hiếm 15 ngày · 40% thẻ VIP loại cao 15 ngày · 20% khung hiếm 30 ngày. Quà 2: 50% 2 ngày VIP · 50% 3 vé loa | nhiệm vụ: Ngẫu nhiên |
| còn lại | không có hộp | chỉ điểm danh (khi có tính năng Nhiệm vụ thì cho điểm hoạt động) | không có nhiệm vụ |

Vé loa có hạn 7 ngày. Mọi hộp đều có nhiệm vụ (bắt buộc), chỉ ô 21 cần VIP. Không có KEN, admin tự thêm nếu muốn.

## 4. Ví dụ màn hình

Mock đầy đủ ở `~/Desktop/checkin-mock/index.html`. Tháng 11, lịch 28 ô, hôm nay 18/11, đã nghỉ 1 ngày, đã điểm danh 16 lần, hôm nay là ô 17:

```
┌ Điểm danh                          Còn 05:12:30 ┐
│ Tháng 11 · Đã điểm danh 16/28  Còn nghỉ được 1  │
│                                                  │
│   1✓   2✓  🎁3✓  4✓  🎁5✓  6✓  🎁★7✓             │
│   8✓   9✓ 🎁10✗ 11✓ 🎁12✓ 13✓ 🎁★14✓             │
│  15✓  16✓ [🎁17]  18  🎁19   20  🎁★21👑          │
│  22   23  🎁24   25  🎁26   27  🎁★28             │
│                                                  │
│  Hôm nay · Ô 17 · Hộp quà bí mật                 │
│                  [ Điểm danh ]                   │
└──────────────────────────────────────────────────┘
```

- Số trơn: ô không có quà, chỉ điểm danh · 🎁 hộp chưa mở · ★ hộp đặc biệt · ✓ đã điểm danh (ô có hộp thì hiện ảnh hộp đã mở) · ✗ hộp mất (hết ngày chưa làm nhiệm vụ hoặc chưa có VIP) · 🔒 không kịp (không còn đủ ngày trong tháng để tới). Hộp chưa nhận của hôm nay (`today`, `pending`) lắc nhẹ khoảng 0,6 giây rồi nghỉ 2 giây, lặp lại. Không có dấu cần VIP trên lưới
- Ô cuối hiện như mọi ô, là hộp thường hay hộp đặc biệt theo cờ Đặc biệt admin đặt.
- Dòng trên ghi "Đã điểm danh X/N" để không bị đọc nhầm số ô là ngày trong tháng, kèm "Còn nghỉ được K ngày" (vẫn tới ô cuối), "Nghỉ thêm là không tới ô N", hoặc "Không kịp ô N".
- Hộp nào cũng có nhiệm vụ nên lưới không cần dấu nhiệm vụ. Tên nhiệm vụ chỉ hiện sau khi bấm Điểm danh.
- Bấm ô đã qua thì hiện ngày thật đã điểm danh ("Điểm danh 15/11").

## 5. Danh sách nhiệm vụ

Không cần bộ đếm. Lúc điểm danh, lúc GET và lúc bấm Mở quà, server chạy một câu `EXISTS ... LIMIT 1` "hôm nay (từ 0h VN) user đã làm chưa" trên bảng có sẵn ở Postgres.

| Mã | Tên hiện cho user | Kiểm tra | Nút Đi làm mở | Ngẫu nhiên mặc định |
|---|---|---|---|---|
| `me_post` | Đăng 1 bài Me | `me.author_id`, `clan_id IS NULL`, `enabled = true` (chưa bị ẩn). Tính **mọi chế độ**, kể cả "Chỉ mình tôi" | khung đăng bài Me | có |
| `me_comment` | Bình luận 1 bài Me | `me_comments.author_id` | tab Me | có |
| `me_react` | Thả cảm xúc 1 bài Me | `me_reactions.user_id`, theo `updated_at` (đổi Thích sang Không thích ở bài cũ cũng tính, bỏ cảm xúc thì dòng bị xoá nên không tính) | tab Me | có |
| `moment_post` | Đăng 1 khoảnh khắc | `moments.author_id`, chưa xoá | tạo khoảnh khắc | có |
| `moment_comment` | Bình luận 1 khoảnh khắc | `moment_comments.author_id` | danh sách khoảnh khắc | có |
| `story_comment` | Bình luận 1 truyện | `story_comments.author_id` | tab Truyện | có |
| `send_gift` | Tặng 1 món quà | `gift_transactions.sender_id` | tab Cá nhân (chọn người để tặng) | không (tốn KEN) |
| `send_megaphone` | Phát 1 loa (cả loa dùng vé) | `megaphones.sender_id`, `type = 'message'` | màn Loa | không (tốn KEN) |
| `play_game` | Chơi xong 1 ván game online | Cùng luật với lịch sử game (`MatchHistory`): `constants.GameMatchHasUserCondition` (ván 2 người theo `player0_id` / `player1_id`, ván 3–4 người qua `game_match_players`), `status = 'finished'`, `reason <> 'void'`, chưa xoá, `finished_at` trong ngày. Ván tập với máy chạy ở client nên không tính | tab Game | có |

- Thêm nhiệm vụ mới = thêm 1 dòng trong registry ở code (mã + câu query + đích nút Đi làm + có vào danh sách ngẫu nhiên mặc định không) và tên i18n. Admin thấy ngay trong dropdown và trong danh sách ngẫu nhiên.
- Kiểm tra index `(author_id/user_id/sender_id, created_at)` của từng bảng, thiếu thì thêm trong migration điểm danh.
- **Mọi mốc ngày, tháng đều tính theo giờ VN** (0h VN, ngày 1 của tháng theo giờ VN). Chỉ cách so trong code cần để ý: `me`, `me_comments`, `me_reactions` lưu `created_at` kiểu `timestamp without time zone` (DB ghi theo giờ UTC), các bảng còn lại là `timestamptz`. Server ép `time.Local = time.UTC` lúc khởi động (`cmd/api/main.go`), nên GORM ghi các cột này theo giờ UTC ở mọi môi trường. Code tính mốc 0h VN rồi truyền vào câu query bằng `.In(time.Local)` (0h VN ngày 19/11 chính là 17:00 UTC ngày 18/11), không so bằng chuỗi ngày. Giờ đọc ra từ các cột này cũng hiểu theo `time.Local` (`checkin.task.go`). Test việc làm lúc 23:30 và 00:30 giờ VN ở cả hai loại bảng.
- Có thể lách bằng cách đăng rồi xoá sau khi mở hộp. Chấp nhận, vì quà khoá và có hạn.

## 6. Trạng thái một ô

### 6.1 Khi bấm Điểm danh (một transaction)

1. Tháng hiện tại chưa có lịch, lịch còn nháp, hoặc nền tảng tắt → `CHECKIN_DISABLED`.
2. Công tắc xác thực email đang bật mà user chưa xác thực → `CHECKIN_EMAIL_NOT_VERIFIED`.
3. Mỗi lần bấm client sinh một `clientRequestId` mới, gửi lại (mất phản hồi, mạng chập chờn) thì dùng lại mã cũ. Mã đã có dòng → trả kết quả của dòng đó, không tính thêm lượt, kể cả khi lượt đó là của hôm trước (bấm 23:59:50, gửi lại 00:00:10 vẫn chỉ 1 lượt, hôm sau user bấm lại bằng mã mới mới điểm danh ngày mới).
4. Đã có dòng của hôm nay → trả trạng thái hiện tại, không làm gì thêm (bấm 2 lần hay 2 máy cũng không cộng 2 ô).
5. Tính ô: dòng mới nhất của user **trong tháng này** có `slot = k` → ô `k + 1`; chưa có dòng nào trong tháng → ô 1. Ô vượt số ô của tháng → `CHECKIN_COMPLETED` (đã đi hết lịch).
6. Ô không có quà → `none`, xong.
7. Ô có quà: chốt nhiệm vụ vào cột `task` (ô Ngẫu nhiên thì bốc trong danh sách ngẫu nhiên lúc này, chỉ trong các nhiệm vụ nền tảng làm được, mục 2.4). Cấu hình ô đọc thẳng từ DB trong transaction (không lấy bản cache lịch tháng, tránh chụp nhầm cấu hình cũ khi admin vừa sửa ô). Chụp cấu hình ô (các quà + cờ) vào `reward_snapshot`, ghi `vip_at_checkin`.
8. Nhiệm vụ đã làm từ 0h và có VIP (nếu hộp cần VIP) → bốc mỗi quà 1 món và phát (`claimed`), ghi kết quả vào `reward_result`.
9. Còn lại → `pending`.

### 6.2 Khi bấm Mở quà

Chạy trong transaction có `ledger.LockUser`, nên 2 máy cùng bấm sẽ chạy lần lượt.

| Dòng hôm nay | Kết quả |
|---|---|
| `pending`, nhiệm vụ chưa làm | lỗi `CHECKIN_TASK_NOT_DONE` |
| `pending`, hộp cần VIP mà chưa có VIP (xét `vip_end_time > now` lúc bấm) | lỗi `CHECKIN_VIP_REQUIRED`, app hiện hộp thoại "Hộp này dành cho VIP", không có nút Mua VIP |
| `pending`, đủ điều kiện | bốc mỗi quà 1 món theo `reward_snapshot` và phát → `claimed`, trả quà vừa nhận |
| `claimed` | trả **200 cùng kết quả đã phát**, không bốc lại, không phát lại. Máy thứ hai bấm cùng lúc, hoặc một máy gửi lại sau khi mất phản hồi, đều thấy đúng kết quả đó |
| không có, `none` | lỗi `CHECKIN_NOTHING_TO_OPEN` |

Dòng `pending` của ngày cũ (kể cả ngày cuối tháng trước) hiển thị là `missed`, không cần job dọn.

### 6.3 Trạng thái client vẽ cho các ô của tháng

| Status | Nghĩa | Hiện |
|---|---|---|
| `claimed` | đã mở hộp | ảnh hộp đã mở + ✓ |
| `none` | đã điểm danh, ô không có quà | số ô + ✓ |
| `missed` | đã điểm danh nhưng hết ngày chưa mở được (chưa làm nhiệm vụ hoặc chưa có VIP) | hộp xám + ✗ |
| `pending` | hôm nay, đã điểm danh, chờ mở (chờ nhiệm vụ hoặc VIP) | hộp viền cam |
| `today` | hôm nay chưa điểm danh, đây là ô sẽ điểm danh | ô viền xanh nhấp nháy |
| `upcoming` | chưa tới, vẫn còn kịp | hộp, hoặc số ô nếu ô đó không có quà |
| `out_of_reach` | chưa tới nhưng không còn đủ ngày trong tháng để tới | xám + 🔒 |

Ô xa nhất còn tới được: `reachable = số lần đã điểm danh trong tháng + số ngày còn lại của tháng, tính cả hôm nay nếu hôm nay chưa điểm danh`. Ô có số lớn hơn `reachable` là `out_of_reach`. Số ngày còn nghỉ được mà vẫn tới ô cuối = `reachable − số ô`.

## 7. Dữ liệu

Một migration Postgres `20261121000001_add_daily_checkin` (file `.up.sql` + `.down.sql` ở `server/cmd/migrations/postgres/`, không có phần ScyllaDB). Version phải lớn hơn mọi môi trường lúc code (mới nhất hiện là `20261120000001_add_megaphone_tickets`), đổi số nếu lúc code đã có migration mới hơn. Không sửa migration đã chạy. Migration **không seed lịch**: tháng nào cũng do admin tạo.

```sql
CREATE TABLE checkin_months (
  month date PRIMARY KEY CHECK (EXTRACT(DAY FROM month) = 1),
  slot_count smallint NOT NULL CHECK (slot_count BETWEEN 1 AND 31),
  published_at timestamptz,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE checkin_slots (
  month date NOT NULL REFERENCES checkin_months(month) ON DELETE CASCADE,
  slot smallint NOT NULL CHECK (slot BETWEEN 1 AND 31),
  gifts jsonb NOT NULL DEFAULT '[]',
  featured boolean NOT NULL,
  require_vip boolean NOT NULL,
  task varchar(32),
  updated_at timestamptz NOT NULL DEFAULT now(),
  PRIMARY KEY (month, slot),
  CHECK ((jsonb_array_length(gifts) = 0) = (task IS NULL))
);

CREATE TABLE user_checkins (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  day date NOT NULL,
  month date NOT NULL,
  slot smallint NOT NULL,
  task varchar(32),
  reward_status varchar(12) NOT NULL,
  reward_snapshot jsonb NOT NULL,
  reward_result jsonb,
  vip_at_checkin boolean NOT NULL,
  client_request_id varchar(64) NOT NULL,
  task_done_at timestamptz,
  claimed_at timestamptz,
  created_at timestamptz NOT NULL DEFAULT now(),
  FOREIGN KEY (month) REFERENCES checkin_months(month),
  CHECK (reward_status IN ('none', 'pending', 'claimed'))
);
CREATE UNIQUE INDEX uq_user_checkins_day ON user_checkins (user_id, day);
CREATE UNIQUE INDEX uq_user_checkins_slot ON user_checkins (user_id, month, slot);
CREATE UNIQUE INDEX uq_user_checkins_client_request ON user_checkins (user_id, client_request_id);
CREATE INDEX idx_user_checkins_month_created ON user_checkins (month, created_at DESC);

CREATE INDEX IF NOT EXISTS idx_me_comments_author_created ON me_comments (author_id, created_at DESC) WHERE deleted_at IS NULL;
CREATE INDEX IF NOT EXISTS idx_me_reactions_user_updated ON me_reactions (user_id, updated_at DESC);
CREATE INDEX IF NOT EXISTS idx_moment_comments_author_created ON moment_comments (author_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_story_comments_author_created ON story_comments (author_id, created_at DESC) WHERE deleted_at IS NULL;

ALTER TABLE user_avatar_frames DROP CONSTRAINT IF EXISTS user_avatar_frames_source_check;
ALTER TABLE user_avatar_frames ADD CONSTRAINT user_avatar_frames_source_check
  CHECK (source IN ('purchase', 'gift', 'transfer', 'gift_code', 'admin', 'checkin'));
```

- `user_checkins.month` có khoá ngoại tới `checkin_months` (không cascade): tháng đã có người điểm danh thì không xoá được lịch, giữ được lịch sử. Lịch nháp và tháng chưa bắt đầu chưa có dòng nào nên xoá bình thường.
- 4 index cuối cho câu kiểm tra nhiệm vụ: các bảng này chưa có index theo người làm + thời gian (đã kiểm tra 19/11). `me`, `moments`, `gift_transactions`, `megaphones` đã có sẵn. Tạo index thường (repo chưa dùng `CONCURRENTLY`) sẽ chặn ghi bảng đó trong lúc tạo, vài giây với cỡ dữ liệu hiện tại, nên chạy migration lúc ít người.
- Bản down: xoá 4 index, xoá 3 bảng (`user_checkins` trước), đổi các dòng khung nguồn `checkin` về `admin` rồi dựng lại constraint nguồn khung cũ.

Constraint `user_avatar_frames_source_check` hiện chỉ cho `purchase, gift, transfer, gift_code, admin` ([20261112000001](../server/cmd/migrations/postgres/20261112000001_allow_admin_avatar_frames.up.sql)). Thiếu `checkin` thì phát khung lỗi và rollback cả ngày VIP, vé loa đi cùng hộp. `user_vip_icons`, `vip_purchases`, `user_megaphone_tickets` không có constraint nguồn nên không phải sửa.

| Cột | Ý nghĩa |
|---|---|
| `checkin_months.month` | ngày 1 của tháng (giờ VN). Có dòng = tháng đã có lịch |
| `checkin_months.published_at` | lúc admin bấm Phát hành. `NULL` = lịch nháp: không chạy, không khoá ô nào. Có giá trị thì lịch chạy từ `max(ngày 1 của tháng, published_at)`, ô khoá tính từ ngày đó |
| `checkin_months.slot_count` | số ô của tháng, API kiểm tra không vượt số ngày của tháng |
| `checkin_slots.slot` | 1 tới `slot_count` |
| `checkin_slots.gifts` | danh sách quà, rỗng là ô không có quà |
| `checkin_slots.featured` | hộp đặc biệt (công tắc Đặc biệt) |
| `checkin_slots.task` | mã nhiệm vụ ở mục 5 hoặc `random` (Ngẫu nhiên). **Bắt buộc khi ô có quà, `NULL` khi ô không có quà**, DB chặn bằng `CHECK` |
| `user_checkins.day` | ngày theo giờ VN |
| `user_checkins.month` | ngày 1 của tháng chứa `day` |
| `user_checkins.slot` | ô đã điểm danh (lần điểm danh thứ mấy trong tháng) |
| `user_checkins.task` | nhiệm vụ đã chốt lúc điểm danh (ô Ngẫu nhiên thì là nhiệm vụ đã bốc), `NULL` với ô không có quà |
| `user_checkins.reward_status` | `claimed` · `pending` · `none`. Hộp mất không ghi riêng, suy ra từ `pending` + `day` cũ |
| `user_checkins.reward_snapshot` | cấu hình ô lúc điểm danh (các quà + cờ) |
| `user_checkins.reward_result` | kết quả sau khi mở: `{items: [{gift, option, type, days?, vipIconId?, frameId?, count?, amount?, expiresInDays?}]}`, mỗi quà một dòng: `gift` là số thứ tự quà, `option` là số thứ tự món đã bốc trong danh sách của quà đó (cả hai đếm từ 1), các trường còn lại chép từ món (cùng tên trường với `gifts`, để admin và app đọc chung một kiểu). Món KEN ngẫu nhiên thì kết quả chỉ ghi `amount` là số đã bốc, không chép `amountMin`/`amountMax` (cấu hình vẫn nằm trong `reward_snapshot`). `NULL` khi chưa mở |
| `user_checkins.vip_at_checkin` | lúc điểm danh có VIP không. Dùng để suy lý do mất hộp "chưa có VIP" (mục 9). **Không** dùng để đếm người mua VIP để mở hộp, vì VIP còn đến từ mã quà, admin, chuyển ngày: số đó đếm từ giao dịch mua VIP thật |
| `user_checkins.task_done_at` | lần đầu server thấy nhiệm vụ đã làm (lúc điểm danh, GET, Mở quà, hoặc lúc admin xem lịch sử / thống kê chạy lại kiểm tra cho hộp mất). Người làm nhiệm vụ rồi đóng app thì cột còn trống tới khi admin xem, nên lịch sử và thống kê không tin cột này một mình (mục 9) |

`gifts` là danh sách quà (tối đa 5). Mỗi quà có `options` gồm 1–10 món, mỗi món là một món quà kèm `weight`. Mở hộp thì mỗi quà bốc 1 món. Ví dụ ô cuối của cấu hình gợi ý:

```json
[
  { "options": [
    { "weight": 40, "type": "avatar_frame", "frameId": "120", "expiresInDays": 15 },
    { "weight": 40, "type": "vip_icon", "vipIconId": 50, "expiresInDays": 15 },
    { "weight": 20, "type": "avatar_frame", "frameId": "120", "expiresInDays": 30 }
  ] },
  { "options": [
    { "weight": 50, "type": "vip_days", "days": 2 },
    { "weight": 50, "type": "megaphone_ticket", "count": 3, "expiresInDays": 7 }
  ] }
]
```

Một món dùng **kiểu `GiftCodeReward` của mã quà tặng** cộng thêm `weight`, và có thêm loại `ken` (trường `amount`) mà mã quà tặng chưa có. Admin dùng kiểu `RewardItem` (gift code + `ken`) và dòng chọn quà chung `RewardItemRow`: form mã quà tặng chỉ hiện 4 loại cũ, form điểm danh hiện thêm KEN. Server phát quà giống `grantRewards` của mã quà tặng, thêm nhánh `ken`.

| `type` | Trường | Ví dụ |
|---|---|---|
| `vip_days` | `days` = số ngày VIP | `{"type":"vip_days","days":2}` |
| `vip_icon` | `vipIconId` = mã loại thẻ, `expiresInDays` (bỏ trống = vĩnh viễn, vẫn khoá) | `{"type":"vip_icon","vipIconId":12,"expiresInDays":7}` |
| `avatar_frame` | `frameId` = mã khung, `expiresInDays` (bỏ trống = vĩnh viễn, vẫn khoá) | `{"type":"avatar_frame","frameId":"004","expiresInDays":15}` |
| `megaphone_ticket` | `count` = số vé (1–100), `expiresInDays` = hạn vé (bỏ trống = không hạn) | `{"type":"megaphone_ticket","count":3,"expiresInDays":7}` |
| `ken` | Cố định: `amount` = số KEN (1–10.000). Ngẫu nhiên: `amountMin` + `amountMax` thay cho `amount`, cả hai tròn 100, 100 ≤ min < max ≤ 10.000. **Chỉ điểm danh có**, mã quà tặng chưa có loại này | `{"type":"ken","amount":500}` hoặc `{"type":"ken","amountMin":100,"amountMax":1000}` |
| `activity_points` | `count` = số điểm (chỉ khi đã có Nhiệm vụ) | `{"type":"activity_points","count":10}` |

`vipIconId` / `frameId` **bắt buộc**: thiếu thì admin và API không cho lưu ô (mục 9).

- `weight` là số nguyên 1–100, tổng các món trong một quà bằng 100 (admin nhập dạng %).
- `reward_snapshot` giữ đúng các quà lúc điểm danh: admin sửa ô giữa ngày không ảnh hưởng người đã điểm danh ô đó hôm đó.
- `user_checkins` cũng là lịch sử để admin tra và làm thống kê.
- Bẫy GORM `default:true` (đã gặp ở module quà): cột boolean không đặt default ở model, luôn set tường minh.

## 8. Server

### 8.1 Module `internal/modules/checkin`

- `checkin.constants.go`: loại quà, status, registry nhiệm vụ, mã lỗi, key setting.
- `checkin.repository.go`: đọc/tạo/sửa `checkin_months` + `checkin_slots`, đọc các dòng của user trong tháng, insert, cập nhật lúc mở hộp, query nhiệm vụ.
- `checkin.service.go`: `Status`, `CheckIn`, `Open`, bốc quà, bốc nhiệm vụ, phát quà.
- `checkin.controller.go`, `checkin.router.go`, `checkin.dig.go`, `checkin.dto.go`.
- Lịch tháng hiện tại (tối đa 31 dòng) cache ngắn trong Redis, admin lưu ô, đổi số ô, phát hành hoặc xoá lịch thì xoá cache.

### 8.2 Bốc và phát quà

Bốc quà:

- Mỗi quà bốc độc lập 1 món theo `weight` bằng `utils.WeightedPick` (đã dùng `crypto/rand`), ngay trong transaction phát quà. Service bọc hàm bốc sau một interface để test cố định được kết quả.
- Món nào cũng đã chọn đủ thẻ VIP / khung (admin và API chặn lưu món thiếu, mục 9), nên lúc bốc không phải lọc món hay bỏ qua quà.
- Nhiệm vụ Ngẫu nhiên bốc đều trong danh sách ngẫu nhiên của setting, cũng bằng nguồn random trên.
- Món KEN ngẫu nhiên: sau khi bốc trúng món, bốc tiếp một mức trong các số tròn 100 từ `amountMin` tới `amountMax`, các mức đều nhau, cũng bằng nguồn random trên.

Phát quà: transaction mở bằng `ledger.LockUser` để 2 request cùng lúc của một user chạy lần lượt. Unique `(user_id, day)` là chốt chặn cuối. Mọi món của hộp (mỗi quà 1 món) phát trong **cùng** transaction: một món lỗi thì cả hộp không mở, kết quả bốc cũng rollback, user bấm lại được.

| Loại | Gọi |
|---|---|
| `vip_days` | `vip.GrantDaysTx(tx, userID, n, "checkin", "Điểm danh tháng M ô X")` |
| `vip_icon` | `vip.GrantIconTx(tx, userID, typeID, IconSourceCheckin, "checkin", grant)` với `grant = models.LockedGrantForDays(expiresInDays)` (bỏ trống là vĩnh viễn, giống mã quà tặng) |
| `avatar_frame` | `avatarframe.GrantFrameTx(tx, userID, frameID, AvatarFrameSourceCheckin, now, grant)`, `grant` như trên, không kiểm tra trước. Quà có hạn tự cộng dồn bản có hạn hoặc tạo bản có hạn mới (kể cả khi đã có bản vĩnh viễn). Hàm trả `false` (quà vĩnh viễn, đã có bản vĩnh viễn) thì vẫn coi là đã phát, không lỗi |
| `megaphone_ticket` | `megaphone.GrantTicketsTx(tx, userID, count, models.MegaphoneTicketSourceCheckin, &row.ID, expiresInDays, now)` |
| `ken` | `ledger.Credit(tx, u, n, ledger.Entry{Type: models.KenTxTypeCheckin, Description: "Điểm danh tháng M ô X", RefType: "user_checkin", RefID: &row.ID})` với `u` là user đã khoá bằng `ledger.LockUser` đầu transaction. Chặn tràn số như nạp KEN (`u.Ken > math.MaxInt32 - n` thì lỗi) |
| `activity_points` | cộng điểm hoạt động ngày của Nhiệm vụ, chỉ bật khi Nhiệm vụ đã có |

- Sau commit: invalidate cache VIP, user và kho khung, giống vòng quay.
- Phát quà lỗi thì **cả lượt** rollback (điểm danh hoặc Mở quà), user thấy lỗi và bấm lại được. Log kèm mã lỗi, tháng, số ô, quà và món, thêm cảnh báo Grafana khi có lỗi phát quà điểm danh để admin sửa ô ngay: ô cấu hình sai sẽ chặn mọi người điểm danh ô đó.
- Thêm loại giao dịch KEN `CHECKIN` (bảng `ken_transactions` không có `CHECK` trên cột loại nên không cần migration): `KenTxTypeCheckin` ([ken_transaction.model.go](../server/internal/models/ken_transaction.model.go)), union `KenTransactionType` + icon/nhãn ở `packages/shared/src/constants/ken.ts`, i18n `ken.historyScreen.types.CHECKIN` (vi "Điểm danh", en "Check-in"), nhãn ở `admin/src/pages/users/constants.ts`.
- Thêm source `checkin`: `IconSourceCheckin` + `PurchaseSourceCheckin` ([vip.repository.go](../server/internal/modules/vip/vip.repository.go)), `AvatarFrameSourceCheckin` ([avatar_frame.model.go](../server/internal/models/avatar_frame.model.go)), `MegaphoneTicketSourceCheckin` ([megaphone_ticket.model.go](../server/internal/models/megaphone_ticket.model.go)), `packages/shared/src/lib/vipHistory.ts` để lịch sử VIP hiện "Điểm danh". Nhãn "Điểm danh" ở admin: `VIP_HISTORY_SOURCE_META`, `VIP_ICON_SOURCE_LABEL`, `USER_AVATAR_FRAME_SOURCE_LABEL` + kiểu `UserAvatarFrameSource` ([users/constants.ts](../admin/src/pages/users/constants.ts)), `MEGAPHONE_TICKET_SOURCE_LABEL` + kiểu `MegaphoneTicketSource` ([megaphones/constants.ts](../admin/src/pages/megaphones/constants.ts)).
- App cũ gặp loại KEN `CHECKIN` hay nguồn VIP `checkin` thì hiện nhãn chung ("Khác"), không lỗi: `KEN_TX_META_FALLBACK` và `vipHistorySourceKey` đã có sẵn đường lùi.
- Khi đã có Nhiệm vụ: điểm danh cũng `Track(open_app)`.

### 8.3 API

| Method | Path | Mô tả |
|---|---|---|
| GET | `/checkin` | `{enabled, popup, needsEmailVerify, month, slotCount, count, slot, completed, checkedInToday, reachable, canOpen, todayTask?, todayResult?, endsAt, slots[slotCount] {slot, box, requireVip, status, items?, checkedInOn?}}`. Chi tiết dưới bảng |
| POST | `/checkin` | body `{clientRequestId}` (bắt buộc, tối đa 64 ký tự, mục 6.1 bước 3). Điểm danh hôm nay, trả trạng thái mới + `slot` (ô của lượt này, gửi lại mã cũ thì là ô của lượt cũ) + `items` nếu hộp mở luôn (nhiệm vụ đã làm từ trước và đủ điều kiện), hoặc lý do chưa mở: `task_pending` (kèm `todayTask`), `vip_required` (chỉ khi hộp cần VIP và chưa có VIP). Gửi lại mã cũ thì lý do tính lại theo dòng đã lưu và VIP hiện tại: hộp thường đã làm nhiệm vụ trả lý do trống (sẵn sàng mở) |
| POST | `/checkin/open` | mở hộp đang chờ của hôm nay, trả trạng thái mới + `slot` + `items` |

Trường của GET:

- `month` dạng `2026-11`, `slotCount` = số ô của tháng, `count` = số lần đã điểm danh trong tháng, `slot` = ô của hôm nay (đã hoặc sắp điểm danh), `completed` = đã điểm danh đủ số ô (không có nghĩa là đã nhận đủ quà).
- `reachable` ở mục 6.3. Client tính số ngày còn nghỉ được = `reachable − slotCount`.
- `box` = `none` · `normal` · `big`. Ô đã điểm danh lấy theo `reward_snapshot`, ô khác lấy theo cấu hình hiện tại. `checkedInOn` = ngày thật đã điểm danh ô đó.
- `items` **chỉ có ở ô `claimed`**, lấy từ `reward_result`. Ô chưa mở, ô mất không trả bảng tỉ lệ hay món nào.
- `todayTask = {code, done}` **chỉ có sau khi điểm danh** và ô hôm nay có quà. Không có trường nhiệm vụ nào ở `slots`.
- `needsEmailVerify` = công tắc xác thực email đang bật, user chưa xác thực và hôm nay chưa điểm danh. Server tính lúc GET, không dựa vào user trong store client có thể cũ.
- `canOpen` = hôm nay đang `pending` và nhiệm vụ đã làm, server tính. VIP không nằm trong `canOpen`: hộp cần VIP vẫn hiện nút Mở quà, bấm mới báo `CHECKIN_VIP_REQUIRED`.
- Client chọn nút: chưa điểm danh → **Điểm danh** (kể cả khi `needsEmailVerify`, bấm vào mới hiện hộp thoại xác thực email); `pending` mà `todayTask.done = false` → **Đi làm**; `canOpen` → **Mở quà**. Hộp `pending` của hôm nay **luôn đứng trước** `completed`: hôm điểm danh ô cuối mà hộp còn chờ thì vẫn hiện thẻ chờ, không hiện "Đã điểm danh đủ".
- `todayResult` = các món đã nhận hôm nay. `endsAt` = 0h VN kế tiếp để client đếm ngược.
- Nền tảng tắt, tháng chưa có lịch hoặc lịch còn nháp → `enabled: false`.

Tối ưu (GET `/checkin` gọi mỗi lần mở app để vẽ popup và chấm đỏ):

- Công tắc có trong `GET /settings/app` (key `dailyCheckin` = `{enabled}` theo nền tảng, cùng bản tin cấu hình app vốn đã tải lúc mở app). Tắt thì client không gọi `/checkin` lần nào.
- Đang tắt hoặc tháng chưa phát hành: chỉ đọc cài đặt (cache bộ nhớ) và lịch tháng (Redis 1 phút), không đụng DB. Đang chạy: 1 câu đọc các lượt của user trong tháng (index `uq_user_checkins_slot`), câu đọc email **chỉ chạy khi chưa điểm danh hôm nay và công tắc email bật**, câu kiểm nhiệm vụ chỉ chạy khi hộp hôm nay đang chờ mà chưa ghi nhận làm xong (làm rồi thì ghi `task_done_at`, lần sau khỏi chạy).
- Câu kiểm nhiệm vụ nào cũng đi theo index `(user, thời gian)`. Riêng `play_game` tách 3 nhánh `UNION ALL` (người chơi 0, người chơi 1, bàn 3–4 người qua `game_match_players`) thay cho điều kiện `OR` không dùng được index, kèm 2 index mới `idx_game_matches_player0_finished` / `player1_finished` trong migration. Kết quả khớp câu cũ trên toàn bộ dữ liệu local.
- Hai POST trả luôn trạng thái mới, client không GET lại. Store client gộp các lần gọi trùng (đang tải thì dùng chung promise), bỏ qua GET nếu vừa tải dưới 30 giây và chưa qua 0h (mở màn Điểm danh thì luôn tải lại).
- Phát KEN xong đẩy số dư mới qua socket bằng số dư `ledger.Credit` vừa tính trong transaction, không đọc lại DB.
- Store client: lỗi mạng thì giữ `clientRequestId` để bấm lại không tính 2 lượt, nhưng GET thành công sau đó thì bỏ mã cũ (trạng thái đã phản ánh lượt kia có vào hay không). Đăng xuất thì bỏ mọi phản hồi đang bay của người trước (đếm thế hệ). GET bắt đầu trước một lượt điểm danh / mở hộp thành công mà về sau thì bỏ, không ghi đè trạng thái mới (đếm số lần thay đổi, test ở `mobile/src/screens/daily-checkin/__tests__`). Đồng hồ máy lệch nên lúc 0h tải lại mà server vẫn trả ngày cũ thì cứ 10 giây thử lại tới khi sang ngày mới. Đang mở màn Điểm danh lúc qua 0h thì không bật thêm popup đè lên.

Khác:

- Mã lỗi: `CHECKIN_DISABLED`, `CHECKIN_COMPLETED`, `CHECKIN_EMAIL_NOT_VERIFIED`, `CHECKIN_TASK_NOT_DONE`, `CHECKIN_VIP_REQUIRED`, `CHECKIN_NOTHING_TO_OPEN`.
- Cả 2 POST đều kiểm tra nền tảng (theo `X-Platform`) đang bật và tháng hiện tại đã phát hành lịch, không thì trả `CHECKIN_DISABLED`.
- Rate limit cho 2 POST (ví dụ 20/phút).
- Ngày và tháng luôn tính phía server theo giờ VN (`utils.VietnamPeriodStart`), không tin giờ máy client.

### 8.4 Cài đặt `app_settings` key `checkin`

```json
{
  "enabled": false,
  "platforms": { "web": { "enabled": true, "disableVersions": [] }, "android": { "enabled": true, "disableVersions": [] }, "ios": { "enabled": true, "disableVersions": [] } },
  "popup": true,
  "requireEmailVerified": true,
  "randomTasks": ["me_post", "me_comment", "me_react", "moment_post", "moment_comment", "story_comment", "play_game"]
}
```

- Cùng dạng với `gift_code`: `enabled` là công tắc tổng (**mặc định tắt**, chưa có dòng setting cũng coi là tắt), `platforms` là `PlatformRules` (bật/tắt từng nền tảng và tắt riêng từng bản app), admin dùng `PlatformRulesTable` + `cleanPlatformRules`. Điểm danh chạy khi `enabled` bật, nền tảng bật và tháng hiện tại đã phát hành lịch.
- `requireEmailVerified` mặc định `true`, giống mã quà tặng. Đổi giữa ngày thì áp ngay cho lần bấm Điểm danh sau.
- `randomTasks` thiếu thì lấy danh sách ngẫu nhiên mặc định trong registry (mục 5). Lưu danh sách rỗng, mã lạ hoặc trùng luôn bị từ chối (`setting.ValidateCheckinValue`).

## 9. Admin

Menu mới **Điểm danh**, 1 trang 4 tab theo thứ tự Lịch tháng · Lịch sử · Thống kê · Cài đặt:

| Tab | Nội dung |
|---|---|
| Lịch tháng | Chọn tháng (tháng đã qua, tháng này, 2 tháng tới), mỗi tháng có nhãn **Đang chạy** / **Sắp tới** / **Nháp** / **Đã qua** / **Chưa tạo**. Tháng chưa tạo có nút **Tạo lịch**: nhập số ô (mặc định 28) và chọn chép từ tháng khác hoặc để trống rồi tự nhập (không có mẫu dựng sẵn, mục 3). Lịch tạo ra là **nháp**: chưa chạy, không khoá ô nào, sửa và kéo thả mọi ô, đổi số ô tự do. Nhập xong bấm **Phát hành** (hỏi xác nhận, không quay lại nháp được): tháng đang chạy thì chạy ngay, tháng sau thì tự chạy từ ngày 1. Tháng đã tạo có ô sửa **Số ô** (tháng đang chạy chỉ được tăng). Lưới 7 cột giống app, mỗi ô hiện loại hộp, số quà, mỗi quà một hàng ảnh các món, và cờ. Ô cuối hiện như mọi ô, không có dải riêng. **Kéo một ô thả lên ô khác để đổi chỗ hai ô** (lưu ngay). Ô đã khoá (mục 2, Sửa lịch) hiện xám kèm ổ khoá, bấm vào chỉ xem, không kéo và không thả vào được; đầu lưới ghi "Ô 1–19 đã khoá … chỉ sửa và kéo thả được ô 20–28". Tháng đã qua chỉ xem. Xoá lịch được với lịch nháp hoặc tháng chưa bắt đầu |
| Lịch sử | Chọn tháng. Bảng mọi lượt điểm danh, mới nhất trước: thời gian, người dùng, ô + loại hộp, nhiệm vụ đã chốt (làm xong lúc nào hoặc chưa làm), trạng thái **Đã mở** (mở lúc nào) / **Chờ mở** / **Mất hộp** (lý do: **không làm nhiệm vụ** / **làm nhiệm vụ rồi nhưng chưa có VIP** / **đủ điều kiện nhưng không bấm mở**) / **Chỉ điểm danh**, các món nhận được, có VIP lúc điểm danh không. Danh sách tháng chỉ có tháng đã phát hành. Lọc theo tên đăng nhập / tên / ID, trạng thái, ô; 20 dòng một trang. Bấm vào tên một người thì hiện **lịch của người đó** phía trên bảng: lưới ô tháng đó, mỗi ô đã điểm danh ghi ngày, trạng thái và món nhận; ô chưa tới ghi **Chưa tới** (còn kịp) hoặc **Không kịp** (tháng đã qua: **Không tới**), ô có hộp hiện biểu tượng hộp; dòng trên ghi đã điểm danh X/N, số hộp đã mở, mất, còn nghỉ được mấy ngày; bảng chỉ còn lượt của người đó |
| Cài đặt | bật/tắt từng nền tảng, bật/tắt popup, công tắc **Xác thực email** (mặc định bật), chọn **danh sách nhiệm vụ ngẫu nhiên** |
| Thống kê | theo tháng và theo ngày: số người điểm danh, phân bố theo ô, **số người đi hết lịch tháng** (tới ô cuối), số hộp đã mở theo loại quà (đếm từ `reward_result`), **kết quả bốc từng món của từng quà so với tỉ lệ đặt**, **số hộp mất vì chưa có VIP** (cùng cách suy lý do với tab Lịch sử), **số người mua VIP để mở hộp** (đếm người khác nhau, không đếm lượt; hộp cần VIP đã mở, lúc điểm danh chưa có VIP, và có giao dịch mua VIP thật trong `vip_purchases` với nguồn `vip.PurchaseSourcePackage` (mua gói ngày VIP) giữa lúc điểm danh và lúc mở. Mua thẻ VIP (`icon`) không cộng ngày nên không tính), hộp mất tách theo 3 lý do và theo từng nhiệm vụ, số vé loa phát ra / đã dùng / hết hạn |

Form sửa ô (modal):

- **Quà**: mỗi quà là một thẻ "Quà 1", "Quà 2"… có danh sách món. Mỗi món một dòng: **thanh kéo + ô %** giống đập trứng, rồi loại, chọn thẻ VIP hoặc khung, số ngày, hạn, số vé (dòng `RewardItemRow` dùng chung với mã quà tặng). Kéo hoặc nhập % một món thì các món khác tự bù, lấy từ món lớn nhất trước, tổng luôn 100% và mỗi món tối thiểu 1%. Thêm món thì món mới được chia phần đều, xoá món thì phần % của nó cộng vào món lớn nhất. Nút **+ Thêm món vào danh sách**, dưới mỗi quà hiện tổng %, khác 100 thì không lưu được. Nút **+ Thêm quà** (tối đa 5).
- Trên cùng form (ngoài tab) là hàng công tắc: **Có hộp quà**, bật thì hiện thêm **Đặc biệt** và **Có VIP để mở** cạnh nhau (dấu ? giải thích từng cái). Tắt Có hộp quà thì ô chỉ điểm danh, ẩn 2 tab; bật lại trước khi Lưu thì quà cũ vẫn còn. Bật ở ô trống thì tự thêm 1 quà mặc định và nhiệm vụ Ngẫu nhiên. Bật mà xoá hết quà thì không lưu được.
- 2 tab bên dưới. Tab **Quà**: các quà. Tab **Nhiệm vụ**: dropdown **Nhiệm vụ** bắt buộc (Ngẫu nhiên / từng nhiệm vụ ở mục 5, mặc định Ngẫu nhiên; chọn Ngẫu nhiên thì hiện danh sách nhiệm vụ đang bốc từ tab Cài đặt). Lưu lỗi thì tự chuyển sang tab có lỗi.
- **Bắt buộc chọn đủ**: món thẻ VIP hay khung chưa chọn mã thì ô chọn báo đỏ "Chọn icon VIP" / "Chọn khung avatar" và không lưu được, API cũng từ chối. API còn chặn mã **không có trong danh mục**: thẻ VIP ngoài 1–138 (`vip.VipTypeMinID`/`VipTypeMaxID`), khung không có trong `server/internal/modules/avatar-frame/assets/avatarFrames.json` (bản chép của `packages/shared/src/lib/avatarFrames.json`; thêm khung mới thì chép đè file này, test Go `TestCatalogMatchesShared` báo lỗi khi hai file lệch). Nhờ vậy ô đã lưu luôn phát đủ quà, không có món bị bỏ qua lúc bốc, và chép tháng cũng luôn ra lịch đủ món.

Cảnh báo:

- **Tháng sau chưa có lịch hoặc còn nháp**: từ ngày 20 hiện cảnh báo đỏ ở đầu trang Điểm danh và trang tổng quan admin: "Tháng 12 chưa có lịch (còn là nháp), từ 01/12 điểm danh sẽ tắt".
- **Tháng này chưa có lịch hoặc còn nháp**: cảnh báo đỏ ở tab Lịch tháng và tab Cài đặt "Tháng 11 còn là nháp nên điểm danh đang tắt".
- **Không tải được dữ liệu** (lỗi mạng, server lỗi): các tab hiện khung lỗi + nút Thử lại, không hiện "tháng chưa có lịch" để admin khỏi tạo trùng lịch.

API và kiểm tra:

- `/admin/checkin/months` (danh sách, tạo, sửa số ô, xoá), `POST /admin/checkin/months/:month/publish` (phát hành, chỉ tháng chưa qua và còn nháp; kiểm tra lại mọi ô theo luật lưu ô, kể cả mã thẻ VIP / khung có trong danh mục, ô nào sai thì không phát hành), `PUT /admin/checkin/months/:month/slots` (sửa một hoặc nhiều ô, mỗi ô gửi kèm `updatedAt` đã đọc: ô đã bị sửa ở tab khác thì trả 409 "Ô X vừa được sửa ở nơi khác", admin đóng modal để mở lại bản mới), `POST /admin/checkin/months/:month/slots/swap` `{from, to}` (kéo thả đổi chỗ: server đổi nội dung hai ô trên dữ liệu mới nhất, không nhận nội dung ô từ client), `/admin/checkin/stats`, `/admin/checkin/history?month=&q=&userId=&status=&slot=&limit=&offset=` (trả `{items, total, limit, offset}`, mỗi dòng có `user`, `day`, `slot`, `box`, `requireVip`, `task`, `taskDoneAt`, `status`, `missReason`, `vipAtCheckin`, `rewards` = các dòng của `reward_result`, `createdAt`, `claimedAt`), `/admin/checkin/users/:userId?month=` (lịch một người: `{user, month, slotCount, entries}`). `status` của lịch sử: `pending` ngày cũ trả là `missed`. Lý do mất hộp **tính lại lúc xem**, không tin `task_done_at` một mình: các dòng mất trong trang mà `task_done_at` trống được kiểm lại theo lô (mỗi nhiệm vụ một câu `UPDATE … FROM` theo danh sách id, thấy làm rồi thì ghi luôn `task_done_at`), lý do `vip` cũng tính một câu cho cả trang. Rồi `missReason = task` khi trong ngày không làm nhiệm vụ; `vip` khi đã làm, hộp cần VIP, lúc điểm danh chưa có VIP và tới 0h không có dòng `vip_purchases` nào cộng ngày VIP (`days > 0`, nguồn nào cũng tính: mua gói, được tặng, mã quà, nhận chuyển…); còn lại `not_opened` (đủ điều kiện mà không bấm mở). Thống kê dùng cùng cách nhưng đối chiếu **cả tháng theo lô**: mỗi nhiệm vụ một câu `UPDATE … FROM` ghi bù `task_done_at` cho mọi hộp mất của tháng (không giới hạn số dòng). Ngày đã qua thì kết quả không đổi nữa, nên Redis giữ `CHECKIN:BACKFILLED:<tháng>` = ngày đã đối chiếu tới, lần sau chỉ đối chiếu các ngày mới. Rồi đếm bằng một câu `GROUP BY task` (lý do `vip` tính bằng `EXISTS` trên `vip_purchases` trong cùng câu). Mọi thao tác ghi lịch (sửa số ô, lưu ô, đổi chỗ, phát hành, xoá) khoá dòng `checkin_months` bằng `SELECT … FOR UPDATE` trong transaction, nên xoá và phát hành cùng lúc chạy lần lượt: xoá chạy sau thì thấy lịch đã phát hành và bị từ chối. Ghi `admin_audit_logs` như các module khác.
- Lưu thì kiểm tra, **cùng giới hạn ở form admin và API** để không lưu được ô mà server không phát nổi:
  - số ô từ 1 tới số ngày của tháng; tháng đang chạy (đã phát hành) không giảm số ô; tháng đã qua không sửa được; tháng đang chạy không sửa ô đã khoá (server tự tính K theo giờ VN, không tin client);
  - tối đa 5 quà mỗi ô; mỗi quà 1–10 món, tổng tỉ lệ các món trong quà bằng 100;
  - mọi món thẻ VIP / khung phải chọn mã và mã phải tồn tại, mã nhiệm vụ có trong registry hoặc là `random`;
  - số ngày VIP > 0;
  - số vé 1–100 (`TicketMaxPerGrant`), hạn vé 0–365 ngày (`TicketMaxDays`, 0 = không hạn). `GrantTicketsTx` từ chối hạn trên 365, lưu 366 thì cả hộp rollback mỗi lần mở;
  - số ngày thẻ VIP / khung 0–365 (0 = vĩnh viễn). Form điểm danh chặn 365 ngay ở ô nhập (`RewardItemRow` nhận giới hạn theo từng form), form mã quà tặng giữ 3650 như hiện tại;
  - ô có quà phải có nhiệm vụ; ô không có quà thì cờ và nhiệm vụ tự tắt.
- Chép lịch sang tháng có số ô khác: ô k chép sang ô k, ô dư bỏ (báo admin), ô thiếu để trống. Muốn dời hộp đặc biệt xuống ô cuối mới thì kéo thả trên lưới.

## 10. Client (web + mobile)

### 10.1 Shared `packages/shared`

Đặt tên `dailyCheckin` (không dùng `checkin` / `CheckIn` vì đã có check-in vị trí của bài Me).

- `types/api/dailyCheckin.type.ts`, `types/client/dailyCheckin.type.ts`, `services/dailyCheckin.service.ts`, `lib/dailyCheckin.ts` (hàm thuần: thẻ hôm nay, số ngày còn nghỉ, hộp kế tiếp, chữ quà, chữ dòng tab Cá nhân, đếm ngược, lỗi).
- `constants/dailyCheckin.ts`: `DAILY_CHECKIN_SLOT_STATUS`, `DAILY_CHECKIN_BOX`, `DAILY_CHECKIN_REWARD_TYPE`, `DAILY_CHECKIN_TASK`, `DAILY_CHECKIN_TASK_TARGET`, `DAILY_CHECKIN_ERROR`.
- `stores/daily-checkin/dailyCheckinStore.ts` (zustand), có thêm `opened` (hộp vừa mở, để hiện hiệu ứng) và `notice` (`needsEmail` / `vipRequired`, để hiện hộp thoại): `data`, `load()`, `checkIn()` (sinh `clientRequestId` mới mỗi lần bấm, gửi lại do lỗi mạng thì dùng lại mã đó), `open()`, `shouldShowPopup()` (đang bật + chưa đi hết lịch + chưa điểm danh + popup bật + chưa hiện hôm nay, nhớ theo ngày VN ở storage máy). Qua 0h VN khi đang mở màn thì tự `load()` lại (ngày 1 sẽ ra lịch tháng mới). Nhận vé loa xong thì tải lại số vé loa. Gọi `load()` mỗi lần mở popup hoặc màn, khi màn Điểm danh được focus lại (mobile `useFocusEffect`, web khi overlay mở lại) và khi app về foreground: đi đăng bài Me trong app rồi quay lại không phát sinh sự kiện foreground. Chọn nút theo `checkedInToday`, `todayTask`, `canOpen` (mục 8.3). Xác thực email xong quay lại cũng `load()` lại.
- Đích nút **Đi làm** dạng trừu tượng (`meComposer`, `meTab`, `momentCreate`, `momentList`, `storyTab`, `gifts`, `megaphone`, `gameTab`). Mỗi nền tảng tự map: web `pages/daily-checkin/useDailyCheckinTask.ts` (đổi tab qua `store/homeNavStore.ts`, mở sẵn khung đăng bài / khoảnh khắc bằng `useHomeNavIntent`, Quà tặng và Loa mở đè lên màn Điểm danh), mobile `screens/daily-checkin/useDailyCheckinTask.ts` (`navigate` + `store/navIntentStore.ts` / `useNavIntent`).
- i18n vi/en: `dailyCheckin.*`.

### 10.2 Màn hình

- **Popup**: mở app hoặc quay lại foreground, nếu `shouldShowPopup()` thì hiện lịch tháng + ô hôm nay + nút **Điểm danh** (hoặc **Xác thực email** nếu công tắc xác thực email bật mà user chưa xác thực). Bấm xong hiện ngay trong popup: "Đã điểm danh" nếu ô không có quà; ô có quà thì "Nhiệm vụ hôm nay: …" + nút **Đi làm**, hoặc hộp mở luôn nếu nhiệm vụ đã làm từ trước và đủ điều kiện.
- **Hộp thoại Cần xác thực email**: "Bạn cần xác thực email để điểm danh" + câu hướng dẫn của mã quà tặng + nút **Xác thực email** mở thẳng chỗ xác thực ở Trang cá nhân.
- **Thứ tự popup lúc mở app** (chỉ hiện một popup một lúc):
  - mobile: chỉ hiện sau khi `AppLockGate` đã mở khoá và `AppUpdateGate` không chặn. Phiên đã hiện popup điểm danh thì không xin đánh giá store (`appReview`). Hiện sau khi màn chính sẵn sàng, tránh bẫy iOS bỏ qua Modal lúc vừa mở app;
  - web: chỉ hiện ở màn chính sau khi đăng nhập.
- **Màn Điểm danh** (web overlay `checkin`, mobile screen `Checkin`): lưới 7 cột, số ô bằng `slotCount`, ô cuối hiện như mọi ô (hộp thường hay hộp đặc biệt theo cờ Đặc biệt). Đếm ngược tới 0h. Dòng trên "Tháng 11 · Đã điểm danh 16/28" kèm "Còn nghỉ được 1 ngày" / "Nghỉ thêm là không tới ô 28" / "Không kịp ô 28". Thẻ hôm nay bên dưới lưới: chưa điểm danh thì nút **Điểm danh** (hoặc **Xác thực email**); ô không có quà thì ghi "Ô 18 không có quà" và "Hộp quà tiếp theo: ô 19" (client tính từ `slots`); đang chờ thì hiện nhiệm vụ + **Đi làm**, làm rồi thì **Mở quà** (hộp cần VIP bấm vào mới báo Cần VIP); đã mở thì danh sách quà vừa nhận; đã điểm danh đủ và hộp hôm nay đã xong thì "Đã điểm danh đủ 28/28 ô tháng 11, hẹn 01/12". Hôm điểm danh ô cuối mà hộp còn chờ thì vẫn hiện thẻ chờ (nhiệm vụ + Đi làm / Mở quà), không hiện câu hoàn tất.
- **Bấm vào ô**: ô chưa mở hiện "Hộp quà bí mật" + số ô + "Điểm danh xong sẽ hiện nhiệm vụ, làm xong mới mở được hộp" + Cần VIP nếu có (không hiện quà, không hiện tên nhiệm vụ); ô đã mở hiện đủ món đã nhận và ngày thật đã điểm danh; ô `missed` giải thích "Hết ngày mà hộp chưa được mở"; ô `out_of_reach` giải thích "Không còn đủ ngày trong tháng để tới ô này"; ô không có quà hiện "Ô này chỉ cần điểm danh".
- **Hiệu ứng mở hộp**: hộp lắc nhẹ rồi bung ra món, khoảng 1 giây, làm bằng animation thường (CSS ở web, `Animated` ở mobile), không cần thư viện mới.
- Dòng **Điểm danh** trong `PERSONAL_ITEMS` (danh sách `PanelRow`, ngay sau Thông tin cá nhân) ([web](../web/src/pages/apps/constants.ts), [mobile](../mobile/src/screens/apps/constants.ts)). Chấm đỏ ở dòng này và ở icon tab Cá nhân trên thanh dưới khi chưa điểm danh hoặc có `pending`. `enabled: false` thì ẩn dòng và popup.
- Thẻ VIP / khung trong kết quả hiện ảnh món + "3 ngày" và dấu khoá, dùng lại `ItemGrantMarks`.
- Mobile: `Dialog` chuẩn, `ScreenHeader`, token màu `ola-*`, `useThemeColors`.
- Đã code: web `pages/daily-checkin/` (màn overlay `dailyCheckin`, `DailyCheckinHost` gắn ở `HomePage` lo popup + hộp thoại), mobile `screens/daily-checkin/` (màn `DailyCheckin`, `DailyCheckinHost` gắn ở `App.tsx` sau `AppLockGate`/`AppUpdateGate`, chờ 0,9 giây sau khi mở app, phiên đã hiện popup thì `suppressAppReviewForSession`). Trên iOS không mở được Modal thứ hai khi popup đang mở, nên trong popup kết quả mở hộp, hộp thoại VIP/email và chi tiết ô hiện thay nội dung popup.

- **Nút nổi ở màn Chat** (web `DailyCheckinFab` trong `ChatPanel`, mobile `DailyCheckinFab` trong `ChatListScreen`), đặt ngay trên nút soạn tin: icon Điểm danh (`menu.webp`) lắc nhẹ, nhãn dưới nút đỏ **Điểm danh** khi chưa điểm danh, cam **Làm nhiệm vụ** / **Mở quà** khi hộp đang chờ; bấm mở popup Điểm danh (store `requestPopup()` → host mở popup). Đã nhận quà, ô không có quà đã điểm danh, đi hết lịch hoặc tắt điểm danh thì không hiện. Góc trên phải có nút **X**: bấm thì ẩn tới 0h VN hôm sau, nhớ theo tài khoản trên máy (`ola.dailyCheckin.fabHiddenDay.<userId>` = `endsAt` của ngày đó), vẫn vào được qua tab Cá nhân.

### 10.3 Ảnh cần vẽ

Đã vẽ 20/11 bằng Codex, cả bộ chung một kiểu: tô phẳng 2–3 tông, viền mảnh theo màu từng phần (giống icon Khung avatar), không 3D bóng. File nằm ở `packages/shared/assets/daily-checkin/` (webp, nền trong suốt), web lấy qua `web/src/shared/constants/dailyCheckinIcons.ts`, mobile qua `mobile/src/screens/daily-checkin/dailyCheckinAssets.ts`. Muốn đổi ảnh thì ghi đè file cùng tên, không phải sửa code. Hộp mất đã có ảnh xám riêng nên không làm mờ thêm, chỉ ô không kịp còn làm mờ.

| File | Dùng ở | Cỡ file | Ghi chú |
|---|---|---|---|
| `box.webp` | ô có hộp thường trên lưới (~28pt), thẻ hôm nay (48pt), hiệu ứng mở hộp (80pt) | 256×256 | hộp quà kín, nhìn rõ ở cỡ nhỏ |
| `box-big.webp` | ô hộp đặc biệt (~36pt), thẻ hôm nay, hiệu ứng mở | 256×256 | cùng hộp đỏ nơ vàng như hộp thường, nơ to hơn, viền vàng ở nắp, có lấp lánh. Không có hộp riêng cho VIP |
| `box-missed.webp` | ô hộp mất (hết ngày chưa mở) | 256×256 | bản xám / bạc màu của hộp thường. Mobile không lọc xám được ảnh nên cần file riêng |
| `box-opened.webp` | ô đã mở hộp (~28pt) | 256×256 | hộp mở nắp, bên trong trống (lưới không lộ quà) |
| `box-big-opened.webp` | ô hộp đặc biệt đã mở (~36pt) | 256×256 | hộp đặc biệt mở nắp, cùng bố cục với `box-opened.webp` |
| `menu.webp` | dòng **Điểm danh** ở tab Cá nhân (40pt) | 120×120 | cùng phong cách các icon menu (Quà tặng, Kho VIP…) |
| `task.webp` | dấu nhiệm vụ trong khung cam "Nhiệm vụ hôm nay" (16pt) | 64×64 | ví dụ tờ giấy + bút |

Không cần vẽ: vương miện ở thẻ Hôm nay / hộp thoại ô cần VIP (dùng `vip-crown.webp`), ảnh quà KEN / ngày VIP / vé loa / thẻ VIP / khung (dùng ảnh có sẵn).

## 11. Thứ tự làm

| Bước | Việc | Ước lượng |
|---|---|---|
| 1 | Migration + model: **xong** (`20261121000001_add_daily_checkin`, `models/checkin.model.go`) | 0,25 ngày |
| 2 | Server: **xong** module `modules/checkin` (người dùng) + `modules/admin/checkin`, cài đặt `setting.checkin.go`, test Go cho khoá ô, ô còn tới được, bốc quà, kiểm tra cấu hình ô, danh mục khung và cài đặt. Đã sửa 5 lỗi review 20/11 (xoá lúc phát hành, tab cũ đổi chỗ / lưu ô, gửi lại qua 0h, mã ngoài danh mục, thống kê quá 5.000 dòng) và thử lại trên Postgres local. Còn: test Go trên Postgres thật theo danh sách dưới (local mới chạy tay bằng script) | 2 ngày |
| 3 | Admin: **xong**, đã bỏ dữ liệu giả, nối API thật, nhãn nguồn `checkin`. Còn: cảnh báo tháng sau chưa có lịch ở trang tổng quan | 0,5 ngày |
| 4 | Shared + web: **xong** popup, màn, hiệu ứng mở hộp, dòng Điểm danh, chấm đỏ, nút Đi làm mở đúng chỗ. Chạy thử local bằng Chrome | 1 ngày |
| 5 | Mobile: **xong** như web, chạy thử iOS simulator với API local. Còn: test store ở mobile jest, thử Android | 1 ngày |
| 6 | E2E local (docker dev, giả qua ngày bằng sửa `day`/`month` các dòng `user_checkins`), ảnh xác nhận web + simulator | 0,5 ngày |

Test server (Go, chạy trên Postgres thật):

- Điểm danh 2 lần cùng ngày, qua 0h, **nghỉ ngày**: đứng yên ở ô cũ, hôm sau ra ô kế, không mất ô nào.
- **Đi hết lịch**: lịch 28 ô, điểm danh tới ô 28 rồi hôm sau POST → `CHECKIN_COMPLETED`, GET `completed: true`, popup không hiện.
- **Ô cuối còn chờ**: điểm danh ô 28 mà hộp chờ nhiệm vụ → GET có `completed: true` nhưng vẫn có `todayTask`, làm xong thì `canOpen` và mở được; hộp chờ VIP → Mở quà báo `CHECKIN_VIP_REQUIRED`, có VIP thì mở được; qua 0h chưa mở → ô 28 thành `missed`.
- **Sang tháng**: 31/10 → 01/11 về ô 1, `pending` của 31/10 thành `missed`. Lịch tháng 2 không cho đặt quá 28 (29) ô.
- **Vào giữa tháng**: 15/11 là ô 1, `reachable = 16`, ô 17–28 là `out_of_reach`.
- Tháng chưa có lịch hoặc lịch còn nháp → GET `enabled: false`, POST `CHECKIN_DISABLED`. Phát hành giữa tháng → mở từ lúc phát hành, bắt đầu ô 1.
- **Hộp chờ quá ngày**: hộp chưa làm nhiệm vụ qua 0h → `missed`, hôm sau điểm danh ra ô kế.
- **Bốc quà**: nguồn random cố định ra đúng món của từng quà; ô 2 quà phát đủ 2 món; chạy 10.000 lần với `crypto/rand` thì tỉ lệ từng quà lệch không quá 2%. KEN ngẫu nhiên 100–1.000 chỉ ra số tròn 100, đủ 10 mức, mỗi mức khoảng 10% (đã có test Go).
- **Ẩn ở API**: GET không có bảng tỉ lệ, món hay nhiệm vụ của ô chưa mở; `todayTask` chỉ có sau khi điểm danh.
- **Nhiệm vụ Ngẫu nhiên**: bốc trong `randomTasks`, GET lại vẫn đúng nhiệm vụ đó, việc làm trước lúc điểm danh vẫn tính.
- Hộp cần VIP: làm xong nhiệm vụ mà chưa có VIP → bấm Mở quà → `CHECKIN_VIP_REQUIRED`; mua VIP trong ngày rồi Mở quà → `claimed`; qua 0h → `missed`.
- Nhiệm vụ làm trước / sau điểm danh, quá ngày chưa làm, làm rồi nhưng không bấm Mở quà (`task_done_at`), `canOpen` trước và sau khi làm. Ô không có quà không bao giờ có nhiệm vụ.
- **Xác thực email**: công tắc bật + chưa xác thực → POST `/checkin` bị `CHECKIN_EMAIL_NOT_VERIFIED`, ô không tiến, GET `needsEmailVerify: true`; xác thực xong điểm danh được; công tắc tắt → không chặn; bật công tắc sau khi user đã điểm danh → vẫn mở hộp được.
- **Phát trọn hộp ô cuối** (khung mới + ngày VIP hoặc vé loa) trên Postgres: qua được constraint nguồn khung.
- Khung đã có vĩnh viễn, quà là bản 7 ngày → thêm bản 7 ngày cạnh bản vĩnh viễn, hộp `claimed`, `reward_result` có món khung. Quà là bản vĩnh viễn → không thêm dòng, hộp vẫn `claimed` và ghi món. Hộp chỉ có 1 quà là khung trùng vẫn mở ra có món.
- KEN: cộng đúng số dư, có giao dịch `CHECKIN` trỏ về dòng điểm danh, số dư sát `MaxInt32` thì lỗi và cả hộp rollback.
- Lịch sử admin: `pending` ngày cũ trả `missed`; làm nhiệm vụ rồi đóng app (`task_done_at` trống) → lý do ra `not_opened` hoặc `vip`, không ra `task`, và `task_done_at` được ghi bù; nhận VIP từ mã quà không tính là mua VIP để mở hộp; lọc theo người, ô, trạng thái; lịch một người khớp các dòng của người đó.
- **2 máy cùng bấm Mở quà** một ô `pending` nhiều món, rồi một máy gửi lại sau khi mất phản hồi → bốc và phát đúng 1 lần, cả 2 máy thấy cùng kết quả.
- **Gửi lại Điểm danh qua 0h** cùng `clientRequestId` → trả lượt cũ, không thêm lượt, không cộng quà lần hai; mã mới mới tính ngày mới. Thiếu `clientRequestId` → 400.
- **Xoá lịch đang phát hành dở**: một transaction giữ khoá dòng tháng rồi phát hành, lệnh xoá gửi giữa chừng phải chờ và bị từ chối, lịch còn nguyên.
- **Tab cũ**: lưu ô bằng `updatedAt` cũ → 409, không ghi; đổi chỗ từ tab cũ giữ đúng quà vừa lưu ở tab khác.
- **Thống kê** với hơn 5.000 hộp mất đều đã làm nhiệm vụ → không hộp nào bị tính "chưa làm"; bài đăng 23:59:30 và 00:00:30 giờ VN tính đúng ngày.
- Admin: ô có quà mà không có nhiệm vụ bị từ chối (cả API lẫn `CHECK` DB); số ô 0 và vượt số ngày bị từ chối, giảm số ô tháng đang chạy bị từ chối; lưu ô với hạn vé 0, 365, 366 (366 bị từ chối); tổng tỉ lệ một quà 99 và 101 bị từ chối, 6 quà bị từ chối, món thẻ VIP / khung chưa chọn mã hoặc mã không tồn tại bị từ chối; sửa tháng đã qua bị từ chối; sửa hoặc đổi chỗ ô ≤ K của tháng đang chạy bị từ chối, ô K+1 lưu được; lịch nháp của tháng hiện tại không khoá ô nào và GET vẫn `enabled: false`; phát hành ngày 19 thì hôm đó chỉ khoá ô 1; phát hành tháng sau từ trước thì khoá tính từ ngày 1; phát hành 2 lần bị từ chối; hạn thẻ / khung 365 lưu được, 366 bị từ chối (form và API); chép lịch 28 ô sang lịch 30 ô.
- `play_game`: ván 2 người, ván nhiều người, ván `void` (không tính). `me_post`: bài "Chỉ mình tôi" có tính, bài bị ẩn không tính.
- POST khi nền tảng tắt → `CHECKIN_DISABLED`.

## 12. Deploy

0. Vé loa (migration `20261120000001` + api) phải lên trước hoặc cùng đợt, vì server điểm danh phát vé loa.
1. Chạy migration (cả 3 nền tảng mặc định tắt, chưa có lịch tháng nào). Migration tạo index trên các bảng lớn (`me_reactions`, `me_comments`, `game_matches`, `moment_comments`, `story_comments`) không dùng `CONCURRENTLY` (golang-migrate gửi cả file trong một lệnh nên Postgres chạy chung một transaction, các migration khác của repo cũng vậy), nên các bảng đó bị chặn ghi trong lúc tạo index: chạy lúc vắng người.
2. Deploy api và admin.
3. Vào admin **tạo lịch tháng hiện tại** (nháp, để trống rồi nhập từng ô theo cấu hình gợi ý ở mục 3) và **tháng sau** (chép từ tháng hiện tại), xem lại tỉ lệ, rồi bấm **Phát hành** cả hai, chọn danh sách nhiệm vụ ngẫu nhiên, xem lại công tắc xác thực email.
4. Deploy web, phát hành app.
5. Trong tab Cài đặt: chọn nền tảng muốn chạy rồi bật công tắc tổng "Bật điểm danh".
6. Việc hằng tháng: tạo và **phát hành** lịch tháng sau trước ngày cuối tháng (admin có cảnh báo từ ngày 20 nếu chưa có lịch hoặc còn nháp).

Không cần deploy chat hay game.
