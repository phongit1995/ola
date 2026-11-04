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

export function megaphoneShowAtMs(megaphone: Pick<Megaphone, 'showAt'>): number {
  return Date.parse(megaphone.showAt);
}

export function megaphoneEndsAtMs(megaphone: Pick<Megaphone, 'showAt' | 'displaySeconds'>): number {
  return megaphoneShowAtMs(megaphone) + megaphone.displaySeconds * 1000;
}

export function sortMegaphones(items: readonly Megaphone[]): Megaphone[] {
  return [...items].sort((a, b) => megaphoneShowAtMs(a) - megaphoneShowAtMs(b) || a.id.localeCompare(b.id));
}

export function pendingMegaphones(items: readonly Megaphone[], now: number): Megaphone[] {
  return items.filter((item) => megaphoneEndsAtMs(item) > now);
}

export interface MegaphoneSchedule {
  current: Megaphone | null;
  nextChangeAt: number | null;
}

export function currentMegaphone(items: readonly Megaphone[], now: number): MegaphoneSchedule {
  let nextChangeAt: number | null = null;
  for (const item of items) {
    const start = megaphoneShowAtMs(item);
    const end = megaphoneEndsAtMs(item);
    if (Number.isNaN(start) || end <= now) continue;
    if (start <= now) return { current: item, nextChangeAt: end };
    if (nextChangeAt == null || start < nextChangeAt) nextChangeAt = start;
  }
  return { current: null, nextChangeAt };
}

export function megaphoneSenderName(megaphone: Pick<Megaphone, 'sender'>): string {
  return megaphone.sender.fullName || megaphone.sender.username;
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
