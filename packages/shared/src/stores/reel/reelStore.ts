import { create } from 'zustand';
import {
  REEL_RETRY_BASE_MS,
  REEL_RETRY_MAX_MS,
  REEL_SEEN_BATCH,
  REEL_SEEN_FLUSH_MS,
  REEL_STATUS,
} from '../../constants/reel';
import { toApiError } from '../../lib/apiError';
import { appendReelGroups } from '../../lib/reel';
import { ReelService, type CreateReelsInput } from '../../services/reel.service';
import type { Reel, ReelTrayGroup } from '../../types/api/reel.type';
import { registerOnLogout, useAuthStore } from '../auth/authStore';

type Timer = ReturnType<typeof setTimeout>;

interface ReelState {
  mine: Reel[];
  groups: ReelTrayGroup[];
  nextCursor: string | null;
  loaded: boolean;
  refreshing: boolean;
  loadingMore: boolean;
  seenIds: ReadonlySet<string>;
  clockMs: number;
  tick: () => void;
  load: () => Promise<void>;
  loadMore: () => Promise<void>;
  refreshMine: () => Promise<string[]>;
  markSeen: (id: string) => void;
  flushSeen: () => Promise<void>;
  publish: (build: () => Promise<CreateReelsInput>) => Promise<boolean>;
  remove: (id: string) => Promise<void>;
  reset: () => void;
}

const SERVER_ERROR_STATUS = 500;
const TOO_MANY_REQUESTS_STATUS = 429;

function initialState() {
  return {
    mine: [] as Reel[],
    groups: [] as ReelTrayGroup[],
    nextCursor: null as string | null,
    loaded: false,
    refreshing: false,
    loadingMore: false,
    seenIds: new Set<string>() as ReadonlySet<string>,
    clockMs: Date.now(),
  };
}

let storeSession = 0;
let trayGeneration = 0;
let mineVersion = 0;

const seenQueue = {
  pending: new Set<string>(),
  timer: undefined as Timer | undefined,
  flushing: false,
  failures: 0,
};

const trayPaging = {
  timer: undefined as Timer | undefined,
  failures: 0,
};

function currentUserId(): string | undefined {
  return useAuthStore.getState().user?.id;
}

function sessionGuard(): () => boolean {
  const session = storeSession;
  const userId = currentUserId();
  return () => session === storeSession && userId != null && userId === currentUserId();
}

function stopPagingRetry() {
  clearTimeout(trayPaging.timer);
  trayPaging.failures = 0;
}

function isRetryable(error: unknown): boolean {
  const status = toApiError(error).status;
  return status === 0 || status === TOO_MANY_REQUESTS_STATUS || status >= SERVER_ERROR_STATUS;
}

function retryDelayMs(failures: number): number {
  return Math.min(REEL_RETRY_BASE_MS * 2 ** failures, REEL_RETRY_MAX_MS);
}

function processingIds(reels: readonly Reel[]): string[] {
  return reels.filter((reel) => reel.status === REEL_STATUS.processing).map((reel) => reel.id);
}

function appendNewReels(mine: readonly Reel[], created: readonly Reel[]): Reel[] {
  const known = new Set(mine.map((reel) => reel.id));
  return [...mine, ...created.filter((reel) => !known.has(reel.id))];
}

export const useReelStore = create<ReelState>((set, get) => {
  function scheduleSeenFlush(delayMs: number) {
    clearTimeout(seenQueue.timer);
    seenQueue.timer = setTimeout(() => void get().flushSeen(), delayMs);
  }

  return {
    ...initialState(),
    tick: () => set({ clockMs: Date.now() }),
    load: async () => {
      const generation = ++trayGeneration;
      const version = mineVersion;
      stopPagingRetry();
      set({ refreshing: true, loadingMore: false });
      try {
        const page = await ReelService.tray();
        if (generation !== trayGeneration) return;
        const mineChanged = version !== mineVersion;
        if (!mineChanged) mineVersion += 1;
        set((state) => ({
          mine: mineChanged ? state.mine : page.mine,
          groups: page.groups,
          nextCursor: page.nextCursor ?? null,
          loaded: true,
          clockMs: Date.now(),
        }));
      } finally {
        if (generation === trayGeneration) set({ refreshing: false });
      }
    },
    loadMore: async () => {
      const { nextCursor, loadingMore, refreshing } = get();
      if (nextCursor == null || loadingMore || refreshing) return;
      const generation = trayGeneration;
      set({ loadingMore: true });
      try {
        const page = await ReelService.tray(nextCursor);
        if (generation !== trayGeneration) return;
        trayPaging.failures = 0;
        set((state) => ({
          groups: appendReelGroups(state.groups, page.groups),
          nextCursor: page.nextCursor ?? null,
          loadingMore: false,
        }));
      } catch (error) {
        if (generation !== trayGeneration) return;
        if (!isRetryable(error)) {
          set({ nextCursor: null, loadingMore: false });
          return;
        }
        const delayMs = retryDelayMs(trayPaging.failures);
        trayPaging.failures += 1;
        trayPaging.timer = setTimeout(() => {
          if (generation === trayGeneration) set({ loadingMore: false });
        }, delayMs);
      }
    },
    refreshMine: async () => {
      const isCurrent = sessionGuard();
      const version = mineVersion;
      const before = processingIds(get().mine);
      const { reels } = await ReelService.mine();
      if (!isCurrent() || version !== mineVersion) return [];
      mineVersion += 1;
      set({ mine: reels, clockMs: Date.now() });
      const after = new Set(reels.map((reel) => reel.id));
      return before.filter((id) => !after.has(id));
    },
    markSeen: (id) => {
      if (get().seenIds.has(id)) return;
      set((state) => ({ seenIds: new Set(state.seenIds).add(id) }));
      seenQueue.pending.add(id);
      if (seenQueue.pending.size >= REEL_SEEN_BATCH) void get().flushSeen();
      else if (seenQueue.failures === 0) scheduleSeenFlush(REEL_SEEN_FLUSH_MS);
    },
    flushSeen: async () => {
      clearTimeout(seenQueue.timer);
      if (seenQueue.flushing || seenQueue.pending.size === 0) return;
      seenQueue.flushing = true;
      const session = storeSession;
      try {
        while (seenQueue.pending.size > 0 && session === storeSession) {
          const batch = [...seenQueue.pending].slice(0, REEL_SEEN_BATCH);
          batch.forEach((id) => seenQueue.pending.delete(id));
          try {
            await ReelService.markSeen(batch);
            seenQueue.failures = 0;
          } catch (error) {
            if (session !== storeSession) return;
            if (!isRetryable(error)) continue;
            batch.forEach((id) => seenQueue.pending.add(id));
            scheduleSeenFlush(retryDelayMs(seenQueue.failures));
            seenQueue.failures += 1;
            return;
          }
        }
      } finally {
        if (session === storeSession) seenQueue.flushing = false;
      }
    },
    publish: async (build) => {
      const isCurrent = sessionGuard();
      const request = await build();
      if (!isCurrent()) return false;
      const created = await ReelService.create(request);
      if (!isCurrent()) return false;
      mineVersion += 1;
      set((state) => ({ mine: appendNewReels(state.mine, created.reels), clockMs: Date.now() }));
      return true;
    },
    remove: async (id) => {
      const isCurrent = sessionGuard();
      await ReelService.remove(id);
      if (!isCurrent()) return;
      mineVersion += 1;
      set((state) => ({ mine: state.mine.filter((reel) => reel.id !== id) }));
    },
    reset: () => {
      storeSession += 1;
      trayGeneration += 1;
      mineVersion += 1;
      stopPagingRetry();
      clearTimeout(seenQueue.timer);
      seenQueue.pending = new Set();
      seenQueue.flushing = false;
      seenQueue.failures = 0;
      set(initialState());
    },
  };
});

registerOnLogout(() => useReelStore.getState().reset());
