import type { Friend } from '@app-types';
import type { Contact, ContactGroup, DeviceType } from './types';

const AVATAR_COLORS = [
  '#7cb342',
  '#5d4037',
  '#6d4c41',
  '#4dd0e1',
  '#ef6c00',
  '#00897b',
  '#9c27b0',
  '#ec407a',
  '#26a69a',
  '#7e57c2',
];

const DEVICE_TYPES: DeviceType[] = ['phone', 'pc', 'apple', 'android', 'winphone'];

function colorForId(id: string): string {
  let hash = 0;
  for (let i = 0; i < id.length; i += 1) {
    hash = (hash * 31 + id.charCodeAt(i)) >>> 0;
  }
  return AVATAR_COLORS[hash % AVATAR_COLORS.length] ?? '#7cb342';
}

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

function hasActiveVip(vipEndTime?: string | null): boolean {
  if (vipEndTime == null || vipEndTime === '') return false;
  const end = new Date(vipEndTime);
  return !Number.isNaN(end.getTime()) && end.getTime() > Date.now();
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
  return friends.map((friend) => ({
    id: friend.id,
    name: friend.username,
    fullName: friend.fullName,
    status: friend.bio,
    color: colorForId(friend.id),
    avatar: friend.avatar,
    vip: hasActiveVip(friend.vipEndTime),
    online: friend.isOnline,
    deviceType: normalizeDevice(friend.deviceType),
    lastActive: friend.isOnline ? undefined : formatLastActive(friend.lastActiveAt),
    statusImage: friend.bioImage ?? undefined,
    group: groupOf(friend),
  }));
}
