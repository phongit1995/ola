import { useState } from 'react';
import { dailyCheckinFabKind } from '../../lib/dailyCheckin';
import type { DailyCheckinFabKind } from '../../types/client/dailyCheckin.type';
import { hideDailyCheckinFabToday, isDailyCheckinFabHidden, useDailyCheckinStore } from './dailyCheckinStore';

export interface DailyCheckinFabState {
  kind: DailyCheckinFabKind | null;
  open: () => void;
  hide: () => void;
}

export function useDailyCheckinFab(): DailyCheckinFabState {
  const status = useDailyCheckinStore((s) => s.status);
  const [hiddenFor, setHiddenFor] = useState<string | null>(null);
  const kind = dailyCheckinFabKind(status);
  const hidden = status != null && (hiddenFor === status.endsAt || isDailyCheckinFabHidden(status));

  return {
    kind: hidden ? null : kind,
    open: () => useDailyCheckinStore.getState().requestPopup(),
    hide: () => {
      if (status == null) return;
      hideDailyCheckinFabToday(status);
      setHiddenFor(status.endsAt);
    },
  };
}
