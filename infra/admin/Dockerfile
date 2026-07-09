FROM node:22-alpine AS build
WORKDIR /app

RUN corepack enable

COPY admin/package.json admin/pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile

COPY admin/ ./

# Biến VITE_* được CI ghi vào admin/.env (xem .github/workflows/build-deploy.yml);
# Vite tự đọc .env lúc build và bake vào bundle.
RUN pnpm build

FROM nginx:1.27-alpine AS runner

COPY infra/admin/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
