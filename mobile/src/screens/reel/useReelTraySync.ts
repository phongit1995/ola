import { useCallback, useRef } from 'react';
import { AppState } from 'react-native';
import { useFocusEffect } from '@react-navigation/native';
import { useReelStore } from '@ola/shared/stores/reel/reelStore';
import {
  useReelTrayLifecycle,
  type ReelVisibilityListener,
} from '@ola/shared/stores/reel/useReelTrayLifecycle';

function ignore() {}

function subscribeAppState(listener: ReelVisibilityListener) {
  const subscription = AppState.addEventListener('change', (state) => {
    if (state === 'active') listener(true);
    else if (state === 'background') listener(false);
  });
  return () => subscription.remove();
}

export function useReelTraySync() {
  const load = useReelStore((s) => s.load);
  const tick = useReelStore((s) => s.tick);
  const focusedOnce = useRef(false);

  useReelTrayLifecycle(subscribeAppState);

  useFocusEffect(
    useCallback(() => {
      if (!focusedOnce.current) {
        focusedOnce.current = true;
        return;
      }
      tick();
      load().catch(ignore);
    }, [load, tick])
  );
}
