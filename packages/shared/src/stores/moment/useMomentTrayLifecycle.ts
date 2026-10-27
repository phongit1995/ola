import { useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import { MOMENT_CLOCK_TICK_MS, MOMENT_PROCESSING_POLL_MS, MOMENT_STATUS } from '../../constants/moment';
import { toast } from '../../lib/toast';
import { useMomentStore } from './momentStore';

export type MomentVisibilityListener = (visible: boolean) => void;

export type SubscribeMomentVisibility = (listener: MomentVisibilityListener) => () => void;

function ignore() {}

export function useMomentTrayLifecycle(
  subscribeVisibility: SubscribeMomentVisibility,
  enabled: boolean
) {
  const { t } = useTranslation();
  const load = useMomentStore((s) => s.load);
  const tick = useMomentStore((s) => s.tick);
  const flushSeen = useMomentStore((s) => s.flushSeen);
  const flushReactions = useMomentStore((s) => s.flushReactions);
  const refreshMine = useMomentStore((s) => s.refreshMine);
  const hasProcessing = useMomentStore((s) =>
    s.mine.some((moment) => moment.status === MOMENT_STATUS.processing)
  );

  useEffect(() => {
    if (!enabled) return;
    load().catch(ignore);
    const clock = setInterval(tick, MOMENT_CLOCK_TICK_MS);
    const unsubscribe = subscribeVisibility((visible) => {
      if (!visible) {
        void flushSeen();
        void flushReactions();
        return;
      }
      tick();
      load().catch(ignore);
    });
    return () => {
      clearInterval(clock);
      unsubscribe();
      void flushSeen();
      void flushReactions();
    };
  }, [enabled, subscribeVisibility, load, tick, flushSeen, flushReactions]);

  useEffect(() => {
    if (!enabled || !hasProcessing) return;
    const poll = setInterval(() => {
      refreshMine()
        .then((failed) => {
          if (failed.length > 0) toast.error(t('moment.processingFailed'));
        })
        .catch(ignore);
    }, MOMENT_PROCESSING_POLL_MS);
    return () => clearInterval(poll);
  }, [enabled, hasProcessing, refreshMine, t]);
}
