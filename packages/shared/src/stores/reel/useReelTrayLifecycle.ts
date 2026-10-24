import { useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import { REEL_CLOCK_TICK_MS, REEL_PROCESSING_POLL_MS, REEL_STATUS } from '../../constants/reel';
import { toast } from '../../lib/toast';
import { useReelStore } from './reelStore';

export type ReelVisibilityListener = (visible: boolean) => void;

export type SubscribeReelVisibility = (listener: ReelVisibilityListener) => () => void;

function ignore() {}

export function useReelTrayLifecycle(subscribeVisibility: SubscribeReelVisibility) {
  const { t } = useTranslation();
  const load = useReelStore((s) => s.load);
  const tick = useReelStore((s) => s.tick);
  const flushSeen = useReelStore((s) => s.flushSeen);
  const refreshMine = useReelStore((s) => s.refreshMine);
  const hasProcessing = useReelStore((s) =>
    s.mine.some((reel) => reel.status === REEL_STATUS.processing)
  );

  useEffect(() => {
    load().catch(ignore);
    const clock = setInterval(tick, REEL_CLOCK_TICK_MS);
    const unsubscribe = subscribeVisibility((visible) => {
      if (!visible) {
        void flushSeen();
        return;
      }
      tick();
      load().catch(ignore);
    });
    return () => {
      clearInterval(clock);
      unsubscribe();
      void flushSeen();
    };
  }, [subscribeVisibility, load, tick, flushSeen]);

  useEffect(() => {
    if (!hasProcessing) return;
    const poll = setInterval(() => {
      refreshMine()
        .then((failed) => {
          if (failed.length > 0) toast.error(t('reel.processingFailed'));
        })
        .catch(ignore);
    }, REEL_PROCESSING_POLL_MS);
    return () => clearInterval(poll);
  }, [hasProcessing, refreshMine, t]);
}
