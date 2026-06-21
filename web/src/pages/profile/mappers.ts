import { activeVipTypeId, colorForName } from '@lib';
import type { FollowUser, Post, PublicProfile } from '@app-types';
import { toMePost } from '../me/mappers';
import type { MePost } from '../me/types';
import type { ProfileFriend, UserProfile } from './types';
import { DEFAULT_COVER_COLOR } from './constants';

function formatBirthday(iso: string): string {
  const [year, month, day] = iso.split('-');
  if (!day || !month) return iso;
  return year ? `${day}/${month}/${year}` : `${day}/${month}`;
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
    username: data.username,
    fullName: data.fullName ?? '',
    color: deps.seedColor !== '' ? deps.seedColor : colorForName(data.username),
    coverColor: DEFAULT_COVER_COLOR,
    avatar: data.avatar,
    coverPhoto: data.coverPhoto,
    verified: data.verified,
    vipTypeId: activeVipTypeId(data.vipUsed, data.vipEndTime),
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
