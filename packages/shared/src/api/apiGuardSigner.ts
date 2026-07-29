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

export function signApiGuard(method: string, path: string): ApiGuardSignature | null {
  const secret = env.apiGuardSecret;
  if (!secret) return null;
  const timestamp = Date.now().toString();
  const nonce = randomUuid();
  const canonical = [timestamp, nonce, method.toUpperCase(), path].join('\n');
  return { timestamp, nonce, signature: signHex(secret, canonical) };
}
