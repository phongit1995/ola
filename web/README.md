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
    ├── pages/              # màn hình theo route (HomePage…)
    ├── store/              # zustand store
    ├── i18n/               # i18next + locales
    └── shared/             # code hạ tầng dùng chung
        ├── api/            # axios instance + *Api.ts
        ├── config/         # env.ts (VITE_*)
        ├── constants/      # routes.ts (ROUTES)…
        ├── components/     # UI dùng chung (ui/, form/…)
        ├── lib/            # tiện ích (cn…)
        ├── hooks/          # custom hooks (useCounter…)
        └── types/          # type dùng chung
```

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
