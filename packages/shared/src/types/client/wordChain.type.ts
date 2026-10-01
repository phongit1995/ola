import type { StoreApi } from 'zustand';
import type { RoomChatStatus } from './roomChat.type';
import type {
  WordChainHint,
  WordChainLeaderboard,
  WordChainLeaderboardPeriod,
  WordChainLeaderboardQuery,
  WordChainLeaderboardSort,
  WordChainLookup,
  WordChainMessage,
  WordChainMoveResult,
  WordChainState,
  WordChainWin,
} from '../api/wordChain.type';

export type WordChainMoveStatus = 'correct' | 'win' | 'warning' | 'error';

export type WordChainInputLock = 'waitTurn' | 'noGuesses';

export type WordChainLeaderboardTab = WordChainLeaderboardSort | 'history';

export interface WordChainTurnRef {
  sessionId?: string;
  turn: number;
}

export interface WordChainGuesses {
  sessionId: string;
  turn: number;
  revision: number;
  remaining: number;
}

export interface WordChainFeedDate {
  kind: 'date';
  key: string;
  createdAt: string;
}

export interface WordChainFeedMessage {
  kind: 'message';
  key: string;
  message: WordChainMessage;
  replyTo?: WordChainMessage;
}

export type WordChainFeedItem = WordChainFeedDate | WordChainFeedMessage;

export type WordChainLeaderboardKey = `${WordChainLeaderboardSort}:${WordChainLeaderboardPeriod}`;

export interface WordChainFetchWinsOptions {
  mine: boolean;
  more?: boolean;
}

export interface WordChainStoreState {
  opened: boolean;
  status: RoomChatStatus;
  state: WordChainState | null;
  hintPrice: number;
  hint: WordChainHint | null;
  guesses: WordChainGuesses | null;
  messages: WordChainMessage[];
  hasMore: boolean;
  loadingMore: boolean;
  leaderboards: Partial<Record<WordChainLeaderboardKey, WordChainLeaderboard>>;
  leaderboardPending: WordChainLeaderboardKey[];
  leaderboardFailed: WordChainLeaderboardKey[];
  wins: WordChainWin[];
  winsMine: boolean;
  winsHasMore: boolean;
  winsNextBefore: string | null;
  winsLoading: boolean;
  winsFailed: boolean;
  lookupResult: WordChainLookup | null;
  lookupLoading: boolean;
  open: () => void;
  close: () => void;
  loadMoreMessages: () => Promise<void>;
  sendMove: (content: string) => Promise<WordChainMoveResult>;
  fetchLeaderboard: (query: WordChainLeaderboardQuery) => Promise<void>;
  fetchWins: (options: WordChainFetchWinsOptions) => Promise<void>;
  buyHint: () => Promise<WordChainHint>;
  lookup: (word: string) => Promise<void>;
  clearLookup: () => void;
  reset: () => void;
}

export type WordChainStoreData = Omit<
  WordChainStoreState,
  | 'open'
  | 'close'
  | 'loadMoreMessages'
  | 'sendMove'
  | 'fetchLeaderboard'
  | 'fetchWins'
  | 'buyHint'
  | 'lookup'
  | 'clearLookup'
  | 'reset'
>;

export interface WordChainConfigState {
  enabled: boolean;
  load: () => Promise<void>;
  markDisabled: () => void;
}

export interface WordChainPrefsState {
  hintAutoSend: boolean;
  setHintAutoSend: (hintAutoSend: boolean) => void;
}

export type PersistedWordChainPrefs = Pick<WordChainPrefsState, 'hintAutoSend'>;

export type WordChainSet = StoreApi<WordChainStoreState>['setState'];
export type WordChainGet = StoreApi<WordChainStoreState>['getState'];
