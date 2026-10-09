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
import { toRecord } from '../../lib/utils';
import {
  isSameWordChainTurn,
  sessionMessages,
  wordChainLeaderboardKey,
  wordChainLookupErrorText,
} from '../../lib/wordChain';
import { SocketService } from '../../services/socket.service';
import { WordChainService } from '../../services/wordChain.service';
import type { WordChainMessage, WordChainState } from '../../types/api/wordChain.type';
import type {
  WordChainGet,
  WordChainSet,
  WordChainStoreData,
  WordChainStoreState,
} from '../../types/client/wordChain.type';
import { setAuthUserKen } from '../auth/authStore';
import { claimRealtimeRegistration } from '../realtimeRegistration.state';
import { useWordChainConfigStore } from './wordChainConfigStore';
import {
  freshWinningMove,
  guessesFor,
  hasMoreInSession,
  isNewerWordChainState,
  mergeWordChainMessages,
  newerGuesses,
  toWordChainMessage,
  toWordChainState,
  withLatestPage,
} from './wordChainHelpers';

const initialWordChainState: WordChainStoreData = {
  opened: false,
  minimized: false,
  notify: false,
  status: 'connecting',
  state: null,
  hintPrice: 0,
  guessPrice: 0,
  guessPackSize: 0,
  hint: null,
  guesses: null,
  messages: [],
  hasMore: false,
  loadingMore: false,
  leaderboards: {},
  leaderboardPending: [],
  leaderboardFailed: [],
  wins: [],
  winsMine: false,
  winsHasMore: false,
  winsNextBefore: null,
  winsLoading: false,
  winsFailed: false,
  lookupResult: null,
  lookupLoading: false,
  celebration: null,
};

function errorCode(error: unknown): string | undefined {
  return toApiError(error).code;
}

function createWordChainSync(set: WordChainSet, get: WordChainGet) {
  let joinAttempt = 0;

  function addMessages(items: WordChainMessage[]) {
    set((store) => ({ messages: mergeWordChainMessages(store.messages, items) }));
  }

  function addLiveMessages(items: WordChainMessage[]) {
    const winner = freshWinningMove(get().messages, items);
    addMessages(items);
    if (get().minimized) set({ notify: true });
    const sessionId = get().state?.sessionId;
    if (winner != null && (sessionId == null || winner.sessionId === sessionId)) {
      set({ celebration: winner });
    }
  }

  function setGuesses(state: WordChainState, remaining: number) {
    set((store) => ({
      guesses: newerGuesses(store.guesses, guessesFor(state, remaining)),
    }));
  }

  function disableRoom() {
    useWordChainConfigStore.getState().markDisabled();
    get().close();
  }

  async function reloadMessages() {
    const page = await WordChainService.messages({
      limit: WORD_CHAIN_MESSAGE_PAGE_SIZE,
    });
    if (!get().opened) return;
    set((store) => {
      const sessionId = store.state?.sessionId;
      return {
        messages: sessionMessages(withLatestPage(store.messages, page.items), sessionId),
        hasMore: hasMoreInSession(page, sessionId),
      };
    });
  }

  function applyState(incoming: WordChainState) {
    const current = get().state;
    if (!isNewerWordChainState(current, incoming)) return;
    const sessionChanged = current != null && current.sessionId !== incoming.sessionId;
    set((store) => ({
      state: incoming,
      messages: sessionMessages(store.messages, incoming.sessionId),
    }));
    if (sessionChanged) void reloadMessages().catch(() => undefined);
  }

  async function refreshOverview() {
    const overview = await WordChainService.overview();
    if (!get().opened) return;
    applyState(overview.state);
    setGuesses(overview.state, overview.remainingGuesses);
  }

  async function join(attempt: number) {
    const live = () => attempt === joinAttempt && get().opened;
    const socket = await SocketService.ready(WORD_CHAIN_JOIN_ACK_TIMEOUT_MS);
    if (!live()) return;
    const ack = toRecord(
      await socket
        .timeout(WORD_CHAIN_JOIN_ACK_TIMEOUT_MS)
        .emitWithAck(WORD_CHAIN_SOCKET_EVENTS.join)
    );
    if (!live()) return;
    if (ack?.ok !== true) {
      set({ status: 'error' });
      return;
    }

    const [overview, page] = await Promise.all([
      WordChainService.overview(),
      WordChainService.messages({ limit: WORD_CHAIN_MESSAGE_PAGE_SIZE }),
    ]);
    if (!live()) return;
    set((store) => ({ messages: withLatestPage(store.messages, page.items) }));
    applyState(overview.state);
    setGuesses(overview.state, overview.remainingGuesses);
    set((store) => {
      const sessionId = store.state?.sessionId;
      return {
        status: 'joined',
        hintPrice: overview.hintPrice,
        guessPrice: overview.guessPrice,
        guessPackSize: overview.guessPackSize,
        hasMore: hasMoreInSession(page, sessionId),
        messages: sessionMessages(store.messages, sessionId),
      };
    });
  }

  function rejoin() {
    const attempt = ++joinAttempt;
    join(attempt).catch((error: unknown) => {
      if (attempt !== joinAttempt || !get().opened) return;
      if (errorCode(error) === WORD_CHAIN_ERROR_CODE.disabled) {
        toast.error(i18n.t('wordChain.disabled'));
        disableRoom();
        return;
      }
      set({ status: 'error' });
    });
  }

  function handleActionError(error: unknown) {
    const code = errorCode(error);
    if (code === WORD_CHAIN_ERROR_CODE.disabled) {
      disableRoom();
    } else if (
      (code === WORD_CHAIN_ERROR_CODE.wordChanged ||
        code === WORD_CHAIN_ERROR_CODE.guessesLeft) &&
      get().opened
    ) {
      void refreshOverview().catch(() => undefined);
    }
  }

  function cancelJoin() {
    joinAttempt += 1;
  }

  if (claimRealtimeRegistration('word-chain')) {
    SocketService.on(WORD_CHAIN_SOCKET_EVENTS.newMessage, (data) => {
      if (!get().opened) return;
      const message = toWordChainMessage(toRecord(data)?.message);
      if (message != null) addLiveMessages([message]);
    });
    SocketService.on(WORD_CHAIN_SOCKET_EVENTS.stateUpdated, (data) => {
      if (!get().opened) return;
      const state = toWordChainState(toRecord(data)?.state);
      if (state != null) applyState(state);
    });
    SocketService.on(WORD_CHAIN_SOCKET_EVENTS.guessesUpdated, (data) => {
      if (!get().opened) return;
      const record = toRecord(data);
      const state = toWordChainState(record?.state);
      const remaining = record?.remainingGuesses;
      if (state == null || typeof remaining !== 'number') return;
      applyState(state);
      setGuesses(state, remaining);
    });
    SocketService.onReconnect(() => {
      if (get().opened) rejoin();
    });
  }

  return {
    addMessages,
    addLiveMessages,
    applyState,
    setGuesses,
    rejoin,
    cancelJoin,
    handleActionError,
  };
}

export const useWordChainStore = create<WordChainStoreState>((set, get) => {
  const sync = createWordChainSync(set, get);
  let winsRequest = 0;
  let lookupRequest = 0;

  function clear() {
    winsRequest += 1;
    lookupRequest += 1;
    sync.cancelJoin();
    set({ ...initialWordChainState });
  }

  return {
    ...initialWordChainState,

    open: () => {
      if (get().opened) {
        set({ minimized: false, notify: false });
        return;
      }
      SocketService.connect();
      set({ ...initialWordChainState, opened: true });
      sync.rejoin();
    },

    close: () => {
      if (!get().opened) return;
      SocketService.connect().emit(WORD_CHAIN_SOCKET_EVENTS.leave);
      clear();
    },

    loadMoreMessages: async () => {
      const { opened, hasMore, loadingMore, state, messages } = get();
      const sessionId = state?.sessionId;
      if (!opened || !hasMore || loadingMore) return;
      const oldest = sessionMessages(messages, sessionId)[0];
      if (oldest == null) return;
      set({ loadingMore: true });
      try {
        const page = await WordChainService.messages({
          limit: WORD_CHAIN_MESSAGE_PAGE_SIZE,
          before: oldest.id,
        });
        const store = get();
        if (!store.opened) return;
        if (sessionMessages(store.messages, sessionId)[0]?.id !== oldest.id) {
          set({ loadingMore: false });
          return;
        }
        sync.addMessages(sessionMessages(page.items, sessionId));
        set({ hasMore: hasMoreInSession(page, sessionId), loadingMore: false });
      } catch {
        if (get().opened) set({ loadingMore: false });
      }
    },

    sendMove: async (content) => {
      const sent = get().state;
      try {
        const result = await WordChainService.move({
          content,
          sessionId: sent?.sessionId,
          turn: sent?.turn,
        });
        if (get().opened) {
          sync.addLiveMessages([result.message, ...result.botMessages]);
          sync.applyState(result.state);
          sync.setGuesses(result.state, result.remainingGuesses);
        }
        return result;
      } catch (error) {
        const state = get().state;
        if (
          state != null &&
          isSameWordChainTurn(state, sent) &&
          errorCode(error) === WORD_CHAIN_ERROR_CODE.noGuesses
        ) {
          sync.setGuesses(state, 0);
        }
        sync.handleActionError(error);
        throw error;
      }
    },

    fetchLeaderboard: async (query) => {
      const key = wordChainLeaderboardKey(query);
      if (get().leaderboardPending.includes(key)) return;
      set((store) => ({
        leaderboardPending: [...store.leaderboardPending, key],
        leaderboardFailed: store.leaderboardFailed.filter((item) => item !== key),
      }));
      try {
        const leaderboard = await WordChainService.leaderboard(query);
        if (!get().opened) return;
        set((store) => ({ leaderboards: { ...store.leaderboards, [key]: leaderboard } }));
      } catch {
        if (!get().opened) return;
        set((store) => ({ leaderboardFailed: [...store.leaderboardFailed, key] }));
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
          ? { winsLoading: true, winsFailed: false }
          : {
              winsLoading: true,
              winsFailed: false,
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
        set({ winsLoading: false, winsFailed: true });
        toast.error(i18n.t('wordChain.winsError'));
      }
    },

    buyHint: async () => {
      try {
        const result = await WordChainService.hint();
        setAuthUserKen(result.kenBalance);
        if (get().opened) {
          set(result.charged ? { hintPrice: result.price, hint: result } : { hint: result });
        }
        return result;
      } catch (error) {
        sync.handleActionError(error);
        throw error;
      }
    },

    buyGuesses: async (request) => {
      try {
        const result = await WordChainService.buyGuesses(request);
        setAuthUserKen(result.kenBalance);
        if (get().opened) {
          sync.applyState(result.state);
          sync.setGuesses(result.state, result.remainingGuesses);
          set({ guessPrice: result.price, guessPackSize: result.guesses });
        }
        return result;
      } catch (error) {
        sync.handleActionError(error);
        throw error;
      }
    },

    lookup: async (word) => {
      const request = ++lookupRequest;
      set({ lookupLoading: true });
      try {
        const result = await WordChainService.lookup(word);
        if (request === lookupRequest) set({ lookupResult: result, lookupLoading: false });
      } catch (error) {
        if (request !== lookupRequest) return;
        set({ lookupLoading: false });
        toast.error(wordChainLookupErrorText(i18n.t, error));
      }
    },

    clearLookup: () => {
      lookupRequest += 1;
      set({ lookupResult: null, lookupLoading: false });
    },

    minimize: () => {
      if (get().opened) set({ minimized: true, notify: false });
    },

    restore: () => set({ minimized: false, notify: false }),

    dismissCelebration: (id) => {
      if (get().celebration?.id === id) set({ celebration: null });
    },

    reset: clear,
  };
});
