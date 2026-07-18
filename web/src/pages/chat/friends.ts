import type { TFunction } from 'i18next';
import { activeVipTypeId, colorForName, formatLastActive, isBirthdayToday, isVipActive } from '@lib';
import type { Friend } from '@app-types';
import type { ContactGroup } from './types';
import type { Contact } from './interface';
import { normalizeDevice } from '@constants';

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
