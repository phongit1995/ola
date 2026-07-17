FROM node:22-alpine AS build
WORKDIR /app

RUN corepack enable

COPY pnpm-workspace.yaml pnpm-lock.yaml package.json ./
COPY game/package.json game/package.json
RUN pnpm install --frozen-lockfile --filter @ola/game...

COPY game game

RUN pnpm -C game build

FROM nginx:1.27-alpine AS runner

COPY infra/game/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/game/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
