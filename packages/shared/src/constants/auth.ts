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
