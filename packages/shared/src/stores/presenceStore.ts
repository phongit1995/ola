import { create } from 'zustand';
import {
  PRESENCE_FOCUS_POLL_INTERVAL_MS,
  PRESENCE_LIST_POLL_INTERVAL_MS,
} from '../constants/presence';
import { PresenceService } from '../services/presence.service';
import type { PresenceState } from '../types/client/presence.type';
import { registerOnLogout } from './authStore';
import {
  configurePresenceForegroundCheck,
  isPresenceForeground,
} from './presenceForeground.state';

export type { PresenceInfo } from '../types/client/presence.type';

export function configurePresenceForeground(check: () => boolean): void {
  configurePresenceForegroundCheck(check);
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
      if (!isPresenceForeground()) return;
      const ids = getUserIds();
      if (ids.length > 0) void get().fetch(ids);
    };
    run();
    const id = setInterval(run, PRESENCE_LIST_POLL_INTERVAL_MS);
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
      if (isPresenceForeground()) void get().fetch([userId]);
    };
    run();
    const id = setInterval(run, PRESENCE_FOCUS_POLL_INTERVAL_MS);
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

registerOnLogout(() => usePresenceStore.getState().reset());
