# 06 — Implementation, handoff và QA

## 1. Mục tiêu handoff

Một implementation đạt chuẩn khi người dùng thấy cùng một hệ “Mộc bản thủ công” ở tất cả 45 state screenshot, không chỉ ở màn board đẹp nhất. Thành công được đo bằng tính nhất quán, khả năng đọc và coverage trạng thái; không đo bằng số lượng texture/asset trang trí.

## 2. Hiện trạng đã đối chiếu

| Hạng mục | Hiện trạng source | So với spec | Việc cần làm khi triển khai |
|---|---|---|---|
| Core palette | đã có trong `style.css` | gần đúng | thêm semantic aliases/paper-bright nếu cần, loại hex lặp |
| Nền wood/paper | đã có CSS gradient/surface | đúng nền tảng | giữ texture rất nhẹ hoặc không texture |
| Button gold/paper/danger | đã có base classes | thiếu state chi tiết/loading | bổ sung hover pointer, loading pattern, focus context |
| Icon button | đã có hit box 44 | placeholder glyph/emoji | thay bằng SVG hệ thống |
| Action bar | anatomy đã có | đang dùng emoji OS | thay Chat/Reaction/Flag/Exit bằng SVG |
| KEN/lock/sound/nav | đang dùng ký tự/emoji | chưa đạt production | tạo inventory icon trong `assets/icons` |
| Board SVG | code-native, đúng cấu trúc chính | phù hợp | QA geometry/glyph/state ở mọi viewport |
| Piece | CSS + live glyph hiện tại | phù hợp anti-AI | QA font fallback và glyph; chỉ chuyển raster nếu asset được duyệt |
| Modal/input/chip | đã có | cần state/a11y review | error/loading/focus/keyboard |
| Reduced motion | đã có media query | cần coverage audit | bảo đảm mọi animation mới được tắt/giảm |
| Visual regression | 45 screenshots | coverage tốt | dùng cùng harness, review diff theo checklist |

Tài liệu này không tự tuyên bố các mục “cần làm” đã được code. Chúng là acceptance criteria cho phase áp dụng style.

## 3. File ownership

| File/thư mục | Trách nhiệm |
|---|---|
| `game/xiangqi/style.css` | token và style component production |
| `game/xiangqi/assets/icons/` | SVG icon source sạch |
| `game/xiangqi/components/` | shared components: board, modal, icon wrapper nếu thêm |
| `game/xiangqi/screens/` | composition và state binding, không tạo token tùy màn |
| `game/xiangqi/docs/style/` | source of truth cho style/handoff |
| `game/xiangqi/docs/screenshots/` | hướng dẫn và output cục bộ từ mock harness (PNG không lưu trong Git) |
| `game/xiangqi/docs/screenshots/style-concepts/` | art direction, không dùng trực tiếp ở runtime |

## 4. Trình tự triển khai đề xuất

### Phase 0 — Khóa baseline

1. Chạy đủ 45 screenshot hiện tại.
2. Lưu git status và xác định diff không liên quan.
3. Ghi viewport/browser/DPR của baseline.
4. Không chỉnh layout và icon cùng một commit nếu muốn review diff dễ.

### Phase 1 — Token normalization

1. Bổ sung semantic token trong `:root`.
2. Thay hex/rgba lặp có ý nghĩa bằng token.
3. Không đổi hình học component ở phase này.
4. Chụp lại lobby, rooms, board, modal, history để xác nhận không regression ngoài màu chủ ý.

### Phase 2 — Icon system

1. Tạo `assets/icons` và icon master theo inventory.
2. Thêm wrapper/typed manifest phù hợp build hiện có.
3. Thay placeholder theo nhóm: navigation → utility → KEN/lock → action bar.
4. Reaction content xử riêng, không block icon control.
5. Chụp các màn có icon ở 16/20/24 px thực.

### Phase 3 — Buttons và controls

1. Chuẩn hóa base states.
2. Bổ sung loading giữ layout.
3. Chuẩn hóa icon-button trên wood/paper.
4. Chuẩn hóa tab, chip, action tile và text link.
5. Kiểm tra keyboard/focus/ARIA trước khi sang component lớn.

### Phase 4 — Board và game state

1. QA 9×10 intersections, cung, sông, marker.
2. QA red/black glyph và flipped view.
3. Selected/hint/capture/check/last move.
4. Pending/expired/opponent-away lock state.
5. Reduced-motion và screen-reader move announce.

### Phase 5 — Surfaces và flows

1. Pod, rows, badges, inputs.
2. Modal/confirm/pregame.
3. Chat/reaction.
4. Toast/banners/result.
5. Empty/loading/error cho mọi list/connection state.

### Phase 6 — Responsive và final regression

1. Test viewport matrix.
2. Test virtual keyboard/safe-area/text zoom.
3. Chạy typecheck/test/build.
4. Chụp đủ state và review visual diff.
5. Chỉ cập nhật baseline khi diff có chủ đích và đã review.

## 5. Mapping token → class production

| Token/pattern | Class cần dùng |
|---|---|
| surface app | `.xq-app`, `.xq-screen` |
| panel paper | `.xq-modal`, `.xq-pregame-panel`, `.xq-chat` |
| paper rows | `.xq-room-row`, `.xq-list-row` |
| primary action | `.xq-btn-gold`, `.xq-tab-active`, `.xq-chip-btn-active` theo đúng semantics |
| secondary action | `.xq-btn-paper` |
| danger action | `.xq-btn-danger`, `.xq-action-danger` |
| outline on dark | `.xq-icon-btn`, `.xq-action`, `.xq-pod` |
| turn state | `.xq-pod-active`, `.xq-turn-announce` |
| check/danger | `.xq-piece-checked`, `.xq-check-banner`, `.xq-pod-clock-urgent` |
| valid move | `.xq-hint-dot` |
| last move | `.xq-last-from`, `.xq-last-to` |

Không tái sử dụng class chỉ vì cùng màu nếu semantics khác. Ví dụ chip gold và CTA gold cùng palette nhưng khác anatomy/state.

## 6. Component Definition of Done

### Button/control

- Anatomy, size và variant đúng tài liệu.
- Có idle/hover/pressed/focus/loading/disabled; selected nếu có.
- Không layout shift khi loading/toggle.
- Hit target ≥44.
- Keyboard/ARIA đúng role và state.
- Không còn emoji placeholder.

### Icon

- SVG source viewBox 24, currentColor, sạch metadata/filter.
- Rõ ở size nhỏ nhất.
- Cùng stroke/visual mass với inventory.
- Accessible name nằm ở control/container phù hợp.
- Có screenshot trên surface thực.

### Board

- Geometry đúng 9×10 và không co méo.
- Tất cả 14 glyph đúng.
- Hướng nhìn của Đỏ/Đen đúng, glyph không lật ngược.
- Selection/hint/capture/check/last move phân biệt rõ.
- Không cho gửi input lặp khi pending/expired/result.
- Touch, keyboard và screen-reader cơ bản hoạt động.

### Modal/drawer

- Focus trap/restore; Esc policy.
- Safe-area/keyboard không che action.
- Loading/error không làm mất draft hoặc đóng nhầm.
- Primary/secondary/danger đúng hierarchy.

### Dynamic feedback

- Announce một lần, không loop.
- Không che board/control quan trọng.
- Có reduced-motion.
- Client không tự công bố kết quả trước server.

## 7. Visual regression suite

Chụp toàn bộ:

```powershell
pnpm -C game shots:xiangqi
```

Chụp nhóm board trọng yếu trong lúc iterate:

```powershell
node game/scripts/xiangqi-shots.mjs --only board,board-selected,board-check,board-urgent,board-move-pending
```

Audit runtime để bảo đảm các screen/component đại diện thực sự nhận `animation-name` (không chỉ có keyframe chết trong CSS):

```powershell
pnpm -C game shots:xiangqi:motion
```

Audit cùng media query giảm chuyển động; probe phải giữ `animation-name` để coverage còn kiểm tra được nhưng duration runtime không được vượt `1 ms`:

```powershell
node game/scripts/xiangqi-shots.mjs --audit-motion --reduced-motion --settle-ms 0
```

Chụp giữa choreography khi review nhịp stagger:

```powershell
node game/scripts/xiangqi-shots.mjs --only lobby,rooms,board --settle-ms 120 --out xiangqi/docs/screenshots/motion-frames
```

### Core review set

| Nhóm | Screenshot |
|---|---|
| Shell/CTA | `lobby`, `lobby-connecting`, `lobby-error` |
| Rows/forms | `rooms`, `rooms-empty`, `rooms-create`, `rooms-password` |
| Pregame | `pregame-alone`, `pregame-ready`, `pregame-guest` |
| Board base | `board`, `board-opp-turn`, `board-selected` |
| Board feedback | `board-check`, `board-urgent`, `board-toast`, `board-announce` |
| Board lock/network | `board-move-pending`, `board-expired`, `board-oppaway` |
| Social | `board-chat`, `board-chat-restore`, `board-reactions` |
| Confirm/result | `confirm-forfeit`, `confirm-exit`, `result-win/lose/draw/friendly` |
| Lists | `history*`, `leaderboard*` |

### Review từng diff

1. Diff có nằm trong phạm vi style đã định không?
2. Text có thay đổi ngoài ý muốn không?
3. Icon baseline/stroke có nhất quán không?
4. Spacing/radius có lệch giữa state không?
5. State disabled/loading/selected có còn nhận ra?
6. Board/glyph/piece position có thay đổi không?
7. Safe-area hoặc z-index có regression không?
8. Có chi tiết “đẹp ngẫu nhiên” không tồn tại trong component system không?

Không cập nhật baseline chỉ vì test ảnh đỏ. Xác định diff là chủ ý trước.

## 8. Functional verification

```powershell
pnpm -C game typecheck
pnpm -C game test
pnpm -C game build
```

UI style không được thay đổi:

- luật nước đi;
- payload/socket event;
- deadline/timeout authority;
- KEN calculation;
- server-owned match result;
- reconnect/resume behavior.

Nếu refactor component làm đổi logic, parity và store tests phải vẫn xanh; screenshot không thay thế functional tests.

## 9. Viewport/manual QA matrix

| Case | 360×640 | 390×844 | 412×915 | 520×900 |
|---|:---:|:---:|:---:|:---:|
| Lobby không cắt CTA/Exit | □ | □ | □ | □ |
| Rooms row không overflow | □ | □ | □ | □ |
| Modal + keyboard dùng được | □ | □ | □ | □ |
| Board đủ 9×10, quân chạm đúng | □ | □ | □ | □ |
| Action bar label không cắt | □ | □ | □ | □ |
| Chat input trên safe-area | □ | □ | □ | □ |
| Result modal fit | □ | □ | □ | □ |
| Text zoom 200% | □ | □ | □ | □ |

Thiết bị/browser tối thiểu cần smoke test: Chromium desktop, Android WebView/Chrome, iOS Safari/WKWebView nếu game chạy trong host tương ứng.

## 10. Glyph QA

Kiểm tra bằng mắt, không chỉ snapshot OCR:

```text
Đỏ:  帥 仕 相 俥 炮 傌 兵
Đen: 將 士 象 車 砲 馬 卒
```

- Đúng glyph/traditional form.
- Không fallback thành tofu/square.
- Không đổi font giữa hai phe.
- Tâm glyph cân trong piece ở 360/390/520.
- Mini-piece vẫn đọc được hoặc có accessible text thay thế.
- Khi dùng asset raster, so hash/dimension và review từng file; không batch accept từ image generator.

## 11. Anti-AI visual review

Reject nếu có một trong các dấu hiệu:

- text/glyph bị méo, thiếu dấu hoặc không đồng bộ font;
- texture thay đổi pattern theo component;
- icon khác stroke, góc, material hoặc perspective;
- ornament văn hóa xuất hiện không có chức năng;
- gradient/glow/particle ngoài danh sách đã duyệt;
- spacing không theo 4/8 grid;
- radius/shadow mới chỉ xuất hiện một lần;
- background scene với cây, gạch, kiến trúc hoặc props;
- UI quan trọng là một bitmap không responsive;
- state chỉ “trông đẹp” ở screenshot base nhưng hỏng ở loading/error/disabled.

Approve khi giao diện có thể giải thích hoàn toàn bằng token, component và state trong bộ docs này.

## 12. Pull request checklist

```md
### Xiangqi — Mộc bản thủ công

- [ ] Phạm vi component/screen được ghi rõ.
- [ ] Không thay luật/network/store ngoài chủ ý.
- [ ] Dùng token, không thêm magic color/radius/shadow.
- [ ] Icon mới theo icon spec và đã thêm inventory.
- [ ] Không còn emoji placeholder trong vùng đã migrate.
- [ ] Keyboard/focus/ARIA đã test.
- [ ] Reduced-motion đã test.
- [ ] 360/390/520 và text zoom đã test.
- [ ] `pnpm -C game typecheck` pass.
- [ ] `pnpm -C game test` pass.
- [ ] `pnpm -C game build` pass.
- [ ] Screenshot core/full đã chụp và diff được review.
- [ ] Docs được cập nhật nếu thêm variant/token/icon.
```

## 13. Quy tắc thay đổi design system

Khi cần token/variant/icon mới:

1. Chứng minh pattern hiện có không diễn tả đúng semantics.
2. Nêu ít nhất hai nơi tái sử dụng hoặc giải thích vì sao là primitive bắt buộc.
3. Viết spec/state/accessibility trước.
4. Thêm implementation và screenshot.
5. Review cả ảnh base lẫn error/loading/disabled.
6. Cập nhật mục lục/inventory/DoD liên quan.

Không thêm CSS modifier mới chỉ để “đẹp hơn một chút” ở một màn.
