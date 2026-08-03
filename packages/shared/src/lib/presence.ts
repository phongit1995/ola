import { formatOlaTime } from './datetime';

export function isBirthdayToday(dateOfBirth: string | undefined, now: Date): boolean {
  if (dateOfBirth == null || dateOfBirth === '') return false;
  const parts = /^(\d{4})-(\d{2})-(\d{2})/.exec(dateOfBirth);
  if (parts != null) {
    return Number(parts[2]) === now.getMonth() + 1 && Number(parts[3]) === now.getDate();
  }
  const date = new Date(dateOfBirth);
  if (Number.isNaN(date.getTime())) return false;
  return date.getMonth() === now.getMonth() && date.getDate() === now.getDate();
}

export function formatLastActive(
  locale: string,
  lastActiveAt?: string,
  now: number = Date.now()
): string | undefined {
  if (lastActiveAt == null || lastActiveAt === '') return undefined;
  const value = formatOlaTime(lastActiveAt, locale, now);
  return value === '' ? undefined : value;
}
