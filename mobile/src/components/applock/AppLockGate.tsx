import { useEffect } from 'react';
import { AppState, Keyboard } from 'react-native';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { shouldLockAfterBackground } from '@lib/appLock';
import { isBiometricPromptActive } from '@lib/biometrics';
import { useAppLockStore } from '@store/appLockStore';
import { AppLockOverlay } from './AppLockOverlay';

export function AppLockGate() {
  const signedIn = useAuthStore((s) => s.user != null);
  const enabled = useAppLockStore((s) => s.enabled);

  useEffect(() => {
    const subscription = AppState.addEventListener('change', (state) => {
      const store = useAppLockStore.getState();
      if (state === 'active') {
        if (
          store.enabled &&
          !store.locked &&
          shouldLockAfterBackground(store.backgroundAt, Date.now(), store.autoLockSeconds)
        ) {
          Keyboard.dismiss();
          store.lock();
        }
        store.clearBackground();
        store.setCovered(false);
        return;
      }
      if (state === 'background') {
        store.markBackground();
        if (store.enabled) {
          Keyboard.dismiss();
          store.setCovered(true);
        }
        return;
      }
      if (store.enabled && !isBiometricPromptActive()) store.setCovered(true);
    });
    return () => subscription.remove();
  }, []);

  if (!signedIn || !enabled) return null;
  return <AppLockOverlay />;
}
