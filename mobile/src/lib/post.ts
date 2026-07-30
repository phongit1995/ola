import { EDIT_WINDOW_MS } from '@ola/shared/constants';

export function isPostEditExpired(
  createdAt: string | null | undefined,
  now = Date.now(),
): boolean {
  if (createdAt == null) return true;
  const createdAtMs = new Date(createdAt).getTime();
  return !Number.isFinite(createdAtMs) || now - createdAtMs > EDIT_WINDOW_MS;
}
