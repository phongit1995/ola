import type { AxiosInstance, InternalAxiosRequestConfig } from 'axios';
import { env } from '../../config';
import { signApiGuard } from '../apiGuardSigner';

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
    const method = config.method ?? 'get';
    const path = resolveRequestPath(config);
    const signed = signApiGuard(method, path);
    if (!signed) return config;

    config.headers.set('X-Timestamp', signed.timestamp);
    config.headers.set('X-Nonce', signed.nonce);
    config.headers.set('X-Signature', signed.signature);
    return config;
  });
}
