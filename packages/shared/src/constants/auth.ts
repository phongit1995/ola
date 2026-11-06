import type { Gender } from '../types/api/auth.type';

export const GENDER = {
  male: 'male',
  female: 'female',
} as const satisfies Record<string, Gender>;

export const PASSWORD_MIN = 6;
export const PASSWORD_MAX = 20;
export const TOKEN_REFRESH_BUFFER_MS = 30_000;

export const EMAIL_VERIFY_ALLOWED_DOMAINS = ['gmail.com', 'yahoo.com', 'yahoo.com.vn', 'icloud.com'];

export function isAllowedVerifyEmailDomain(email: string): boolean {
  const domain = email.slice(email.lastIndexOf('@') + 1);
  return EMAIL_VERIFY_ALLOWED_DOMAINS.includes(domain);
}

const EMAIL_SUBADDRESS_MARK = '+';
const GMAIL_DOMAIN = 'gmail.com';
const GMAIL_LOCAL_PATTERN = /^[a-z0-9](?:\.?[a-z0-9])*$/;

export function isAllowedVerifyEmailLocal(email: string): boolean {
  const at = email.lastIndexOf('@');
  if (at <= 0) return false;
  const local = email.slice(0, at);
  if (local.includes(EMAIL_SUBADDRESS_MARK)) return false;
  return email.slice(at + 1) !== GMAIL_DOMAIN || GMAIL_LOCAL_PATTERN.test(local);
}
