import type { MomentOverlay, MomentTrayGroup, MomentType } from '../api/moment.type';
import type { ReactionType } from '../api/chat.type';
import type { MOMENT_MUSIC_SLIDE_SECONDS } from '../../constants/moment';
import type { UploadFile } from './upload.type';

export interface MomentMediaDraft {
  type: Exclude<MomentType, 'text'>;
  url: string;
  file?: UploadFile;
  posterUrl?: string;
  duration?: number;
  playable?: boolean;
}

export type MomentMusicSeconds = (typeof MOMENT_MUSIC_SLIDE_SECONDS)[number];

export interface MomentMusicDraft {
  file: UploadFile;
  url: string;
  fileName: string;
  title: string;
  durationMs: number;
  startMs: number;
  slideSeconds: MomentMusicSeconds;
}

export interface MomentDraftSlide {
  id: string;
  media: MomentMediaDraft | null;
  background: string;
  overlays: MomentOverlay[];
  blank?: boolean;
}

export interface MomentViewerSession {
  groups: MomentTrayGroup[];
  startIndex: number;
  own: boolean;
  archive?: boolean;
  startMomentId?: string;
  detailId?: string;
  unseenOnly?: boolean;
}

export interface MomentPosition {
  groupIndex: number;
  itemIndex: number;
}

export interface MomentReactionSpark {
  x: number;
  y: number;
  rotate: number;
  size: number;
  color: string | null;
}

export interface MomentConfigState {
  enabled: boolean | null;
  videoVipRequired: boolean;
  musicEnabled: boolean;
  load: () => Promise<void>;
}

export interface MomentReactionBurst {
  id: number;
  type: ReactionType;
  fromX: number;
  fromY: number;
  toX: number;
  toY: number;
  sparks: MomentReactionSpark[];
}
