import { useMemo } from 'react';
import { activeReelGroups, visibleReelTray } from '../../lib/reel';
import { useReelStore } from './reelStore';

export function useReelTray() {
  const mine = useReelStore((s) => s.mine);
  const groups = useReelStore((s) => s.groups);
  const seenIds = useReelStore((s) => s.seenIds);
  const clockMs = useReelStore((s) => s.clockMs);
  return useMemo(
    () => visibleReelTray({ mine, groups }, seenIds, clockMs),
    [mine, groups, seenIds, clockMs]
  );
}

export function useReelAuthorCount() {
  return useReelStore((s) => activeReelGroups(s.groups, s.clockMs, s.seenIds).length);
}
