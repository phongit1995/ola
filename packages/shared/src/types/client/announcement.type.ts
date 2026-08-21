import type { Announcement } from '../api/announcement.type';

export interface AnnouncementState {
  announcement: Announcement | null;
  loading: boolean;
  detailOpen: boolean;
  hidden: boolean;
  dismissedId: string | null;
  load: () => Promise<void>;
  openDetail: () => void;
  closeDetail: () => void;
  hide: () => void;
  dismiss: () => void;
  reset: () => void;
}

export interface PersistedAnnouncementState {
  dismissedId: string | null;
}
