import type { AxiosInstance, InternalAxiosRequestConfig } from 'axios';
import { guardCanonical, signGuard } from '@ola/api-guard';
import { env } from '../../config';
import { randomUuid } from '../../lib/randomUuid';

function stripQuery(url: string): string {
  return url.split(/[?#]/, 1)[0] ?? '';
}

function pathnameOf(url: string): string {
  const withoutProtocol = url.replace(/^[a-z][a-z0-9+.-]*:\/\/[^/]*/i, '');
  const path = stripQuery(withoutProtocol);
  return path === '' ? '/' : path;
}

function resolveRequestPath(config: InternalAxiosRequestConfig): string {
  const base = config.baseURL ?? env.apiUrl;
  const url = config.url ?? '';
  if (/^[a-z][a-z0-9+.-]*:\/\//i.test(url)) return pathnameOf(url);
  const basePath = pathnameOf(base).replace(/\/$/, '');
  const relative = stripQuery(url);
  const joined = relative.startsWith('/') ? `${basePath}${relative}` : `${basePath}/${relative}`;
  return joined === '' ? '/' : joined;
}

export function registerApiGuardInterceptor(http: AxiosInstance): void {
  if (!env.apiGuardSecret) return;

  http.interceptors.request.use((config) => {
    const timestamp = Date.now().toString();
    const nonce = randomUuid();
    const method = (config.method ?? 'get').toUpperCase();
    const path = resolveRequestPath(config);

    const signature = signGuard(env.apiGuardSecret, guardCanonical(timestamp, nonce, method, path));

    config.headers.set('X-Timestamp', timestamp);
    config.headers.set('X-Nonce', nonce);
    config.headers.set('X-Signature', signature);
    return config;
  });
}
