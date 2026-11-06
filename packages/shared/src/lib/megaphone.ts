import type { TFunction } from 'i18next';
import { MEGAPHONE_ERROR_KEYS } from '../constants/megaphone';
import type { Megaphone } from '../types/api/megaphone.type';
import { ApiError } from './apiError';

const ASCII_SPACE = 0x20;
const ASCII_DELETE = 0x7f;

function isHiddenControl(char: string): boolean {
  const code = char.charCodeAt(0);
  return (code < ASCII_SPACE || code === ASCII_DELETE) && !/\s/.test(char);
}

export function normalizeMegaphoneContent(text: string): string {
  const visible = Array.from(text.normalize('NFC'))
    .filter((char) => !isHiddenControl(char))
    .join('');
  return visible.split(/\s+/).filter(Boolean).join(' ');
}

export function megaphoneLength(text: string): number {
  return Array.from(normalizeMegaphoneContent(text)).length;
}

export function megaphoneSenderName(megaphone: Pick<Megaphone, 'sender'>): string {
  return megaphone.sender.fullName || megaphone.sender.username;
}

export function megaphoneExpiresAtMs(megaphone: Pick<Megaphone, 'expiresAt'>): number {
  return Date.parse(megaphone.expiresAt);
}

export function activeSeenIds(seenIds: Record<string, number>, now: number): Record<string, number> {
  return Object.fromEntries(Object.entries(seenIds).filter(([, expiresAt]) => expiresAt > now));
}

export function megaphoneWaitMinutes(seconds: number): number {
  return Math.max(1, Math.ceil(seconds / 60));
}

export function megaphoneErrorText(t: TFunction, error: unknown): string {
  if (error instanceof ApiError) {
    const key = (error.code != null ? MEGAPHONE_ERROR_KEYS[error.code] : undefined) ?? MEGAPHONE_ERROR_KEYS[error.message];
    if (key != null) return t(key);
  }
  return t('megaphone.errors.failed');
}
