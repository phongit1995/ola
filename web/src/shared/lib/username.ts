const INVALID_USERNAME_CHARS = /[^a-z0-9._]/g;

export const USERNAME_MAX = 20;

export function sanitizeUsername(value: string): string {
  return value.toLowerCase().replace(INVALID_USERNAME_CHARS, '').slice(0, USERNAME_MAX);
}
