# support-web — trang pháp lý & hỗ trợ tĩnh cho store

Site tĩnh chứa **Chính sách bảo mật** và **Điều khoản sử dụng** của app **Ola Me**, dùng để dán link vào App Store Connect / Google Play Console.

## Link production (Cloudflare Pages)

| Trang | URL |
|-------|-----|
| Chính sách bảo mật | https://ola-me.pages.dev/privacy |
| Điều khoản sử dụng | https://ola-me.pages.dev/terms |
| Trang chủ | https://ola-me.pages.dev/ |

Alias 301 có sẵn: `/chinh-sach-bao-mat`, `/privacy-policy` → `/privacy`; `/dieu-khoan`, `/terms-of-use`, `/tos` → `/terms`.

Ép ngôn ngữ bằng query: `?lang=vi` hoặc `?lang=en` (mặc định theo ngôn ngữ trình duyệt, có nút chuyển VI/EN trên đầu trang).

Chỗ dán link:
- **App Store Connect** → App Information → *Privacy Policy URL* = link privacy; License Agreement / EULA dùng link terms.
- **Play Console** → App content → *Privacy policy* = link privacy; Store listing → website.

## Nội dung lấy từ đâu

HTML được **sinh ra** từ i18n dùng chung của app, không viết tay:

```
packages/shared/src/i18n/locales/vi.json → privacyPolicy, terms
packages/shared/src/i18n/locales/en.json → privacyPolicy, terms
```

Sửa nội dung pháp lý thì **sửa file JSON đó** (app và web dùng chung), rồi build lại. Nhớ bump `updated` trong JSON khi đổi nội dung.

## Build

```bash
node support-web/build.mjs
```

Sinh ra trong `public/`: `index.html`, `privacy.html`, `terms.html`, `robots.txt`, `sitemap.xml`.
Các file khác trong `public/` (`favicon.png`, `apple-touch-icon.png`, `og-image.png`, `_headers`, `_redirects`) là tĩnh, không bị build ghi đè.

Xem thử local:

```bash
cd support-web/public && python3 -m http.server 5891
# http://127.0.0.1:5891/privacy.html
```

## Deploy

```bash
cd support-web
node build.mjs
npx wrangler pages deploy public --project-name ola-me --branch main --commit-dirty=true
```

Project Cloudflare Pages: `ola-me` (account `phongit1995@gmail.com`, tạo bằng `wrangler pages project create ola-me --production-branch main`). Deploy không qua Git nên mỗi lần chạy lệnh trên là ra một bản production mới.

## Gắn domain riêng (tuỳ chọn)

Nếu muốn URL đẹp hơn `*.pages.dev`:

```bash
npx wrangler pages domain add legal.olachat.net --project-name ola-me
```

Rồi thêm bản ghi `CNAME legal → ola-me.pages.dev` trong DNS của domain (nếu domain đã ở Cloudflare thì Pages tự thêm). Sau khi domain hoạt động, sửa `SITE_URL` trong `build.mjs` và build + deploy lại để canonical/OG/sitemap trỏ đúng.

## Cấu hình

- `wrangler.toml` — `pages_build_output_dir = "public"`.
- `public/_headers` — security headers + cache (HTML no-cache, ảnh 7 ngày).
- `public/_redirects` — alias URL tiếng Việt.
- Các hằng ở đầu `build.mjs`: `SITE_URL`, `APP_NAME`, `SUPPORT_EMAIL`.
