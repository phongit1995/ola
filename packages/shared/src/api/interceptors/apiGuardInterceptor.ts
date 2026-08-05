import type { AxiosInstance, InternalAxiosRequestConfig } from 'axios';
import { env } from '../../config/env';
import { apiPathOf, signApiGuard } from '../apiGuardSigner';

function resolveRequestPath(config: InternalAxiosRequestConfig): string {
  return apiPathOf(config.url ?? '', config.baseURL ?? env.apiUrl);
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
