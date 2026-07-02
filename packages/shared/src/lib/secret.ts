import { base64ToBytes, bytesToBase64, utf8Decode, utf8Encode } from './base64';

const SECRET_KEY = 'ola.saved-accounts.v1';

function xorBytes(bytes: Uint8Array): Uint8Array {
  const key = utf8Encode(SECRET_KEY);
  const out = new Uint8Array(bytes.length);
  for (let index = 0; index < bytes.length; index += 1) {
    out[index] = bytes[index]! ^ key[index % key.length]!;
  }
  return out;
}

export function encodeSecret(plain: string): string {
  return bytesToBase64(xorBytes(utf8Encode(plain)));
}

export function decodeSecret(encoded: string): string {
  try {
    return utf8Decode(xorBytes(base64ToBytes(encoded)));
  } catch {
    return '';
  }
}
