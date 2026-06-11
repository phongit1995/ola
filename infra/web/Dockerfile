FROM node:22-alpine AS build
WORKDIR /app

RUN corepack enable

COPY web/package.json web/pnpm-lock.yaml ./
RUN pnpm install --frozen-lockfile

COPY web/ ./

ARG VITE_API_URL=http://localhost:8080/api/v1
ARG VITE_API_TIMEOUT=10000
ARG VITE_API_GUARD_SECRET=
ARG VITE_SOCKET_URL=
ENV VITE_API_URL=$VITE_API_URL \
    VITE_API_TIMEOUT=$VITE_API_TIMEOUT \
    VITE_API_GUARD_SECRET=$VITE_API_GUARD_SECRET \
    VITE_SOCKET_URL=$VITE_SOCKET_URL
RUN pnpm build

FROM nginx:1.27-alpine AS runner

COPY infra/web/nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
