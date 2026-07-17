import { create } from 'zustand';
import i18n from 'i18next';
import { MeService } from '../services';
import { toast } from '../lib';
import type { MeNotification } from '../types';

const PAGE_SIZE = 30;

interface MeNotificationIncoming {
  notification?: MeNotification | null;
  removedId?: string | null;
  unreadCount: number;
}

interface MeNotificationState {
  items: MeNotification[];
  unreadCount: number;
  loading: boolean;
  loadingMore: boolean;
  hasMore: boolean;
  nextCursor: string | null;
  load: () => Promise<void>;
  loadMore: () => Promise<void>;
  markAllRead: () => Promise<void>;
  refreshUnread: () => Promise<void>;
  handleIncoming: (payload: MeNotificationIncoming) => void;
}

function dedupe(items: MeNotification[]): MeNotification[] {
  const seen = new Set<string>();
  return items.filter((item) => {
    if (seen.has(item.id)) return false;
    seen.add(item.id);
    return true;
  });
}

export const useMeNotificationStore = create<MeNotificationState>((set, get) => ({
  items: [],
  unreadCount: 0,
  loading: false,
  loadingMore: false,
  hasMore: false,
  nextCursor: null,
  load: async () => {
    set({ loading: true });
    try {
      const result = await MeService.notifications({ limit: PAGE_SIZE });
      set({
        items: result.items,
        unreadCount: result.unreadCount,
        nextCursor: result.nextCursor ?? null,
        hasMore: result.nextCursor != null && result.nextCursor !== '',
        loading: false,
      });
    } catch {
      set({ loading: false });
      toast.error(i18n.t('me.notifLoadError'));
    }
  },
  loadMore: async () => {
    const { loadingMore, hasMore, nextCursor, items } = get();
    if (loadingMore || !hasMore || nextCursor == null) return;
    set({ loadingMore: true });
    try {
      const result = await MeService.notifications({ limit: PAGE_SIZE, cursor: nextCursor });
      set({
        items: dedupe([...items, ...result.items]),
        unreadCount: result.unreadCount,
        nextCursor: result.nextCursor ?? null,
        hasMore: result.nextCursor != null && result.nextCursor !== '',
        loadingMore: false,
      });
    } catch {
      set({ loadingMore: false });
      toast.error(i18n.t('me.notifLoadError'));
    }
  },
  markAllRead: async () => {
    if (get().unreadCount === 0) return;
    set((state) => ({
      unreadCount: 0,
      items: state.items.map((item) => ({ ...item, isRead: true })),
    }));
    try {
      await MeService.markNotificationsRead();
    } catch {
      void get().refreshUnread();
    }
  },
  refreshUnread: async () => {
    try {
      const { count } = await MeService.notificationsUnreadCount();
      set({ unreadCount: count });
    } catch {
      return;
    }
  },
  handleIncoming: ({ notification, removedId, unreadCount }) => {
    if (removedId != null) {
      set((state) => ({
        items: state.items.filter((item) => item.id !== removedId),
        unreadCount,
      }));
      return;
    }
    if (notification == null) return;
    set((state) => ({
      items: dedupe([notification, ...state.items]),
      unreadCount,
    }));
  },
}));
