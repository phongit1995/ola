import { create } from 'zustand';
import { mergeHistory, readBotHistory, type HistoryEntry, type HistoryStatus } from '../helpers/history';
import { mockFetchHistory } from '../helpers/historyMock';
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
    if (navigator.onLine === false) {
      set({ status: 'offline' });
      return;
    }
    set({ status: 'loading' });
    try {
      const online = await mockFetchHistory();
      if (seq !== requestSeq) return;
      const { bot, touched, expandedId } = get();
      set({ status: 'ready', online, expandedId: touched ? expandedId : (mergeHistory(online, bot)[0]?.id ?? null) });
    } catch {
      if (seq !== requestSeq) return;
      set({ status: 'error' });
    }
  },

  toggle(id) {
    playSound('click');
    set((state) => ({ expandedId: state.expandedId === id ? null : id, touched: true }));
  },
}));
