import type { ReactionType } from './chat.type';

export type MomentType = 'image' | 'video' | 'text';

export type MomentVisibility = 'public' | 'friend';

export type MomentStatus = 'ready' | 'processing' | 'purging' | 'purged';

export type MomentHiddenBy = 'owner' | 'admin';

export type MomentOverlayStyle = 'plain' | 'solid' | 'soft';

export type MomentTextAlign = 'left' | 'center' | 'right';

export interface MomentAuthor {
  id: string;
  username: string;
  fullName?: string;
  avatar?: string | null;
}

export interface MomentOverlay {
  id: string;
  text: string;
  x: number;
  y: number;
  w: number;
  scale: number;
  rotation: number;
  color: string;
  style: MomentOverlayStyle;
  font: string;
  bold?: boolean;
  italic?: boolean;
  align: MomentTextAlign;
}

export interface Moment {
  id: string;
  author: MomentAuthor;
  type: MomentType;
  status?: MomentStatus;
  position: number;
  background?: string;
  overlays: MomentOverlay[];
  mediaUrl?: string;
  thumbUrl?: string;
  width?: number;
  height?: number;
  duration?: number;
  visibility: MomentVisibility;
  viewerCount?: number;
  reactionCount?: number;
  reactions?: MomentReactionCount[];
  hidden?: boolean;
  hiddenBy?: MomentHiddenBy;
  mediaPurged?: boolean;
  createdAt: string;
  expiresAt: string;
}

export interface MomentTrayGroup {
  author: MomentAuthor;
  moments: Moment[];
}

export interface MomentTrayPage {
  mine: Moment[];
  groups: MomentTrayGroup[];
  nextCursor?: string;
}

export interface CreateMomentItem {
  type?: MomentType;
  background?: string;
  overlays: MomentOverlay[];
}

export interface CreateMomentsResult {
  moments: Moment[];
}

export interface MyMomentsResult {
  moments: Moment[];
}

export interface MomentHistoryPage {
  moments: Moment[];
  nextOffset: number | null;
}

export interface MarkMomentsSeenResult {
  ids: string[];
}

export interface MomentReactionCount {
  type: ReactionType;
  count: number;
}

export interface MomentReactResult {
  type: ReactionType;
  count: number;
}

export interface MomentViewer {
  user: MomentAuthor;
  viewedAt: string;
}

export interface MomentReactor {
  user: MomentAuthor;
  reactedAt: string;
  reactions: MomentReactionCount[];
}

export interface MomentUserPage<T> {
  items: T[];
  total: number;
  limit: number;
  offset: number;
  nextOffset: number | null;
}

export type MomentViewersPage = MomentUserPage<MomentViewer>;

export type MomentReactorsPage = MomentUserPage<MomentReactor>;
