import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import { sharedPersistStorage } from '../platform/persistStorage';
import { AnnouncementService } from '../services/announcement.service';
import type { Announcement } from '../types/api/announcement.type';
import type {
  AnnouncementState,
  PersistedAnnouncementState,
} from '../types/client/announcement.type';

export const useAnnouncementStore = create<AnnouncementState>()(
  persist(
    (set, get) => ({
      announcement: null,
      loading: false,
      detailOpen: false,
      hidden: false,
      dismissedId: null,
      feedDismissedId: null,

      load: async () => {
        if (get().loading) return;
        set({ loading: true });
        try {
          const { announcement } = await AnnouncementService.latest();
          set({ announcement, loading: false, hidden: false });
        } catch {
          set({ loading: false });
        }
      },

      openDetail: () => set({ detailOpen: true }),
      closeDetail: () => set({ detailOpen: false }),
      hide: () => set({ hidden: true }),
      dismiss: () => {
        const current = get().announcement;
        if (current != null) set({ dismissedId: current.id, detailOpen: false });
      },
      dismissFromFeed: () => {
        const current = get().announcement;
        if (current != null) set({ feedDismissedId: current.id });
      },
      reset: () =>
        set({ announcement: null, loading: false, detailOpen: false, hidden: false }),
    }),
    {
      name: 'ola.announcement',
      storage: sharedPersistStorage<PersistedAnnouncementState>(),
      partialize: (state) => ({ dismissedId: state.dismissedId, feedDismissedId: state.feedDismissedId }),
    }
  )
);

export function selectVisibleAnnouncement(state: AnnouncementState) {
  const { announcement, dismissedId, hidden } = state;
  if (announcement == null || hidden || announcement.id === dismissedId) return null;
  return announcement;
}

export function selectFeedAnnouncement(state: AnnouncementState) {
  const { announcement, feedDismissedId } = state;
  if (announcement == null || announcement.id === feedDismissedId) return null;
  return announcement;
}

export function announcementPublishedAt(announcement: Announcement): string {
  return announcement.startsAt ?? announcement.createdAt;
}
