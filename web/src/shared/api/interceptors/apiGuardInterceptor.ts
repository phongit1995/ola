import type { AxiosInstance, InternalAxiosRequestConfig } from 'axios';
import { env } from '@config';

const encoder = new TextEncoder();

function toHex(buffer: ArrayBuffer): string {
  return Array.from(new Uint8Array(buffer))
    .map((byte) => byte.toString(16).padStart(2, '0'))
    .join('');
}

async function hmacSha256Hex(secret: string, value: string): Promise<string> {
  const key = await crypto.subtle.importKey(
    'raw',
    encoder.encode(secret),
    { name: 'HMAC', hash: 'SHA-256' },
    false,
    ['sign'],
  );
  return toHex(await crypto.subtle.sign('HMAC', key, encoder.encode(value)));
}

function resolveRequestPath(config: InternalAxiosRequestConfig): string {
  const base = config.baseURL ?? env.apiUrl;
  const normalizedBase = base.endsWith('/') ? base : `${base}/`;
  return new URL(config.url ?? '', normalizedBase).pathname;
}

export function registerApiGuardInterceptor(http: AxiosInstance): void {
  if (!env.apiGuardSecret) return;

  http.interceptors.request.use(async (config) => {
    const timestamp = Date.now().toString();
    const nonce = crypto.randomUUID();
    const method = (config.method ?? 'get').toUpperCase();
    const path = resolveRequestPath(config);

    const canonical = [timestamp, nonce, method, path].join('\n');
    const signature = await hmacSha256Hex(env.apiGuardSecret, canonical);

    config.headers.set('X-Timestamp', timestamp);
    config.headers.set('X-Nonce', nonce);
    config.headers.set('X-Signature', signature);
    return config;
  });
}
