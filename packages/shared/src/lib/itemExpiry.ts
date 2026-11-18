import type { TFunction } from 'i18next';

const SECOND_MS = 1000;
const MINUTE_MS = 60 * SECOND_MS;
const HOUR_MS = 60 * MINUTE_MS;
const DAY_MS = 24 * HOUR_MS;
const EXPIRING_SOON_MS = DAY_MS;

export interface ExpiringItem {
  expiresAt?: string | null;
}

export interface LockableItem extends ExpiringItem {
  locked?: boolean;
}

function expiryTime(expiresAt?: string | null): number | null {
  if (expiresAt == null || expiresAt === '') return null;
  const time = new Date(expiresAt).getTime();
  return Number.isNaN(time) ? null : time;
}

export function isItemExpired(expiresAt: string | null | undefined, now: number): boolean {
  const time = expiryTime(expiresAt);
  return time != null && time <= now;
}

export function isItemExpiringSoon(expiresAt: string | null | undefined, now: number): boolean {
  const time = expiryTime(expiresAt);
  return time != null && time > now && time - now < EXPIRING_SOON_MS;
}

export function isItemLocked(item: LockableItem): boolean {
  return item.locked === true || expiryTime(item.expiresAt) != null;
}

export function withoutExpiredItems<T extends ExpiringItem>(items: readonly T[], now: number): T[] {
  return items.filter((item) => !isItemExpired(item.expiresAt, now));
}

function pad2(value: number): string {
  return String(value).padStart(2, '0');
}

export function formatCountdown(leftMs: number): string {
  const total = Math.max(0, Math.floor(leftMs / SECOND_MS));
  const hours = Math.floor(total / 3600);
  const minutes = Math.floor((total % 3600) / 60);
  const seconds = total % 60;
  return hours > 0 ? `${pad2(hours)}:${pad2(minutes)}:${pad2(seconds)}` : `${pad2(minutes)}:${pad2(seconds)}`;
}

export function itemExpiryLabel(t: TFunction, expiresAt: string | null | undefined, now: number): string | null {
  const time = expiryTime(expiresAt);
  if (time == null || time <= now) return null;
  const left = time - now;
  if (left < DAY_MS) return formatCountdown(left);
  const days = Math.floor(left / DAY_MS);
  const hours = Math.floor((left % DAY_MS) / HOUR_MS);
  return hours > 0 ? t('itemExpiry.dayHour', { days, hours }) : t('itemExpiry.days', { count: days });
}

export function itemExpiryTickMs(expiresAt: string | null | undefined, now: number): number {
  return isItemExpiringSoon(expiresAt, now) ? SECOND_MS : MINUTE_MS;
}

export function formatItemExpiryTime(expiresAt: string | null | undefined): string | null {
  const time = expiryTime(expiresAt);
  if (time == null) return null;
  const date = new Date(time);
  const pad = (value: number) => String(value).padStart(2, '0');
  const day = `${pad(date.getDate())}/${pad(date.getMonth() + 1)}`;
  const withYear = date.getFullYear() === new Date().getFullYear() ? day : `${day}/${date.getFullYear()}`;
  return `${pad(date.getHours())}:${pad(date.getMinutes())} ${withYear}`;
}

export function itemExpiryExactText(t: TFunction, expiresAt: string | null | undefined): string | null {
  const formatted = formatItemExpiryTime(expiresAt);
  return formatted == null ? null : t('itemExpiry.until', { time: formatted });
}
