import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import {
  DEFAULT_ROOM_FILTERS,
  ROOM_MAX_BLOCKED_USERS,
} from '../../constants/room';
import { sharedPersistStorage } from '../../platform/persistStorage';
import { RoomService } from '../../services/room.service';
import type { RoomFilters, RoomMember } from '../../types/api/room.type';
import type { RoomFilterState } from '../../types/client/room.type';
import { registerOnLogout, useAuthStore } from '../auth/authStore';

export { DEFAULT_ROOM_FILTERS } from '../../constants/room';

export class RoomBlockLimitError extends Error {
  constructor() {
    super('room block limit reached');
    this.name = 'RoomBlockLimitError';
  }
}

export function memberMatchesFilter(member: RoomMember, filters: RoomFilters): boolean {
  if (filters.showAll) return true;
  const anyGender = filters.female || filters.male || filters.flexible;
  if (!anyGender) return true;
  if (filters.female && member.gender === 'female') return true;
  if (filters.male && member.gender === 'male') return true;
  if (filters.flexible && member.gender !== 'female' && member.gender !== 'male') return true;
  return false;
}

interface BlockSession {
  userId: string;
  key: string;
  stillValid: () => boolean;
}

let generation = 0;
let queue: Promise<void> = Promise.resolve();
let queuedSync: { key: string; promise: Promise<void> } | null = null;

function currentUserId(): string | null {
  return useAuthStore.getState().user?.id ?? null;
}

function captureSession(): BlockSession | null {
  const userId = currentUserId();
  if (userId == null) return null;
  const startedAt = generation;
  return {
    userId,
    key: `${userId}:${startedAt}`,
    stillValid: () => generation === startedAt && currentUserId() === userId,
  };
}

function enqueue(task: (session: BlockSession) => Promise<void>): Promise<void> {
  const session = captureSession();
  if (session == null) return Promise.resolve();
  const run = queue.then(
    () => (session.stillValid() ? task(session) : undefined),
    () => (session.stillValid() ? task(session) : undefined)
  );
  queue = run.catch(() => undefined);
  return run;
}

function union(base: string[], extra: string[]): string[] {
  const seen = new Set(base);
  const merged = [...base];
  for (const id of extra) {
    if (!seen.has(id)) {
      seen.add(id);
      merged.push(id);
    }
  }
  return merged;
}

function withoutId(ids: string[], targetId: string): string[] {
  return ids.filter((id) => id !== targetId);
}

export const useRoomFilterStore = create<RoomFilterState>()(
  persist(
    (set, get) => {
      function pendingFor(userId: string): string[] {
        return get().pendingBlockUploads[userId] ?? [];
      }

      function localIdsToUpload(userId: string): string[] {
        const state = get();
        const pending = pendingFor(userId);
        if (state.migratedBlockOwnerIds.includes(userId)) return pending;
        const ownsCache = state.blockedOwnerId === userId || state.blockedOwnerId == null;
        return union(pending, ownsCache ? state.blockedUserIds : []);
      }

      function applyServerList(userId: string, serverIds: string[]): void {
        set({
          blockedUserIds: union(serverIds, localIdsToUpload(userId)),
          blockedOwnerId: userId,
        });
      }

      function setPending(userId: string, ids: string[]) {
        set((state) => {
          const next = { ...state.pendingBlockUploads };
          if (ids.length === 0) delete next[userId];
          else next[userId] = ids;
          return { pendingBlockUploads: next };
        });
      }

      async function runSync(session: BlockSession): Promise<void> {
        const { userId, stillValid } = session;
        const toUpload = localIdsToUpload(userId);

        let server: string[];
        try {
          server = (await RoomService.blockedUsers()).userIds;
        } catch {
          return;
        }
        if (!stillValid()) return;

        const failed: string[] = [];
        let known = new Set(server);
        for (const id of toUpload) {
          if (known.has(id)) continue;
          if (known.size >= ROOM_MAX_BLOCKED_USERS) {
            failed.push(id);
            continue;
          }
          try {
            server = (await RoomService.blockUser(id)).userIds;
            known = new Set(server);
          } catch {
            failed.push(id);
          }
          if (!stillValid()) return;
        }

        set((state) => ({
          blockedUserIds: union(server, failed),
          blockedOwnerId: userId,
          migratedBlockOwnerIds: state.migratedBlockOwnerIds.includes(userId)
            ? state.migratedBlockOwnerIds
            : [...state.migratedBlockOwnerIds, userId],
        }));
        setPending(userId, failed);
      }

      async function runBlock(session: BlockSession, targetId: string): Promise<void> {
        const { userId, stillValid } = session;
        const before = get().blockedUserIds;
        if (before.includes(targetId)) return;
        if (before.length >= ROOM_MAX_BLOCKED_USERS) throw new RoomBlockLimitError();
        set({ blockedUserIds: union(before, [targetId]), blockedOwnerId: userId });
        try {
          const result = await RoomService.blockUser(targetId);
          if (!stillValid()) return;
          applyServerList(userId, result.userIds);
        } catch (error) {
          if (!stillValid()) return;
          set((state) => ({ blockedUserIds: withoutId(state.blockedUserIds, targetId) }));
          throw error;
        }
      }

      async function runUnblock(session: BlockSession, targetId: string): Promise<void> {
        const { userId, stillValid } = session;
        const before = get().blockedUserIds;
        if (!before.includes(targetId)) return;
        set({ blockedUserIds: withoutId(before, targetId), blockedOwnerId: userId });
        setPending(userId, withoutId(pendingFor(userId), targetId));
        try {
          const result = await RoomService.unblockUser(targetId);
          if (!stillValid()) return;
          applyServerList(userId, withoutId(result.userIds, targetId));
        } catch (error) {
          if (!stillValid()) return;
          set((state) => ({ blockedUserIds: union(state.blockedUserIds, [targetId]) }));
          throw error;
        }
      }

      return {
        filters: DEFAULT_ROOM_FILTERS,
        blockedUserIds: [],
        blockedOwnerId: null,
        pendingBlockUploads: {},
        migratedBlockOwnerIds: [],
        setFilters: (filters) => set({ filters }),
        blockUser: (userId) => enqueue((session) => runBlock(session, userId)),
        unblockUser: (userId) => enqueue((session) => runUnblock(session, userId)),
        syncBlockedUsers: () => {
          const session = captureSession();
          if (session == null) return Promise.resolve();
          if (queuedSync?.key === session.key) return queuedSync.promise;
          const promise = enqueue(runSync).finally(() => {
            if (queuedSync?.key === session.key) queuedSync = null;
          });
          queuedSync = { key: session.key, promise };
          return promise;
        },
        resetBlockedUsers: () => {
          generation += 1;
          set({ blockedUserIds: [] });
        },
        isBlocked: (userId) => get().blockedUserIds.includes(userId),
      };
    },
    {
      name: 'ola.roomFilter',
      storage: sharedPersistStorage<RoomFilterState>(),
      partialize: (state) =>
        ({
          filters: state.filters,
          blockedUserIds: state.blockedUserIds,
          blockedOwnerId: state.blockedOwnerId,
          pendingBlockUploads: state.pendingBlockUploads,
          migratedBlockOwnerIds: state.migratedBlockOwnerIds,
        }) as RoomFilterState,
    }
  )
);

registerOnLogout(() => useRoomFilterStore.getState().resetBlockedUsers());
