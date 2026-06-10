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
| `@app-types` | `src/shared/types` |

Khai báo alias ở **2 nơi và phải đồng bộ**: `tsconfig.app.json` (`compilerOptions.paths`) và `vite.config.ts` (`resolve.alias`). Mỗi module trong `shared/` có `index.ts` (barrel) để import gọn: `import { ROUTES } from '@constants'`.

## Khác

- Quản lý gói: **pnpm** (`pnpm dev`, `pnpm build`, `pnpm lint`).
- Tailwind v4 cấu hình bằng CSS (`@theme` trong `src/index.css`), không có `tailwind.config.js`.
- Trước khi coi như xong: `pnpm lint` và `pnpm build` phải sạch.
