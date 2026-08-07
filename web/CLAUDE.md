# Quy ước cho Claude Code — `web/`

## Không viết comment trong code

**Tuyệt đối không thêm comment vào code** ở thư mục `web/` — gồm:

- Comment dòng `//` và block `/* ... */` trong `.ts` / `.tsx`
- Comment JSX `{/* ... */}`
- JSDoc `/** ... */`
- Comment CSS `/* ... */` trong `.css`

Code phải **tự diễn giải** qua tên biến/hàm/component rõ ràng. Nếu một đoạn khó hiểu đến mức cần comment, hãy **tách hàm/đặt tên lại** cho dễ đọc thay vì viết comment.

Ngoại lệ duy nhất: chỉ thị bắt buộc của công cụ (ví dụ `// @ts-expect-error`, `// eslint-disable-next-line`) khi thực sự cần — và phải kèm lý do ngắn gọn ngay trên cùng dòng chỉ thị.

## Cấu trúc thư mục

```
src/
├─ shared/              code hạ tầng dùng chung toàn app
│  ├─ api/              axios instance (http.ts) + các *Api.ts
│  ├─ config/           env.ts — đọc biến VITE_* (apiUrl, apiTimeout)
│  ├─ constants/        routes.ts (ROUTES) và các hằng số khác
│  ├─ components/       UI dùng chung: ui/, form/, LanguageSwitcher
│  ├─ lib/              hàm tiện ích (cn, ...)
│  ├─ hooks/            hook dùng chung
│  ├─ services/         *.service.ts — gọi API qua http helper
│  └─ types/            type domain dùng chung
├─ routes/              AppRouter.tsx — khai báo route tập trung
├─ pages/               mỗi route 1 folder, component riêng của màn đặt cạnh
├─ store/               zustand store
├─ i18n/                cấu hình i18next + locales
└─ assets/              ảnh, icon
```

- **Routing**: khai báo trong `src/routes/AppRouter.tsx`; mọi path lấy từ `ROUTES` (`@constants`), **không hardcode** chuỗi `'/login'`... trong page.
- **Config/env**: chỉ đọc `import.meta.env.VITE_*` trong `src/shared/config`; nơi khác import từ `@config`.

## Import alias

| Alias | Trỏ tới |
|-------|---------|
| `@/*` | `src/*` (dùng cho `@/pages`, `@/store`, `@/assets`, `@/routes`) |
| `@api` | `src/shared/api` |
| `@config` | `src/shared/config` |
| `@constants` | `src/shared/constants` |
| `@components` (và `@components/*`) | `src/shared/components` |
| `@lib` | `src/shared/lib` |
| `@hooks` | `src/shared/hooks` |
| `@services` | `src/shared/services` |
| `@app-types` | `src/shared/types` |

Khai báo alias ở **2 nơi và phải đồng bộ**: `tsconfig.app.json` (`compilerOptions.paths`) và `vite.config.ts` (`resolve.alias`). Mỗi module trong `shared/` có `index.ts` (barrel) để import gọn: `import { ROUTES } from '@constants'`.

## Không hardcode

- **Union domain** (status/type/role/gender/mode từ server): KHÔNG so sánh chuỗi trần (`status === 'friend'`). Dùng const map trong `@ola/shared/constants` — đã có `RELATIONSHIP_STATUS`, `GENDER`, `CALL_TYPE`, `CALL_MODE`, `MESSAGE_TYPE`, `MESSAGE_STATUS`, `CLAN_ROLE`, `APP_NOTIFICATION_TYPE`; union mới thì thêm map mới theo mẫu `as const satisfies Record<string, T>`. Union UI cục bộ trong 1 file (tab, step, tone) thì so literal thoải mái.
- **Màu**: ưu tiên token `ola-*` trong `@theme` (`src/index.css`) — gồm cả `ola-surface`, `ola-surface-cool`, `ola-border-strong`, bộ `ola-call-*`, bộ `ola-marriage-*`. Màu mới xuất hiện ≥3 lần hoặc dùng ở ≥2 feature → thêm token, KHÔNG rải `-[#hex]`. Màu trang trí một-lần (gradient game...) được phép để arbitrary.
- **Magic number** (limit API, slice preview, timeout ms): đặt hằng có tên — dùng ở ≥2 file trong folder thì vào `constants.ts` của folder, 1 file thì module-level const đầu file.
- **URL ngoài** (social, store, download...): vào `src/shared/constants` (mẫu: `appDownload.ts`, `socialLinks.ts`).
- **Tiền tệ**: dùng `formatVndCurrency` / `formatVnd` / `formatKen` từ `@lib`, không tự nối hậu tố `đ`.

## Khác

- Quản lý gói: **pnpm** (`pnpm dev`, `pnpm build`, `pnpm lint`).
- Tailwind v4 cấu hình bằng CSS (`@theme` trong `src/index.css`), không có `tailwind.config.js`.
- Trước khi coi như xong: `pnpm lint` và `pnpm build` phải sạch.
