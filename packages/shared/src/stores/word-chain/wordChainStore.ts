import i18n from 'i18next';
import { create } from 'zustand';
import { WORD_CHAIN_SOCKET_EVENTS } from '../../constants/socket';
import {
  WORD_CHAIN_ERROR_CODE,
  WORD_CHAIN_JOIN_ACK_TIMEOUT_MS,
  WORD_CHAIN_MESSAGE_PAGE_SIZE,
  WORD_CHAIN_WIN_PAGE_SIZE,
} from '../../constants/wordChain';
import { toApiError } from '../../lib/apiError';
import { toast } from '../../lib/toast';
import { SocketService } from '../../services/socket.service';
import { WordChainService } from '../../services/wordChain.service';
import type {
  WordChainMessage,
  WordChainState,
} from '../../types/api/wordChain.type';
import type {
  WordChainGet,
  WordChainSet,
  WordChainStoreData,
  WordChainStoreState,
} from '../../types/client/wordChain.type';
import { useAuthStore } from '../auth/authStore';
import { claimRealtimeRegistration } from '../realtimeRegistration.state';
import { toRecord } from '../room/roomHelpers';
import {
  guessesFor,
  isNewerWordChainState,
  mergeWordChainMessages,
  sessionMessages,
  toWordChainMessage,
  toWordChainState,
  withLatestPage,
  wordChainLeaderboardKey,
} from './wordChainHelpers';

const initialWordChainState: WordChainStoreData = {
  opened: false,
  status: 'connecting',
  state: null,
  points: 0,
  hintPrice: 0,
  guesses: null,
  messages: [],
  hasMore: false,
  loadingMore: false,
  leaderboards: {},
  leaderboardPending: [],
  wins: [],
  winsMine: false,
  winsHasMore: false,
  winsNextBefore: null,
  winsLoading: false,
};

function syncAuthKen(ken: number) {
  useAuthStore.setState((state) => (state.user ? { user: { ...state.user, ken } } : state));
}

function createWordChainSync(set: WordChainSet, get: WordChainGet) {
  function addMessages(items: WordChainMessage[]) {
    set((store) => ({ messages: mergeWordChainMessages(store.messages, items) }));
  }

  async function reloadMessages() {
    const page = await WordChainService.messages({
      limit: WORD_CHAIN_MESSAGE_PAGE_SIZE,
    });
    if (!get().opened) return;
    set((store) => ({
      messages: sessionMessages(
        withLatestPage(store.messages, page.items),
        store.state?.sessionId
      ),
      hasMore: page.hasMore,
    }));
  }

  function applyState(incoming: WordChainState) {
    const current = get().state;
    if (!isNewerWordChainState(current, incoming)) return;
    const sessionChanged =
      current != null && current.sessionId !== incoming.sessionId;
    set((store) => ({
      state: incoming,
      messages: sessionMessages(store.messages, incoming.sessionId),
    }));
    if (sessionChanged) void reloadMessages().catch(() => undefined);
  }

  async function join() {
    const socket = await SocketService.ready(WORD_CHAIN_JOIN_ACK_TIMEOUT_MS);
    if (!get().opened) return;
    const ack = toRecord(
      await socket
        .timeout(WORD_CHAIN_JOIN_ACK_TIMEOUT_MS)
        .emitWithAck(WORD_CHAIN_SOCKET_EVENTS.join)
    );
    if (!get().opened) return;
    if (ack?.ok !== true) {
      set({ status: 'error' });
      return;
    }

    const [overview, page] = await Promise.all([
      WordChainService.overview(),
      WordChainService.messages({ limit: WORD_CHAIN_MESSAGE_PAGE_SIZE }),
    ]);
    if (!get().opened) return;
    set((store) => ({ messages: withLatestPage(store.messages, page.items) }));
    applyState(overview.state);
    set((store) => ({
      status: 'joined',
      points: overview.points,
      hintPrice: overview.hintPrice,
      guesses: guessesFor(overview.state, overview.remainingGuesses),
      hasMore: page.hasMore,
      messages: sessionMessages(store.messages, store.state?.sessionId),
    }));
  }

  function rejoin() {
    join().catch(() => {
      if (get().opened) set({ status: 'error' });
    });
  }

  if (claimRealtimeRegistration('word-chain')) {
    SocketService.on(WORD_CHAIN_SOCKET_EVENTS.newMessage, (data) => {
      if (!get().opened) return;
      const message = toWordChainMessage(toRecord(data)?.message);
      if (message != null) addMessages([message]);
    });
    SocketService.on(WORD_CHAIN_SOCKET_EVENTS.stateUpdated, (data) => {
      if (!get().opened) return;
      const state = toWordChainState(toRecord(data)?.state);
      if (state != null) applyState(state);
    });
    SocketService.onReconnect(() => {
      if (get().opened) rejoin();
    });
  }

  return { addMessages, applyState, rejoin };
}

export const useWordChainStore = create<WordChainStoreState>((set, get) => {
  const sync = createWordChainSync(set, get);
  let winsRequest = 0;

  return {
    ...initialWordChainState,

    open: async () => {
      if (get().opened) return;
      SocketService.connect();
      set({ ...initialWordChainState, opened: true });
      sync.rejoin();
    },

    close: () => {
      if (!get().opened) return;
      SocketService.connect().emit(WORD_CHAIN_SOCKET_EVENTS.leave);
      winsRequest += 1;
      set({ ...initialWordChainState });
    },

    loadMoreMessages: async () => {
      const { opened, hasMore, loadingMore, state, messages } = get();
      if (!opened || !hasMore || loadingMore) return;
      const oldest = sessionMessages(messages, state?.sessionId)[0];
      if (oldest == null) return;
      set({ loadingMore: true });
      try {
        const page = await WordChainService.messages({
          limit: WORD_CHAIN_MESSAGE_PAGE_SIZE,
          before: oldest.id,
        });
        const store = get();
        if (!store.opened) return;
        if (sessionMessages(store.messages, store.state?.sessionId)[0]?.id !== oldest.id) {
          set({ loadingMore: false });
          return;
        }
        sync.addMessages(page.items);
        set({ hasMore: page.hasMore, loadingMore: false });
      } catch {
        if (get().opened) set({ loadingMore: false });
      }
    },

    sendMove: async (content) => {
      const sentState = get().state;
      try {
        const result = await WordChainService.move({ content });
        if (get().opened) {
          sync.addMessages([result.message, ...result.botMessages]);
          sync.applyState(result.state);
          set({
            points: result.points,
            guesses: guessesFor(result.state, result.remainingGuesses),
          });
        }
        return result;
      } catch (error) {
        const state = get().state;
        if (
          sentState != null &&
          state != null &&
          state.sessionId === sentState.sessionId &&
          state.turn === sentState.turn &&
          toApiError(error).code === WORD_CHAIN_ERROR_CODE.noGuesses
        ) {
          set({ guesses: guessesFor(state, 0) });
        }
        throw error;
      }
    },

    fetchLeaderboard: async (query) => {
      const key = wordChainLeaderboardKey(query);
      if (get().leaderboardPending.includes(key)) return;
      set((store) => ({ leaderboardPending: [...store.leaderboardPending, key] }));
      try {
        const leaderboard = await WordChainService.leaderboard(query);
        set((store) => ({ leaderboards: { ...store.leaderboards, [key]: leaderboard } }));
      } catch {
        toast.error(i18n.t('wordChain.leaderboardError'));
      } finally {
        set((store) => ({
          leaderboardPending: store.leaderboardPending.filter((item) => item !== key),
        }));
      }
    },

    fetchWins: async ({ mine, more = false }) => {
      const current = get();
      const before = more ? current.winsNextBefore : null;
      if (more && (current.winsLoading || current.winsMine !== mine || before == null)) {
        return;
      }
      const request = ++winsRequest;
      set(
        more
          ? { winsLoading: true }
          : {
              winsLoading: true,
              winsMine: mine,
              wins: [],
              winsHasMore: false,
              winsNextBefore: null,
            }
      );
      try {
        const page = await WordChainService.wins({
          limit: WORD_CHAIN_WIN_PAGE_SIZE,
          before: before ?? undefined,
          mine,
        });
        if (request !== winsRequest) return;
        set((store) => ({
          wins: more ? [...store.wins, ...page.items] : page.items,
          winsHasMore: page.hasMore,
          winsNextBefore: page.nextBefore ?? null,
          winsLoading: false,
        }));
      } catch {
        if (request !== winsRequest) return;
        set({ winsLoading: false });
        toast.error(i18n.t('wordChain.winsError'));
      }
    },

    buyHint: async () => {
      const result = await WordChainService.hint();
      syncAuthKen(result.kenBalance);
      return result;
    },

    lookup: (word) => WordChainService.lookup(word),

    reset: () => {
      winsRequest += 1;
      set({ ...initialWordChainState });
    },
  };
});
