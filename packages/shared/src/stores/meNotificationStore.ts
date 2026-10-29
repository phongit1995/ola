import { create } from 'zustand';
import i18n from 'i18next';
import { NOTIFICATION_PAGE_SIZE } from '../constants/notification';
import { toast } from '../lib/toast';
import { MeService } from '../services/me.service';
import type { MeNotification } from '../types/api/me.type';
import type { MeNotificationState } from '../types/client/notification.type';

const removedIds = new Set<string>();
let realtimeSeq = 0;

function isFresher(candidate: MeNotification, known: MeNotification): boolean {
  const countDiff = (candidate.actorCount ?? 1) - (known.actorCount ?? 1);
  if (countDiff !== 0) return countDiff > 0;
  return Date.parse(candidate.createdAt) > Date.parse(known.createdAt);
}

function compareNewestFirst(a: MeNotification, b: MeNotification): number {
  const byTime = Date.parse(b.createdAt) - Date.parse(a.createdAt);
  if (byTime !== 0) return byTime;
  return a.id < b.id ? 1 : a.id > b.id ? -1 : 0;
}

function mergeKeepingFresher(
  current: readonly MeNotification[],
  incoming: readonly MeNotification[]
): MeNotification[] {
  const byId = new Map<string, MeNotification>();
  for (const item of [...current, ...incoming]) {
    if (removedIds.has(item.id)) continue;
    const known = byId.get(item.id);
    if (known == null || isFresher(item, known)) byId.set(item.id, item);
  }
  return [...byId.values()].sort(compareNewestFirst);
}

export const useMeNotificationStore = create<MeNotificationState>((set, get) => ({
  items: [],
  unreadCount: 0,
  loading: false,
  loadingMore: false,
  hasMore: false,
  nextCursor: null,
  load: async () => {
    const seq = realtimeSeq;
    set({ loading: true });
    try {
      const result = await MeService.notifications({ limit: NOTIFICATION_PAGE_SIZE });
      set((state) => {
        const realtimeArrived = seq !== realtimeSeq;
        return {
          items: mergeKeepingFresher(realtimeArrived ? state.items : [], result.items),
          unreadCount: realtimeArrived ? state.unreadCount : result.unreadCount,
          nextCursor: result.nextCursor ?? null,
          hasMore: result.nextCursor != null && result.nextCursor !== '',
          loading: false,
        };
      });
    } catch {
      set({ loading: false });
      toast.error(i18n.t('me.notifLoadError'));
    }
  },
  loadMore: async () => {
    const { loadingMore, hasMore, nextCursor } = get();
    if (loadingMore || !hasMore || nextCursor == null) return;
    const seq = realtimeSeq;
    set({ loadingMore: true });
    try {
      const result = await MeService.notifications({
        limit: NOTIFICATION_PAGE_SIZE,
        cursor: nextCursor,
      });
      set((state) => ({
        items: mergeKeepingFresher(state.items, result.items),
        unreadCount: seq !== realtimeSeq ? state.unreadCount : result.unreadCount,
        nextCursor: result.nextCursor ?? null,
        hasMore: result.nextCursor != null && result.nextCursor !== '',
        loadingMore: false,
      }));
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
    realtimeSeq += 1;
    if (removedId != null) {
      removedIds.add(removedId);
      set((state) => ({
        items: state.items.filter((item) => item.id !== removedId),
        unreadCount,
      }));
      return;
    }
    if (notification == null || removedIds.has(notification.id)) return;
    const known = get().items.find((item) => item.id === notification.id);
    if (known != null && !isFresher(notification, known)) return;
    set((state) => ({
      items: mergeKeepingFresher(state.items, [notification]),
      unreadCount,
    }));
  },
}));
