FROM node:22-alpine AS build
WORKDIR /app

RUN corepack enable

# Monorepo pnpm: game import @ola/shared qua alias/paths (../packages/shared/src)
# và vite-plugin-static-copy đọc asset ở packages/shared/assets -> cần copy folder này.
COPY pnpm-workspace.yaml pnpm-lock.yaml package.json ./
COPY packages/shared/package.json packages/shared/package.json
COPY game/package.json game/package.json
RUN pnpm install --frozen-lockfile --filter @ola/game...

COPY packages/shared packages/shared
COPY game game

RUN pnpm -C game build

FROM nginx:1.27-alpine AS runner

COPY infra/game/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/game/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
