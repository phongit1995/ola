# Ola Web

Web app: **React 19 + Vite + TypeScript + Tailwind CSS v4**.

> Dùng **pnpm** (lockfile: `pnpm-lock.yaml`).

## Chạy

```bash
pnpm install
pnpm dev           # http://localhost:3005
```

## Scripts

| Lệnh | Tác dụng |
|------|----------|
| `pnpm dev` | Dev server (HMR) |
| `pnpm build` | Type-check (`tsc -b`) + build production vào `dist/` |
| `pnpm preview` | Xem thử bản build |
| `pnpm lint` / `lint:fix` | ESLint |
| `pnpm format` | Prettier |
| `pnpm typecheck` | Chỉ type-check |

## Cấu trúc

```
web/
├── index.html
├── vite.config.ts         # plugin react + tailwind + alias @ -> src
├── tsconfig.*.json         # alias @/* trong tsconfig.app.json
├── eslint.config.js / .prettierrc.json
└── src/
    ├── main.tsx            # entry
    ├── App.tsx             # render <AppRouter />
    ├── index.css           # @import "tailwindcss" + @theme (token Ola)
    ├── assets/             # ảnh, svg import tĩnh
    ├── routes/             # AppRouter.tsx — khai báo route tập trung
    ├── pages/              # mỗi màn / nghiệp vụ một thư mục (xem "Quy ước trong màn")
    ├── store/              # zustand store
    ├── i18n/               # i18next + locales
    └── shared/             # code hạ tầng dùng chung
        ├── api/            # axios instance + *Api.ts
        ├── config/         # env.ts (VITE_*)
        ├── constants/      # routes.ts (ROUTES)…
        ├── components/     # UI dùng chung (ui/, form/…)
        ├── lib/            # tiện ích dùng chung nhiều màn (barrel, re-export cả @ola/shared/lib)
        ├── hooks/          # hook dùng chung nhiều màn
        └── types/          # type dùng chung
```

## Tài liệu giao diện

- [Style guide icon Me](../docs/me-icon-style-guide.md)

## Quy ước

- **Import alias:** ngoài `@/` → `src/`, mỗi module trong `shared/` có alias ngắn riêng — khai báo đồng bộ ở `tsconfig.app.json` và `vite.config.ts`:

  | Alias | Trỏ tới |
  |-------|---------|
  | `@/*` | `src/*` |
  | `@api` | `src/shared/api` |
  | `@config` | `src/shared/config` |
  | `@constants` | `src/shared/constants` |
  | `@components` `@components/*` | `src/shared/components` |
  | `@lib` | `src/shared/lib` |
  | `@hooks` | `src/shared/hooks` |
  | `@app-types` | `src/shared/types` |

  Ví dụ: `import { ROUTES } from '@constants'`, `import { TextField } from '@components/form/TextField'`.
- **Tailwind v4:** cấu hình bằng CSS (`@theme` trong `src/index.css`), không cần `tailwind.config.js`. Token màu Ola: `bg-ola-primary`, `text-ola-accent`…

## Quy ước trong màn

Giống quy ước của admin (`admin/README.md`). Mỗi thư mục `pages/<màn>/` gồm:

| File | Chứa gì | Ví dụ |
|------|---------|-------|
| `XxxPage.tsx`, `XxxPanel.tsx`, `XxxOverlay.tsx`, `components/` | Component: state, xử lý sự kiện, JSX | `chat/ChatPanel.tsx` |
| `useXxx.ts` | Hook của màn: state, gọi store/service | `me/useMeFeed.ts` |
| `constants.ts` | Hằng số `UPPER_CASE`: giới hạn, khoảng cách vuốt, dữ liệu tĩnh | `chat/constants.ts` (`SWIPE_TRIGGER`, `SUGGESTED_FRIENDS`) |
| `utils.ts` | Hàm thuần không có JSX: đổi dữ liệu API → dữ liệu hiển thị, format, tính toán | `chat/utils.ts` (`toBubble`, `mapFriendsToContacts`) |
| `types.ts` | Type / interface dùng cho nhiều file trong màn. Không tách riêng `interface.ts` | `chat/types.ts` (`ChatMessage`, `ContactGroup`) |
| `xxxAssets.ts` | Bảng ảnh / âm thanh của màn, đổi asset chỉ sửa ở đây | `games/pen/penAssets.ts` |

Chỉ tạo `constants.ts` / `utils.ts` / `types.ts` khi màn có nội dung cho file đó.

Module có tác dụng phụ (phát âm thanh, đọc/ghi `localStorage`, clipboard, upload, quyền thiết bị) không đưa vào `utils.ts`. Giữ file riêng, đặt tên theo việc nó làm (`spin-wheel/spinWheelSound.ts`, `apps/arcadePositions.ts`, `chat/hiddenPeerCards.ts`, `me/composer.ts`). Màn lớn có nhiều module như vậy thì gom vào `lib/` của màn (`call/lib/`). Style object dùng chung cho nhiều component của một màn để ở `xxxStyles.ts` (`spin-wheel/spinWheelStyles.ts`).

**Đặt code ở đâu**

- Chỉ một màn dùng → để trong thư mục của màn đó, kể cả hook (`room/useAttachPanel.ts`, `story/useHorizontalDragScroll.ts`).
- Nhiều màn con cùng một nhóm dùng → để ở thư mục cha của nhóm (`pages/games/`).
- Nhiều nhóm màn dùng → đưa lên `src/shared/hooks`, `src/shared/lib` hoặc `src/shared/components` và export qua `index.ts`.
- Logic thuần dùng được cho cả web lẫn mobile → `packages/shared` (`@ola/shared`).
- Import thứ đã có ở `@ola/shared` thì import thẳng (`@lib`, `@app-types`, `@ola/shared/stores/...`). Không tạo file trung gian chỉ để re-export trong thư mục màn.
- Import trong cùng màn dùng đường dẫn tương đối (`./utils`, `../types`); import từ ngoài màn dùng alias (`@lib`, `@/pages/...`).

**Đặt tên**

- Hook đặt tên `useXxx.ts`. Hậu tố `Store` để dành cho zustand (`useMeFeedStore`).
- Tên trong `constants.ts` / `utils.ts` dùng chung cho cả thư mục, nên phải rõ nghĩa ngoài file gốc (`SWIPE_TRIGGER`, `roomMessageAbilities`).

**Giữ lại trong component**

- `XxxProps` không export, hằng số có JSX hoặc `ReactNode`, style object chỉ một component dùng.
