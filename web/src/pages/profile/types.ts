import type { PostReaction, RelationshipInfo } from '@app-types';
import type { MePost } from '../me/types';
import type { ComposedPost } from '../me/components/MeComposerDialog';

export interface ProfilePostActions {
  toggleReaction: (id: string, type: PostReaction) => void;
  adjustCommentCount: (id: string, delta: number) => void;
  editPost: (id: string, draft: ComposedPost) => Promise<boolean>;
  deletePost: (id: string) => void;
}

export interface ProfileFriend {
  name: string;
  color: string;
}

export interface ProfileActions {
  kiss: () => void;
  toggleFollow: () => void;
  friendAction: () => void;
  blockAction: () => void;
  message: () => void;
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
  isSelf: boolean;
}

export interface ProfileSecondary {
  media: string[];
  following: ProfileFriend[];
  posts: MePost[];
  loading: boolean;
}

export interface ProfileController {
  profile: UserProfile | null;
  loading: boolean;
  notFound: boolean;
  relationship: RelationshipInfo;
  busy: boolean;
  actions: ProfileActions;
  secondary: ProfileSecondary;
  postActions: ProfilePostActions;
}
