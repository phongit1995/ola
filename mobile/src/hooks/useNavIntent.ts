import { useEffect, useRef } from 'react';
import { useNavIntentStore, type NavIntent } from '@store/navIntentStore';

export function useNavIntent(intent: NavIntent, run: () => void): void {
  const runRef = useRef(run);

  useEffect(() => {
    runRef.current = run;
  });

  useEffect(() => {
    const consume = () => {
      if (useNavIntentStore.getState().take(intent)) runRef.current();
    };
    const timer = setTimeout(consume, 0);
    const unsubscribe = useNavIntentStore.subscribe((state, prev) => {
      if (state.intent !== prev.intent) consume();
    });
    return () => {
      clearTimeout(timer);
      unsubscribe();
    };
  }, [intent]);
}
