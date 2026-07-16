import type { TFunction } from 'i18next';
import { activeVipTypeId, colorForName, isVipActive } from '@lib';
import type { Friend } from '@app-types';
import type { Contact, ContactGroup } from './types';
import { normalizeDevice } from '@constants';

function isBirthdayToday(dateOfBirth: string | undefined, now: Date): boolean {
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

function groupOf(friend: Friend, now: Date): ContactGroup {
  return isBirthdayToday(friend.dateOfBirth, now) ? 'birthday' : 'friend';
}

export function mapFriendsToContacts(friends: Friend[], t: TFunction, now: number): Contact[] {
  const today = new Date(now);
  return friends.map((friend) => {
    return {
      id: friend.id,
      name: friend.username,
      fullName: friend.fullName,
      status: friend.bio,
      color: colorForName(friend.id),
      avatar: friend.avatar,
      vip: isVipActive(friend.vipEndTime),
      vipTypeId: activeVipTypeId(friend.vipUsed, friend.vipEndTime),
      online: friend.isOnline,
      deviceType: normalizeDevice(friend.deviceType),
      lastActive: friend.isOnline ? undefined : formatLastActive(t, friend.lastActiveAt, now),
      statusImage: friend.bioImage ?? undefined,
      group: groupOf(friend, today),
    };
  });
}
