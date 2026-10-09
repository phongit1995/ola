# Phòng nối từ

Tài liệu tính năng phòng nối từ (word chain) của Ola: luật chơi, vòng đời phiên và cách dữ liệu được lưu. Hợp đồng REST và socket cho client xem ở [api.md](api.md).

Code backend: `server/internal/modules/room/wordchain/`. Luật chơi lấy từ nhánh PvP của [minhqnd/Noi-Tu-Discord](https://github.com/minhqnd/Noi-Tu-Discord) (MIT). Chỉ lấy luật, không lấy cơ chế riêng của Discord.

## 1. Tổng quan

- Toàn hệ thống chỉ có **1 phòng nối từ**. Phòng không gắn với bảng `rooms`, không có `roomId`, không có danh sách phòng, không đếm số người.
- Người chơi nối từ với nhau (PvP). **Bot chỉ làm trọng tài**: chấm từng từ, báo thắng, mở ván mới. Bot không tự nối từ.
- User đã đăng nhập là chơi được, không cần join phòng qua ticket. Join socket chỉ để nhận realtime.
- Dữ liệu ván chơi nằm ở **Redis**. Postgres chỉ giữ 3 thứ: tiền **Gợi ý** và **Mua thêm lượt** (`users.ken`, `ken_transactions`, `word_chain_hint_purchases`), lịch sử ghi điểm `word_chain_scores` để thống kê theo thời gian (xem mục 6), và cấu hình bật/tắt phòng, giá gợi ý, giá mua thêm lượt trong `app_settings` (xem mục 9).
- Tính năng phụ: **Tra từ** (hộp tra từ mở từ nút bên trái ô nhập, và nút ⓘ nhỏ nằm ngoài bubble, cạnh mỗi từ nối đúng, để ai cũng xem được nghĩa), **Bảng xếp hạng**, **Gợi ý** và **Mua thêm lượt** (mất KEN).

## 2. Luật chơi

Một từ hợp lệ khi thỏa lần lượt các điều kiện dưới đây. Server dừng ở điều kiện đầu tiên bị sai và trả `code` tương ứng.

| Thứ tự | Điều kiện | `code` khi sai | Reaction |
|---|---|---|---|
| 1 | Đúng **2 âm tiết** (khoảng trắng thừa đã được gộp, xem phần chuẩn hoá) | `invalid_format` | ⚠️ |
| 2 | Âm tiết đầu trùng âm tiết cuối của từ hiện tại (các cách viết tương đương coi là một, xem phần chuẩn hoá) | `mismatch` | ❌ |
| 3 | Chưa dùng trong ván hiện tại (`bánh mì` và `bánh mỳ` tính là cùng một từ) | `repeated` | ❌ |
| 4 | Có trong từ điển tiếng Việt (gọi API dict.minhqnd.com). Âm tiết `y` sau phụ âm ghép (`chý`, `thỵ`, `nghỷ`) là sai chính tả, bị chấm luôn mà không gọi API | `not_in_dict` | ❌ |

Kết quả của từ hợp lệ:

- Nếu còn từ để nối tiếp: `code = ok` (✅). Từ đó thành từ hiện tại.
- Nếu **không còn từ nào để nối tiếp**: `code = win` (🏆). Người vừa nối **thắng ván**, bot mở ngay ván mới với từ mới. Từ mở ván được đưa luôn vào lịch sử, nên không ai nối lại được từ đó.
  - Web hiện hiệu ứng chúc mừng cho mọi người đang mở phòng: pháo giấy bắn từ 2 góc, thẻ có cúp, tên người thắng, từ thắng và "+1 trận thắng", bubble từ thắng sáng viền vàng. Thẻ tự tắt sau khoảng 4 giây hoặc khi bấm vào, không chặn ô nhập. Chỉ chạy khi tin thắng tới realtime (socket hoặc response của chính người thắng), tải lại lịch sử không hiện lại; máy bật giảm chuyển động thì bỏ pháo giấy và hiệu ứng nảy.
- Mỗi từ hợp lệ (`ok` hoặc `win`) được **+1 điểm**. Từ `win` được thêm **+1 trận thắng**. Điểm và trận thắng cộng dồn mãi, không reset theo phiên.
- Bảng xếp hạng có 2 tab **Thắng** (mở mặc định) và **Điểm**, lọc theo **Hôm nay / Tuần này / Tháng này / Tất cả** (giờ Việt Nam, tuần bắt đầu thứ Hai), và tab **Lịch sử** các trận thắng (tất cả hoặc của mình).
- Từ sai không bị trừ điểm, nhưng **mỗi người chỉ có 3 lượt đoán cho mỗi từ hiện tại**. Mọi kiểu sai (`invalid_format`, `mismatch`, `repeated`, `not_in_dict`) đều trừ 1 lượt.
  - Mỗi lần sai, bot gửi 1 tin `wrong_answer` ngay sau tin sai: lý do sai, số lượt còn lại, và từ hiện tại.
  - Hết 3 lượt thì server chặn (`403 WORD_CHAIN_NO_GUESSES`), không lưu tin. Người đó chờ tới khi có người khác nối đúng, hoặc **mua thêm 3 lượt** cho đúng từ đó (xem "Mua thêm lượt" bên dưới).
  - Khi từ hiện tại đổi (có người nối đúng, thắng ván, hoặc bot thay từ vì 12 giờ không ai nối) thì mọi người có lại đủ 3 lượt, lượt đã mua cho từ cũ mà chưa dùng thì mất.
  - Số lượt sai nằm trong state (`wrongCounts`, không trả ra client). Số lượt đã mua đọc từ `ken_transactions` theo `sessionId` + `turn` (chỉ đọc khi người đó đã sai từ 3 lần). Lượt còn lại = 3 + lượt đã mua − lượt sai. Mỗi lần từ đổi, `turn` tăng 1 nên lượt sai về rỗng và lượt đã mua của từ cũ không còn tính.
- **Không được nối 2 lần liên tiếp.** State lưu `wordOwnerId` là người đã nối ra từ hiện tại. Người đó gửi gì cũng bị chặn (`403 WORD_CHAIN_WAIT_TURN`), không trừ lượt, không lưu tin, tới khi có người khác nối đúng.
  - Từ do bot đưa ra (mở phiên, mở ván sau khi thắng, thay từ sau 12 giờ) không thuộc về ai, nên ai cũng nối được, kể cả người vừa thắng ván.
- Một ván giữ tối đa 100 từ gần nhất để kiểm tra từ lặp.

Chuẩn hoá trước khi chấm (`wordchain.normalize.go`):

- Đưa về NFC, chữ thường, bỏ khoảng trắng hai đầu.
- Gộp mọi khoảng trắng giữa các âm tiết (nhiều dấu cách, tab, xuống dòng, NBSP và các khoảng trắng Unicode khác) thành 1 dấu cách, nên gõ thừa dấu cách không bị mất lượt.
- Đặt dấu thanh lên `o`/`u` ở cuối âm tiết: `oà → òa`, `oè → òe`, `uý → úy` (trừ sau `q`, ví dụ `quý` giữ nguyên).
- Tin hiển thị giữ nguyên nội dung người gõ (`content`), từ đã chuẩn hoá nằm ở `word`. `word` vẫn giữ `i`/`y` như người gõ (`bánh mỳ`, `công ty`).
- Khi so âm tiết, kiểm tra từ lặp và lọc từ nối tiếp, server dùng khoá so sánh (`syllableKey` / `wordKey`), coi các cách viết tương đương là một:
  - Âm tiết chỉ gồm 1 phụ âm `h k l m s t` + `y` thì so như `i`: `mỳ = mì`, `kỹ = kĩ`, `ty = ti`. Từ điển lưu dạng `i`.
  - `qu` + `i` (kèm `t` hoặc không) so như `qu` + `y`: `quí = quý`, `quít = quýt`.
  - Nhờ vậy sau "bánh mỳ" gõ "mì chính" hay "mỳ tôm" đều được, và gợi ý `suggest` trả về "mì …" vẫn được tính là từ nối tiếp.
- Chặn `y` sau phụ âm ghép `ch gh kh nh ph th ngh`. API từ điển đổi `y → i` sau mọi chữ `h`, nên báo "báo chý" là có (thành "báo chí"). Nếu không chặn, âm tiết "chý" không khớp gợi ý "chí …" nào, server tưởng hết từ nối và cho thắng ngay.
- API chỉ đổi `qui → quy` khi chuỗi có "qui" không dấu, còn từ điển lưu lẫn cả hai kiểu ("quý báu" nhưng "yêu quí"). Vì vậy tra từ và chấm từ có âm tiết `qu` + `i/y` sẽ thử lần lượt các cách viết (tối đa 4 request); từ không có `qu` chỉ gọi 1 request như cũ.

### Gợi ý (mất KEN)

- Nút 💡 cạnh nút Gửi. Mỗi lần gợi ý tốn **500 KEN** theo mặc định, admin đổi được giá (mục 9). Server trả tối đa **5 từ** (`HintMaxWords`) nối được vào từ hiện tại.
- Từ gợi ý lấy từ từ điển local (từ còn nối tiếp được đứng trước) rồi tới `suggest`, bỏ từ đã dùng trong ván, và phải được API `lookup` chấp nhận, cùng tiêu chí với lúc chấm từ.
- Server tìm gợi ý **trước** (ngoài lock), có ít nhất 1 từ mới trừ KEN. Không tìm được thì trả `409 WORD_CHAIN_NO_HINT` và **không trừ tiền**. `suggest` lỗi thì trả `503` và cũng không trừ. `lookup` lỗi ở vài từ thì vẫn bán gợi ý nếu đã đủ 5 từ hợp lệ; chưa đủ 5 từ mà có lỗi thì trả `503`.
- Trước khi trừ tiền, server lấy lock toàn cục và đọc lại state. Nếu từ hiện tại vừa đổi (có người nối trước trong lúc tìm gợi ý) thì trả `409 WORD_CHAIN_WORD_CHANGED` và **không trừ tiền**.
- **Mỗi lượt chỉ trả tiền 1 lần.** Mỗi lần mua ghi 1 dòng vào bảng Postgres `word_chain_hint_purchases`, khoá chính (người mua, phiên, `turn`), **trong cùng transaction trừ KEN**: trừ tiền và ghi nhận đã mua cùng thành công hoặc cùng huỷ. Mua lại cho cùng lượt (bấm 2 lần, mạng gửi lại) thì server trả lại đúng danh sách cũ với `charged = false`, không gọi API từ điển và không trừ KEN. Client cũng giữ gợi ý đã mua trong store, nên đóng rồi mở lại hộp gợi ý vẫn thấy danh sách.
- Người đang không được chơi thì không mua được gợi ý: từ hiện tại do chính mình nối (`403 WORD_CHAIN_WAIT_TURN`) hoặc đã hết lượt đoán (`403 WORD_CHAIN_NO_GUESSES`). Không đủ KEN thì trả `400 WORD_CHAIN_INSUFFICIENT_KEN`.
- Trừ KEN trong một transaction Postgres có khoá dòng `users` (`FOR UPDATE`): kiểm tra lượt này đã mua chưa, trừ tiền, ghi `ken_transactions` loại `WORD_CHAIN_HINT` và dòng `word_chain_hint_purchases` (hiện trong lịch sử KEN của user với tên "Gợi ý nối từ"), rồi xoá user cache và bắn `KEN_UPDATED` cho mọi tab/thiết bị của user.
- Gợi ý chỉ là danh sách từ. Gửi từ gợi ý vẫn đi qua `POST /moves` như từ tự gõ, được chấm và cộng điểm bình thường. Nếu trong lúc đó có người khác nối trước thì gợi ý không còn khớp; client báo gợi ý đã cũ và khoá nút gửi.
- Tuỳ chọn **Tự động gửi** lưu ở máy người dùng (store `wordChainPrefsStore`, key `ola.word-chain.prefs`; web lưu ở localStorage, mobile lưu ở MMKV). Bật thì mua xong client gửi luôn từ đầu tiên; tắt thì hiện danh sách gợi ý, mỗi từ có nút Gửi.

### Mua thêm lượt (mất KEN)

- Chỉ mua được khi **đã hết lượt** cho từ hiện tại. Lúc đó web khoá ô nhập (chữ mờ "Hết lượt đoán") và nút Gửi đổi thành **Mua lượt**. Bấm vào mở hộp xác nhận: từ đang trả lời, số lượt, giá, số dư, và lưu ý lượt mua chỉ dùng cho từ này. Bấm **Mua 3 lượt** mới trừ tiền.
- Mỗi lần mua được **3 lượt** (`WordChainGuessPackSize`), giá mặc định **500 KEN**, admin đổi được (mục 9). Mua bao nhiêu lần cũng được: dùng hết 3 lượt mua thì lại mua tiếp.
- Lượt mua **chỉ dùng cho đúng từ đang trả lời**. Client gửi `sessionId` + `turn` của từ lúc mở hộp và giá đang hiện trên nút; từ đã đổi thì server trả `409 WORD_CHAIN_WORD_CHANGED`, giá đã đổi thì `409 WORD_CHAIN_PRICE_CHANGED` (client chỉ báo lỗi, người chơi tự tải lại trang), cả hai đều không trừ tiền. Hộp đang mở mà từ đổi thì web báo "Từ hiện tại đã đổi, bạn có lại lượt đoán miễn phí rồi" và bỏ nút mua.
- Server kiểm tra dưới lock toàn cục: còn lượt thì từ chối (`409 WORD_CHAIN_GUESSES_LEFT`), nên bấm 2 lần hay mạng gửi lại cũng chỉ trừ tiền 1 lần. Người vừa nối ra từ hiện tại không mua được (`403 WORD_CHAIN_WAIT_TURN`). Thiếu KEN thì `400 WORD_CHAIN_INSUFFICIENT_KEN`.
- Lượt đã mua **chỉ lưu ở Postgres**, không ghi vào Redis. Trong lock, server trừ KEN bằng 1 transaction: khoá dòng `users`, đếm lại lượt đã mua của từ này (khác với lúc kiểm tra thì từ chối), ghi `ken_transactions` loại `WORD_CHAIN_GUESS` (`ref_id` = `sessionId`, metadata có `turn`, `guesses`; hiện trong lịch sử KEN với tên "Mua lượt nối từ"). Transaction lỗi hay hết thời gian thì không trừ tiền và cũng không có lượt; đã commit thì có cả hai. Không cần bước thu hồi. Trừ xong thì xoá user cache và bắn `KEN_UPDATED` như gợi ý.
- Mua xong server bắn `WORD_CHAIN_GUESSES_UPDATED` riêng tới mọi socket của người mua, để tab/thiết bị khác cũng mở khoá ô nhập. Không có tin bot nào trong phòng, người khác không biết.
- Mua thêm lượt rồi thì dùng được Gợi ý cho từ đó như bình thường.

## 3. Vòng đời phiên và ván

```text
Phiên (session)                         tạo 1 lần, không hết hạn, tin nhắn luôn giữ
 ├─ Ván 1: bot đưa từ → nối … → ngõ cụt → 🏆 thắng
 ├─ Ván 2: bot đưa từ mới
 │    └─ 12 giờ không ai nối từ của bot → bot thay từ khác
 └─ …
```

- **Phiên** chỉ được tạo khi chưa có state nào (lần đầu có người vào, hoặc Redis mất state). Phiên không hết hạn, `sessionId` giữ nguyên, **tin nhắn không bao giờ bị xoá theo thời gian**.
- **Từ do bot đưa ra** (từ mở phiên, từ mở ván sau khi thắng) có hạn **12 giờ** tính từ lúc bot đưa ra (`lastProgressAt`). Hết hạn mà chưa ai nối đúng thì bot thay bằng từ khác:
  - ghi đè tin bot đã đưa ra từ cũ (`session_started` hoặc `game_started`) thành tin `game_started` với từ mới, **giữ nguyên `id`**, `seq` mới nên tin chuyển xuống cuối danh sách. Không có tin thông báo "đổi từ";
  - event realtime gửi lại tin đó (cùng `id`), client gộp theo `id` nên tự thay tin cũ;
  - tin người chơi (kể cả các lần đoán sai từ cũ) giữ nguyên. `turn` tăng 1, mọi người có lại đủ lượt.
- **Từ do người chơi nối** thì không bao giờ hết hạn. Phòng chờ tới khi có người nối tiếp.
- Từ sai không kéo dài hạn của từ bot.
- State lưu `botMessageId` là id tin bot đang đưa ra từ hiện tại. "Từ hiện tại là của bot" được suy ra từ `history` chỉ có 1 từ.
- Server đặt timer đúng thời điểm từ bot hết hạn, và kiểm tra lại mỗi khi có request đọc hoặc nối từ, nên từ vẫn được thay đúng hạn kể cả khi server restart. Nếu lúc đó không chọn được từ mới (API từ điển lỗi) thì giữ nguyên từ cũ, vẫn cho nối, và thử lại sau 30 giây.
- **Ván mới** (sau khi có người thắng) vẫn nằm trong phiên. Tin nhắn giữ nguyên, bot đăng thêm tin `win` và `game_started`.

## 4. Từ điển

| Việc | Nguồn |
|---|---|
| Kiểm tra từ có tồn tại | Luôn gọi API `dict.minhqnd.com/api/v1/lookup`, chỉ nhận kết quả có `lang_code = vi` |
| Kiểm tra ngõ cụt (còn từ nối tiếp không) | Còn ít nhất 1 từ chưa dùng **được API `lookup` chấp nhận**, cùng tiêu chí với lúc chấm từ (xem bên dưới) |
| Chọn từ mở đầu phiên và ván | Bốc ngẫu nhiên từ từ điển local. Bản thân từ đó phải được API `lookup` chấp nhận (từ điển local có từ sai chính tả, ví dụ "quến dỗ") và không còn là ngõ cụt theo cách kiểm tra ở trên. Thử tối đa 20 từ, không từ nào đạt thì báo lỗi |
| Tra từ cho người chơi | API `lookup` |

Từ điển local nằm ở `wordchain/assets/` (`wordPairs.json`, `customWords.json`, copy từ repo gốc) và được `go:embed` vào binary. **Hai file này phải có trong git**, thiếu thì server không build được.

Lý do vẫn cần từ điển local dù đã kiểm tra từ bằng API:

- API `lookup` chỉ trả lời "từ này có tồn tại không", không liệt kê được các từ bắt đầu bằng một âm tiết.
- API không có endpoint lấy từ ngẫu nhiên để mở ván.
- Từ điển local cho thêm ứng viên ngoài `suggest`, vì `suggest` chỉ trả tối đa khoảng 20 kết quả.

Cách kiểm tra "còn từ để nối" sau một từ đúng, ví dụ sau "đẹp đẽ" thì xét âm tiết "đẽ":

1. Lấy các từ chưa dùng bắt đầu bằng "đẽ" trong từ điển local. Nếu có từ nào đã được cache là hợp lệ thì kết luận còn từ.
2. Gọi API `suggest` để lấy thêm ứng viên.
3. Gọi `lookup` cho **mọi** ứng viên chưa biết kết quả, mỗi đợt 10 từ song song, ưu tiên ứng viên từ `suggest`. Gặp 1 từ hợp lệ là dừng ngay và kết luận còn từ.
4. Chỉ kết luận ngõ cụt (người vừa nối thắng) khi **đã kiểm tra hết** ứng viên và không từ nào hợp lệ. Nếu API lỗi ở ứng viên nào đó thì không kết luận thắng, nước đi trả `503` và không lưu gì.

Ví dụ: từ điển local có "đẽ mị" nhưng API `lookup` trả 404, còn `suggest("đẽ")` chỉ ra "đẽo…". Vậy "đẹp đẽ" là ngõ cụt và người nối nó thắng. Nếu chỉ tin từ điển local, phòng sẽ kẹt mãi ở từ "đẽ", vì từ người chơi nối không hết hạn.

Chi phí: trung vị mỗi âm tiết có 5 ứng viên, nhiều nhất là 225 (âm "ăn"). Âm tiết nhiều ứng viên hầu như luôn gặp từ hợp lệ ngay đợt đầu, nên chỉ trường hợp gần như mọi ứng viên đều không hợp lệ mới phải gọi nhiều đợt. Việc này chạy ngoài lock.

Khác bot gốc: bot gốc chỉ tính một ứng viên khi bản thân nó cũng còn nối tiếp được. Ola chỉ cần còn 1 từ hợp lệ để nối, đúng với câu "không còn từ nào để nối tiếp".

Kết quả `lookup` (có hoặc không) được cache 24 giờ trong Redis, nên các lần sau thường không phải gọi API.

Nếu API lỗi, hoặc không chọn được từ mở ván còn nối được, thì:

- nước đi (kể cả nước đi thắng) trả `503 WORD_CHAIN_VERIFY_FAILED` và **không lưu gì**;
- mở phiên lúc có người vào (chưa có state) trả `503`, lần gọi sau sẽ thử lại;
- thay từ bot đã hết hạn thì giữ nguyên từ cũ, request vẫn chạy bình thường, timer thử lại sau 30 giây.

## 5. Khác biệt so với bot gốc

| Hạng mục | Bot gốc (Discord) | Ola |
|---|---|---|
| Kiểm tra từ tồn tại | Từ điển local (`listWordSet`) | Gọi API dict.minhqnd.com |
| Kiểm tra ngõ cụt | Chỉ từ điển local | Còn từ chưa dùng được API chấp nhận. Ứng viên lấy từ local + `suggest` |
| Lịch sử ván mới sau khi thắng | Rỗng (từ mở ván chơi lại được) | Có sẵn từ mở ván |
| Kênh chơi | Kênh Discord do admin thêm | 1 phòng cố định |
| Kết thúc | Thắng thì mở ván mới | Giống bot gốc, thêm: từ của bot sau 12 giờ không ai nối thì bot thay từ khác (ghi đè tin bot cũ, giữ tin người chơi) |
| Thống kê | Chuỗi, kỷ lục, số lần thắng | Điểm = số từ hợp lệ, số trận thắng, lọc theo ngày/tuần/tháng, lịch sử thắng |
| Luật sai 3 lần reset chuỗi | Có | Không |
| Nối 2 lần liên tiếp | Được | Không được, phải chờ người khác nối |
| Gợi ý | Có, miễn phí, thưởng theo chuỗi | Có, mất KEN (mặc định 500), mỗi lượt chỉ trả 1 lần |
| Hết lượt đoán | Sai 3 lần thì reset chuỗi | Chờ người khác nối hoặc mua thêm 3 lượt cho từ đó (mất KEN, mặc định 500) |
| Xin ván mới (vote 15 giây), góp ý, thêm từ | Có | Không |
| Chơi với bot, DM | Có | Không |
| Phát hiện dán text / chống copy | Không có | Không có |

Về text dán vào: cả bot gốc và Ola đều không phân biệt được gõ hay dán. Server chỉ nhận chuỗi `content`. Chữ hoa, khoảng trắng (hai đầu, nhiều dấu cách, tab, xuống dòng, NBSP) và tổ hợp dấu kiểu macOS/iOS (NFD) đều được chuẩn hoá. Khác bot gốc, Ola không chấm `invalid_format` chỉ vì khoảng trắng thừa. Ký tự vô hình không phải khoảng trắng (ví dụ zero-width space) vẫn làm từ sai định dạng.

## 6. Lưu trữ

### Redis

| Key | Kiểu | Nội dung |
|---|---|---|
| `WORD_CHAIN:STATE` | STRING (JSON) | Phiên hiện tại: `sessionId`, `word`, `history`, `sessionStartedAt`, `lastProgressAt`, `revision`, `turn`, `wrongCounts`, `botMessageId`, `wordOwnerId` |
| `WORD_CHAIN:STATE_REV` | STRING (INCR) | Bộ đếm `revision` của state, tăng mỗi lần state đổi |
| `WORD_CHAIN:MSG` | HASH | `messageId → JSON tin nhắn`. Chỉ lưu `senderId`, không lưu tên, avatar, VIP |
| `WORD_CHAIN:MSG_INDEX` | ZSET | `messageId`, score = `seq` |
| `WORD_CHAIN:MSG_SEQ` | STRING (INCR) | Bộ đếm `seq` của tin nhắn |
| `WORD_CHAIN:LOOKUP_COOLDOWN:<userId>` | STRING, TTL 5 giây | Cooldown tra từ |
| `WORD_CHAIN:WORD_EXISTS:<từ>` | STRING, TTL 24 giờ | Cache kết quả API `lookup`: `1` có, `0` không |
| `WORD_CHAIN:LOOKUP:<từ đã chuẩn hoá>` | STRING (JSON), TTL 24 giờ | Toàn bộ kết quả API `lookup` (nghĩa, dịch, từ liên quan). Tra từ trúng cache thì không tính cooldown |
| `LOCK:WORD_CHAIN` | STRING, TTL 15 giây | Lock toàn cục khi xử lý nước đi, tạo phiên và thay từ bot |

- Phòng giữ tối đa 5000 tin gần nhất. Vượt thì xoá tin cũ nhất. Ngoài giới hạn này không tin nào bị xoá; tin bot đưa ra từ đã hết hạn chỉ bị ghi đè bằng từ mới.
- Mọi thao tác ghi Redis của một nước đi (state, tin người chơi, tin bot) nằm trong **một transaction Redis** (MULTI/EXEC). Điểm ghi vào Postgres ngay sau đó (xem bên dưới).
- Khi server đã lấy được lock, request bị hủy giữa chừng vẫn ghi đủ và vẫn phát event.
- **Không gọi API từ điển khi đang giữ lock.** Nước đi được chấm xong (kể cả chọn từ mở ván mới khi thắng) ở ngoài lock, dựa trên state có `revision` R. Vào lock, server chỉ kiểm tra state vẫn ở `revision` R rồi ghi.
- Client gửi kèm `sessionId` + `turn` của từ mà người chơi đang nhìn thấy. Nếu lúc chấm hoặc lúc ghi mà từ hiện tại đã đổi (có người nối trước, thắng ván, bot thay từ) thì server trả `409 WORD_CHAIN_WORD_CHANGED`: **không trừ lượt, không lưu tin**. Người chơi xem từ mới rồi gửi lại. Client không gửi `turn` thì server lấy `turn` ở lần đọc state đầu tiên.
- Nếu revision đổi nhưng từ vẫn vậy (ví dụ người khác vừa đoán sai) thì server chấm lại, tối đa 3 lần, sau đó trả `409` không có `code` (phòng bận).
- Tạo phiên (lúc vào lần đầu) và thay từ bot hết hạn cũng chọn và kiểm tra từ mới trước khi lấy lock.

### Postgres: `word_chain_scores`

Mỗi từ nối đúng là một dòng. Đây là nguồn cho thống kê theo thời gian và lịch sử thắng.

| Cột | Kiểu | Nội dung |
|---|---|---|
| `message_id` | uuid, PK | id tin nối từ. Ghi bằng `ON CONFLICT DO NOTHING` nên không bao giờ trùng |
| `session_id` | uuid | phiên chơi |
| `user_id` | uuid, FK `users` | người nối |
| `word`, `previous_word` | varchar(100) | từ vừa nối và từ được nối vào |
| `points` | smallint, mặc định 1 | điểm của lần nối này |
| `is_win` | boolean | đây có phải từ cuối (thắng) không |
| `created_at` | timestamptz | thời điểm nối |

Index:

- `(created_at)` cho bảng xếp hạng theo kỳ;
- `(created_at DESC, message_id DESC) WHERE is_win` cho lịch sử thắng;
- `(user_id, created_at DESC, message_id DESC) WHERE is_win` cho lịch sử thắng của một người;
- `(user_id) INCLUDE (points, is_win)` cho kỳ **Tất cả**: tổng điểm/thắng của một người, xếp hạng và đếm người chơi (migration `20261001000001`).

- Điểm trong kỳ = `SUM(points)`, trận thắng trong kỳ = `COUNT(*) FILTER (WHERE is_win)`. Muốn thống kê khoảng khác chỉ cần đổi điều kiện `created_at`.
- **Mọi kỳ, kể cả Tất cả, đều đọc từ bảng này.** Kỳ Tất cả là cùng câu truy vấn nhưng không giới hạn thời gian. Điểm của mình (`points` trong overview và response nối từ) và số người đã ghi điểm/đã thắng ở trang admin cũng đọc từ đây, nên mọi chỗ khớp nhau.
- Điểm ghi trước khi có bảng này (chỉ nằm ở 2 ZSET Redis cũ `WORD_CHAIN:POINTS`, `WORD_CHAIN:WINS`) không còn được tính. 2 key đó không còn dùng, xoá được.
- Mốc kỳ tính theo GMT+7: ngày từ 00:00, tuần từ 00:00 thứ Hai, tháng từ 00:00 ngày 1.
- Ghi Postgres **sau** khi transaction Redis thành công và **ngoài lock**, thử tối đa 3 lần (chờ 100 ms rồi 200 ms). Vẫn lỗi thì log, nước đi vẫn thành công nhưng thiếu 1 dòng điểm. Không ghi Postgres trước, vì Redis lỗi sau đó sẽ để lại dòng điểm không có thật.
- Đo trên 5 triệu dòng (khoảng 13.700 từ/ngày trong 1 năm): ghi 1 dòng ~0,1 ms; bảng xếp hạng hôm nay / tuần / tháng ~16 / 65 / 125 ms; lịch sử thắng dưới 1,5 ms. Thời gian truy vấn theo kỳ tăng theo số dòng trong kỳ, không theo tổng kích thước bảng. Khi lượng chơi tăng khoảng 10 lần thì nên thêm bảng cộng dồn theo ngày, dựng lại được từ bảng này.

### Postgres: `word_chain_hint_purchases`

Mỗi lần mua gợi ý là một dòng, ghi trong cùng transaction trừ KEN (migration `20261001000002`).

| Cột | Kiểu | Nội dung |
|---|---|---|
| `user_id`, `session_id`, `turn` | uuid, uuid, bigint, PK | người mua và lượt (từ hiện tại) đã mua gợi ý. Khoá chính chặn trừ tiền 2 lần cho cùng lượt |
| `word` | varchar(100) | từ hiện tại lúc mua |
| `hints` | text[] | danh sách gợi ý đã bán |
| `price` | integer | số KEN đã trừ |
| `ken_transaction_id` | uuid, FK `ken_transactions` | giao dịch trừ tiền tương ứng |
| `created_at` | timestamptz | thời điểm mua |

## 7. Luồng realtime

```text
API service ──Kafka CHAT.WORD_CHAIN.EVENT──▶ Chat service ──Socket.IO──▶ kênh "word_chain"
```

- API service publish event sau khi nhả lock. Vì vậy 2 nước đi gần nhau có thể tới client **đảo thứ tự**.
- Client dùng `revision` (state) và `seq` (tin nhắn) để sắp lại và bỏ dữ liệu cũ. Chi tiết ở [api.md](api.md#4-quy-tắc-phía-client).

## 8. File chính

| File | Nội dung |
|---|---|
| `wordchain.normalize.go` | Chuẩn hoá tiếng Việt, tách âm tiết |
| `wordchain.dictionary.go` | Từ điển local: ứng viên để nối, bốc từ mở đầu |
| `wordchain.verifier.go` | Client gọi dict.minhqnd.com (`lookup`, `suggest`) và cache kết quả `lookup` |
| `wordchain.oracle.go` | Tiêu chí chung: từ có tồn tại, còn từ để nối không, chọn từ mở ván |
| `wordchain.engine.go` | Luật chấm một nước đi, không có I/O |
| `wordchain.service.go` | Xử lý nước đi, tạo phiên, dựng mutation khi ghi nước đi |
| `wordchain.lock.go` | Lock toàn cục, gom event và phát sau khi nhả lock |
| `wordchain.timer.go` | Timer thay từ bot hết hạn |
| `wordchain.store.go` | Đọc và ghi Redis, transaction `Apply` |
| `wordchain.messages.go` | Nội dung tin bot |
| `wordchain.lookup.go` | Tra từ, cooldown chỉ áp dụng khi phải gọi API ngoài |
| `wordchain.hint.go` | Gợi ý: chọn từ, kiểm tra điều kiện, kiểm tra lại dưới lock, nhớ gợi ý đã mua |
| `wordchain.guess.go` | Mua thêm lượt: đọc lượt đã mua từ Postgres, kiểm tra giá và điều kiện dưới lock, trừ KEN, báo số lượt mới cho các thiết bị của người mua |
| `wordchain.wallet.go` | Sau khi trừ KEN: xoá user cache, bắn `KEN_UPDATED` |
| `wordchain.leaderboard.go` | Ghi điểm vào Postgres, bảng xếp hạng theo điểm/thắng và theo kỳ (GMT+7), lịch sử thắng |
| `wordchain.repository.go` | Bảng `word_chain_scores` (điểm, bảng xếp hạng, lịch sử thắng) và transaction trừ KEN cho gợi ý, mua thêm lượt (khoá dòng `users`, ghi `ken_transactions`) |
| `wordchain.config.go` | Đọc cấu hình `word_chain` (bật/tắt, giá gợi ý, giá mua thêm lượt), chặn khi phòng bị tắt |
| `wordchain.admin.go` | Dữ liệu cho trang admin: tổng quan ván hiện tại, lịch sử tin, trận thắng |
| `wordchain.controller.go`, `wordchain.router.go` | REST |

Ngoài folder `wordchain`, tính năng này còn đụng tới:

- `constants/constant.go`: mọi hằng số của tính năng (cache key, thời gian, giới hạn, code, mã lỗi), Kafka topic và tên event socket;
- `domain/room`: handler Kafka → socket;
- `transport/kafka`: producer, adapter;
- `transport/websocket`: kênh `word_chain`, event join/leave;
- `modules/room/room.dig.go` và `room.router.go`: gắn DI và route;
- `modules/setting`: key `word_chain` trong `app_settings`, endpoint `GET /settings/word-chain`;
- `modules/admin/wordchain`: API admin `/admin/word-chain`.

## 9. Admin

Menu admin **Phòng chat** tách thành 2 mục con:

- **Danh sách phòng** (`/rooms`): các phòng chat thường, như trước.
- **Phòng nối từ** (`/rooms/word-chain`): thẻ tổng quan (từ hiện tại, người đưa ra từ, các từ trong ván, số người đã ghi điểm/đã thắng, trạng thái hiển thị, giá gợi ý và giá mua thêm lượt) và 3 tab:
  - **Lịch sử nối từ**: tin nhắn của phòng, mới nhất trước, có nút tải thêm (Redis giữ 5000 tin gần nhất). Mỗi tin có nhãn kết quả: Đúng, Thắng, Sai âm đầu, Từ đã dùng, Không có trong từ điển, Sai định dạng, hoặc loại tin của trọng tài.
  - **Trận thắng**: đọc từ `word_chain_scores`, bấm vào người thắng để chỉ xem trận của người đó.
  - **Cấu hình**: bật/tắt hiển thị phòng, giá gợi ý và giá mua thêm lượt.

Cấu hình lưu ở `app_settings`, key `word_chain`:

```json
{ "enabled": true, "hintPrice": 500, "guessPrice": 500 }
```

- Chưa có dòng nào thì dùng mặc định: **hiển thị**, gợi ý **500 KEN**, mua thêm lượt **500 KEN**. Dòng cũ chưa có `guessPrice` thì dùng 500.
- Admin lưu qua `PUT /admin/settings/word_chain`. Server bắt buộc có `enabled` và `hintPrice`; `guessPrice` không bắt buộc (để admin bản cũ vẫn lưu được). Giá là số nguyên từ 1 đến 10.000.000, không nhận trường lạ.
- Tắt phòng (`enabled = false`):
  - web ẩn mục **Phòng nối từ** khỏi danh sách phòng (đọc `GET /settings/word-chain` mỗi lần mở tab Phòng chat và khi kéo làm mới);
  - server trả `403 WORD_CHAIN_DISABLED` cho `GET /rooms/word-chain`, `GET /messages`, `POST /moves`, `POST /hints` và `POST /guesses`. Người đang ở trong phòng thì lần gửi tiếp theo bị từ chối, client báo "Phòng nối từ đang tạm đóng", đóng phòng và ẩn luôn mục đó;
  - lịch sử, điểm, trận thắng và bảng xếp hạng giữ nguyên; timer thay từ của trọng tài tạm dừng, không thay từ khi phòng tắt.
- Giá gợi ý và giá mua thêm lượt đọc lại ở mỗi lần mua, nên đổi giá có hiệu lực ngay. `hintPrice`, `guessPrice` trong `GET /rooms/word-chain` và `price` trong response mua là giá thật đã áp dụng; client cập nhật giá hiển thị theo response.
- Đọc cấu hình lỗi (DB lỗi) thì server **coi như phòng đóng**, để không vô tình mở lại phòng admin đã tắt: trả `503 WORD_CHAIN_UNAVAILABLE` cho các endpoint trên, timer thay từ thử lại sau 30 giây.
- API admin (cần quyền admin): `GET /admin/word-chain` (tổng quan, không tạo phiên mới), `GET /admin/word-chain/messages?limit&before`, `GET /admin/word-chain/wins?limit&before&userId`.

## 10. Mobile

Màn nối từ trên mobile nằm ở `mobile/src/screens/room/word-chain/`, dùng chung toàn bộ logic với web qua `@ola/shared` (`wordChainStore`, `wordChainConfigStore`, `wordChainPrefsStore`, `lib/wordChain`, chuỗi dịch). Mobile chỉ viết lại tầng giao diện.

- Route `WordChain` nằm trong stack của tab Phòng chat, nên tab bar vẫn hiện như phòng chat thường. Vào màn thì mở phòng, thoát thì đóng; admin tắt phòng thì tự quay về danh sách. Đăng xuất reset store.
- Danh sách phòng có dòng **Phòng nối từ** ngay dưới **Chọn phòng nhanh**, ẩn khi admin tắt. Cấu hình đọc lại mỗi lần mở tab và khi kéo làm mới.
- Feed dùng `FlashList` + `useStickyBottomList` (bám đáy, tải thêm tin cũ khi cuộn lên đầu), bàn phím qua `ChatKeyboardArea` như phòng chat.
- Hộp thoại dùng `Dialog` chuẩn của mobile: Gợi ý, Tra từ / nghĩa từ, Bảng xếp hạng (Thắng / Điểm / Lịch sử + lọc kỳ), Luật chơi.
- Hiệu ứng thắng dùng Reanimated: pháo giấy tính quỹ đạo trên UI thread, thẻ cúp có tia sáng SVG xoay, viền vàng quanh bubble từ thắng. Máy bật giảm chuyển động thì bỏ pháo giấy và hiệu ứng nảy. Khác web: chữ từ thắng màu vàng đặc (RN không có chữ gradient) và dùng font hệ thống đậm thay cho Baloo 2.
- Icon nối từ (`.webp`) copy từ web vào `mobile/src/assets/icons/word-chain/`, gom trong `wordChainAssets.ts`.

