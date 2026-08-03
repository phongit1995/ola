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
