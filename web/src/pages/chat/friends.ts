import { activeVipTypeId, colorForName, isVipActive } from '@lib';
import type { Friend } from '@app-types';
import type { Contact, ContactGroup, DeviceType } from './types';

const DEVICE_TYPES: DeviceType[] = ['phone', 'pc', 'apple', 'android', 'winphone'];

function normalizeDevice(value?: string): DeviceType {
  return DEVICE_TYPES.includes(value as DeviceType) ? (value as DeviceType) : 'android';
}

function isBirthdayToday(dateOfBirth?: string): boolean {
  if (dateOfBirth == null || dateOfBirth === '') return false;
  const date = new Date(dateOfBirth);
  if (Number.isNaN(date.getTime())) return false;
  const now = new Date();
  return date.getMonth() === now.getMonth() && date.getDate() === now.getDate();
}

function formatLastActive(lastActiveAt?: string): string | undefined {
  if (lastActiveAt == null || lastActiveAt === '') return undefined;
  const then = new Date(lastActiveAt);
  if (Number.isNaN(then.getTime())) return undefined;
  const minutes = Math.floor((Date.now() - then.getTime()) / 60000);
  if (minutes < 1) return 'vừa xong';
  if (minutes < 60) return `${minutes} phút trước`;
  const hours = Math.floor(minutes / 60);
  if (hours < 24) return `${hours} giờ trước`;
  return `${Math.floor(hours / 24)} ngày trước`;
}

function groupOf(friend: Friend): ContactGroup {
  return isBirthdayToday(friend.dateOfBirth) ? 'birthday' : 'friend';
}

export function mapFriendsToContacts(friends: Friend[]): Contact[] {
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
      lastActive: friend.isOnline ? undefined : formatLastActive(friend.lastActiveAt),
      statusImage: friend.bioImage ?? undefined,
      group: groupOf(friend),
    };
  });
}
