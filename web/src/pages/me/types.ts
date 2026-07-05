import type { PostCheckIn, PostVisibility } from '@app-types';

export type MeCheckIn = PostCheckIn;

export interface MePost {
  id: string;
  authorId: string;
  author: string;
  fullName: string;
  avatar: string | null;
  color: string;
  time: string;
  createdAt?: string;
  content: string;
  visibility: PostVisibility;
  image: string | null;
  photos?: string[];
  checkIn?: MeCheckIn | null;
  comments: number;
  likes: number;
  liked: boolean;
  disliked: boolean;
  mention: boolean;
  pinned: boolean;
  topLikers: { name: string; avatar: string | null; color: string }[];
}

export type MeTab = 'community' | 'personal';
