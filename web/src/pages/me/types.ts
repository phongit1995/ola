import type { PostCheckIn } from '@app-types';

export type MeCheckIn = PostCheckIn;

export interface MePost {
  id: string;
  author: string;
  color: string;
  time: string;
  content: string;
  image: string | null;
  photos?: string[];
  checkIn?: MeCheckIn | null;
  comments: number;
  likes: number;
  likers: string[];
  liked: boolean;
  disliked: boolean;
  mention: boolean;
}

export type MeTab = 'feed' | 'tagged' | 'media' | 'mentions';
