import { useCallback, useEffect, useMemo, useState } from 'react';
import { MEGAPHONE_HISTORY_PAGE_SIZE } from '../../constants/megaphone';
import { MegaphoneService } from '../../services/megaphone.service';
import type { Megaphone } from '../../types/api/megaphone.type';
import type { MegaphoneHistory } from '../../types/client/megaphone.type';
import { useRoomFilterStore } from '../room/roomFilterStore';
import { useMegaphoneStore } from './megaphoneStore';

export type { MegaphoneHistory } from '../../types/client/megaphone.type';

interface HistoryState {
  items: Megaphone[];
  cursor?: string;
  done: boolean;
  loading: boolean;
}

const EMPTY_HISTORY: HistoryState = { items: [], done: false, loading: false };

function useVisibleMegaphones(items: readonly Megaphone[]): Megaphone[] {
  const blockedUserIds = useRoomFilterStore((s) => s.blockedUserIds);
  return useMemo(() => {
    if (blockedUserIds.length === 0) return [...items];
    const blocked = new Set(blockedUserIds);
    return items.filter((item) => !blocked.has(item.sender.id));
  }, [items, blockedUserIds]);
}

export function useMegaphoneHistory(): MegaphoneHistory {
  const [state, setState] = useState<HistoryState>(EMPTY_HISTORY);
  const removedIds = useMegaphoneStore((s) => s.removedIds);
  const kept = useMemo(() => state.items.filter((item) => removedIds[item.id] == null), [state.items, removedIds]);
  const visible = useVisibleMegaphones(kept);

  const fetchPage = useCallback(async (cursor?: string) => {
    setState((prev) => ({ ...prev, loading: true }));
    try {
      const result = await MegaphoneService.history({ cursor, limit: MEGAPHONE_HISTORY_PAGE_SIZE });
      setState((prev) => ({
        items: cursor == null ? result.items : [...prev.items, ...result.items],
        cursor: result.nextCursor,
        done: result.nextCursor == null,
        loading: false,
      }));
    } catch {
      setState((prev) => ({ ...prev, done: true, loading: false }));
    }
  }, []);

  useEffect(() => {
    const timer = setTimeout(() => void fetchPage(), 0);
    return () => clearTimeout(timer);
  }, [fetchPage]);

  return {
    items: visible,
    done: state.done,
    loading: state.loading,
    loadMore: () => {
      if (!state.loading && !state.done) void fetchPage(state.cursor);
    },
    refresh: () => {
      if (!state.loading) void fetchPage();
    },
    prepend: (megaphone) => {
      setState((prev) => ({
        ...prev,
        items: [megaphone, ...prev.items.filter((item) => item.id !== megaphone.id)],
      }));
    },
  };
}
