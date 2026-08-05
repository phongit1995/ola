import { hmac } from '@noble/hashes/hmac.js';
import { sha512 } from '@noble/hashes/sha2.js';
import { bytesToHex, utf8ToBytes } from '@noble/hashes/utils.js';
import { env } from '../config/env';
import { randomUuid } from '../lib/randomUuid';
import type { ApiGuardSignature } from '../types/lib.type';

export type { ApiGuardSignature } from '../types/lib.type';

function signHex(secret: string, value: string): string {
  return bytesToHex(hmac(sha512, utf8ToBytes(secret), utf8ToBytes(value)));
}

function stripQuery(url: string): string {
  return url.split(/[?#]/, 1)[0] ?? '';
}

function pathnameOf(url: string): string {
  const withoutProtocol = url.replace(/^[a-z][a-z0-9+.-]*:\/\/[^/]*/i, '');
  const path = stripQuery(withoutProtocol);
  return path === '' ? '/' : path;
}

export function apiPathOf(url: string, baseUrl?: string): string {
  if (/^[a-z][a-z0-9+.-]*:\/\//i.test(url)) return pathnameOf(url);
  const basePath = pathnameOf(baseUrl ?? env.apiUrl).replace(/\/$/, '');
  const relative = stripQuery(url);
  const joined = relative.startsWith('/')
    ? `${basePath}${relative}`
    : `${basePath}/${relative}`;
  return joined === '' ? '/' : joined;
}

export function signApiGuard(method: string, path: string): ApiGuardSignature | null {
  const secret = env.apiGuardSecret;
  if (!secret) return null;
  const timestamp = Date.now().toString();
  const nonce = randomUuid();
  const canonical = [timestamp, nonce, method.toUpperCase(), path].join('\n');
  return { timestamp, nonce, signature: signHex(secret, canonical) };
}
