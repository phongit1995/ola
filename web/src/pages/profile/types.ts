import type { PostReaction, RelationshipInfo } from '@app-types';
import type { MePost } from '../me/types';
import type { ComposedPost } from '../me/components/MeComposerDialog';

export interface ProfilePostActions {
  toggleReaction: (id: string, type: PostReaction) => void;
  adjustCommentCount: (id: string, delta: number) => void;
  editPost: (id: string, draft: ComposedPost) => Promise<boolean>;
  deletePost: (id: string) => void;
  togglePin: (id: string, pinned: boolean) => void;
}

export interface ProfileFriend {
  name: string;
  fullName?: string;
  avatar?: string;
  color: string;
}

export interface ProfileActions {
  kiss: () => void;
  toggleFollow: () => void;
  friendAction: () => void;
  blockAction: () => void;
  message: () => void;
  changeCover: (file: File) => Promise<void>;
  changeAvatar: (file: File) => Promise<void>;
}

export interface UserProfile {
  nick: string;
  username: string;
  fullName: string;
  color: string;
  coverColor: string;
  avatar?: string;
  coverPhoto?: string;
  verified: boolean;
  vipTypeId: number | null;
  fans: number;
  kisses: number;
  bio: string;
  gender: 'male' | 'female';
  marriage: string;
  spouse: { nick: string; avatar?: string } | null;
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
