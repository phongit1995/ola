import { create } from 'zustand';
import { STORE_CHECK, checkStoreForUpdate, fetchUpdateRequired } from '@lib/appUpdate';

const RECHECK_INTERVAL_MS = 10 * 60 * 1000;

let lastCheckAt = 0;
let inflight: Promise<void> | null = null;

interface AppUpdateState {
  required: boolean;
  check: () => Promise<void>;
}

async function runCheck(set: (partial: Partial<AppUpdateState>) => void): Promise<void> {
  if ((await checkStoreForUpdate()) === STORE_CHECK.latest) {
    set({ required: false });
    return;
  }
  const required = await fetchUpdateRequired();
  if (required == null) {
    lastCheckAt = 0;
    return;
  }
  set({ required });
}

export const useAppUpdateStore = create<AppUpdateState>((set) => ({
  required: false,

  check: () => {
    if (inflight != null) return inflight;
    if (Date.now() - lastCheckAt < RECHECK_INTERVAL_MS) return Promise.resolve();
    lastCheckAt = Date.now();
    inflight = runCheck(set).finally(() => {
      inflight = null;
    });
    return inflight;
  },
}));
