# Quy ước cho Claude Code — `web/`

## Không viết comment trong code

**Tuyệt đối không thêm comment vào code** ở thư mục `web/` — gồm:

- Comment dòng `//` và block `/* ... */` trong `.ts` / `.tsx`
- Comment JSX `{/* ... */}`
- JSDoc `/** ... */`
- Comment CSS `/* ... */` trong `.css`

Code phải **tự diễn giải** qua tên biến/hàm/component rõ ràng. Nếu một đoạn khó hiểu đến mức cần comment, hãy **tách hàm/đặt tên lại** cho dễ đọc thay vì viết comment.

Ngoại lệ duy nhất: chỉ thị bắt buộc của công cụ (ví dụ `// @ts-expect-error`, `// eslint-disable-next-line`) khi thực sự cần — và phải kèm lý do ngắn gọn ngay trên cùng dòng chỉ thị.

## Khác

- Quản lý gói: **pnpm** (`pnpm dev`, `pnpm build`, `pnpm lint`).
- Import alias `@/` → `src/`.
- Tailwind v4 cấu hình bằng CSS (`@theme` trong `src/index.css`), không có `tailwind.config.js`.
- Trước khi coi như xong: `pnpm lint` và `pnpm build` phải sạch.
