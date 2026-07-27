FROM node:22-alpine AS build
WORKDIR /app

RUN corepack enable

# Monorepo pnpm: web phụ thuộc @ola/shared (packages/shared, ship TS source)
COPY pnpm-workspace.yaml pnpm-lock.yaml package.json ./
COPY packages/shared/package.json packages/shared/package.json
COPY web/package.json web/package.json
RUN pnpm install --frozen-lockfile --filter web...

COPY packages/shared packages/shared
COPY web web

# Biến VITE_* được CI ghi vào web/.env (xem .github/workflows/build.yml);
# Vite tự đọc .env lúc build và bake vào bundle.
RUN pnpm -C web build

FROM nginx:1.27-alpine AS runner

COPY infra/web/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/web/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
