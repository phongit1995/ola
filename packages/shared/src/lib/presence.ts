import type { TFunction } from 'i18next';

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
  t: TFunction,
  lastActiveAt?: string,
  now: number = Date.now()
): string | undefined {
  if (lastActiveAt == null || lastActiveAt === '') return undefined;
  const then = new Date(lastActiveAt);
  if (Number.isNaN(then.getTime())) return undefined;
  const minutes = Math.floor((now - then.getTime()) / 60000);
  if (minutes < 1) return t('chat.lastActiveJustNow');
  if (minutes < 60) return t('chat.lastActiveMinutes', { count: minutes });
  const hours = Math.floor(minutes / 60);
  if (hours < 24) return t('chat.lastActiveHours', { count: hours });
  return t('chat.lastActiveDays', { count: Math.floor(hours / 24) });
}
