import { BASE64_ALPHABET } from './base64.constants';

export function utf8Encode(input: string): Uint8Array {
  const bytes: number[] = [];
  for (const char of input) {
    const code = char.codePointAt(0)!;
    if (code <= 0x7f) {
      bytes.push(code);
    } else if (code <= 0x7ff) {
      bytes.push(0xc0 | (code >> 6), 0x80 | (code & 0x3f));
    } else if (code <= 0xffff) {
      bytes.push(0xe0 | (code >> 12), 0x80 | ((code >> 6) & 0x3f), 0x80 | (code & 0x3f));
    } else {
      bytes.push(
        0xf0 | (code >> 18),
        0x80 | ((code >> 12) & 0x3f),
        0x80 | ((code >> 6) & 0x3f),
        0x80 | (code & 0x3f)
      );
    }
  }
  return Uint8Array.from(bytes);
}

export function utf8Decode(bytes: Uint8Array): string {
  let result = '';
  let index = 0;
  while (index < bytes.length) {
    const first = bytes[index]!;
    let codePoint = first;
    let extraBytes = 0;
    if (first >= 0xf0) {
      codePoint = first & 0x07;
      extraBytes = 3;
    } else if (first >= 0xe0) {
      codePoint = first & 0x0f;
      extraBytes = 2;
    } else if (first >= 0xc0) {
      codePoint = first & 0x1f;
      extraBytes = 1;
    }
    for (let offset = 1; offset <= extraBytes; offset += 1) {
      codePoint = (codePoint << 6) | (bytes[index + offset]! & 0x3f);
    }
    result += String.fromCodePoint(codePoint);
    index += extraBytes + 1;
  }
  return result;
}

export function bytesToBase64(bytes: Uint8Array): string {
  let result = '';
  for (let index = 0; index < bytes.length; index += 3) {
    const byte1 = bytes[index]!;
    const byte2 = bytes[index + 1];
    const byte3 = bytes[index + 2];
    result += BASE64_ALPHABET[byte1 >> 2];
    result += BASE64_ALPHABET[((byte1 & 0x03) << 4) | ((byte2 ?? 0) >> 4)];
    result += byte2 == null ? '=' : BASE64_ALPHABET[((byte2 & 0x0f) << 2) | ((byte3 ?? 0) >> 6)];
    result += byte3 == null ? '=' : BASE64_ALPHABET[byte3 & 0x3f];
  }
  return result;
}

export function base64ToBytes(value: string): Uint8Array {
  const clean = value.replace(/=+$/, '');
  const bytes: number[] = [];
  let buffer = 0;
  let bits = 0;
  for (const char of clean) {
    const index = BASE64_ALPHABET.indexOf(char);
    if (index < 0) continue;
    buffer = (buffer << 6) | index;
    bits += 6;
    if (bits >= 8) {
      bits -= 8;
      bytes.push((buffer >> bits) & 0xff);
    }
  }
  return Uint8Array.from(bytes);
}

export function base64DecodeToString(input: string): string {
  return utf8Decode(base64ToBytes(input));
}
