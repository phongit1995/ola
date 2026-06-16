import type { PostCheckIn, PostVisibility } from '@app-types';

export type MeCheckIn = PostCheckIn;

export interface MePost {
  id: string;
  authorId: string;
  author: string;
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
  likers: string[];
  liked: boolean;
  disliked: boolean;
  mention: boolean;
}

export type MeTab = 'feed' | 'tagged' | 'media' | 'mentions';
