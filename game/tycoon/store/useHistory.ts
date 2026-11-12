import { create } from 'zustand';
import { historyFromServer, mergeHistory, readBotHistory, type HistoryEntry, type HistoryStatus } from '../helpers/history';
import { createRequestGuard, requestOnce } from '../helpers/requestOnce';
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

const nextRequest = createRequestGuard();

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
    const isCurrent = nextRequest();
    const tycoon = useTycoon.getState();
    const session = tycoon.session();
    if (navigator.onLine === false || !session || tycoon.online !== 'ready') {
      set({ status: 'offline' });
      return;
    }
    set({ status: 'loading' });
    const meId = tycoon.profile?.id ?? '';
    const reply = await requestOnce({ subscribe: session.onHistory, isCurrent, send: () => session.getHistory() });
    if (reply.status === 'stale') return;
    if (reply.status === 'timeout' || reply.data.error?.trim()) {
      set({ status: 'error' });
      return;
    }
    const online = (reply.data.items ?? []).map((item) => historyFromServer(item, meId, tycoon.profile ?? undefined));
    const { bot, touched, expandedId } = get();
    set({ status: 'ready', online, expandedId: touched ? expandedId : (mergeHistory(online, bot)[0]?.id ?? null) });
  },

  toggle(id) {
    playSound('click');
    set((state) => ({ expandedId: state.expandedId === id ? null : id, touched: true }));
  },
}));
