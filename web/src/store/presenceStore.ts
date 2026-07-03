import { create } from 'zustand';
import { PresenceService } from '@services';

export interface PresenceInfo {
  isOnline: boolean;
  lastActiveAt?: string;
}

interface PresenceState {
  presence: Map<string, PresenceInfo>;
  listIntervalId: number | null;
  focusIntervalId: number | null;
  focusUserId: string | null;
  fetch: (userIds: string[]) => Promise<void>;
  startListPolling: (getUserIds: () => string[]) => void;
  stopListPolling: () => void;
  startFocusPolling: (userId: string) => void;
  stopFocusPolling: () => void;
  reset: () => void;
}

const LIST_INTERVAL_MS = 60_000;
const FOCUS_INTERVAL_MS = 15_000;

export const usePresenceStore = create<PresenceState>((set, get) => ({
  presence: new Map(),
  listIntervalId: null,
  focusIntervalId: null,
  focusUserId: null,

  fetch: async (userIds) => {
    if (userIds.length === 0) return;
    try {
      const res = await PresenceService.batch(userIds);
      const next = new Map(get().presence);
      for (const user of res.users) {
        next.set(user.userId, { isOnline: user.isOnline, lastActiveAt: user.lastActiveAt });
      }
      set({ presence: next });
    } catch {
      return;
    }
  },

  startListPolling: (getUserIds) => {
    get().stopListPolling();
    const run = () => {
      if (document.visibilityState !== 'visible') return;
      const ids = getUserIds();
      if (ids.length > 0) void get().fetch(ids);
    };
    run();
    const id = window.setInterval(run, LIST_INTERVAL_MS);
    set({ listIntervalId: id });
  },

  stopListPolling: () => {
    const id = get().listIntervalId;
    if (id !== null) {
      window.clearInterval(id);
      set({ listIntervalId: null });
    }
  },

  startFocusPolling: (userId) => {
    get().stopFocusPolling();
    const run = () => {
      if (document.visibilityState !== 'visible') return;
      void get().fetch([userId]);
    };
    run();
    const id = window.setInterval(run, FOCUS_INTERVAL_MS);
    set({ focusIntervalId: id, focusUserId: userId });
  },

  stopFocusPolling: () => {
    const id = get().focusIntervalId;
    if (id !== null) {
      window.clearInterval(id);
      set({ focusIntervalId: null, focusUserId: null });
    }
  },

  reset: () => {
    get().stopListPolling();
    get().stopFocusPolling();
    set({ presence: new Map() });
  },
}));
