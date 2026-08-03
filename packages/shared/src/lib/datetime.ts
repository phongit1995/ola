import dayjs from 'dayjs';
import localizedFormat from 'dayjs/plugin/localizedFormat';
import 'dayjs/locale/vi';
import {
  EN_TIME_LABELS,
  VI_TIME_LABELS,
} from './datetime.constants';

dayjs.extend(localizedFormat);

function resolveLocale(locale: string): string {
  return locale.startsWith('vi') ? 'vi' : 'en';
}

function pad(value: number): string {
  return String(value).padStart(2, '0');
}

function formatSlashDate(date: Date, includeYear: boolean): string {
  const value = `${pad(date.getDate())}/${pad(date.getMonth() + 1)}`;
  return includeYear ? `${value}/${date.getFullYear()}` : value;
}

function startOfWeek(date: Date, lang: string): number {
  const firstDay = lang === 'vi' ? 1 : 0;
  const value = new Date(date.getFullYear(), date.getMonth(), date.getDate());
  value.setDate(value.getDate() - ((value.getDay() - firstDay + 7) % 7));
  return value.getTime();
}

function isSameWeek(a: Date, b: Date, lang: string): boolean {
  return startOfWeek(a, lang) === startOfWeek(b, lang);
}

function isPreviousWeek(then: Date, now: Date, lang: string): boolean {
  const elapsed = startOfWeek(now, lang) - startOfWeek(then, lang);
  return Math.round(elapsed / 86_400_000) === 7;
}

function dayGapAcrossPreviousWeek(then: Date, now: Date): number {
  return now.getDay() + 7 - then.getDay();
}

function labelsFor(locale: string) {
  return resolveLocale(locale) === 'vi' ? VI_TIME_LABELS : EN_TIME_LABELS;
}

export function formatDateDMY(iso: string): string {
  const date = new Date(iso);
  if (Number.isNaN(date.getTime())) return '';
  return `${pad(date.getDate())}-${pad(date.getMonth() + 1)}-${date.getFullYear()}`;
}

export function formatDateSlashDMY(iso: string): string {
  const date = new Date(iso);
  return Number.isNaN(date.getTime()) ? '' : formatSlashDate(date, true);
}

export function formatClockHM(iso?: string): string {
  if (iso == null || iso === '') return '';
  const date = new Date(iso);
  if (Number.isNaN(date.getTime())) return '';
  return `${pad(date.getHours())}:${pad(date.getMinutes())}`;
}

export function isSameDay(a: string, b: string): boolean {
  const da = new Date(a);
  const db = new Date(b);
  if (Number.isNaN(da.getTime()) || Number.isNaN(db.getTime())) return false;
  return (
    da.getFullYear() === db.getFullYear() &&
    da.getMonth() === db.getMonth() &&
    da.getDate() === db.getDate()
  );
}

export function yearsSince(iso: string): number {
  const then = dayjs(iso);
  if (!then.isValid()) return 0;
  return Math.max(0, dayjs().diff(then, 'year'));
}

export function monthsSince(iso: string): number {
  const then = dayjs(iso);
  if (!then.isValid()) return 0;
  return Math.max(0, dayjs().diff(then, 'month'));
}

export function daysSince(iso: string): number {
  const then = dayjs(iso);
  if (!then.isValid()) return 0;
  return Math.max(0, dayjs().diff(then, 'day'));
}

export function createDateFormatter(locale: string): (iso: string) => string {
  const lang = resolveLocale(locale);
  return (iso: string) => {
    const date = dayjs(iso);
    return date.isValid() ? date.locale(lang).format('L') : iso;
  };
}

export function formatOlaTime(iso: string, locale: string, nowMs: number = Date.now()): string {
  const then = new Date(iso);
  if (Number.isNaN(then.getTime())) return '';
  const now = new Date(nowMs);
  const lang = resolveLocale(locale);
  const labels = labelsFor(lang);
  const time = formatClockHM(iso);
  const weekday = labels.weekdays[then.getDay()] ?? '';

  if (then.getFullYear() !== now.getFullYear()) {
    return `${time} ${weekday} ${formatSlashDate(then, true)}`;
  }

  if (isSameWeek(then, now, lang)) {
    if (then.getDate() === now.getDate()) {
      const ageSeconds = Math.floor(Math.abs(nowMs - then.getTime()) / 1000);
      if (ageSeconds <= 60) return labels.justNow;
      const minutes = Math.floor(ageSeconds / 60);
      if (minutes < 60) return labels.minute(minutes);
      const hours = Math.floor(minutes / 60);
      if (hours < 7) return labels.hour(hours);
      return `${time} ${labels.today}`;
    }

    const dayDifference = now.getDate() - then.getDate();
    if (dayDifference === 1) return `${time} ${labels.yesterday}`;
    if (dayDifference === 2) return `${time} ${labels.dayBefore}`;
    if (dayDifference > 2) return `${time} ${weekday}`;
    return `${time} ${weekday} ${formatSlashDate(then, false)}`;
  }

  if (isPreviousWeek(then, now, lang)) {
    const dayGap = dayGapAcrossPreviousWeek(then, now);
    if (dayGap === 1) return `${time} ${labels.yesterday}`;
    if (dayGap === 2) return `${time} ${labels.dayBefore}`;
  }

  return `${time} ${weekday} ${formatSlashDate(then, false)}`;
}

export function createTimeFormatter(locale: string): (iso: string) => string {
  return (iso: string) => formatOlaTime(iso, locale);
}

export function formatOlaDateSeparator(
  iso: string,
  locale: string,
  nowMs: number = Date.now(),
): string {
  const then = new Date(iso);
  if (Number.isNaN(then.getTime())) return iso;
  const now = new Date(nowMs);
  const lang = resolveLocale(locale);
  const labels = labelsFor(lang);
  const upper = (value: string) => value.toLocaleUpperCase(lang === 'vi' ? 'vi-VN' : 'en-US');
  const weekday = upper(labels.weekdays[then.getDay()] ?? '');

  if (then.getFullYear() !== now.getFullYear()) {
    return `${weekday} ${formatSlashDate(then, true)}`;
  }

  if (isSameWeek(then, now, lang)) {
    if (then.getDate() === now.getDate()) return upper(labels.today);
    const dayDifference = now.getDate() - then.getDate();
    if (dayDifference === 1) return upper(labels.yesterday);
    if (dayDifference === 2) return upper(labels.dayBefore);
    if (dayDifference > 2) return weekday;
    return formatSlashDate(then, true);
  }

  if (isPreviousWeek(then, now, lang)) {
    const dayGap = dayGapAcrossPreviousWeek(then, now);
    if (dayGap === 1) return upper(labels.yesterday);
    if (dayGap === 2) return upper(labels.dayBefore);
  }

  return `${weekday} ${formatSlashDate(then, false)}`;
}

export function createDateSeparatorFormatter(locale: string): (iso: string) => string {
  return (iso: string) => formatOlaDateSeparator(iso, locale);
}
