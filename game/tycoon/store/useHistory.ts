import { create } from 'zustand';
import { historyFromServer, mergeHistory, readBotHistory, type HistoryEntry, type HistoryStatus } from '../helpers/history';
import { useTycoon } from './useTycoon';
import { playSound } from '../audio';

interface HistoryState {
  status: HistoryStatus;
  online: HistoryEntry[];
  bot: HistoryEntry[];
  expandedId: string | null;
  touched: boolean;

  open(userId: string | undefined): void;
  load(): Promise<void>;
  toggle(id: string): void;
}

let requestSeq = 0;
const REQUEST_TIMEOUT_MS = 10_000;

export const useHistory = create<HistoryState>((set, get) => ({
  status: 'loading',
  online: [],
  bot: [],
  expandedId: null,
  touched: false,

  open(userId) {
    const bot = userId ? readBotHistory(userId) : [];
    set({ status: 'loading', online: [], bot, expandedId: bot[0]?.id ?? null, touched: false });
    void get().load();
  },

  async load() {
    const seq = ++requestSeq;
    const tycoon = useTycoon.getState();
    const session = tycoon.session();
    if (navigator.onLine === false || !session || tycoon.online !== 'ready') {
      set({ status: 'offline' });
      return;
    }
    set({ status: 'loading' });
    const meId = tycoon.profile?.id ?? '';
    await new Promise<void>((resolve) => {
      const timer = setTimeout(() => {
        off();
        if (seq === requestSeq) set({ status: 'error' });
        resolve();
      }, REQUEST_TIMEOUT_MS);
      const off = session.onHistory((data) => {
        clearTimeout(timer);
        off();
        resolve();
        if (seq !== requestSeq) return;
        if (data.error?.trim()) {
          set({ status: 'error' });
          return;
        }
        const online = (data.items ?? []).map((item) => historyFromServer(item, meId, tycoon.profile ?? undefined));
        const { bot, touched, expandedId } = get();
        set({ status: 'ready', online, expandedId: touched ? expandedId : (mergeHistory(online, bot)[0]?.id ?? null) });
      });
      session.getHistory();
    });
  },

  toggle(id) {
    playSound('click');
    set((state) => ({ expandedId: state.expandedId === id ? null : id, touched: true }));
  },
}));
