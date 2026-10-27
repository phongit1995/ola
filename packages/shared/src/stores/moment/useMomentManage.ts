import { useEffect } from 'react';
import { MOMENT_CLOCK_TICK_MS } from '../../constants/moment';
import { useMomentStore } from './momentStore';
import { useMomentHiddenToggle } from './useMomentHiddenToggle';

function ignore() {}

export function useMomentManage() {
  const moments = useMomentStore((s) => s.history);
  const loaded = useMomentStore((s) => s.historyLoaded);
  const loading = useMomentStore((s) => s.historyLoading);
  const hasMore = useMomentStore((s) => s.historyNextOffset != null);
  const clockMs = useMomentStore((s) => s.clockMs);
  const tick = useMomentStore((s) => s.tick);
  const loadHistory = useMomentStore((s) => s.loadHistory);
  const loadMoreHistory = useMomentStore((s) => s.loadMoreHistory);
  const { busyId, toggleHidden } = useMomentHiddenToggle();

  useEffect(() => {
    tick();
    loadHistory().catch(ignore);
    const clock = setInterval(tick, MOMENT_CLOCK_TICK_MS);
    return () => clearInterval(clock);
  }, [tick, loadHistory]);

  function loadMore() {
    loadMoreHistory().catch(ignore);
  }

  return { moments, loaded, loading, hasMore, loadMore, clockMs, busyId, toggleHidden };
}
