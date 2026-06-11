FROM node:22-alpine AS build
WORKDIR /app

RUN corepack enable

COPY web/package.json web/pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile

COPY web/ ./

# Biến VITE_* được CI ghi vào web/.env (xem .github/workflows/build.yml);
# Vite tự đọc .env lúc build và bake vào bundle.
RUN pnpm build

FROM nginx:1.27-alpine AS runner

COPY infra/web/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
