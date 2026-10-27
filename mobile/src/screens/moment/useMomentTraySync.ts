import { useCallback, useRef } from 'react';
import { AppState } from 'react-native';
import { useFocusEffect } from '@react-navigation/native';
import { useMomentStore } from '@ola/shared/stores/moment/momentStore';
import {
  useMomentTrayLifecycle,
  type MomentVisibilityListener,
} from '@ola/shared/stores/moment/useMomentTrayLifecycle';

function ignore() {}

function subscribeAppState(listener: MomentVisibilityListener) {
  const subscription = AppState.addEventListener('change', (state) => {
    if (state === 'active') listener(true);
    else if (state === 'background') listener(false);
  });
  return () => subscription.remove();
}

export function useMomentTraySync(enabled: boolean) {
  const load = useMomentStore((s) => s.load);
  const tick = useMomentStore((s) => s.tick);
  const focusedOnce = useRef(false);

  useMomentTrayLifecycle(subscribeAppState, enabled);

  useFocusEffect(
    useCallback(() => {
      if (!enabled) return;
      if (!focusedOnce.current) {
        focusedOnce.current = true;
        return;
      }
      tick();
      load().catch(ignore);
    }, [enabled, load, tick])
  );
}
