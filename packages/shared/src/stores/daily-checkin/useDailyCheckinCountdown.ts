import { useEffect, useRef, useState } from 'react';
import { DAILY_CHECKIN_RELOAD_RETRY_MS, DAILY_CHECKIN_TICK_MS } from '../../constants/dailyCheckin';
import { dailyCheckinRemainingMs } from '../../lib/dailyCheckin';
import type { DailyCheckinStatus } from '../../types/api/dailyCheckin.type';
import { useDailyCheckinStore } from './dailyCheckinStore';

export function useDailyCheckinCountdown(status: DailyCheckinStatus | null): number {
  const [nowMs, setNowMs] = useState(() => Date.now());
  const lastReloadAt = useRef(0);

  useEffect(() => {
    if (status == null || !status.enabled) return;
    const endsAt = Date.parse(status.endsAt);
    const timer = setInterval(() => {
      const now = Date.now();
      setNowMs(now);
      if (now >= endsAt && now - lastReloadAt.current >= DAILY_CHECKIN_RELOAD_RETRY_MS) {
        lastReloadAt.current = now;
        void useDailyCheckinStore.getState().load({ force: true });
      }
    }, DAILY_CHECKIN_TICK_MS);
    return () => clearInterval(timer);
  }, [status]);

  return status == null ? 0 : dailyCheckinRemainingMs(status, nowMs);
}
