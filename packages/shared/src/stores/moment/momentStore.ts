import { create } from 'zustand';
import {
  MOMENT_REACT_FLUSH_MS,
  MOMENT_REACT_MAX_PER_REQUEST,
  MOMENT_REACT_MAX_PER_TYPE,
  MOMENT_RETRY_BASE_MS,
  MOMENT_RETRY_MAX_MS,
  MOMENT_SEEN_BATCH,
  MOMENT_SEEN_FLUSH_MS,
  MOMENT_STATUS,
} from '../../constants/moment';
import { toApiError } from '../../lib/apiError';
import { appendMomentGroups, isMomentActive } from '../../lib/moment';
import { MomentService, type CreateMomentsInput } from '../../services/moment.service';
import type { ReactionType } from '../../types/api/chat.type';
import type { Moment, MomentTrayGroup } from '../../types/api/moment.type';
import { registerOnLogout, useAuthStore } from '../auth/authStore';

type Timer = ReturnType<typeof setTimeout>;

interface MomentState {
  mine: Moment[];
  groups: MomentTrayGroup[];
  nextCursor: string | null;
  loaded: boolean;
  refreshing: boolean;
  loadingMore: boolean;
  seenIds: ReadonlySet<string>;
  clockMs: number;
  history: Moment[];
  historyNextOffset: number | null;
  historyLoaded: boolean;
  historyLoading: boolean;
  tick: () => void;
  load: () => Promise<void>;
  loadMore: () => Promise<void>;
  refreshMine: () => Promise<string[]>;
  loadHistory: () => Promise<void>;
  loadMoreHistory: () => Promise<void>;
  markSeen: (id: string) => void;
  flushSeen: () => Promise<void>;
  react: (momentId: string, type: ReactionType) => void;
  flushReactions: () => Promise<void>;
  publish: (build: () => Promise<CreateMomentsInput>) => Promise<boolean>;
  setHidden: (id: string, hidden: boolean) => Promise<void>;
  reset: () => void;
}

const SERVER_ERROR_STATUS = 500;
const TOO_MANY_REQUESTS_STATUS = 429;

function initialState() {
  return {
    mine: [] as Moment[],
    groups: [] as MomentTrayGroup[],
    nextCursor: null as string | null,
    loaded: false,
    refreshing: false,
    loadingMore: false,
    seenIds: new Set<string>() as ReadonlySet<string>,
    clockMs: Date.now(),
    history: [] as Moment[],
    historyNextOffset: null as number | null,
    historyLoaded: false,
    historyLoading: false,
  };
}

let storeSession = 0;
let trayGeneration = 0;
let mineVersion = 0;
let historyGeneration = 0;
let historyVersion = 0;

const HISTORY_STALE_RETRIES = 2;

const seenQueue = {
  pending: new Set<string>(),
  timer: undefined as Timer | undefined,
  flushing: false,
  failures: 0,
};

interface QueuedReaction {
  momentId: string;
  type: ReactionType;
  count: number;
}

const reactionQueue = {
  pending: new Map<string, QueuedReaction>(),
  maxed: new Set<string>(),
  timer: undefined as Timer | undefined,
  flushing: false,
  failures: 0,
};

function reactionKey(momentId: string, type: ReactionType) {
  return `${momentId}:${type}`;
}

function queueReaction(momentId: string, type: ReactionType, count: number) {
  const key = reactionKey(momentId, type);
  if (reactionQueue.maxed.has(key)) return false;
  const queued = reactionQueue.pending.get(key)?.count ?? 0;
  reactionQueue.pending.set(key, {
    momentId,
    type,
    count: Math.min(queued + count, MOMENT_REACT_MAX_PER_TYPE),
  });
  return true;
}

function markReactionMaxed(momentId: string, type: ReactionType) {
  const key = reactionKey(momentId, type);
  reactionQueue.maxed.add(key);
  reactionQueue.pending.delete(key);
}

function takeReaction(): QueuedReaction | null {
  const next = reactionQueue.pending.entries().next();
  if (next.done) return null;
  const [key, queued] = next.value;
  reactionQueue.pending.delete(key);
  const count = Math.min(queued.count, MOMENT_REACT_MAX_PER_REQUEST);
  if (queued.count > count) queueReaction(queued.momentId, queued.type, queued.count - count);
  return { ...queued, count };
}

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
  return Math.min(MOMENT_RETRY_BASE_MS * 2 ** failures, MOMENT_RETRY_MAX_MS);
}

function processingMoments(moments: readonly Moment[]): Moment[] {
  return moments.filter((moment) => moment.status === MOMENT_STATUS.processing);
}

function appendNewMoments(mine: readonly Moment[], created: readonly Moment[]): Moment[] {
  const known = new Set(mine.map((moment) => moment.id));
  return [...mine, ...created.filter((moment) => !known.has(moment.id))];
}

function prependNewMoments(history: readonly Moment[], created: readonly Moment[]): Moment[] {
  const known = new Set(history.map((moment) => moment.id));
  return [...created.filter((moment) => !known.has(moment.id)), ...history];
}

function patchMoments(list: readonly Moment[], fresh: readonly Moment[]): Moment[] {
  const byId = new Map(fresh.map((moment) => [moment.id, moment]));
  return list.map((moment) => byId.get(moment.id) ?? moment);
}

export const useMomentStore = create<MomentState>((set, get) => {
  function scheduleSeenFlush(delayMs: number) {
    clearTimeout(seenQueue.timer);
    seenQueue.timer = setTimeout(() => void get().flushSeen(), delayMs);
  }

  function scheduleReactionFlush(delayMs: number) {
    clearTimeout(reactionQueue.timer);
    reactionQueue.timer = setTimeout(() => void get().flushReactions(), delayMs);
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
        const page = await MomentService.tray();
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
        const page = await MomentService.tray(nextCursor);
        if (generation !== trayGeneration) return;
        trayPaging.failures = 0;
        set((state) => ({
          groups: appendMomentGroups(state.groups, page.groups),
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
      const processingBefore = processingMoments(get().mine);
      const { moments } = await MomentService.mine();
      if (!isCurrent() || version !== mineVersion) return [];
      const after = new Set(moments.map((moment) => moment.id));
      const nowMs = Date.now();
      const failed = new Set(
        processingBefore
          .filter((moment) => !after.has(moment.id) && isMomentActive(moment, nowMs))
          .map((moment) => moment.id)
      );
      mineVersion += 1;
      historyVersion += 1;
      set((state) => ({
        mine: moments,
        history: patchMoments(state.history, moments).filter((moment) => !failed.has(moment.id)),
        clockMs: nowMs,
      }));
      return processingBefore.map((moment) => moment.id).filter((id) => !after.has(id));
    },
    loadHistory: async () => {
      const isCurrent = sessionGuard();
      const generation = ++historyGeneration;
      set({ historyLoading: true });
      try {
        for (let attempt = 0; attempt <= HISTORY_STALE_RETRIES; attempt += 1) {
          const version = historyVersion;
          const page = await MomentService.history();
          if (!isCurrent() || generation !== historyGeneration) return;
          const stale = version !== historyVersion;
          if (stale && attempt < HISTORY_STALE_RETRIES) continue;
          set((state) => ({
            history: stale ? patchMoments(page.moments, state.history) : page.moments,
            historyNextOffset: page.nextOffset,
            historyLoaded: true,
            clockMs: Date.now(),
          }));
          return;
        }
      } finally {
        if (generation === historyGeneration) set({ historyLoading: false });
      }
    },
    loadMoreHistory: async () => {
      const { historyNextOffset, historyLoading } = get();
      if (historyNextOffset == null || historyLoading) return;
      const isCurrent = sessionGuard();
      const generation = historyGeneration;
      set({ historyLoading: true });
      try {
        const page = await MomentService.history(historyNextOffset);
        if (!isCurrent() || generation !== historyGeneration) return;
        set((state) => ({
          history: appendNewMoments(state.history, page.moments),
          historyNextOffset: page.nextOffset,
        }));
      } finally {
        if (generation === historyGeneration) set({ historyLoading: false });
      }
    },
    markSeen: (id) => {
      if (get().seenIds.has(id)) return;
      set((state) => ({ seenIds: new Set(state.seenIds).add(id) }));
      seenQueue.pending.add(id);
      if (seenQueue.pending.size >= MOMENT_SEEN_BATCH) void get().flushSeen();
      else if (seenQueue.failures === 0) scheduleSeenFlush(MOMENT_SEEN_FLUSH_MS);
    },
    flushSeen: async () => {
      clearTimeout(seenQueue.timer);
      if (seenQueue.flushing || seenQueue.pending.size === 0) return;
      seenQueue.flushing = true;
      const session = storeSession;
      try {
        while (seenQueue.pending.size > 0 && session === storeSession) {
          const batch = [...seenQueue.pending].slice(0, MOMENT_SEEN_BATCH);
          batch.forEach((id) => seenQueue.pending.delete(id));
          try {
            await MomentService.markSeen(batch);
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
    react: (momentId, type) => {
      if (!queueReaction(momentId, type, 1)) return;
      if (reactionQueue.failures === 0) scheduleReactionFlush(MOMENT_REACT_FLUSH_MS);
    },
    flushReactions: async () => {
      clearTimeout(reactionQueue.timer);
      if (reactionQueue.flushing || reactionQueue.pending.size === 0) return;
      reactionQueue.flushing = true;
      const session = storeSession;
      try {
        let next = takeReaction();
        while (next != null && session === storeSession) {
          try {
            const result = await MomentService.react(next.momentId, next.type, next.count);
            reactionQueue.failures = 0;
            if (result.count >= MOMENT_REACT_MAX_PER_TYPE) {
              markReactionMaxed(next.momentId, next.type);
            }
          } catch (error) {
            if (session !== storeSession) return;
            if (isRetryable(error)) {
              queueReaction(next.momentId, next.type, next.count);
              scheduleReactionFlush(retryDelayMs(reactionQueue.failures));
              reactionQueue.failures += 1;
              return;
            }
          }
          next = takeReaction();
        }
      } finally {
        if (session === storeSession) reactionQueue.flushing = false;
      }
    },
    publish: async (build) => {
      const isCurrent = sessionGuard();
      const request = await build();
      if (!isCurrent()) return false;
      const created = await MomentService.create(request);
      if (!isCurrent()) return false;
      mineVersion += 1;
      historyVersion += 1;
      set((state) => ({
        mine: appendNewMoments(state.mine, created.moments),
        history: state.historyLoaded ? prependNewMoments(state.history, created.moments) : state.history,
        clockMs: Date.now(),
      }));
      return true;
    },
    setHidden: async (id, hidden) => {
      const isCurrent = sessionGuard();
      const updated = await MomentService.setHidden(id, hidden);
      if (!isCurrent()) return;
      mineVersion += 1;
      historyVersion += 1;
      set((state) => ({
        mine: patchMoments(state.mine, [updated]),
        history: patchMoments(state.history, [updated]),
      }));
    },
    reset: () => {
      storeSession += 1;
      trayGeneration += 1;
      mineVersion += 1;
      historyGeneration += 1;
      stopPagingRetry();
      clearTimeout(seenQueue.timer);
      seenQueue.pending = new Set();
      seenQueue.flushing = false;
      seenQueue.failures = 0;
      clearTimeout(reactionQueue.timer);
      reactionQueue.pending = new Map();
      reactionQueue.maxed = new Set();
      reactionQueue.flushing = false;
      reactionQueue.failures = 0;
      set(initialState());
    },
  };
});

registerOnLogout(() => useMomentStore.getState().reset());
