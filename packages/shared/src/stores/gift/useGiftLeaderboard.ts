import { useEffect, useState } from 'react';
import {
  GIFT_LEADERBOARD_LIMIT,
  GIFT_LEADERBOARD_PERIOD,
  GIFT_LEADERBOARD_TYPE,
} from '../../constants/gift';
import { GiftService } from '../../services/gift.service';
import type {
  GiftLeaderboardPeriod,
  GiftLeaderboardResult,
  GiftLeaderboardType,
} from '../../types/api/gift.type';
import type { GiftLeaderboard } from '../../types/client/gift.type';

export type { GiftLeaderboard } from '../../types/client/gift.type';

function boardKey(type: GiftLeaderboardType, period: GiftLeaderboardPeriod): string {
  return `${type}:${period}`;
}

export function useGiftLeaderboard(): GiftLeaderboard {
  const [type, setType] = useState<GiftLeaderboardType>(GIFT_LEADERBOARD_TYPE.receiver);
  const [period, setPeriod] = useState<GiftLeaderboardPeriod>(GIFT_LEADERBOARD_PERIOD.week);
  const [boards, setBoards] = useState<Record<string, GiftLeaderboardResult>>({});
  const [failedKey, setFailedKey] = useState<string | null>(null);
  const key = boardKey(type, period);

  useEffect(() => {
    if (boards[key] != null || failedKey === key) return;
    let cancelled = false;
    GiftService.leaderboard({ type, period, limit: GIFT_LEADERBOARD_LIMIT })
      .then((result) => {
        if (!cancelled) setBoards((prev) => ({ ...prev, [key]: result }));
      })
      .catch(() => {
        if (!cancelled) setFailedKey(key);
      });
    return () => {
      cancelled = true;
    };
  }, [boards, failedKey, key, type, period]);

  return {
    type,
    period,
    selectType: (value) => {
      setFailedKey(null);
      setType(value);
    },
    selectPeriod: (value) => {
      setFailedKey(null);
      setPeriod(value);
    },
    board: boards[key],
    failed: failedKey === key,
  };
}
