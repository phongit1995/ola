FROM node:22-alpine AS build
WORKDIR /app

RUN corepack enable

# Monorepo pnpm: admin phụ thuộc @ola/domain + @ola/api-guard (packages/*, ship TS source)
COPY pnpm-workspace.yaml pnpm-lock.yaml package.json ./
COPY packages/domain/package.json packages/domain/package.json
COPY packages/api-guard/package.json packages/api-guard/package.json
COPY admin/package.json admin/package.json
RUN pnpm install --frozen-lockfile --filter admin...

COPY packages/domain packages/domain
COPY packages/api-guard packages/api-guard
COPY admin admin

# Biến VITE_* được CI ghi vào admin/.env (xem .github/workflows/build-deploy.yml);
# Vite tự đọc .env lúc build và bake vào bundle.
RUN pnpm -C admin build

FROM nginx:1.27-alpine AS runner

COPY infra/admin/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/admin/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
