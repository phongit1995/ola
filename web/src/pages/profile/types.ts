import type { MePost } from '../me/types';

export interface ProfileFriend {
  name: string;
  color: string;
}

export interface ProfileActions {
  kiss: () => void;
  toggleFollow: () => void;
  friendAction: () => void;
  blockAction: () => void;
}

export interface UserProfile {
  nick: string;
  color: string;
  coverColor: string;
  verified: boolean;
  vip: boolean;
  fans: number;
  kisses: number;
  bio: string;
  gender: 'male' | 'female';
  marriage: string;
  birthday: string;
  joinDate: string;
  media: string[];
  following: ProfileFriend[];
  posts: MePost[];
  isSelf: boolean;
}
