import { create } from 'zustand';
import i18n from 'i18next';
import {
  DAILY_CHECKIN_ERROR,
  DAILY_CHECKIN_FRESH_MS,
  DAILY_CHECKIN_POPUP_STORAGE_KEY,
  DAILY_CHECKIN_REWARD_TYPE,
} from '../../constants/dailyCheckin';
import { toApiError } from '../../lib/apiError';
import { dailyCheckinErrorText, dailyCheckinNeedsAttention } from '../../lib/dailyCheckin';
import { randomUuid } from '../../lib/randomUuid';
import { toast } from '../../lib/toast';
import { getKeyValueStorage } from '../../platform/keyValueStorage';
import { DailyCheckinService } from '../../services/dailyCheckin.service';
import type { DailyCheckinActionResult, DailyCheckinStatus } from '../../types/api/dailyCheckin.type';
import type { DailyCheckinState } from '../../types/client/dailyCheckin.type';
import { loadAppConfig } from '../appConfigStore';
import { registerOnLogout, useAuthStore } from '../auth/authStore';
import { useMegaphoneTicketStore } from '../megaphone/megaphoneTicketStore';

const initialState = {
  status: null,
  loadedAt: 0,
  loading: false,
  acting: false,
  opened: null,
  notice: null,
};

let inflight: Promise<void> | null = null;
let pendingRequestId: string | null = null;
let generation = 0;
let mutations = 0;

function isFresh(status: DailyCheckinStatus | null, loadedAt: number, nowMs: number): boolean {
  if (status == null || nowMs - loadedAt >= DAILY_CHECKIN_FRESH_MS) return false;
  return !status.enabled || nowMs < Date.parse(status.endsAt);
}

function afterRewards(result: DailyCheckinActionResult) {
  const items = result.items ?? [];
  if (items.length === 0) return;
  void useAuthStore.getState().refreshUser();
  const tickets = useMegaphoneTicketStore.getState();
  if (tickets.loaded && items.some((item) => item.type === DAILY_CHECKIN_REWARD_TYPE.megaphoneTicket)) {
    void tickets.load();
  }
}

export const useDailyCheckinStore = create<DailyCheckinState>((set, get) => {
  function apply(result: DailyCheckinActionResult) {
    mutations += 1;
    const items = result.items ?? [];
    const slot = result.status.slots[(result.slot ?? result.status.slot) - 1];
    set({
      status: result.status,
      loadedAt: Date.now(),
      opened: items.length > 0 && slot != null ? { slot: slot.slot, box: slot.box, items } : get().opened,
    });
    afterRewards(result);
  }

  function refreshAfterReject(code: string | undefined) {
    if (
      code === DAILY_CHECKIN_ERROR.disabled ||
      code === DAILY_CHECKIN_ERROR.completed ||
      code === DAILY_CHECKIN_ERROR.emailNotVerified ||
      code === DAILY_CHECKIN_ERROR.taskNotDone ||
      code === DAILY_CHECKIN_ERROR.nothingToOpen
    ) {
      void get().load({ force: true });
    }
  }

  return {
    ...initialState,

    load: (options) => {
      if (inflight != null) return inflight;
      const { status, loadedAt } = get();
      if (!options?.force && isFresh(status, loadedAt, Date.now())) return Promise.resolve();
      set({ loading: true });
      const gen = generation;
      const seenMutations = mutations;
      inflight = (async () => {
        try {
          const config = await loadAppConfig('dailyCheckin');
          if (gen !== generation) return;
          if (config != null && !config.enabled) {
            set({ status: null, loadedAt: Date.now() });
            return;
          }
          const next = await DailyCheckinService.status();
          if (gen !== generation) return;
          if (seenMutations !== mutations || get().acting) return;
          pendingRequestId = null;
          set({ status: next, loadedAt: Date.now() });
        } catch {
          if (gen === generation) set({ loadedAt: Date.now() });
        } finally {
          if (gen === generation) {
            set({ loading: false });
            inflight = null;
          }
        }
      })();
      return inflight;
    },

    checkIn: async () => {
      if (get().acting) return 'failed';
      const requestId = pendingRequestId ?? randomUuid();
      pendingRequestId = requestId;
      const gen = generation;
      set({ acting: true });
      try {
        const result = await DailyCheckinService.checkIn(requestId);
        if (gen !== generation) return 'failed';
        apply(result);
        pendingRequestId = null;
        return 'done';
      } catch (err) {
        if (gen !== generation) return 'failed';
        const apiError = toApiError(err);
        if (apiError.status !== 0) pendingRequestId = null;
        refreshAfterReject(apiError.code);
        if (apiError.code === DAILY_CHECKIN_ERROR.emailNotVerified) {
          set({ notice: 'needsEmail' });
          return 'needsEmail';
        }
        toast.error(dailyCheckinErrorText(i18n.t, err));
        return 'failed';
      } finally {
        set({ acting: false });
      }
    },

    open: async () => {
      if (get().acting) return 'failed';
      const gen = generation;
      set({ acting: true });
      try {
        const result = await DailyCheckinService.open();
        if (gen !== generation) return 'failed';
        apply(result);
        return 'done';
      } catch (err) {
        if (gen !== generation) return 'failed';
        const apiError = toApiError(err);
        if (apiError.code === DAILY_CHECKIN_ERROR.vipRequired) {
          set({ notice: 'vipRequired' });
          return 'vipRequired';
        }
        refreshAfterReject(apiError.code);
        toast.error(dailyCheckinErrorText(i18n.t, err));
        return 'failed';
      } finally {
        set({ acting: false });
      }
    },

    dismissOpened: () => set({ opened: null }),

    dismissNotice: () => set({ notice: null }),

    reset: () => {
      generation += 1;
      inflight = null;
      pendingRequestId = null;
      set({ ...initialState });
    },
  };
});

export function selectDailyCheckinVisible(state: DailyCheckinState): boolean {
  return state.status?.enabled === true;
}

export function selectDailyCheckinAttention(state: DailyCheckinState): boolean {
  return dailyCheckinNeedsAttention(state.status);
}

function popupStorageKey(): string | null {
  const userId = useAuthStore.getState().user?.id;
  return userId != null ? `${DAILY_CHECKIN_POPUP_STORAGE_KEY}.${userId}` : null;
}

export function shouldShowDailyCheckinPopup(status: DailyCheckinStatus | null): boolean {
  if (status == null || !status.enabled || !status.popup) return false;
  if (status.checkedInToday || status.completed) return false;
  const key = popupStorageKey();
  if (key == null) return false;
  try {
    return getKeyValueStorage().getItem(key) !== status.endsAt;
  } catch {
    return true;
  }
}

export function markDailyCheckinPopupShown(status: DailyCheckinStatus): void {
  const key = popupStorageKey();
  if (key == null) return;
  try {
    getKeyValueStorage().setItem(key, status.endsAt);
  } catch {
    return;
  }
}

registerOnLogout(() => useDailyCheckinStore.getState().reset());
