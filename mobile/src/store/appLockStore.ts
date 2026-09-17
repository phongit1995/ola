import { create } from 'zustand';
import { persist } from 'zustand/middleware';
import { sharedPersistStorage } from '@ola/shared/platform';
import {
  createPinSalt,
  hashPin,
  lockoutDurationMs,
  pinMatches,
  type AutoLockSeconds,
} from '@lib/appLock';

interface AppLockSettings {
  enabled: boolean;
  pinHash: string;
  pinSalt: string;
  biometricEnabled: boolean;
  autoLockSeconds: AutoLockSeconds;
  failedAttempts: number;
  lockoutUntil: number;
}

interface AppLockState extends AppLockSettings {
  locked: boolean;
  covered: boolean;
  backgroundAt: number | null;
  setCovered: (covered: boolean) => void;
  markBackground: () => void;
  clearBackground: () => void;
  setPin: (pin: string) => void;
  disable: () => void;
  setBiometricEnabled: (value: boolean) => void;
  setAutoLockSeconds: (value: AutoLockSeconds) => void;
  lock: () => void;
  unlock: () => void;
  verifyPin: (pin: string) => boolean;
}

const DEFAULT_SETTINGS: AppLockSettings = {
  enabled: false,
  pinHash: '',
  pinSalt: '',
  biometricEnabled: false,
  autoLockSeconds: 0,
  failedAttempts: 0,
  lockoutUntil: 0,
};

export const useAppLockStore = create<AppLockState>()(
  persist(
    (set, get) => ({
      ...DEFAULT_SETTINGS,
      locked: false,
      covered: false,
      backgroundAt: null,
      setCovered: (covered) => {
        if (get().covered !== covered) set({ covered });
      },
      markBackground: () => {
        if (get().backgroundAt == null) set({ backgroundAt: Date.now() });
      },
      clearBackground: () => set({ backgroundAt: null }),
      setPin: (pin) => {
        const pinSalt = createPinSalt();
        set({
          enabled: true,
          pinSalt,
          pinHash: hashPin(pin, pinSalt),
          failedAttempts: 0,
          lockoutUntil: 0,
        });
      },
      disable: () => set({ ...DEFAULT_SETTINGS, locked: false, covered: false, backgroundAt: null }),
      setBiometricEnabled: (biometricEnabled) => set({ biometricEnabled }),
      setAutoLockSeconds: (autoLockSeconds) => set({ autoLockSeconds }),
      lock: () => {
        if (get().enabled) set({ locked: true, backgroundAt: null });
      },
      unlock: () =>
        set({ locked: false, backgroundAt: null, failedAttempts: 0, lockoutUntil: 0 }),
      verifyPin: (pin) => {
        const state = get();
        if (state.lockoutUntil > Date.now()) return false;
        if (pinMatches(pin, state.pinSalt, state.pinHash)) {
          set({ failedAttempts: 0, lockoutUntil: 0 });
          return true;
        }
        const failedAttempts = state.failedAttempts + 1;
        const lockoutMs = lockoutDurationMs(failedAttempts);
        set({
          failedAttempts,
          lockoutUntil: lockoutMs > 0 ? Date.now() + lockoutMs : 0,
        });
        return false;
      },
    }),
    {
      name: 'ola.app-lock',
      storage: sharedPersistStorage<AppLockSettings>(),
      partialize: (state) => ({
        enabled: state.enabled,
        pinHash: state.pinHash,
        pinSalt: state.pinSalt,
        biometricEnabled: state.biometricEnabled,
        autoLockSeconds: state.autoLockSeconds,
        failedAttempts: state.failedAttempts,
        lockoutUntil: state.lockoutUntil,
      }),
      merge: (persisted, current) => {
        const saved = (persisted ?? {}) as Partial<AppLockSettings>;
        return {
          ...current,
          ...saved,
          locked: saved.enabled === true,
          covered: false,
          backgroundAt: null,
        };
      },
    }
  )
);
