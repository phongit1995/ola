import { useCallback, useRef } from 'react';
import { Platform } from 'react-native';

export function useAfterDismiss() {
  const pendingRef = useRef<(() => void) | null>(null);

  const runPending = useCallback(() => {
    const pending = pendingRef.current;
    pendingRef.current = null;
    pending?.();
  }, []);

  const schedule = useCallback((action: () => void) => {
    pendingRef.current = action;
  }, []);

  const cancel = useCallback(() => {
    pendingRef.current = null;
  }, []);

  const runAfterClose = useCallback(() => {
    if (Platform.OS !== 'ios') requestAnimationFrame(runPending);
  }, [runPending]);

  return { schedule, cancel, runAfterClose, onDismiss: runPending };
}
