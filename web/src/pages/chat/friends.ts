import type { TFunction } from 'i18next';
import { activeVipTypeId, colorForName, isVipActive } from '@lib';
import type { Friend } from '@app-types';
import type { Contact, ContactGroup, DeviceType } from './types';
import { DEVICE_TYPES } from './constants';

function normalizeDevice(value?: string): DeviceType {
  return DEVICE_TYPES.includes(value as DeviceType) ? (value as DeviceType) : 'android';
}

function isBirthdayToday(dateOfBirth?: string): boolean {
  if (dateOfBirth == null || dateOfBirth === '') return false;
  const now = new Date();
  const parts = /^(\d{4})-(\d{2})-(\d{2})/.exec(dateOfBirth);
  if (parts != null) {
    return Number(parts[2]) === now.getMonth() + 1 && Number(parts[3]) === now.getDate();
  }
  const date = new Date(dateOfBirth);
  if (Number.isNaN(date.getTime())) return false;
  return date.getMonth() === now.getMonth() && date.getDate() === now.getDate();
}

function formatLastActive(t: TFunction, lastActiveAt?: string): string | undefined {
  if (lastActiveAt == null || lastActiveAt === '') return undefined;
  const then = new Date(lastActiveAt);
  if (Number.isNaN(then.getTime())) return undefined;
  const minutes = Math.floor((Date.now() - then.getTime()) / 60000);
  if (minutes < 1) return t('chat.lastActiveJustNow');
  if (minutes < 60) return t('chat.lastActiveMinutes', { count: minutes });
  const hours = Math.floor(minutes / 60);
  if (hours < 24) return t('chat.lastActiveHours', { count: hours });
  return t('chat.lastActiveDays', { count: Math.floor(hours / 24) });
}

function groupOf(friend: Friend): ContactGroup {
  return isBirthdayToday(friend.dateOfBirth) ? 'birthday' : 'friend';
}

export function mapFriendsToContacts(friends: Friend[], t: TFunction): Contact[] {
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
      lastActive: friend.isOnline ? undefined : formatLastActive(t, friend.lastActiveAt),
      statusImage: friend.bioImage ?? undefined,
      group: groupOf(friend),
    };
  });
}
