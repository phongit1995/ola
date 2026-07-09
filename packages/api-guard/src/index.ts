import { hmac } from '@noble/hashes/hmac.js'
import { sha512 } from '@noble/hashes/sha2.js'
import { bytesToHex, utf8ToBytes } from '@noble/hashes/utils.js'

export function guardCanonical(
  timestamp: string,
  nonce: string,
  method: string,
  path: string,
): string {
  return [timestamp, nonce, method, path].join('\n')
}

export function signGuard(secret: string, canonical: string): string {
  return bytesToHex(hmac(sha512, utf8ToBytes(secret), utf8ToBytes(canonical)))
}
