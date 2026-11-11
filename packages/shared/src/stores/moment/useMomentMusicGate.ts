import { useCallback, useEffect, useState } from 'react';
import { MOMENT_MUSIC_WAIT_MS } from '../../constants/moment';

type MomentMusicGateStatus = 'loading' | 'playing' | 'failed';

export function useMomentMusicGate(key: string | null, active: boolean) {
  const [state, setState] = useState<{ key: string | null; status: MomentMusicGateStatus }>({
    key,
    status: 'loading',
  });
  const status = state.key === key ? state.status : 'loading';

  const update = useCallback(
    (next: MomentMusicGateStatus) => {
      setState((current) => {
        const previous = current.key === key ? current.status : 'loading';
        if (previous === 'failed' || (current.key === key && previous === next)) return current;
        return { key, status: next };
      });
    },
    [key]
  );
  const markPlaying = useCallback(() => update('playing'), [update]);
  const markBuffering = useCallback(() => update('loading'), [update]);
  const markFailed = useCallback(() => update('failed'), [update]);

  useEffect(() => {
    if (key == null || !active || status !== 'loading') return;
    const timer = setTimeout(markFailed, MOMENT_MUSIC_WAIT_MS);
    return () => clearTimeout(timer);
  }, [key, active, status, markFailed]);

  return { waiting: key != null && status === 'loading', markPlaying, markBuffering, markFailed };
}
