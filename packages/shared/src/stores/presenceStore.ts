import { create } from 'zustand';
import { PresenceService } from '../services';

export interface PresenceInfo {
  isOnline: boolean;
  lastActiveAt?: string;
}

interface PresenceState {
  presence: Map<string, PresenceInfo>;
  listIntervalId: ReturnType<typeof setInterval> | null;
  focusIntervalId: ReturnType<typeof setInterval> | null;
  fetch: (userIds: string[]) => Promise<void>;
  startListPolling: (getUserIds: () => string[]) => void;
  stopListPolling: () => void;
  startFocusPolling: (userId: string) => void;
  stopFocusPolling: () => void;
  reset: () => void;
}

const LIST_INTERVAL_MS = 60_000;
const FOCUS_INTERVAL_MS = 15_000;

const webDocument = (globalThis as { document?: { visibilityState?: string } }).document;

let isForeground: () => boolean = () =>
  webDocument == null || webDocument.visibilityState === 'visible';

export function configurePresenceForeground(check: () => boolean): void {
  isForeground = check;
}

export const usePresenceStore = create<PresenceState>((set, get) => ({
  presence: new Map(),
  listIntervalId: null,
  focusIntervalId: null,

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
      if (!isForeground()) return;
      const ids = getUserIds();
      if (ids.length > 0) void get().fetch(ids);
    };
    run();
    const id = setInterval(run, LIST_INTERVAL_MS);
    set({ listIntervalId: id });
  },

  stopListPolling: () => {
    const id = get().listIntervalId;
    if (id !== null) {
      clearInterval(id);
      set({ listIntervalId: null });
    }
  },

  startFocusPolling: (userId) => {
    get().stopFocusPolling();
    const run = () => {
      if (isForeground()) void get().fetch([userId]);
    };
    run();
    const id = setInterval(run, FOCUS_INTERVAL_MS);
    set({ focusIntervalId: id });
  },

  stopFocusPolling: () => {
    const id = get().focusIntervalId;
    if (id !== null) {
      clearInterval(id);
      set({ focusIntervalId: null });
    }
  },

  reset: () => {
    get().stopListPolling();
    get().stopFocusPolling();
    set({ presence: new Map() });
  },
}));
