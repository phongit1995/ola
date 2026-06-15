export interface MeCheckIn {
  name: string;
  address?: string;
  lat?: number;
  lng?: number;
  action?: string;
  actionIcon?: string;
}

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

export type MeTab = 'feed' | 'mentions' | 'media' | 'follower';
