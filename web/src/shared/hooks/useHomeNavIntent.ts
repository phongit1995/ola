import { useEffect, useRef } from 'react';
import { useHomeNavStore, type HomeNavIntent } from '@/store/homeNavStore';

export function useHomeNavIntent(intent: HomeNavIntent, run: () => void): void {
  const runRef = useRef(run);

  useEffect(() => {
    runRef.current = run;
  });

  useEffect(() => {
    const consume = () => {
      if (useHomeNavStore.getState().takeIntent(intent)) runRef.current();
    };
    const timer = window.setTimeout(consume, 0);
    const unsubscribe = useHomeNavStore.subscribe((state, prev) => {
      if (state.intent !== prev.intent) consume();
    });
    return () => {
      window.clearTimeout(timer);
      unsubscribe();
    };
  }, [intent]);
}
