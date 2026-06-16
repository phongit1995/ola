import { colorForName } from '@lib';
import type { FollowUser, Post, PublicProfile } from '@app-types';
import { toMePost } from '../me/mappers';
import type { MePost } from '../me/types';
import type { ProfileFriend, UserProfile } from './types';

const DEFAULT_COVER_COLOR = '#33691e';

function formatBirthday(iso: string): string {
  const [, month, day] = iso.split('-');
  if (!day || !month) return iso;
  return `${day}/${month}`;
}

export interface ProfileMapDeps {
  seedColor: string;
  marriedLabel: string;
  singleLabel: string;
  joinedLabel: string;
  formatDate: (iso: string) => string;
}

export function mapPublicProfile(data: PublicProfile, deps: ProfileMapDeps): UserProfile {
  const nick = data.fullName && data.fullName !== '' ? data.fullName : data.username;
  return {
    nick,
    color: deps.seedColor !== '' ? deps.seedColor : colorForName(data.username),
    coverColor: DEFAULT_COVER_COLOR,
    verified: data.verified,
    vip: Boolean(data.vipUsed),
    fans: data.followerCount,
    kisses: data.kisses,
    bio: data.bio ?? '',
    gender: data.gender,
    marriage: data.marriage === 'married' ? deps.marriedLabel : deps.singleLabel,
    birthday: data.dateOfBirth ? formatBirthday(data.dateOfBirth) : '',
    joinDate: `${deps.joinedLabel} ${deps.formatDate(data.createdAt)}`,
    isSelf: data.relationship?.status === 'self',
  };
}

export function mapFollowing(users: FollowUser[]): ProfileFriend[] {
  return users.map((user) => ({ name: user.username, color: colorForName(user.username) }));
}

export function mapPosts(posts: Post[], formatTime: (iso: string) => string): MePost[] {
  return posts.map((post) => toMePost(post, formatTime));
}
