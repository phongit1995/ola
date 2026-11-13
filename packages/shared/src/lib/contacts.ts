import type { Friend } from '../types/api/relationship.type';
import type { Contact, DeviceType } from '../types/client/contact.type';
import { colorForName } from './avatarColor';
import { formatLastActive, isBirthdayToday } from './presence';
import { activeVipTypeId, isVipActive } from './vip';

const DEVICE_TYPES: DeviceType[] = ['phone', 'pc', 'apple', 'android', 'winphone'];

const DEVICE_ALIASES: Record<string, DeviceType> = {
  ios: 'apple',
  android: 'android',
  web: 'pc',
};

export function normalizeDevice(value?: string): DeviceType {
  if (value == null || value === '') return 'pc';
  if (DEVICE_TYPES.includes(value as DeviceType)) return value as DeviceType;
  return DEVICE_ALIASES[value] ?? 'pc';
}

export function mapFriendsToContacts(friends: Friend[], locale: string, now: number): Contact[] {
  const today = new Date(now);
  return friends.map((friend) => ({
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
    lastActive: friend.isOnline ? undefined : formatLastActive(locale, friend.lastActiveAt, now),
    statusImage: friend.bioImage ?? undefined,
    group: isBirthdayToday(friend.dateOfBirth, today) ? 'birthday' : 'friend',
  }));
}
