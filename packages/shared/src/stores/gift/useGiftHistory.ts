import { useCallback, useEffect, useState } from 'react';
import { GIFT_HISTORY_DIRECTION, GIFT_HISTORY_PAGE_SIZE } from '../../constants/gift';
import { GiftService } from '../../services/gift.service';
import type { GiftHistoryDirection, GiftHistoryItem } from '../../types/api/gift.type';
import type { GiftHistory } from '../../types/client/gift.type';

export type { GiftHistory } from '../../types/client/gift.type';

interface HistoryPageState {
  items: GiftHistoryItem[];
  cursor?: string;
  done: boolean;
  loading: boolean;
}

const EMPTY_HISTORY: HistoryPageState = { items: [], done: false, loading: false };

function fetchHistory(direction: GiftHistoryDirection, cursor?: string) {
  const params = { cursor, limit: GIFT_HISTORY_PAGE_SIZE };
  return direction === GIFT_HISTORY_DIRECTION.received
    ? GiftService.received(params)
    : GiftService.sent(params);
}

export function useGiftHistory(): GiftHistory {
  const [direction, setDirection] = useState<GiftHistoryDirection>(GIFT_HISTORY_DIRECTION.received);
  const [histories, setHistories] = useState<Record<GiftHistoryDirection, HistoryPageState>>({
    received: EMPTY_HISTORY,
    sent: EMPTY_HISTORY,
  });
  const current = histories[direction];

  const fetchPage = useCallback(async (target: GiftHistoryDirection, cursor?: string) => {
    setHistories((prev) => ({ ...prev, [target]: { ...prev[target], loading: true } }));
    try {
      const result = await fetchHistory(target, cursor);
      setHistories((prev) => ({
        ...prev,
        [target]: {
          items: cursor == null ? result.items : [...prev[target].items, ...result.items],
          cursor: result.nextCursor,
          done: result.nextCursor == null,
          loading: false,
        },
      }));
    } catch {
      setHistories((prev) => ({ ...prev, [target]: { ...prev[target], done: true, loading: false } }));
    }
  }, []);

  useEffect(() => {
    if (current.items.length > 0 || current.done || current.loading) return;
    const timer = setTimeout(() => void fetchPage(direction), 0);
    return () => clearTimeout(timer);
  }, [current.items.length, current.done, current.loading, direction, fetchPage]);

  return {
    direction,
    selectDirection: setDirection,
    items: current.items,
    done: current.done,
    loading: current.loading,
    loadMore: () => {
      if (!current.loading && !current.done) void fetchPage(direction, current.cursor);
    },
  };
}
