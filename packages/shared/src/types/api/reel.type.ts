export type ReelType = 'image' | 'video' | 'text';

export type ReelVisibility = 'public' | 'friend';

export type ReelStatus = 'ready' | 'processing';

export type ReelOverlayStyle = 'plain' | 'solid' | 'soft';

export type ReelTextAlign = 'left' | 'center' | 'right';

export interface ReelAuthor {
  id: string;
  username: string;
  fullName?: string;
  avatar?: string | null;
}

export interface ReelOverlay {
  id: string;
  text: string;
  x: number;
  y: number;
  w: number;
  scale: number;
  rotation: number;
  color: string;
  style: ReelOverlayStyle;
  font: string;
  align: ReelTextAlign;
}

export interface Reel {
  id: string;
  author: ReelAuthor;
  type: ReelType;
  status?: ReelStatus;
  position: number;
  background?: string;
  overlays: ReelOverlay[];
  mediaUrl?: string;
  thumbUrl?: string;
  width?: number;
  height?: number;
  duration?: number;
  visibility: ReelVisibility;
  viewerCount?: number;
  createdAt: string;
  expiresAt: string;
}

export interface ReelTrayGroup {
  author: ReelAuthor;
  reels: Reel[];
}

export interface ReelTrayPage {
  mine: Reel[];
  groups: ReelTrayGroup[];
  nextCursor?: string;
}

export interface CreateReelItem {
  background?: string;
  overlays: ReelOverlay[];
}

export interface CreateReelsResult {
  reels: Reel[];
}

export interface MyReelsResult {
  reels: Reel[];
}

export interface MarkReelsSeenResult {
  ids: string[];
}

export interface ReelViewer {
  user: ReelAuthor;
  viewedAt: string;
}

export interface ReelViewersPage {
  items: ReelViewer[];
  total: number;
  limit: number;
  offset: number;
  nextOffset: number | null;
}
