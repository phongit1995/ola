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
    ├── App.tsx
    ├── index.css           # @import "tailwindcss" + @theme (token Ola)
    ├── assets/             # ảnh, svg import tĩnh
    ├── components/ui/      # component tái sử dụng (Button…)
    ├── pages/              # màn hình theo route (HomePage…)
    ├── hooks/              # custom hooks (useCounter…)
    ├── lib/                # tiện ích (cn…)
    └── types/              # type dùng chung
```

## Quy ước

- **Import alias:** `@/` trỏ tới `src/` — `import { Button } from '@/components/ui/Button'`.
- **Tailwind v4:** cấu hình bằng CSS (`@theme` trong `src/index.css`), không cần `tailwind.config.js`. Token màu Ola: `bg-ola-primary`, `text-ola-accent`…
