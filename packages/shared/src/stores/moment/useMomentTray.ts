import { useMemo } from 'react';
import { visibleMomentTray } from '../../lib/moment';
import { useMomentStore } from './momentStore';

export function useMomentTray() {
  const mine = useMomentStore((s) => s.mine);
  const groups = useMomentStore((s) => s.groups);
  const seenIds = useMomentStore((s) => s.seenIds);
  const clockMs = useMomentStore((s) => s.clockMs);
  return useMemo(
    () => ({ ...visibleMomentTray({ mine, groups }, clockMs), seenIds }),
    [mine, groups, seenIds, clockMs]
  );
}
