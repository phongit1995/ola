import type { ReelOverlay, ReelTrayGroup, ReelType } from '../api/reel.type';
import type { UploadFile } from './upload.type';

export interface ReelMediaDraft {
  type: Exclude<ReelType, 'text'>;
  url: string;
  file?: UploadFile;
  posterUrl?: string;
  duration?: number;
  playable?: boolean;
}

export interface ReelDraftSlide {
  id: string;
  media: ReelMediaDraft | null;
  background: string;
  overlays: ReelOverlay[];
}

export interface ReelViewerSession {
  groups: ReelTrayGroup[];
  startIndex: number;
  own: boolean;
}

export interface ReelPosition {
  groupIndex: number;
  itemIndex: number;
}
