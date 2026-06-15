export interface MePost {
  id: string;
  author: string;
  color: string;
  time: string;
  content: string;
  image: string | null;
  photos?: string[];
  checkIn?: string | null;
  comments: number;
  likes: number;
  likers: string[];
  liked: boolean;
  disliked: boolean;
  mention: boolean;
}

export type MeTab = 'feed' | 'mentions' | 'media' | 'follower';
