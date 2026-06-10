# infra/web — Docker cho web (Vite SPA → nginx)

Build context là **root repo** (vì `nginx.conf` nằm trong `infra/`, nguồn ở `web/`).

```bash
# Build (chạy ở root repo). VITE_API_URL được bake vào bundle lúc build.
docker build -f infra/web/Dockerfile -t ola-web --build-arg VITE_API_URL=https://api.cua-ban.com .

# Run
docker run -d -p 8080:80 ola-web   # → http://localhost:8080
```

Lưu ý: `VITE_API_URL` là **build-time** — đổi backend phải build lại image. Mặc định `http://localhost:8080` nếu không truyền `--build-arg`.

## CI/CD

- `.github/workflows/web-docker.yml` — build & push Docker Hub `phongit1995/ola-web` (tự chạy khi push `main`, hoặc chạy tay). Cần secrets `DOCKERHUB_USERNAME`, `DOCKERHUB_TOKEN`.
- `.github/workflows/web-deploy.yml` — deploy thủ công: SSH vào server pull + run lại container.

## Deploy thủ công từ máy (script)

```bash
cp infra/web/deploy.env.example infra/web/deploy.env   # điền SSH_HOST/PORT/USER/PASSWORD
bash infra/web/deploy.sh                                # pull latest + recreate container
```

`deploy.env` đã được `.gitignore`. Có thể override qua biến môi trường, vd: `TAG=v1.0.0 bash infra/web/deploy.sh`.

## Deploy qua GitHub Actions (web-deploy)

Vào **Actions → web-deploy → Run workflow**, nhập `tag`. Secrets cần khai báo (Settings → Secrets and variables → Actions → Secrets):

| Secret | Ví dụ |
|--------|-------|
| `SSH_HOST` | host SSH server |
| `SSH_PORT` | `22` |
| `SSH_USERNAME` | `root` |
| `SSH_PASSWORD` | mật khẩu SSH |
| `DOCKERHUB_USERNAME` | đã có (dùng cho tên image) |

⚠️ **Reachability:** runner GitHub (cloud) phải SSH tới được server. `phong.local` là **LAN** → cloud runner KHÔNG vào được. Hai cách xử lý:
1. **Self-hosted runner** đặt trong cùng mạng/trên server → đổi `runs-on: ubuntu-latest` thành `runs-on: self-hosted`. Đây là cách đơn giản nhất cho host LAN.
2. **SSH public**: cho server một host SSH truy cập được từ internet (IP public, hoặc Cloudflare Access qua `cloudflared access`), rồi để `SSH_HOST` trỏ tới đó.

Nếu chỉ deploy từ máy trong nhà thì dùng `deploy.sh` là gọn nhất.

