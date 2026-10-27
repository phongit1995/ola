import { useEffect, useMemo, useState } from 'react';
import { MOMENT_VIEWER_PREFETCH_GROUPS } from '../../constants/moment';
import { activeMomentGroups } from '../../lib/moment';
import type { MomentTrayGroup } from '../../types/api/moment.type';
import { useMomentStore } from './momentStore';

function newTrayGroups(
  storeGroups: readonly MomentTrayGroup[],
  seenIds: ReadonlySet<string>,
  known: readonly MomentTrayGroup[]
): MomentTrayGroup[] {
  const knownAuthors = new Set(known.map((group) => group.author.id));
  return activeMomentGroups(storeGroups, Date.now(), seenIds).filter(
    (group) => !knownAuthors.has(group.author.id)
  );
}

export function useMomentViewerGroups(
  base: MomentTrayGroup[],
  groupIndex: number,
  extend: boolean
): MomentTrayGroup[] {
  const [appended, setAppended] = useState<MomentTrayGroup[]>([]);
  const loadMore = useMomentStore((s) => s.loadMore);
  const hasMore = useMomentStore((s) => s.nextCursor != null);
  const busy = useMomentStore((s) => s.loadingMore || s.refreshing);

  useEffect(() => {
    if (!extend) return;
    return useMomentStore.subscribe((state, previous) => {
      if (state.groups === previous.groups) return;
      setAppended((current) => {
        const fresh = newTrayGroups(state.groups, state.seenIds, [...base, ...current]);
        return fresh.length > 0 ? [...current, ...fresh] : current;
      });
    });
  }, [base, extend]);

  const groups = useMemo(
    () => (extend && appended.length > 0 ? [...base, ...appended] : base),
    [base, appended, extend]
  );

  useEffect(() => {
    if (!extend || !hasMore || busy) return;
    if (groupIndex < groups.length - MOMENT_VIEWER_PREFETCH_GROUPS) return;
    void loadMore();
  }, [extend, hasMore, busy, groupIndex, groups.length, loadMore]);

  return groups;
}
