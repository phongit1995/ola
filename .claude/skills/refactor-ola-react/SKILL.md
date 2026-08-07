---
name: refactor-ola-react
description: >
  Refactor & viết code đúng chuẩn React CHO CẢ HAI nền tảng Ola: web (`web/src`, React 19 + Vite)
  và mobile React Native (`mobile/src`), cùng package chung `@ola/shared` (`packages/shared`).
  Dùng khi user nói "refactor", "dọn code", "gom code trùng web mobile", "tách helper/hook",
  "đưa lên shared", hoặc khi sửa file trong `mobile/src` / `packages/shared`, hoặc refactor
  đụng đồng thời cả web lẫn mobile. Refactor CHỈ web thuần → dùng thêm skill `refactor-ola-web`.
  Skill nêu: phân loại logic (a PURE / b STATE / c UI-BOUND), quy tắc chọn nơi đặt
  (shared vs per-platform), inventory helper/hook shared đã có (đừng viết lại),
  các thứ BẮT BUỘC per-platform, và checklist verify 3 package.
---

# Refactor React cho Ola — web + mobile + shared

Mục tiêu: logic viết MỘT lần ở `@ola/shared`, component chỉ render UI, không trùng lặp web↔mobile, verify sạch cả 3 package.

## 0. Kiến trúc 3 tầng

```
packages/shared (@ola/shared)   ← store zustand, services, types, i18n locales (chung),
                                   lib (helper thuần), hook React không đụng platform
web/src                         ← UI web; @lib re-export toàn bộ @ola/shared/lib + helper web riêng
mobile/src                      ← UI React Native; import thẳng @ola/shared/*; @lib = mobile/src/lib
```

- i18n locales (`en.json`/`vi.json`) nằm ở shared → key giống nhau 2 nền tảng → hàm nhận `t: TFunction` đặt shared được.
- `react` là peerDependency của shared → **hook React đặt trong shared được** (tiền lệ: `stores/presence/presenceHooks.ts`, `stores/feed/usePostListActions.ts`).
- `toast` shared (`lib/toast.ts`) đẩy vào `useToastStore` — render được cả 2 nền tảng → trong shared cứ dùng `toast` + `i18n.t(...)`, KHÔNG nhận toast làm tham số.
- Export map shared: `./lib` qua barrel `lib/index.ts` (thêm file mới NHỚ append barrel); `./stores/*` import thẳng theo đường dẫn file (match cả subfolder: `stores/chat/chatStore`), không cần barrel.
- **Cấu trúc `stores/` theo feature-folder**: store nào có file vệ tinh (actions / realtime / `*.state.ts` / helpers / hook) thì cả cụm nằm trong `stores/<feature>/` — hiện có `app-notification/ auth/ call/ chat/ chat-bot/ clan/ feed/ friends/ ken/ pen/ presence/ room/ toast/`. Store một mình (settings, marriage, mediaViewer...) để phẳng ở root. Đuôi `.state.ts` = runtime singleton (không zustand, không persist) — giữ convention này. Thêm vệ tinh cho store đang phẳng → tạo folder rồi dời cả cụm.

## 1. Phân loại logic trong component trước khi tách

- **(a) PURE** — tính toán thuần từ input (label i18n, format, build điều kiện): tách ra `.ts` ngay.
- **(b) STATE/STORE** — gọi setState/store/service/toast: tách thành **custom hook** (`useXxx.ts`).
- **(c) UI-BOUND** — ref/scroll/keyboard/Animated/DOM: ĐỂ LẠI trong component (hoặc hook nhận ref như `useStickyBottomList`).

## 2. Quy tắc chọn nơi đặt khi tách

1. **PURE + không phụ thuộc per-platform** (chỉ cần `t`, formatter, type shared) → `packages/shared/src/lib/<tên>.ts` + append barrel. Vd: `relationshipLabels.ts`, `vipPurchase.ts`, `presence.ts`.
2. **PURE nhưng phụ thuộc per-platform** (vd `kulImageForText` — web trả string, mobile trả ImageSourcePropType) → helper **cạnh page/screen, cùng tên 2 bên** để dễ đối chiếu: `web/src/pages/room/roomMessageView.ts` ↔ `mobile/src/screens/room/roomMessageView.ts`. ĐỪNG cố tham số hoá dependency để ép lên shared nếu làm call-site rườm hơn.
3. **STATE/STORE dùng ở ≥2 màn** → hook trong shared nếu chỉ đụng service/store/toast shared (vd `usePostListActions`); hook per-platform nếu đụng composer/picker/navigation (vd web `useEditMePost.ts` vì `ComposedPost` + upload File).
4. **STATE phức tạp cả một feed** → cân nhắc đưa hẳn vào zustand store shared theo mẫu `meFeedStore`/`clanFeedStore` (optimistic + rollback + guard) thay vì hook.

## 3. Inventory shared ĐÃ CÓ — tái dùng, đừng viết lại

`lib/`: `formatKen` (number), `formatDateDMY`/`formatDateSlashDMY`/`formatClockHM`/`isSameDay`/`createDateFormatter`/`createTimeFormatter` (datetime), `formatLastActive`/`isBirthdayToday` (presence), `chatFriendActionLabel`/`profileFriendLabel` (relationshipLabels), `vipPackageLabel`/`vipBuyErrorText`/`vipConfirmMessage`/`BuyVipMode` (vipPurchase), `ApiError`/`toApiError`, `toast`, `colorForName`, `isVipActive`/`activeVipTypeId`, `parseMessageMetadata`, `formatDuration`, `randomUuid`, upload helpers.

`stores/`: `feed/postHelpers` (`applyPostReaction`/`reconcileTopLikers`), `feed/selfLiker`, hook `feed/usePostListActions({posts, setPosts, keepOnlyLiked?, reloadAfterPin?})` → `{toggleReaction, adjustCommentCount, deletePost, togglePin}`, `presence/presenceHooks`, `chat/chatStore`/`room/roomChatStore` + realtime, `feed/meFeedStore`/`clan/clanFeedStore` (mẫu optimistic chuẩn: `reacting` guard + rollback + toast), `chat-bot/useChatBotTurns` (lõi hội thoại bot, nhận transport per-platform).

## 4. BẮT BUỘC per-platform — đừng đưa lên shared

- `kul.ts`/`kulImageForText`, `reactions.ts`/`REACTION_IMAGE` (asset: web string url ↔ mobile `require()`).
- `renderRichText`/`SmileyText`, media viewer, nén/chọn ảnh, voice recorder.
- Icon trong builder action-sheet (web `import` ↔ mobile `require` + `iconTint`), `MessageSheetAction` type khác nhau 2 bên → builder giữ trong component, chỉ tách phần điều kiện (abilities) ra helper.
- Navigation (react-router ↔ react-navigation), Keyboard/Animated/FlashList (mobile), DOM/scrollIntoView (web).
- `.svg` chỉ web; mobile dùng `.png`.

## 5. Quy tắc khi gom bản trùng web↔mobile

- **KHÔNG đổi hành vi**: nếu 2 bản khác nhau có chủ đích (vd web room check `type !== 'image'` còn mobile chat check `type === 'text'`; canReply web có `!blocked` mobile không) → GIỮ NGUYÊN từng biến thể, đừng "chuẩn hoá chéo". Chỉ được nâng cấp lên bản chuẩn (guard, reconcile) khi bản chuẩn đã tồn tại trong store shared và khác biệt chỉ là thiếu sót.
- Hàm nhận `t: TFunction` (import type từ `i18next`) làm tham số ĐẦU, theo mẫu `chatQuoteExcerpt(t, ...)`.
- `interface.ts` / `types.ts` per-folder (chuẩn mới, `web/pages/chat` đã theo): `interface.ts` = interface export, `types.ts` = type alias, file view-mapper chỉ chứa HÀM, `XxxProps` không export để tại component.
- **Icon SVG inline** (`function CameraIcon() { <svg>... }` trong component): gom về `components/Icons.tsx` cùng folder, mỗi icon nhận `className` (+ `strokeWidth` nếu stroke) với default đúng chỗ dùng phổ biến — KHÔNG để icon trùng 2 file (vd CheckIcon từng lặp ở ChangeAvatar + ChangeCover). Mẫu: `web/pages/chat/components/Icons.tsx`.
- **Magic constant** module-level trong component (`const MAX_BALLOONS = 12`, min/max, duration...): dời về `constants.ts` cùng cấp folder page/screen và import vào.
- **KHÔNG hardcode string literal của union domain** trong so sánh (`status === 'pending_incoming'`): dùng const map trong `@ola/shared/constants` — đã có `RELATIONSHIP_STATUS` (relationship.ts, `as const satisfies Record<string, RelationshipStatus>`); union mới thì tạo const map tương tự cạnh đó.
- KHÔNG comment trong code (cả web, mobile, shared) — tên hàm tự diễn giải.

## 6. Checklist verify (PHẢI sạch trước khi xong)

```bash
cd packages/shared && pnpm typecheck && pnpm lint
cd ../../web       && pnpm lint && pnpm build
cd ../mobile       && pnpm typecheck && pnpm lint
```

- Sửa shared là ảnh hưởng CẢ HAI app → luôn chạy đủ 3 package dù chỉ đụng 1 nơi.
- Working tree thường có WIP của user (clan/vip/server...) — commit trên nhánh riêng, `git add` ĐÍCH DANH từng file của refactor, không `git add -A`. Message tiếng Việt, prefix `refactor(scope):`.
- Xoá hàm local xong → quét import thừa (`kulImageForText`, `isSameDay`...) tránh lỗi lint unused.

## 7. Tham chiếu chéo

- Quy ước web-only chi tiết (Tailwind v4, alias tsconfig+vite, ROUTES...) → skill `refactor-ola-web`.
- Port nguyên màn web → mobile (bảng ánh xạ primitive, NativeWind khác Tailwind) → skill `port-web-to-mobile`.
