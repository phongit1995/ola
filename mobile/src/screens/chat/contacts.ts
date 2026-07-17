import type { TFunction } from 'i18next';
import { activeVipTypeId, colorForName, formatLastActive, isBirthdayToday, isVipActive } from '@ola/shared/lib';
import type { Friend } from '@ola/shared/types';
import { normalizeDevice, type DeviceType } from '@lib/deviceIcons';

export type ContactGroup = 'birthday' | 'new' | 'utility' | 'friend';

export interface Contact {
  id: string;
  name: string;
  fullName?: string;
  status?: string;
  color: string;
  avatar?: string;
  vip: boolean;
  vipTypeId?: number | null;
  online: boolean;
  deviceType: DeviceType;
  lastActive?: string;
  statusImage?: string;
  group: ContactGroup;
}

export interface SuggestedFriend {
  name: string;
  color: string;
}

export const SUGGESTED_FRIENDS: SuggestedFriend[] = [
  { name: 'anhthu', color: '#ec407a' },
  { name: 'baolong', color: '#26a69a' },
  { name: 'cammy', color: '#7e57c2' },
  { name: 'dunghoang', color: '#42a5f5' },
  { name: 'giangpham', color: '#ef5350' },
  { name: 'hannguyen', color: '#ab47bc' },
  { name: 'khoile', color: '#26c6da' },
  { name: 'linhdan', color: '#ffa726' },
  { name: 'minhquan', color: '#66bb6a' },
  { name: 'ngocbich', color: '#ec407a' },
  { name: 'phuongvy', color: '#5c6bc0' },
  { name: 'tuanvu', color: '#8d6e63' },
];

export function mapFriendsToContacts(friends: Friend[], t: TFunction, now: number): Contact[] {
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
    lastActive: friend.isOnline ? undefined : formatLastActive(t, friend.lastActiveAt, now),
    statusImage: friend.bioImage ?? undefined,
    group: isBirthdayToday(friend.dateOfBirth, today) ? 'birthday' : 'friend',
  }));
}
