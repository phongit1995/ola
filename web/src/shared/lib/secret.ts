const SECRET_KEY = 'ola.saved-accounts.v1';

function xorBytes(bytes: Uint8Array): Uint8Array {
  const key = new TextEncoder().encode(SECRET_KEY);
  const out = new Uint8Array(bytes.length);
  for (let index = 0; index < bytes.length; index += 1) {
    out[index] = bytes[index]! ^ key[index % key.length]!;
  }
  return out;
}

function bytesToBase64(bytes: Uint8Array): string {
  let binary = '';
  for (let index = 0; index < bytes.length; index += 1) {
    binary += String.fromCharCode(bytes[index]!);
  }
  return btoa(binary);
}

function base64ToBytes(value: string): Uint8Array {
  const binary = atob(value);
  const bytes = new Uint8Array(binary.length);
  for (let index = 0; index < binary.length; index += 1) {
    bytes[index] = binary.charCodeAt(index);
  }
  return bytes;
}

export function encodeSecret(plain: string): string {
  return bytesToBase64(xorBytes(new TextEncoder().encode(plain)));
}

export function decodeSecret(encoded: string): string {
  try {
    return new TextDecoder().decode(xorBytes(base64ToBytes(encoded)));
  } catch {
    return '';
  }
}
