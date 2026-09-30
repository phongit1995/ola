# Phòng nối từ

Tài liệu tính năng phòng nối từ (word chain) của Ola: luật chơi, vòng đời phiên và cách dữ liệu được lưu. Hợp đồng REST và socket cho client xem ở [api.md](api.md).

Code backend: `server/internal/modules/room/wordchain/`. Luật chơi lấy từ nhánh PvP của [minhqnd/Noi-Tu-Discord](https://github.com/minhqnd/Noi-Tu-Discord) (MIT). Chỉ lấy luật, không lấy cơ chế riêng của Discord.

## 1. Tổng quan

- Toàn hệ thống chỉ có **1 phòng nối từ**. Phòng không gắn với bảng `rooms`, không có `roomId`, không có danh sách phòng, không đếm số người.
- Người chơi nối từ với nhau (PvP). **Bot chỉ làm trọng tài**: chấm từng từ, báo thắng, mở ván mới. Bot không tự nối từ.
- User đã đăng nhập là chơi được, không cần join phòng qua ticket. Join socket chỉ để nhận realtime.
- Dữ liệu ván chơi nằm ở **Redis**. Postgres chỉ giữ 2 thứ: tiền **Gợi ý** (`users.ken`, `ken_transactions`) và lịch sử ghi điểm `word_chain_scores` để thống kê theo thời gian (xem mục 6).
- Tính năng phụ: **Tra từ** (hộp tra từ, và nút ⓘ nhỏ nằm ngoài bubble, cạnh mỗi từ nối đúng, để ai cũng xem được nghĩa), **Bảng xếp hạng** và **Gợi ý** (mất KEN).

## 2. Luật chơi

Một từ hợp lệ khi thỏa lần lượt các điều kiện dưới đây. Server dừng ở điều kiện đầu tiên bị sai và trả `code` tương ứng.

| Thứ tự | Điều kiện | `code` khi sai | Reaction |
|---|---|---|---|
| 1 | Đúng **2 âm tiết**, cách nhau bởi **1 dấu cách** | `invalid_format` | ⚠️ |
| 2 | Âm tiết đầu trùng âm tiết cuối của từ hiện tại | `mismatch` | ❌ |
| 3 | Chưa dùng trong ván hiện tại | `repeated` | ❌ |
| 4 | Có trong từ điển tiếng Việt (gọi API dict.minhqnd.com) | `not_in_dict` | ❌ |

Kết quả của từ hợp lệ:

- Nếu còn từ để nối tiếp: `code = ok` (✅). Từ đó thành từ hiện tại.
- Nếu **không còn từ nào để nối tiếp**: `code = win` (🏆). Người vừa nối **thắng ván**, bot mở ngay ván mới với từ mới. Từ mở ván được đưa luôn vào lịch sử, nên không ai nối lại được từ đó.
- Mỗi từ hợp lệ (`ok` hoặc `win`) được **+1 điểm**. Từ `win` được thêm **+1 trận thắng**. Điểm và trận thắng cộng dồn mãi, không reset theo phiên.
- Bảng xếp hạng có 2 tab **Điểm** và **Thắng**, lọc theo **Hôm nay / Tuần này / Tháng này / Tất cả** (giờ Việt Nam, tuần bắt đầu thứ Hai), và tab **Lịch sử** các trận thắng (tất cả hoặc của mình).
- Từ sai không bị trừ điểm, nhưng **mỗi người chỉ có 3 lượt đoán cho mỗi từ hiện tại**. Mọi kiểu sai (`invalid_format`, `mismatch`, `repeated`, `not_in_dict`) đều trừ 1 lượt.
  - Mỗi lần sai, bot gửi 1 tin `wrong_answer` ngay sau tin sai: lý do sai, số lượt còn lại, và từ hiện tại.
  - Hết 3 lượt thì server chặn (`403 WORD_CHAIN_NO_GUESSES`), không lưu tin. Người đó phải chờ tới khi có người khác nối đúng.
  - Khi từ hiện tại đổi (có người nối đúng, thắng ván, hoặc bot thay từ vì 12 giờ không ai nối) thì mọi người có lại đủ 3 lượt.
  - Số lượt sai nằm trong state (`wrongCounts`, không trả ra client). Mỗi lần từ đổi, `turn` tăng 1.
- **Không được nối 2 lần liên tiếp.** State lưu `wordOwnerId` là người đã nối ra từ hiện tại. Người đó gửi gì cũng bị chặn (`403 WORD_CHAIN_WAIT_TURN`), không trừ lượt, không lưu tin, tới khi có người khác nối đúng.
  - Từ do bot đưa ra (mở phiên, mở ván sau khi thắng, thay từ sau 12 giờ) không thuộc về ai, nên ai cũng nối được, kể cả người vừa thắng ván.
- Một ván giữ tối đa 100 từ gần nhất để kiểm tra từ lặp.

Chuẩn hoá trước khi chấm (`wordchain.normalize.go`):

- Đưa về NFC, chữ thường, bỏ khoảng trắng hai đầu.
- Đổi kiểu bỏ dấu cũ sang kiểu mới ở cuối âm tiết: `oà → òa`, `uý → úy` (trừ sau `q`, ví dụ `quý` giữ nguyên).
- Tin hiển thị giữ nguyên nội dung người gõ (`content`), từ đã chuẩn hoá nằm ở `word`.

### Gợi ý (mất KEN)

- Nút 💡 cạnh nút Gửi. Mỗi lần gợi ý tốn **500 KEN** (`HintPriceKen`), server trả tối đa **5 từ** (`HintMaxWords`) nối được vào từ hiện tại.
- Từ gợi ý lấy từ từ điển local (từ còn nối tiếp được đứng trước) rồi tới `suggest`, bỏ từ đã dùng trong ván, và phải được API `lookup` chấp nhận, cùng tiêu chí với lúc chấm từ.
- Server tìm gợi ý **trước**, có ít nhất 1 từ mới trừ KEN. Không tìm được thì trả `409 WORD_CHAIN_NO_HINT` và **không trừ tiền**. API từ điển lỗi thì trả `503` và cũng không trừ, kể cả khi chỉ lỗi `suggest` hoặc lỗi `lookup` ở một từ trong khi các từ khác vẫn tra được.
- Người đang không được chơi thì không mua được gợi ý: từ hiện tại do chính mình nối (`403 WORD_CHAIN_WAIT_TURN`) hoặc đã hết lượt đoán (`403 WORD_CHAIN_NO_GUESSES`). Không đủ KEN thì trả `400 WORD_CHAIN_INSUFFICIENT_KEN`.
- Trừ KEN trong một transaction Postgres có khoá dòng `users` (`FOR UPDATE`), ghi `ken_transactions` loại `WORD_CHAIN_HINT` (hiện trong lịch sử KEN của user với tên "Gợi ý nối từ"), rồi xoá user cache và bắn `KEN_UPDATED` cho mọi tab/thiết bị của user.
- Gợi ý chỉ là danh sách từ. Gửi từ gợi ý vẫn đi qua `POST /moves` như từ tự gõ, được chấm và cộng điểm bình thường. Nếu trong lúc đó có người khác nối trước thì gợi ý không còn khớp; client báo gợi ý đã cũ và khoá nút gửi.
- Tuỳ chọn **Tự động gửi** lưu ở máy người dùng (web: localStorage, mobile: MMKV, key `ola.word-chain.prefs`). Bật thì mua xong client gửi luôn từ đầu tiên; tắt thì hiện danh sách gợi ý, mỗi từ có nút Gửi.

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
| Chọn từ mở đầu phiên và ván | Bốc ngẫu nhiên từ từ điển local, rồi kiểm tra như trên. Thử tối đa 10 từ, không từ nào nối được thì báo lỗi, không mở ván bằng ngõ cụt |
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
| Xin ván mới (vote 15 giây), gợi ý, góp ý, thêm từ | Có | Không |
| Chơi với bot, DM | Có | Không |
| Phát hiện dán text / chống copy | Không có | Không có |

Về text dán vào: cả bot gốc và Ola đều không phân biệt được gõ hay dán. Server chỉ nhận chuỗi `content`. Chữ hoa, khoảng trắng hai đầu và tổ hợp dấu kiểu macOS/iOS (NFD) đều được chuẩn hoá. Còn các trường hợp sau sẽ bị chấm `invalid_format`, giống bot gốc:

- giữa 2 âm tiết có 2 dấu cách trở lên;
- xuống dòng hoặc tab;
- dấu cách không ngắt (NBSP) hoặc ký tự vô hình, thường gặp khi copy từ web.

## 6. Lưu trữ

### Redis

| Key | Kiểu | Nội dung |
|---|---|---|
| `WORD_CHAIN:STATE` | STRING (JSON) | Phiên hiện tại: `sessionId`, `word`, `history`, `sessionStartedAt`, `lastProgressAt`, `revision`, `turn`, `wrongCounts`, `botMessageId`, `wordOwnerId` |
| `WORD_CHAIN:STATE_REV` | STRING (INCR) | Bộ đếm `revision` của state, tăng mỗi lần state đổi |
| `WORD_CHAIN:MSG` | HASH | `messageId → JSON tin nhắn`. Chỉ lưu `senderId`, không lưu tên, avatar, VIP |
| `WORD_CHAIN:MSG_INDEX` | ZSET | `messageId`, score = `seq` |
| `WORD_CHAIN:MSG_SEQ` | STRING (INCR) | Bộ đếm `seq` của tin nhắn |
| `WORD_CHAIN:POINTS` | ZSET | `userId`, score = tổng điểm từ trước tới nay |
| `WORD_CHAIN:WINS` | ZSET | `userId`, score = tổng số trận thắng từ trước tới nay |
| `WORD_CHAIN:LOOKUP_COOLDOWN:<userId>` | STRING, TTL 5 giây | Cooldown tra từ |
| `WORD_CHAIN:WORD_EXISTS:<từ>` | STRING, TTL 24 giờ | Cache kết quả API `lookup`: `1` có, `0` không |
| `WORD_CHAIN:LOOKUP:<từ đã chuẩn hoá>` | STRING (JSON), TTL 24 giờ | Toàn bộ kết quả API `lookup` (nghĩa, dịch, từ liên quan). Tra từ trúng cache thì không tính cooldown |
| `LOCK:WORD_CHAIN` | STRING, TTL 15 giây | Lock toàn cục khi xử lý nước đi, tạo phiên và thay từ bot |

- Phòng giữ tối đa 5000 tin gần nhất. Vượt thì xoá tin cũ nhất. Ngoài giới hạn này không tin nào bị xoá; tin bot đưa ra từ đã hết hạn chỉ bị ghi đè bằng từ mới.
- Mọi thao tác ghi của một nước đi (state, điểm, tin người chơi, tin bot) nằm trong **một transaction Redis** (MULTI/EXEC), nên không có chuyện đổi từ mà không cộng điểm.
- Khi server đã lấy được lock, request bị hủy giữa chừng vẫn ghi đủ và vẫn phát event.
- **Không gọi API từ điển khi đang giữ lock.** Nước đi được chấm xong (kể cả chọn từ mở ván mới khi thắng) ở ngoài lock, dựa trên state có `revision` R. Vào lock, server chỉ kiểm tra state vẫn ở `revision` R rồi ghi. Nếu có người khác vừa nối trước (revision đã đổi) thì server chấm lại theo state mới, tối đa 3 lần, sau đó trả `409`.
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

Index: `(created_at)` cho bảng xếp hạng theo kỳ; `(created_at DESC) WHERE is_win` cho lịch sử thắng; `(user_id, created_at DESC) WHERE is_win` cho lịch sử thắng của một người.

- Điểm trong kỳ = `SUM(points)`, trận thắng trong kỳ = `COUNT(*) FILTER (WHERE is_win)`. Muốn thống kê khoảng khác chỉ cần đổi điều kiện `created_at`.
- Kỳ **Tất cả** đọc từ Redis ZSET (`POINTS`, `WINS`): nhanh và giữ nguyên điểm tích luỹ từ trước khi có bảng này. Hôm nay / Tuần / Tháng đọc từ Postgres, nên chỉ tính từ lúc deploy bảng.
- Mốc kỳ tính theo GMT+7: ngày từ 00:00, tuần từ 00:00 thứ Hai, tháng từ 00:00 ngày 1.
- Ghi Postgres **sau** khi transaction Redis thành công và **ngoài lock**. Ghi lỗi thì chỉ log, nước đi vẫn thành công; khi đó số liệu theo kỳ thiếu 1 dòng nhưng "Tất cả" vẫn đúng. Không ghi Postgres trước, vì Redis lỗi sau đó sẽ để lại dòng điểm không có thật.
- Đo trên 5 triệu dòng (khoảng 13.700 từ/ngày trong 1 năm): ghi 1 dòng ~0,1 ms; bảng xếp hạng hôm nay / tuần / tháng ~16 / 65 / 125 ms; lịch sử thắng dưới 1,5 ms. Thời gian truy vấn theo kỳ tăng theo số dòng trong kỳ, không theo tổng kích thước bảng. Khi lượng chơi tăng khoảng 10 lần thì nên thêm bảng cộng dồn theo ngày, dựng lại được từ bảng này.

## 7. Luồng realtime

```text
API service ──Kafka CHAT.WORD_CHAIN.EVENT──▶ Chat service ──Socket.IO──▶ kênh "word_chain"
```

- API service publish event sau khi nhả lock. Vì vậy 2 nước đi gần nhau có thể tới client **đảo thứ tự**.
- Client dùng `revision` (state) và `seq` (tin nhắn) để sắp lại và bỏ dữ liệu cũ. Chi tiết ở [api.md](api.md#4-quy-tắc-phía-client).

## 8. File chính

| File | Nội dung |
|---|---|
| `wordchain.constants.go` | Mọi hằng số: thời gian, giới hạn, cache key, code, reaction |
| `wordchain.normalize.go` | Chuẩn hoá tiếng Việt, tách âm tiết |
| `wordchain.dictionary.go` | Từ điển local: ứng viên để nối, bốc từ mở đầu |
| `wordchain.verifier.go` | Client gọi dict.minhqnd.com (`lookup`, `suggest`) và cache kết quả `lookup` |
| `wordchain.oracle.go` | Tiêu chí chung: từ có tồn tại, còn từ để nối không, chọn từ mở ván |
| `wordchain.engine.go` | Luật chấm một nước đi, không có I/O |
| `wordchain.service.go` | Lock, xử lý nước đi, tạo phiên, timer thay từ bot hết hạn, phát event |
| `wordchain.store.go` | Đọc và ghi Redis, transaction `Apply` |
| `wordchain.messages.go` | Nội dung tin bot |
| `wordchain.lookup.go` | Tra từ, cooldown chỉ áp dụng khi phải gọi API ngoài |
| `wordchain.hint.go` | Gợi ý: chọn từ, kiểm tra điều kiện, gọi ví trừ KEN |
| `wordchain.wallet.go` | Trừ KEN cho gợi ý trong transaction Postgres, ghi `ken_transactions` |
| `wordchain.leaderboard.go` | Ghi điểm vào Postgres, bảng xếp hạng theo điểm/thắng và theo kỳ (GMT+7), lịch sử thắng |
| `wordchain.repository.go` | Đọc và ghi bảng `word_chain_scores` |
| `wordchain.controller.go`, `wordchain.router.go` | REST |

Ngoài folder `wordchain`, tính năng này còn đụng tới:

- `constants/constant.go`: Kafka topic và tên event socket;
- `domain/room`: handler Kafka → socket;
- `transport/kafka`: producer, adapter;
- `transport/websocket`: kênh `word_chain`, event join/leave;
- `modules/room/room.dig.go` và `room.router.go`: gắn DI và route.
