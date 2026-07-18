---
name: refactor-ola-web
description: >
  Refactor & viết code đúng chuẩn cho web app Ola (`web/`): React 19 + TypeScript + Vite +
  Tailwind v4 (CSS @theme, không config) + zustand + i18next + pnpm. Dùng khi user nói
  "refactor", "dọn code", "gom code trùng", "tách helper/component", "review code web",
  "tối ưu store/chat/room", hoặc khi sửa/thêm bất kỳ file nào trong `web/src`. Skill liệt kê
  quy ước bắt buộc (KHÔNG comment), các helper dùng chung đã có (đừng viết lại), pattern
  store (optimistic-send, realtime dedupe, tính VIP ngoài render), và checklist trước khi xong.
---

# Refactor & code chuẩn cho Ola web (`web/`)

Áp dụng cho MỌI thay đổi trong `web/src`. Mục tiêu: code tự diễn giải, không trùng lặp, tái dùng helper sẵn có, lint + build sạch.

## 0. Quy ước BẮT BUỘC (đọc `web/CLAUDE.md`)
- **TUYỆT ĐỐI KHÔNG comment**: không `//`, `/* */`, JSDoc, JSX `{/* */}`, CSS comment. Nếu đoạn khó hiểu → **tách hàm / đặt tên lại**, đừng viết comment. Ngoại lệ duy nhất: chỉ thị công cụ (`// @ts-expect-error`, `// eslint-disable-next-line`) kèm lý do ngắn.
- **Import alias**: `@/*`, `@api`, `@config`, `@constants`, `@components`, `@lib`, `@hooks`, `@services`, `@app-types`. Mỗi module `shared/*` có barrel `index.ts` — export thêm thì nhớ thêm vào đó.
- **Tailwind v4**: cấu hình bằng `@theme` trong `src/index.css`, KHÔNG có `tailwind.config.js`. Dùng token màu `ola-*` đã định nghĩa.
- **i18next type-safe**: key phải tồn tại trong `src/i18n/locales/en.json` (sinh type) VÀ `vi.json`. Thêm key vào CẢ HAI trước khi dùng `t('...')`, nếu không TS báo lỗi.
- **pnpm**. Trước khi coi là xong: `pnpm lint` và `pnpm build` PHẢI sạch.
- Shell hay reset cwd về `/Volumes/D/ola` — chạy lệnh `web/` thì `cd /Volumes/D/ola/web` trước.

## 1. Helper dùng chung ĐÃ CÓ — tái dùng, đừng viết lại
Trước khi tự viết util, kiểm tra `src/shared/lib` (export qua `@lib`):
- **VIP**: `isVipActive(vipEndTime)`, `activeVipTypeId(vipUsed, vipEndTime)` (`lib/vip.ts`); `vipIconUrl(id)`, `parseVipTypeId(vipUsed)` (`lib/vipIcon.ts`).
- **Metadata message**: `parseMessageMetadata(metadata)` → `{ url?, duration? }` (`lib/messageMetadata.ts`). KHÔNG tự `JSON.parse`.
- **Thời lượng m:ss**: `formatDuration(seconds)`, `formatDurationMs(ms)` (`lib/duration.ts`).
- **Ngày/giờ locale**: `createDateFormatter`, `createTimeFormatter` (`lib/datetime.ts`, dùng dayjs).
- **Màu avatar**: `colorForName(nameHoặcId)` (`lib/avatarColor.ts`). Đừng tạo bảng màu/hash mới.
- **Rich text / smiley / kul**: `renderRichText`, `SmileyText`, `kulImageForText`, `KUL_IMAGES`, `SMILEY_PANEL` (`lib/richText.tsx`, `SmileyText.tsx`, `kul.ts`, `chatSmiley.ts`).
- **Toast**: `toast.success/error/info` (`lib/toast.ts`).
- **Hook**: `useLongPress` (`hooks/useLongPress.ts`) — ĐỪNG tự viết `setTimeout` long-press; `useVoiceRecorder`.

### Component UI dùng chung (`@components`, `shared/components/ui`) — đừng dựng lại
- `ActionButton({ variant: 'filled'|'outline' })` — nút pill (kết bạn / bỏ chặn...). ĐỪNG tự viết `rounded-full ... px-3 py-1`.
- `PresenceBadge({ icon?, tone: 'primary'|'white', className })` — chấm online / badge thiết bị (đặt `className="absolute right-0 bottom-0"`). Điều kiện `online &&` để ở call-site.
- `UserName({ name, fullName?, className?, fullNameClassName? })` — render `name · fullName` 1 dòng, tự `truncate`.
- `VipIcon({ typeId?, src?, className?='h-4 w-4' })` — icon VIP (tự `vipIconUrl(typeId)`, hoặc `src` resolved sẵn); trả null nếu không có. Đừng tự `<img src={vipIconUrl(...)}>`.
- `UserRow({ name, username?, fullName?, avatar, color, online?, deviceIcon?, layout: 'stacked'|'inline', onClick?, trailing? })` — 1 hàng user: avatar + presence + tên + slot phải.
- `UserListDialog({ open, title, onClose, loading, isEmpty, empty, search?, children })` — vỏ dialog tìm-kiếm-+-danh-sách (Compose / AddContact / BlockedList đều dùng). Mỗi item bọc `<li>` quanh `<UserRow>`.
- Khác: `Avatar`, `Dialog`, `ConfirmDialog`, `ListOptionDialog`, `Spinner`, `FullScreenOverlay`, `ScreenHeader`, `AttachmentBar`, `SmileyInput`, `SmileyGrid`.

## 2. Pattern store (zustand) — theo đúng để khỏi lặp
- **Optimistic send** (chatStore): dùng `store/messageHelpers.ts`:
  `buildOptimisticMessage({ clientMsgId, conversationId, type, status, content?, metadata? })`,
  `runOptimisticSend(set, optimistic, (id) => api(id), onSuccess?)`,
  `markById(messages, id, patch)`, `markByClientMsgId(messages, clientMsgId, patch)`.
  Mỗi action gửi tin chỉ nên ~6 dòng. KHÔNG copy lại khối try/catch optimistic.
- **Realtime dedupe**: tin đến qua socket khớp bằng `id` HOẶC `clientMsgId` (echo tin mình gửi). Xem `chatRealtime.ts` / `roomChatStore.ts` envelopeHandler.
- **Guard sau await**: sau mỗi `await`, kiểm tra `get().currentConversationId` / `get().activeRoom?.id` còn khớp trước khi `set`.
- **State init/reset**: khai báo `const initialState = {...}`, spread `...initialState` trong `create` và `reset()`.

## 3. ⚠️ react-hooks rules (eslint chặn build)
- `react-hooks/purity`: **KHÔNG gọi `Date.now()` / `new Date()` (không tham số) / `Math.random()` trong lúc render** (kể cả trong hàm con gọi khi render, hoặc `useMemo`). → Tính ở **store/mapper ngoài render** rồi truyền xuống (ví dụ `vipTypeId` của room member/message tính trong `roomChatStore`, không tính trong component).
- `react-hooks/set-state-in-effect`: **KHÔNG gọi `setState` đồng bộ trong thân `useEffect`**. Reset state khi prop đổi → dùng pattern render-phase (`const [prev,setPrev]=useState(x); if (x!==prev){setPrev(x); ...}`). setState trong callback async (`.then`, `setTimeout`) thì OK.
- `new Date(iso)` (CÓ tham số) là thuần — dùng thoải mái khi render.

## 4. Cấu trúc & nơi đặt code
- `shared/` = hạ tầng dùng chung (api, config, constants, components/ui, lib, hooks, services, types). Logic/UI dùng ở ≥2 màn → đưa vào đây.
- `pages/<feature>/` = màn + component riêng đặt cạnh; `components/`, `*.ts` view-mapper (vd `chatView.ts`), `interface.ts` + `types.ts`.
- **Tách interface/type theo file** (chuẩn mới, `pages/chat` đã theo — folder khác áp dụng dần khi refactor):
  - `interface.ts` = mọi `interface` EXPORT của folder (shape dữ liệu/view: `ChatMessage`, `ConversationView`, `Contact`...).
  - `types.ts` = chỉ `type` alias (union/literal: `ChatMessageKind`, `ContactGroup`...) — `interface.ts` import alias từ đây.
  - File view-mapper (`chatView.ts`...) chỉ chứa HÀM, không khai báo interface export — dời sang `interface.ts`.
  - `XxxProps` KHÔNG export của component vẫn để ngay tại file component, đừng gom.
- `store/` = zustand. `routes/AppRouter.tsx` + `ROUTES` (`@constants`) — KHÔNG hardcode path.
- Tách UI lặp thành component ở `shared/components/ui` (vd hàng avatar + `username · fullName`, badge online, dialog search+list).

## 5. Quy trình refactor (làm theo thứ tự)
1. **Quét trùng lặp** trước khi sửa: grep hàm/khối giống nhau (format, parse, vip, optimistic, `.map(item => match ? {...} : item)`).
2. **Gom về `shared/lib` hoặc `store/*Helpers.ts`**, export qua barrel.
3. **Thay thế từng nơi dùng**, giữ hành vi cũ. Nếu đổi format hiển thị (vd giờ) → hỏi user trước.
4. Chia commit nhỏ theo nhóm (lib → consumers → store...). Message tiếng Việt, prefix `refactor(web...)`/`feat(web...)`.
5. `cd /Volumes/D/ola/web && pnpm lint && pnpm build` — sạch mới xong. Lỗi ở file VIP đang dở (`pages/vip/*`) là việc riêng của user — KHÔNG tự sửa, chỉ báo.
6. Tận dụng IDE diagnostics (báo unused import / cannot find name ngay) để dọn import sau mỗi edit.

## 6. KHÔNG đụng nếu không được yêu cầu
- `pages/vip/*`, `server/`, `admin/`, file `vip.service.ts` / `vip.type.ts` (việc VIP của user thường đang dở) — chỉ commit khi user yêu cầu rõ, không stage lẫn.
- Mock `data.ts` (chat/room/profile) là tàn dư — không dựa vào để suy luận hành vi thật.

## 7. Tham chiếu chéo
- Refactor đụng **mobile RN hoặc `packages/shared`**, hoặc gom code trùng web↔mobile → skill `refactor-ola-react` (quy tắc chọn shared vs per-platform, inventory helper shared, checklist 3 package).
- Refactor/đánh giá **UI/UX** sâu hơn (style, layout, component design) → dùng skill `ui-ux-pro-max`.
- Cần biết màn hình gốc hiển thị/logic thế nào → skill `docs-screens-apk` (đọc APK trong `older-ola/`).
