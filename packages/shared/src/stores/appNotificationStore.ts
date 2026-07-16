import { create } from 'zustand';
import i18n from 'i18next';
import { NotificationService } from '../services';
import { toast } from '../lib';
import type { AppNotification } from '../types';

const PAGE_SIZE = 30;

interface AppNotificationIncoming {
  notification?: AppNotification | null;
  removedId?: string | null;
  unreadCount: number;
}

interface AppNotificationState {
  items: AppNotification[];
  unreadCount: number;
  loading: boolean;
  loadingMore: boolean;
  hasMore: boolean;
  nextCursor: string | null;
  load: () => Promise<void>;
  loadMore: () => Promise<void>;
  markAllRead: () => Promise<void>;
  refreshUnread: () => Promise<void>;
  handleIncoming: (payload: AppNotificationIncoming) => void;
  removeLocal: (id: string) => void;
}

function dedupe(items: AppNotification[]): AppNotification[] {
  const seen = new Set<string>();
  return items.filter((item) => {
    if (seen.has(item.id)) return false;
    seen.add(item.id);
    return true;
  });
}

export const useAppNotificationStore = create<AppNotificationState>((set, get) => ({
  items: [],
  unreadCount: 0,
  loading: false,
  loadingMore: false,
  hasMore: false,
  nextCursor: null,
  load: async () => {
    set({ loading: true });
    try {
      const result = await NotificationService.list({ limit: PAGE_SIZE });
      set({
        items: result.items,
        unreadCount: result.unreadCount,
        nextCursor: result.nextCursor ?? null,
        hasMore: result.nextCursor != null && result.nextCursor !== '',
        loading: false,
      });
    } catch {
      set({ loading: false });
      toast.error(i18n.t('notify.loadError'));
    }
  },
  loadMore: async () => {
    const { loadingMore, hasMore, nextCursor, items } = get();
    if (loadingMore || !hasMore || nextCursor == null) return;
    set({ loadingMore: true });
    try {
      const result = await NotificationService.list({ limit: PAGE_SIZE, cursor: nextCursor });
      set({
        items: dedupe([...items, ...result.items]),
        unreadCount: result.unreadCount,
        nextCursor: result.nextCursor ?? null,
        hasMore: result.nextCursor != null && result.nextCursor !== '',
        loadingMore: false,
      });
    } catch {
      set({ loadingMore: false });
      toast.error(i18n.t('notify.loadError'));
    }
  },
  markAllRead: async () => {
    if (get().unreadCount === 0) return;
    set((state) => ({
      unreadCount: 0,
      items: state.items.map((item) => ({ ...item, isRead: true })),
    }));
    try {
      await NotificationService.markAllRead();
    } catch {
      void get().refreshUnread();
    }
  },
  refreshUnread: async () => {
    try {
      const { count } = await NotificationService.unreadCount();
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
  removeLocal: (id) => {
    set((state) => {
      const target = state.items.find((item) => item.id === id);
      const unreadDelta = target != null && !target.isRead ? 1 : 0;
      return {
        items: state.items.filter((item) => item.id !== id),
        unreadCount: Math.max(0, state.unreadCount - unreadDelta),
      };
    });
  },
}));
