# War God — Thiết kế lại cách chơi & bộ icon

> Mục tiêu: chốt lại **luật chơi** và **bộ icon** của game War God, từ chẩn đoán hiện trạng đến bộ cơ chế mới, kèm chi phí kỹ thuật và thứ tự triển khai.
>
> Nguồn đã đọc & kiểm chứng:
> - Luật server: [`board.go`](../server/internal/game/games/war-god/board.go), [`battle.go`](../server/internal/game/games/war-god/battle.go), [`logic.go`](../server/internal/game/games/war-god/logic.go), [`logic_test.go`](../server/internal/game/games/war-god/logic_test.go)
> - Engine: [`engine.go`](../server/internal/game/engine/engine.go), [`settlement.go`](../server/internal/game/engine/settlement.go), [`settlement.repository.go`](../server/internal/game/settlement.repository.go)
> - Client: [`logic/core.ts`](../game/war-god/logic/core.ts), [`logic/battle.ts`](../game/war-god/logic/battle.ts), [`logic/server-types.ts`](../game/war-god/logic/server-types.ts), [`screens/battle/index.ts`](../game/war-god/screens/battle/index.ts), [`screens/battle/hud.ts`](../game/war-god/screens/battle/hud.ts), [`screens/lobby/guide-popup.ts`](../game/war-god/screens/lobby/guide-popup.ts)
> - Icon: 8 file trong [`game/war-god/assets/items/`](../game/war-god/assets/items/) — đã đo hue/sat/light bằng Pillow, số liệu ở mục 2.2
>
> Trạng thái: **plan, chưa code**. Toàn bộ trị số là điểm khởi đầu, cần playtest.

---

## 0. Kết luận (TL;DR)

**Kiến trúc tạo game đã chuẩn, không cần sửa.** Server authoritative, RNG deterministic lưu trong state, `Steps[]` là kịch bản animation để client replay — thiết kế này tốt và giữ nguyên.

**Luật chơi thì cần làm lại**, và vấn đề không nằm ở trị số:

- 6 ô nhưng chỉ có 5 vai, trong đó ô Đá là "kiếm yếu" và ô Nước là ô rác (vì tuyệt chiêu không đáng tiêu)
- Không có tương tác giữa hai người chơi ngoài việc trừ HP
- Không leo thang: lượt 1 và lượt 20 giống nhau
- Bàn 64 ô đồng nhất suốt trận, không có ô đặc biệt — trong khi **ô đặc biệt là nguồn vui chính của mọi match-3 thành công**

**Bộ icon có lỗi khả đọc thật**, không phải chuyện thẩm mỹ: bàn 8×8 hiện chỉ có **3 màu đọc được** cộng 3 khối xám-lam. Kiếm và Lửa cùng hue 31°; Đá và Nước cùng hệ lam.

**Hướng đã chốt (Phương án B):** 6 ô mới với **Kiếm là nguồn damage** (Kiếm thường bị giáp chặn, Kiếm Lửa xuyên giáp), ba thanh **HP 200 / Nội Lực 100 / Nộ 100**, giữ 2 ô đặc biệt (Kiếm Lửa + Đại Trái Tim), **nổ theo loại ô** (mỗi Lôi được ghép hoặc bị Kiếm Lửa nổ trúng giật 1 ô ngẫu nhiên, Kiếm Lửa nổ 3×3), bảng màu 6 hue cách đều tối thiểu 35°.

---

## 1. Hiện trạng: cách thức tạo game

Phần này **đã ổn, giữ nguyên**. Ghi lại để người đọc sau không phải dò lại.

Luật nằm hoàn toàn ở server, client chỉ là máy chiếu:

- [`logic.go`](../server/internal/game/games/war-god/logic.go) implement interface chuẩn `Init(seed)` → `ValidateMove` → `Apply` → `Result` / `KeepTurn` / `TimeoutSkipsTurn`, tự `Register()` vào registry
- RNG là splitmix64, **seed lưu trong state dưới dạng string** → toàn bộ trận deterministic, restore được sau restart
- `DecodeState` validate kỹ: đúng cỡ bàn, tile hợp lệ, không còn match chưa xử, còn nước đi, HP/MP/giáp trong ngưỡng
- `Apply` trả state mới (copy board + fighters), không mutate → rollback được khi persist lỗi
- `Steps[]` là **kịch bản animation** do server sinh (swap → match → gravity → special → shuffle), client replay rồi snap về board authoritative. Không có cách nào client tự tính damage trong PvP
- Thứ tự đi trước **được random** (`rand.Intn(2)` swap p0/p1, [engine.go:1511](../server/internal/game/engine/engine.go#L1511)) → không có lợi thế người đi trước
- Luồng bàn: tạo bàn (cược + mật khẩu) → khách join → ready → chủ start → escrow Ken → match. Có reserve/lock chống double-join, grace 30s khi mất kết nối và **đồng hồ lượt bị pause** trong lúc đó
- Lượt 45s (`GAME_TURN_SECONDS`, [config.go:23](../server/internal/config/config.go#L23)), 3 lần timeout liên tiếp thì xử thua
- Hoa hồng 5% (`WARGOD_COMMISSION_PERCENT`), thắng cược nhận `+0,95 × bet`

Đã kiểm phần cược: client chặn `bet > ken` và `bet > maxBet`, server chặn qua `ensureCanBet` (balance) và hằng `MaxBet` — `maxBet` client nhận chính là `engine.MaxBet` nên **không có lỗ hổng** ở đây.

### 1.1 Bộ ô & tài sản hiện có (đã verify trong code)

Chốt lại điểm xuất phát để phân biệt "đang có" với "sẽ thêm". **Đào Tiên / Nộ / Lôi / hệ nổ đều chưa tồn tại** — toàn bộ mục 3–7 là làm mới, không phải sửa.

| Hạng mục | Hiện tại |
|---|---|
| Bộ ô | 6 base: `sword · fire · heart · water · shield · stone` + special `fireSword`, `greaterHeart` ([core.ts:4-7](../game/war-god/logic/core.ts#L4-L7)) |
| Assets | `sword/fire/heart/water/shield/stone/fire-sword-v1/greater-heart-v1` — **không có** `peach.png`, `lightning.png` |
| Thanh | 2 thanh HP + MP (nội lực). **Chưa có** thanh/flag Nộ |
| Nổ | **Không** có cơ chế nổ nào |
| Đào / ×2 / xuyên giáp | **Không** tồn tại — `Fighter` chỉ có `HP/MP/Armor` ([battle.go:20-24](../server/internal/game/games/war-god/battle.go#L20-L24)) |
| Guide in-game | Chỉ nhắc `❤️ Tim · 💧 Nước · tuyệt chiêu 50 nội lực` ([guide-popup.ts:11-18](../game/war-god/screens/lobby/guide-popup.ts#L11-L18)) |
| StateVersion | `1` |

---

## 2. Chẩn đoán hiện trạng

### 2.1 Luật chơi — vấn đề không nằm ở trị số

| # | Vấn đề | Biểu hiện |
|---|---|---|
| 1 | **Không có quyết định thú vị** | Mỗi lượt chỉ là "quét bàn tìm nước nhiều damage nhất". Không trade-off, không setup cho lượt sau |
| 2 | **Không có tương tác giữa 2 người** | Chung một bàn nhưng không bao giờ *làm gì* tới đối thủ ngoài trừ HP |
| 3 | **Không leo thang** | Lượt 1 và lượt 20 y hệt. Cao trào duy nhất là ult 25 dmg — mà nó còn yếu |
| 4 | **Bàn 64 ô đồng nhất suốt trận** | Không có ô nổ, ô khoá, ô mục tiêu |
| 5 | **Hai người chơi giống hệt nhau** | Không tướng, không kỹ năng |
| 6 | **1/6 bàn là ô rác** | Ô Nước vô nghĩa vì ult không đáng tiêu |

Chi tiết hai lỗi trị số nặng nhất:

**Ô Đá là kiếm yếu.** Đá 3 dmg và Kiếm 5 dmg đều là vật lý, đều bị giáp chặn ([battle.go:57](../server/internal/game/games/war-god/battle.go#L57)) — Đá không có bản sắc gì.

**Tuyệt chiêu về mặt toán là nước đi tệ.** 50 MP, 25 damage, và **mất luôn quyền thêm lượt** ([logic.go:233](../server/internal/game/games/war-god/logic.go#L233)):

- 3 ô Nước = 21 MP → cần ~2,4 nước "nước" (0 damage) để nạp đủ
- Rồi tiêu thêm 1 lượt để ra 25 damage
- Tức ~3,4 lượt cho 25 damage (≈7/lượt), so với ~15/lượt khi chỉ ghép kiếm

Bot mức KHÓ lại `return true` vô điều kiện khi đủ mana ([battle.ts:229](../game/war-god/logic/battle.ts#L229)) → bot khó đang chơi *dở hơn* ở điểm này.

**Nước 4 ô tim quá mạnh:** 16 HP + 8 HP Đại Trái Tim = 24 HP + thêm lượt, không bị chặn bởi gì cả. So với 4 ô kiếm = 20 damage mà còn bị giáp ăn.

**Điểm thiết kế tốt duy nhất:** cặp Kiếm (15 dmg bị chặn) vs Lửa (12 dmg xuyên giáp) tạo quyết định thật.

### 2.2 Bộ icon — số liệu đo được

```
ô        cỡ file    hue     sat    light
tim      256x238   353,1°   87%     58%   ← rực
nước     191x256   197,6°   91%     54%   ← rực
lửa      219x256    31,1°   85%     51%   ← rực
kiếm     237x256    31,3°   34%     64%   ← đục
khiên    211x256   169,8°   13%     50%   ← đục
đá       251x256   207,9°   10%     57%   ← đục
```

1. **Kiếm và Lửa cùng hue 31°.** Kiếm ra beige-cam vì cán vàng cộng lưỡi bạc ngả ấm. Chúng chỉ khác độ rực, mà hue là kênh mắt đọc trước nhất
2. **Đá 208° và Nước 198° cùng hệ lam**, cũng chỉ khác độ rực
3. **Khiên bị triệt màu**: vàng cộng lam trộn lại còn sat 13% → ở cỡ 41px là một khối xám-teal, gần với Đá (10%)
4. Kết quả: bàn 8×8 thực chất chỉ có **3 màu đọc được** (đỏ, cam, cyan) cộng **3 khối xám-lam** phải phân biệt bằng hình dáng ở 41px. Với match-3 đây là **lỗi khả đọc**
5. **Vàng làm accent trên cả Kiếm lẫn Khiên** → thêm một điểm nhầm
6. **Tỉ lệ không đồng nhất** (191×256 → 256×238) mà code chuẩn hoá theo cạnh dài ([battle/index.ts:218](../game/war-god/screens/battle/index.ts#L218)) → Nước render ~30×41px còn Tim ~41×38px, **lệch ~25% khối lượng thị giác**. Icon không được vẽ trên canvas chung
7. **Nguồn 256px, render 41px** → nặng gấp ~6 lần; 8 PNG rời ~610KB, không atlas
8. Outline không nhất quán: Kiếm/Đá/Khiên/Nước dùng viền đen-navy trung tính, Tim/Lửa dùng viền self-color
9. Tên file còn hậu tố `-v1` (asset tạm)

---

## 3. Bộ 6 ô mới

**Nguyên tắc: chỉ Kiếm (thường + Kiếm Lửa) gây damage.** Người mới mở game ra là hiểu ngay, và mỗi ô có một vai không trùng ai.

| ô | vai | trị số |
|---|---|---|
| ⚔️ **Kiếm** | Nguồn damage chính. **Giáp chặn được** | **7/ô** |
| 🍑 **Đào Tiên** | Nạp thanh Nộ | **+10 Nộ/ô** |
| 💧 **Nước / Xoáy Âm Dương** | Nạp Nội Lực (mana) | **+7 MP/ô** |
| ❤️ **Tim** | Hồi máu | **5/ô** |
| 🛡️ **Khiên** | Giáp, tiêu hao 2/lượt, ≥20 giáp thì phản 2 dmg | **5/ô**, cap 30 |
| ⚡ **Lôi** | **0 damage tự thân** — mỗi Lôi được ghép hoặc bị Kiếm Lửa nổ trúng giật 1 ô ngẫu nhiên | nổ |

**2 ô đặc biệt** (giữ từ game hiện tại, sinh hiếm ~1/60, là biến thể của ô thường — ghép chung với ô gốc được):

| ô | sinh từ | vai | trị số |
|---|---|---|---|
| 🔥⚔️ **Kiếm Lửa** | Kiếm | Damage **xuyên giáp** + **nổ khối 3×3** | **12/ô** |
| ❤️➕ **Đại Trái Tim** | Tim | Hồi máu nhiều | **10/ô** |

**Ba thanh: HP 200 · Nội Lực (mana) 100 · Nộ 100.** Để HP 200 cho trận **dài hơn** — máu ít thì trận kết thúc quá nhanh; đồng thời cú Nộ/ult không one-shot. *(Trị số damage/hồi ở trên là điểm khởi đầu cho HP 200, cần playtest lại nhịp trận.)*

### Vì sao bộ này tốt hơn

| | |
|---|---|
| **Nhìn là hiểu** | Kiếm = đánh. Không phải học 3 loại damage với chuyện xuyên giáp hay không |
| **Không ô nào trùng vai** | Lỗi "Đá là kiếm yếu" tan biến hoàn toàn |
| **Ô Kiếm trở nên quý** | Một nguồn damage → mỗi cụm kiếm trên bàn là mục tiêu. Bàn có sức căng |
| **Sinh quyết định thật** | Ăn kiếm ngay, hay nạp Đào trước rồi mới ăn? |
| **Trận có nhịp** | nạp → bung → dồn kiếm. Có sóng, có cao trào |
| **Sửa luôn lỗi tim quá mạnh** | Hồi máu giờ 12,5% HP/nước so với damage 17,5% → thế thủ tự yếu đi, **không cần cơ chế chống thủ riêng** |

**Lôi là ô hay nhất bộ:** 0 damage nhưng nó **tạo cơ hội đánh** — giật số mục tiêu bằng số Lôi được kích hoạt, xáo trộn ô rơi, và damage đến từ ô Kiếm bị sét ăn.

### Cái phải đánh đổi

Bỏ Lửa là **bỏ mất cặp thiết kế tốt nhất đang có** (Lửa xuyên giáp vs Kiếm bị chặn). Mất chiều đó thì giáp có nguy cơ thành quá mạnh vì chỉ còn một nguồn damage để chặn.

**Cách bù: Nộ cho Kiếm xuyên giáp.** Chiều sâu chuyển từ *"chọn ô nào"* sang *"chọn thời điểm nào"* — giáp vẫn có ý nghĩa, và Nộ trở thành lời đáp cho giáp. Cộng thêm giáp tiêu hao 2/lượt thì cân.

---

## 4. Hai thanh — phân vai để không trùng nhau

Cả hai thanh đều nạp bằng ghép ô, nên phải khác nhau ở **cách dùng**:

| | 💧 NỘI LỰC → Tuyệt chiêu | 🍑 NỘ → Kiếm đau hơn |
|---|---|---|
| Nạp bằng | Ô Nước, +7/ô | Ô Đào Tiên, +10/ô |
| Điều kiện dùng | **Không cần gì** — bấm là ra damage | **Phải có nước kiếm trên bàn** |
| Cho gì | Tiêu hết MP (tối thiểu 50), damage = **MP/2**, xuyên giáp | Nước kiếm kế tiếp **×2 + xuyên giáp**, rồi reset 0 |
| Vai | **Sàn** — đường ra khi bàn bí, chắc chắn có | **Trần** — ăn to nhất game, nhưng có điều kiện |
| Con số | 50 MP → 25 · 100 MP → **50** | 3 kiếm → **42** · 4 kiếm → **56** |

**Nộ không tự bung.** Đầy 100 thì đứng đó chờ. Chỗ hay nằm ở chữ "chờ": đầy Nộ rồi mà bàn chỉ có nước kiếm 3 ô — ăn luôn (42) hay chịu rủi ro đợi một lượt dựng nước 4 ô (56)? Đợi thì đối thủ được đánh thêm một nước. Quyết định có rủi ro, xuất hiện mỗi lượt.

Hai thanh tạo trục quyết định thứ hai: tích MP tới 100 để ult 50, hay bung sớm ở 50 lấy 25? Hai trục chạy song song suốt trận.

**Nộ chặn ở 100**, ghép Đào thêm là thừa → tạo áp lực phải dùng.

### Ult giải quyết rủi ro lớn nhất của thiết kế

Chỉ Kiếm gây damage mà Kiếm chiếm 1/6 bàn → sẽ có lượt không có nước kiếm nào. Nếu xử lý sai, game cho **cảm giác bất lực** — đúng ngược mục tiêu.

Ba lớp bảo vệ:

1. **Ult là đường ra.** Bàn không có kiếm thì vẫn bung được tuyệt chiêu. Đây chính là lý do giữ ô Nước
2. **Ô Lôi để "đào" ra kiếm.** Bốn mục tiêu ngẫu nhiên xáo trộn nhiều cột trên bàn, tạo cơ hội cascade mới
3. **Không lượt nào là lượt trắng.** Lượt không có kiếm thì nạp Đào, hồi máu, lên giáp — đang đầu tư cho cú đánh sau. Cần truyền đạt qua UI: thanh Nộ nhích lên phải thấy rõ và sướng

### UX bắt buộc

**Khi Nộ đầy 100, mọi ô Kiếm trên bàn phát sáng.** Đây là cách truyền đạt trực tiếp nhất — người chơi không cần đọc hướng dẫn để hiểu "ăn kiếm bây giờ sẽ đau".

---

## 5. Weighted spawn — bắt buộc phải có

Kiếm là nguồn damage duy nhất mà chỉ chiếm 1/6 bàn → phải nâng tỉ lệ sinh:

```
Kiếm 22%  ·  Đào 16%  ·  Tim 16%  ·  Lôi 16%  ·  Khiên 15%  ·  Nước 15%
```

Kỹ thuật: đổi `r.tile()` từ `next() % tileCount` ([board.go:37-39](../server/internal/game/games/war-god/board.go#L37-L39)) sang bảng trọng số lũy tích. RNG vẫn deterministic, `createBoard` vẫn retry như cũ, `findMatches` không đụng.

---

## 6. Hệ thống nổ (theo loại ô)

**Nổ = xoá thêm ô ngoài cụm ghép, và các ô bị nổ VẪN tính hiệu ứng.** Damage/hồi/mana đến từ chính các ô bị nổ trúng. Nổ đến từ **loại ô**, không phải từ hình ghép.

| Nguồn | Điều kiện | Hình nổ | Số ô nổ thêm |
|---|---|---|---|
| ⚡ **Lôi** | có Lôi trong cụm ghép hoặc bị Kiếm Lửa nổ trúng | mỗi ô Lôi phóng sét tới 1 mục tiêu ngẫu nhiên, không trùng | bằng số Lôi được kích hoạt |
| 🔥⚔️ **Kiếm Lửa** | nằm trong cụm ghép (ghép chung Kiếm được) | khối 3×3 | 8 ô quanh mỗi Kiếm Lửa |

> Lôi **0 damage tự thân** — giá trị là giật trúng ô Kiếm để lôi damage ra. Kiếm Lửa vừa tự gây 12 damage xuyên giáp, vừa nổ 3×3.

![Mock UI ghép ba Lôi giật ba mục tiêu](./war-god-lightning-mock.png)

### Cách tính (một wave)

```
1. findMatches       → cụm ghép ≥3 (counts + danh sách ô match)
2. computeExplosions → từ Kiếm Lửa trong cụm, gom vùng 3×3; Lôi trong cụm hoặc vùng lửa phóng thêm tia
3. gộp counts        → cộng loại của ô bị nổ vào bảng đếm
4. applyTileEffects  → tính damage/hồi/mana/giáp MỘT LẦN từ counts đã gộp
5. gravity + spawn   → ô trống rơi xuống, sinh ô mới
6. lặp lại từ (1)    → cascade nếu tạo cụm mới
```

### Quy tắc

- **Chỉ có dây Kiếm Lửa → Lôi**: Lôi bị vùng 3×3 chạm sẽ phóng đúng một tia. Mục tiêu ngẫu nhiên của tia không kích hoạt tiếp Lôi/Kiếm Lửa khác (tránh chuỗi vô tận). Nổ dây vẫn xảy ra tự nhiên qua bước rơi (5) → tạo cụm mới → nổ mới.
- **Nộ ×2 chốt theo Nộ TRƯỚC wave**: chỉ ×2 khi thanh Nộ đã đầy 100 *từ trước khi* wave này tính effect, áp cho damage Kiếm/Kiếm Lửa **kể cả** phần damage từ ô Kiếm bị nổ trúng, rồi reset về 0. Ô **Đào ăn trong chính wave này chỉ nạp Nộ cho các nước sau**, không tự làm đầy-rồi-×2 ngay trong wave (tránh mơ hồ thứ tự nạp/tiêu; khớp `applyTileEffects` server & client).
- **Server-authoritative**: PvP dùng RNG đã lưu trong state để chọn số mục tiêu bằng số Lôi được kích hoạt, rồi gửi cả mapping `source → target` cho hai máy replay giống hệt nhau. Bot chọn mục tiêu một lần và dùng chung kết quả cho effect, FX và gravity.

### Ví dụ

- Ghép 3 **Lôi** giật trúng 2 Kiếm + 1 Tim → **14 damage** (2×7, bị giáp chặn) + 5 HP, dù Lôi tự thân 0 damage.
- Ghép **Kiếm + Kiếm Lửa + Kiếm**: cụm = 2×7 + 1×12 (xuyên giáp) = **26**; Kiếm Lửa nổ 3×3 trúng thêm 3 Nước + 2 Tim + 1 Kiếm → **+7 damage, +21 MP, +10 HP**.

### Thêm lượt & hệ nhân

- **Thêm lượt cộng dồn**: mỗi đường ngang/dọc ≥4 ô trong một wave nhận **+1 lượt**; hai đường riêng nhận +2, một đường 5+ vẫn là +1. Các cascade tiếp tục cộng vào bank. Nếu wave không có đường 4+ nhưng dọn ≥5 ô match (T/L/thập hoặc nhiều cụm 3), giữ luật cũ +1; ô chỉ bị nổ không tính điều kiện.
- **Chỉ Nộ là hệ nhân duy nhất.** Nổ là nguồn *cascade*, Nộ là nguồn *nhân* — không chồng hệ nhân thứ hai để tránh one-shot.
- Van an toàn cần playtest: cụm Kiếm lớn trong Nộ + nổ + cascade vẫn có thể vọt cao (cân nhắc cap damage/wave, hoặc Nộ chỉ ×2 ở wave đầu). Với HP 200 thì rủi ro one-shot đã giảm hẳn.

---

## 7. Ô đặc biệt: giữ Kiếm Lửa + Đại Trái Tim

Phương án B **giữ 2 ô đặc biệt** sẵn có trong game (`fireSword`, `greaterHeart`) — biến thể của Kiếm/Tim, sinh hiếm ~1/60, ghép chung với ô gốc được. Kiếm Lửa nay thêm **nổ 3×3** (mục 6).

**Đã loại bỏ** hệ "ô đặc biệt tạo theo hình ghép" (Phù Văn match-4 / Bùng Nổ hình L-T / Thần Khí match-5) từng cân nhắc ở bản nháp trước: nó bắt phải refactor `findMatches` để nhận diện hình dạng và thêm một tầng phức tạp lớn. Với B, **nổ đến từ loại ô** (Lôi, Kiếm Lửa) chứ không từ hình ghép → đơn giản hơn nhiều, không cần refactor findMatches, mà vẫn có cascade và cao trào.

Nguồn "khoảnh khắc" đã đủ ba: **Nộ, ult, và nổ** (Lôi + Kiếm Lửa). Thêm nữa là bloat.

> *Ghi chú:* `flyMatched` hiện bay ô kiếm về card đối thủ ([battle/index.ts:372-383](../game/war-god/screens/battle/index.ts#L372-L383)) — FX có sẵn khớp với thiết kế mới, không phải sửa gì.

---

## 8. Vấn đề chưa có lời giải: kéo trận vô hạn

**Đây là lỗ hổng nghiêm trọng nhất tìm được, và bộ cơ chế đã chốt ở trên KHÔNG giải quyết nó.** Ghi lại để không bị bỏ quên.

`Result()` chỉ kết thúc khi có người về 0 HP — **không có max moves, không có tổng thời gian, không có hòa**. Kết hợp với:

- `timeoutRuns` **reset về 0 mỗi khi người đó đi một nước** ([engine.go:1234](../server/internal/game/engine/engine.go#L1234))
- timeout chỉ mất lượt chứ không thua ngay, phải 3 lần liên tiếp ([engine.go:1713-1718](../server/internal/game/engine/engine.go#L1713-L1718))

→ Người đang thua lặp `đi 1 nước → timeout → timeout → đi 1 nước…`: mỗi vòng ngốn 90 giây của đối thủ mà không bao giờ đạt mốc 3 lần. **Với trận có Ken đang escrow thì đây là vector griefing thật.**

Hai cách chữa, nên làm cả hai:

1. **Tử Chiến** — từ nước thứ 50, mỗi lượt cả hai bên −3 HP và ô Tim chỉ hồi 50%. Chặn kéo trận theo cách thuận game, tạo thêm cao trào, và không cần thêm logic hòa
2. **Tính timeout tích luỹ** thay vì liên tiếp

Nếu thêm cap thời gian thì phải quyết tiebreak. Gợi ý: ai nhiều HP hơn thắng — lúc đó nhánh `'HÒA'` ở client ([battle/index.ts:1227](../game/war-god/screens/battle/index.ts#L1227)) mới có tác dụng, hiện nó là code chết vì `Result()` không bao giờ trả draw.

---

## 9. Bộ icon mới

### 9.1 Bảng màu

Vấn đề: Tim phải đỏ, Kiếm phải vàng kim, Đào nếu vẽ màu đào thật (~25° cam-hồng) thì **ba ô ấm chen nhau trong 55°** — khoảng cách hue nhỏ nhất chỉ 22°, không đọc được ở 41px.

Cách giải: vẽ **Đào Tiên phát sáng hồng-tím** thay vì màu đào tự nhiên. Đào tiên trong thần thoại là quả trường sinh, cho nó phát quang magenta là hợp mạch — và bảng màu sạch hẳn:

| ô | hue | sat | light |
|---|---|---|---|
| ⚔️ Kiếm | **50°** vàng kim | 85% | 60% |
| 🛡️ Khiên | **145°** lục | 70% | 46% |
| 💧 Nước | **200°** lam | 91% | 54% |
| ⚡ Lôi | **275°** tím điện | 80% | 58% |
| 🍑 Đào Tiên | **320°** hồng-tím | 75% | 66% |
| ❤️ Tim | **355°** đỏ | 90% | 56% |

Khoảng cách hue: 50→145 = 95° · 145→200 = 55° · 200→275 = 75° · 275→320 = 45° · 320→355 = 35° · 355→50 = 55°.

**Nhỏ nhất 35°**, so với 22° nếu vẽ đào màu tự nhiên. Bù thêm bằng độ sáng (Đào 66% vs Tim 56%) và hình dáng khác hẳn.

So với hiện tại là bước nhảy lớn: bàn đang chỉ có **3 màu đọc được**; sau đổi là **6 hue cách đều tối thiểu 35°**.

**Phải kiểm mù màu:** cặp rủi ro là Khiên lục 145° ↔ Tim đỏ 355° (deuteranopia, ~6% nam giới) → tách bằng độ sáng 46% vs 56%. Cần mô phỏng kiểm trước khi chốt.

### 9.2 Chuẩn hoá pipeline

| Việc | Chi tiết |
|---|---|
| Canvas chung | 256×256, vật thể trong safe area 224×224 |
| Cân khối lượng thị giác | Cân theo **diện tích quang học**, không theo bounding box |
| Kích thước xuất | 96px (@2x cho tile 48px) + 48px (@1x) |
| Atlas | Gộp 1 spritesheet: **~610KB → ~90KB** |
| Outline | Chốt một chuẩn duy nhất — đề xuất viền self-color darken 45% + rim light trên-trái |
| Tên file | Bỏ hậu tố `-v1` |

### 9.3 Art cho ô đặc biệt & FX nổ — dùng overlay

Giữ icon gốc, phủ lớp lên (2 ô đặc biệt là biến thể của Kiếm/Tim):

| Ô / FX | Cách thể hiện |
|---|---|
| 🔥⚔️ Kiếm Lửa | Icon Kiếm + hào quang lửa cam quanh viền |
| ❤️➕ Đại Trái Tim | Icon Tim + vầng sáng + lớn hơn ~10% |
| FX Lôi giật N ô | Mỗi ô Lôi phóng một bó tia zigzag tím/trắng tới mục tiêu + vòng impact |
| FX nổ Kiếm Lửa (3×3) | Bùng lửa cam + vòng sốc |

Tất cả đều là hình học/particle → làm được bằng Pixi Graphics, **không cần hoạ sĩ** (xem mục 11.8).

### 9.4 Phân định việc

**Làm được bằng Pillow (không cần hoạ sĩ):** dịch hue giữ nguyên độ sáng, nâng độ rực, chuẩn hoá canvas, cân khối lượng quang học, xuất @1x/@2x, gộp atlas, mô phỏng mù màu để kiểm.

**Cần hoạ sĩ:** icon Đào Tiên và Lôi (2 ô mới, vẽ từ đầu), và bỏ khung vàng của Khiên rồi vẽ lại lõi — recolor thuần sẽ ra màu bẩn vì vàng cộng lam đang triệt nhau.

---

## 10. HUD — layout cụ thể

Card fighter **190×140 → 190×162**:

```
y=8    avatar ring (36)
y=26   tên
y=48   ❤️ HP        (14)
y=70   💧 NỘI LỰC   (14)
y=92   🍑 NỘ        (14)   ← mới
y=116  nút TUYỆT CHIÊU (36)
                          card = 162
```

`makeBar` tái dùng nguyên vẹn ([hud.ts:68](../game/war-god/screens/battle/hud.ts#L68)), chỉ thêm một lần gọi.

**Chi phí thật thấp hơn tưởng.** Hằng số chiều cao trong `computeTileSize` cộng lại là 376 ([battle/index.ts:170](../game/war-god/screens/battle/index.ts#L170)), thành 398; `topStart` 156 → 178. Trên iPhone 390×844 thì `boardBudget ≈ 661` vẫn lớn hơn 470 nên **tile vẫn bị cap ở 58px — bàn không nhỏ đi một pixel**. Chỉ viewport thấp (designH0 < ~915) mới mất ~2px/ô.

Lưu ý: [hud.ts:189](../game/war-god/screens/battle/hud.ts#L189) đang tái dùng `A.items.shield` làm icon giáp — không đụng, nhưng nhớ là icon ô cũng xuất hiện trong HUD.

---

## 11. Chi phí kỹ thuật

### 11.1 Bảng file

| Phần | Việc |
|---|---|
| [`board.go`](../server/internal/game/games/war-god/board.go) | `tileFire`→`tilePeach`, `tileStone`→`tileLightning` + `tileNames` · weighted spawn · thêm `computeExplosions` (N Lôi giật N ô ngẫu nhiên, Kiếm Lửa 3×3) |
| [`battle.go`](../server/internal/game/games/war-god/battle.go) | Viết lại `applyTileEffects` (Kiếm bị chặn + Kiếm Lửa xuyên giáp) · `Fighter` thêm `fury` (Nộ) · giáp tiêu hao + phản dmg · HP 200/MP 100/Nộ 100 |
| [`logic.go`](../server/internal/game/games/war-god/logic.go) | Nộ, ult scale, `Step.Exploded`, resolve nổ trong cascade, `StateVersion` 1→**2** |
| [`logic_test.go`](../server/internal/game/games/war-god/logic_test.go) | Phần lớn 20 test phải viết lại |
| [`server-types.ts`](../game/war-god/logic/server-types.ts) | `TILE_ORDER`, `decodeTile` (`n & 7` + kind), fallback `?? 'stone'` |
| [`hud.ts`](../game/war-god/screens/battle/hud.ts) | Thanh Nộ, card 152, nút Tuyệt Chiêu thu nhỏ + badge giáp nằm ngang cạnh nút, đèn báo Nộ đầy |
| [`battle/index.ts`](../game/war-god/screens/battle/index.ts) | Replay step nổ, FX nổ, phát sáng ô Kiếm khi Nộ đầy, hằng số layout |
| [`guide-popup.ts`](../game/war-god/screens/lobby/guide-popup.ts) | Viết lại toàn bộ (xem 11.4) |
| assets | 2 icon mới (Đào Tiên, Lôi) · recolor 4 icon còn lại · overlay ô đặc biệt |

### 11.2 `findMatches` KHÔNG cần refactor

Phương án B nổ theo **loại ô** (Lôi, Kiếm Lửa) chứ không theo **hình ghép**, nên `findMatches` giữ nguyên — `maxRun` sẵn có đã đủ cho luật thêm lượt. Chỉ cần thêm:

- `computeExplosions(board, matched, rng)` — Kiếm Lửa lấy vùng 3×3; mỗi Lôi trong match hoặc vùng lửa rút 1 ô ngoài match/vùng nổ, không hoàn lại.
- `Step.Exploded []int` giữ union ô bị ăn; `Step.LightningArcs` giữ cặp `source → target` để client vẽ đúng tia sét.
- Trong vòng cascade của `Apply`: gộp ô nổ vào `removed` và cộng loại của chúng vào `counts` **trước** `applyTileEffects`.

**Không** cần encode kind vào tile, **không** cần nhận diện hình L/T/4/5. `fireSword`/`greaterHeart` đã là tile type sẵn có trong `tileCount` → `decodeTile` ([server-types.ts:69](../game/war-god/logic/server-types.ts#L69)) chỉ cần thêm 2 tên ô mới (`peach`, `lightning`), là điểm indirection duy nhất phải đổi.

### 11.3 Phải làm trước tất cả: dọn việc viết luật hai lần

Luật đang **viết hai lần**: Go cho PvP, TS cho bot ([`logic/battle.ts`](../game/war-god/logic/battle.ts), [`logic/core.ts`](../game/war-god/logic/core.ts)). Hai bên hiện khớp từng con số nhưng **không có test nào chốt việc đó**.

Bot AI phải viết lại hoàn toàn (hiện `botChooseMove` chấm điểm theo `c.sword*5 + c.fire*4.5 + …`, [battle.ts:203](../game/war-god/logic/battle.ts#L203)) và giờ còn phải hiểu "nạp Đào rồi mới dồn kiếm".

→ **Cho bot chạy qua server** (server tạo match PvE với đối thủ là bot), rồi **xoá sạch luật TS**. Client chỉ còn là máy chiếu cho cả PvE lẫn PvP, đúng như PvP đang làm.

Không làm bước này trước thì mọi thứ ở trên phải viết hai lần, và `findMatches` refactor cũng phải làm hai lần.

### 11.4 Hướng dẫn trong game — 8 thiếu sót hiện tại

Các con số trong [guide-popup.ts:7-20](../game/war-god/screens/lobby/guide-popup.ts#L7-L20) hiện **khớp đúng** với server, nhưng thiếu:

1. Hết giờ = **mất lượt**, và **3 lần mới xử thua** (guide chỉ nói "mỗi lượt có 45 giây")
2. "45 giây" hardcode ở client, server lấy từ `GAME_TURN_SECONDS` → đổi config là guide nói sai
3. Mỗi đặc kỹ chỉ kích hoạt **một lần trong một nước**, kể cả cascade dài
4. Ult tiêu một lượt thưởng như nước đi thường; nếu bank còn nhiều lượt thì phải hiển thị số còn lại
5. Nội lực cap 100; hồi máu không vượt HP tối đa
6. Bàn **tự đảo lại toàn bộ** khi hết nước đi
7. Không có kết quả hòa
8. Thắng cược bị trừ **5% hoa hồng**

### 11.5 Rủi ro deploy

`StateVersion` 1 → 2. Engine chỉ restore state khi `snapshot.StateVersion == gameLogic.StateVersion()` ([settlement.go:477](../server/internal/game/engine/settlement.go#L477)) → **mọi trận đang chạy sẽ không restore được sau deploy**.

Cần chọn: deploy vào giờ trống, hoặc viết đường hoàn cược cho các trận bị huỷ. **Đây là điểm duy nhất trong plan có thể mất tiền của người chơi nếu bỏ qua.**

### 11.6 Trị số phải cấu hình được

Toàn bộ số ở [battle.go:3-19](../server/internal/game/games/war-god/battle.go#L3-L19) đang là hằng compile-time. Đưa ra env/config để tinh chỉnh cân bằng **không cần deploy** — sẽ cần rất nhiều lần chỉnh sau khi lên.

### 11.7 Telemetry

Hiện chỉ log `move_count`. Cần log thêm: phân bố loại ô đã ghép, mức MP khi bung ult, số lần vào Nộ mỗi trận, tần suất mỗi loại ô đặc biệt, độ dài trận.

**Không có dữ liệu thì cân bằng chỉ là đoán.**

### 11.8 FX nổ — hạ tầng animation đã có sẵn (đánh giá độ khó)

Đã verify: **animation nổ là phần nhẹ nhất của tính năng**, vì bộ công cụ FX của war-god đã đủ. Phần tốn công là *logic* nổ ở server (§6, §11.2), không phải phần nhìn.

Mảnh dùng lại được ngay:

| Có sẵn | Vị trí | Dùng cho nổ |
|---|---|---|
| `tween(target, {alpha,scale,x,y}, dur)` (Promise) | [kit.ts:19](../game/war-god/kit.ts#L19) | animate mọi thứ 1 dòng |
| Xoá ô match: co lại + mờ dần | [index.ts:439](../game/war-god/screens/battle/index.ts#L439) | áp đúng anim này cho các ô trong `Step.Exploded` |
| Hiệu ứng "bùng" (2 vòng cam/vàng, bung + mờ) | [index.ts:385-389](../game/war-god/screens/battle/index.ts#L385-L389) | mầm sẵn của FX nổ — chỉnh màu/cỡ |
| Flash trắng | [index.ts:609-618](../game/war-god/screens/battle/index.ts#L609-L618) | chớp lúc nổ |
| `AnimatedSprite` + bộ cắt spritesheet (đang dùng cho `ult.png`) | [index.ts:512-523](../game/war-god/screens/battle/index.ts#L512-L523), [:545](../game/war-god/screens/battle/index.ts#L545) | nếu muốn nổ bằng ảnh động |
| Vòng replay cascade (`await`/`sleep` tuần tự `match → gravity`) | `resolveCascades` [index.ts:677](../game/war-god/screens/battle/index.ts#L677) | chèn thêm 1 nhịp `await` "nổ" vào giữa |

Độ khó phần nhìn:

| Cách | Độ khó | Ghi chú |
|---|---|---|
| **Procedural** (tia zigzag + vòng sốc + hạt, thuần Pixi Graphics) | 🟢 Dễ (~vài giờ) | **Không cần art.** Tia Lôi ba lớp tím/trắng nối nguồn tới đích; burst cam cho Kiếm Lửa |
| **Spritesheet** (ảnh động đẹp hơn) | 🟡 Trung bình | Hạ tầng có sẵn như `ult.png`, chỉ cần **1 PNG explosion** + wiring |

**Đề xuất:** làm procedural trước (đủ đẹp, không chờ art), thay spritesheet sau nếu cần — không phải viết lại gì.

---

## 12. Thứ tự triển khai

| Phase | Nội dung | StateVersion |
|---|---|---|
| **0** | Bot server-side + xoá luật TS · recolor icon + atlas + pipeline · trị số ra config · telemetry · viết lại hướng dẫn | Không đổi → **deploy an toàn** |
| **1** | Bộ 6 ô mới (Đào Tiên, Lôi) · Kiếm là nguồn damage · weighted spawn · giáp tiêu hao + phản dmg · ult scale · **HP 200 / MP 100 / Nộ 100** · giữ Kiếm Lửa + Đại Trái Tim | **Có** |
| **2** | Thanh Nộ + HUD (thêm 1 thanh) + đèn báo + phát sáng ô Kiếm khi Nộ đầy | Có |
| **3** | Hệ nổ theo loại ô (N Lôi giật N ô ngẫu nhiên + Kiếm Lửa 3×3): `computeExplosions` + mapping tia sét + FX procedural | Có |
| **4** | Tử Chiến / chống kéo trận (mục 8) | Có |

**Phase 1 và 2 nên gộp một đợt deploy** — cùng bump StateVersion một lần, đỡ phải huỷ trận hai lần.

**Phase 3** nhẹ hơn hẳn bản nháp cũ (không refactor `findMatches`, không hệ ô-đặc-biệt-theo-hình) — chủ yếu là `computeExplosions` + animation nổ (mục 11.8).

---

## 13. Sổ quyết định

Ghi lại các phương án đã cân nhắc rồi loại, để người đọc sau không đề xuất lại.

| Phương án | Kết quả | Lý do |
|---|---|---|
| Giữ ô Đá, cho nó vai phá giáp | **Loại** | Bỏ Đá gọn hơn; hai ô xuyên giáp cộng giáp tiêu hao đã đủ khắc chế Khiên |
| Giữ ô Lửa (xuyên giáp + Thiêu Đốt) | **Loại** | Chọn hướng "chỉ Kiếm gây damage" cho dễ hiểu. Bù bằng Nộ xuyên giáp |
| Cascade multiplier ×1.5/×2/×2.5 theo wave | **Loại** | Đã có Nộ ×2; ba hệ nhân chồng nhau gây one-shot |
| Thanh Nộ nạp bằng **hứng damage** | **Loại** | Chốt nạp bằng ô Đào Tiên theo yêu cầu. Đánh đổi: hai thanh cùng bản chất, đã bù bằng phân vai sàn/trần ở mục 4 |
| Nộ **tự bung** khi đầy | **Loại** | Giữ ở 100 chờ nước kiếm thì tạo quyết định có rủi ro, hay hơn |
| Cơ chế "Thịnh Nộ" (mỗi 8 nước một loại ô ×2) | **Loại** | Trùng vai và trùng tên với thanh Nộ |
| **5 ô + 1 thanh** (bỏ ô Nước và ult) | **Loại** | Đã cân nhắc: Kiếm sẽ chiếm 20% bàn tự nhiên, HUD không phải sửa. Nhưng giữ ult thì ult thành đường ra cho lượt bí — giá trị này lớn hơn |
| Đào Tiên vẽ màu đào tự nhiên (~25°) | **Loại** | Ba ô ấm chen nhau trong 55°, hue gap nhỏ nhất chỉ 22° |
| Ô "Đao" (đại đao) thay Lửa | **Loại** | Đao và Kiếm cùng là lưỡi kim khí → lặp lại đúng lỗi "Đá là kiếm yếu" vừa bỏ |
| Chiến Thần / chọn tướng | **Hoãn** | Cần art tướng và balance nhiều tướng. Xem lại sau Phase 3 |
| Đối kháng trên bàn (Đóng Băng, Đá Tảng) | **Hoãn** | Xem lại sau Phase 3 |

---

## 14. Việc còn mở

1. **Van an toàn cho damage một nước** (mục 6) — cap cứng, hay Nộ chỉ ×2 ở wave đầu? Cần playtest
2. **Bàn 8×8 hay 7×7** — với weighted spawn và ô Lôi hay nổ, số nước đi hợp lệ sẽ tăng; nếu bàn quá dễ thì thu về 7×7
3. **Tiebreak khi thêm cap thời gian** (mục 8) — ai nhiều HP hơn thắng, hay hòa và hoàn cược?
4. **Trị số toàn bộ mục 3 và 4** là điểm khởi đầu, chưa playtest
5. **Cosmetic:** `turnNumber = state.moveCount + 1` ([battle/index.ts:1153](../game/war-god/screens/battle/index.ts#L1153)) hiển thị là "lượt" nhưng thật ra đếm **số nước đi** — thêm lượt cũng +1, nên số không tương ứng với vòng
