# infra/web — Docker cho web (Vite SPA → nginx)

Build context là **root repo** (vì `nginx.conf` nằm trong `infra/`, nguồn ở `web/`).

```bash
# Build (chạy ở root repo). VITE_API_URL được bake vào bundle lúc build.
docker build -f infra/web/Dockerfile -t ola-web --build-arg VITE_API_URL=https://api.cua-ban.com .

# Run
docker run -d -p 8080:80 ola-web   # → http://localhost:8080
```

Lưu ý: `VITE_API_URL` là **build-time** — đổi backend phải build lại image. Mặc định `http://localhost:8080` nếu không truyền `--build-arg`.
