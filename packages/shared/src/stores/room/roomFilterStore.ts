import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import {
  DEFAULT_ROOM_FILTERS,
  ROOM_MAX_BLOCKED_USERS,
} from '../../constants/room';
import { sharedPersistStorage } from '../../platform/persistStorage';
import { RoomService } from '../../services/room.service';
import type {
  RoomBlockedUser,
  RoomBlockedUsersResult,
  RoomFilters,
  RoomMember,
} from '../../types/api/room.type';
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

interface QueuedSync {
  key: string;
  started: boolean;
  promise: Promise<boolean>;
}

type PendingUploadKey = 'pendingBlockUploads' | 'pendingMigrationUploads';

let generation = 0;
let queue: Promise<unknown> = Promise.resolve();
let queuedSync: QueuedSync | null = null;

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

function enqueue<T>(
  task: (session: BlockSession) => Promise<T>
): Promise<T | undefined> {
  const session = captureSession();
  if (session == null) return Promise.resolve(undefined);
  const run = queue.then(
    () => (session.stillValid() ? task(session) : undefined),
    () => (session.stillValid() ? task(session) : undefined)
  );
  queue = run.catch(() => undefined);
  return run;
}

function detailsFrom(result: RoomBlockedUsersResult): Record<string, RoomBlockedUser> {
  return Object.fromEntries((result.users ?? []).map((user) => [user.userId, user]));
}

function mergeDetails(
  existing: Record<string, RoomBlockedUser>,
  server: Record<string, RoomBlockedUser>,
  ids: string[]
): Record<string, RoomBlockedUser> {
  const merged: Record<string, RoomBlockedUser> = {};
  for (const id of ids) {
    const detail = server[id] ?? existing[id];
    if (detail != null) merged[id] = detail;
  }
  return merged;
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
      function pendingFor(userId: string, key: PendingUploadKey = 'pendingBlockUploads'): string[] {
        return get()[key][userId] ?? [];
      }

      function legacyIdsFor(userId: string): string[] {
        const state = get();
        const pending = pendingFor(userId, 'pendingMigrationUploads');
        if (state.migratedBlockOwnerIds.includes(userId)) return pending;
        const ownsCache = state.blockedOwnerId === userId || state.blockedOwnerId == null;
        return union(pending, ownsCache ? state.blockedUserIds : []);
      }

      function localIdsToUpload(userId: string): string[] {
        return union(pendingFor(userId), legacyIdsFor(userId));
      }

      function applyServerList(userId: string, result: RoomBlockedUsersResult): void {
        const ids = union(result.userIds, localIdsToUpload(userId));
        set((state) => ({
          blockedUserIds: ids,
          blockedUsers: mergeDetails(state.blockedUsers, detailsFrom(result), ids),
          blockedOwnerId: userId,
        }));
      }

      function setPending(userId: string, ids: string[], key: PendingUploadKey = 'pendingBlockUploads') {
        set((state) => {
          const next = { ...state[key] };
          if (ids.length === 0) delete next[userId];
          else next[userId] = ids;
          return { [key]: next };
        });
      }

      async function runSync(session: BlockSession): Promise<boolean> {
        const { userId, stillValid } = session;
        const pending = pendingFor(userId);
        const legacy = legacyIdsFor(userId).filter((id) => !pending.includes(id));

        let server: RoomBlockedUsersResult;
        try {
          server = await RoomService.blockedUsers();
        } catch {
          return false;
        }
        if (!stillValid()) return false;

        let known = new Set(server.userIds);
        async function upload(ids: string[], migration: boolean): Promise<string[] | null> {
          const failed: string[] = [];
          for (const id of ids) {
            if (known.has(id)) continue;
            if (known.size >= ROOM_MAX_BLOCKED_USERS) {
              failed.push(id);
              continue;
            }
            try {
              server = await RoomService.blockUser(id, migration);
              known = new Set(server.userIds);
            } catch {
              failed.push(id);
            }
            if (!stillValid()) return null;
          }
          return failed;
        }

        const failed = await upload(pending, false);
        if (failed == null) return false;
        const failedLegacy = await upload(legacy, true);
        if (failedLegacy == null) return false;

        const ids = union(server.userIds, union(failed, failedLegacy));
        set((state) => ({
          blockedUserIds: ids,
          blockedUsers: mergeDetails(state.blockedUsers, detailsFrom(server), ids),
          blockedOwnerId: userId,
          migratedBlockOwnerIds: state.migratedBlockOwnerIds.includes(userId)
            ? state.migratedBlockOwnerIds
            : [...state.migratedBlockOwnerIds, userId],
        }));
        setPending(userId, failed);
        setPending(userId, failedLegacy, 'pendingMigrationUploads');
        return true;
      }

      function setDetail(targetId: string, detail: RoomBlockedUser | undefined) {
        set((state) => {
          const next = { ...state.blockedUsers };
          if (detail == null) delete next[targetId];
          else next[targetId] = detail;
          return { blockedUsers: next };
        });
      }

      async function runBlock(
        session: BlockSession,
        targetId: string,
        detail: RoomBlockedUser | undefined
      ): Promise<void> {
        const { userId, stillValid } = session;
        const before = get().blockedUserIds;
        if (before.includes(targetId)) return;
        if (before.length >= ROOM_MAX_BLOCKED_USERS) throw new RoomBlockLimitError();
        set({ blockedUserIds: union(before, [targetId]), blockedOwnerId: userId });
        if (detail != null) setDetail(targetId, detail);
        try {
          const result = await RoomService.blockUser(targetId);
          if (!stillValid()) return;
          applyServerList(userId, result);
        } catch (error) {
          if (!stillValid()) return;
          set((state) => ({ blockedUserIds: withoutId(state.blockedUserIds, targetId) }));
          setDetail(targetId, undefined);
          throw error;
        }
      }

      async function runUnblock(session: BlockSession, targetId: string): Promise<void> {
        const { userId, stillValid } = session;
        const before = get().blockedUserIds;
        if (!before.includes(targetId)) return;
        const beforeDetail = get().blockedUsers[targetId];
        set({ blockedUserIds: withoutId(before, targetId), blockedOwnerId: userId });
        setDetail(targetId, undefined);
        setPending(userId, withoutId(pendingFor(userId), targetId));
        setPending(
          userId,
          withoutId(pendingFor(userId, 'pendingMigrationUploads'), targetId),
          'pendingMigrationUploads'
        );
        try {
          const result = await RoomService.unblockUser(targetId);
          if (!stillValid()) return;
          applyServerList(userId, {
            userIds: withoutId(result.userIds, targetId),
            users: (result.users ?? []).filter((user) => user.userId !== targetId),
          });
        } catch (error) {
          if (!stillValid()) return;
          set((state) => ({ blockedUserIds: union(state.blockedUserIds, [targetId]) }));
          setDetail(targetId, beforeDetail);
          throw error;
        }
      }

      return {
        filters: DEFAULT_ROOM_FILTERS,
        blockedUserIds: [],
        blockedUsers: {},
        blockedOwnerId: null,
        pendingBlockUploads: {},
        pendingMigrationUploads: {},
        migratedBlockOwnerIds: [],
        setFilters: (filters) => set({ filters }),
        blockUser: (userId, detail) =>
          enqueue((session) => runBlock(session, userId, detail)).then(() => undefined),
        unblockUser: (userId) =>
          enqueue((session) => runUnblock(session, userId)).then(() => undefined),
        syncBlockedUsers: () => {
          const session = captureSession();
          if (session == null) return Promise.resolve(false);
          if (queuedSync?.key === session.key && !queuedSync.started) return queuedSync.promise;
          const entry: QueuedSync = { key: session.key, started: false, promise: Promise.resolve(false) };
          entry.promise = enqueue((s) => {
            entry.started = true;
            return runSync(s);
          })
            .then((synced) => synced === true)
            .finally(() => {
              if (queuedSync === entry) queuedSync = null;
            });
          queuedSync = entry;
          return entry.promise;
        },
        resetBlockedUsers: () => {
          generation += 1;
          set({ blockedUserIds: [], blockedUsers: {} });
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
          blockedUsers: state.blockedUsers,
          blockedOwnerId: state.blockedOwnerId,
          pendingBlockUploads: state.pendingBlockUploads,
          pendingMigrationUploads: state.pendingMigrationUploads,
          migratedBlockOwnerIds: state.migratedBlockOwnerIds,
        }) as RoomFilterState,
    }
  )
);

registerOnLogout(() => useRoomFilterStore.getState().resetBlockedUsers());
