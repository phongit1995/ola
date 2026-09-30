import type { StoreApi } from 'zustand';
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

export type WordChainStatus = 'connecting' | 'joined' | 'error';

export interface WordChainGuesses {
  sessionId: string;
  turn: number;
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
  status: WordChainStatus;
  state: WordChainState | null;
  points: number;
  hintPrice: number;
  guesses: WordChainGuesses | null;
  messages: WordChainMessage[];
  hasMore: boolean;
  loadingMore: boolean;
  leaderboards: Partial<Record<WordChainLeaderboardKey, WordChainLeaderboard>>;
  leaderboardPending: WordChainLeaderboardKey[];
  wins: WordChainWin[];
  winsMine: boolean;
  winsHasMore: boolean;
  winsNextBefore: string | null;
  winsLoading: boolean;
  open: () => Promise<void>;
  close: () => void;
  loadMoreMessages: () => Promise<void>;
  sendMove: (content: string) => Promise<WordChainMoveResult>;
  fetchLeaderboard: (query: WordChainLeaderboardQuery) => Promise<void>;
  fetchWins: (options: WordChainFetchWinsOptions) => Promise<void>;
  buyHint: () => Promise<WordChainHint>;
  lookup: (word: string) => Promise<WordChainLookup>;
  reset: () => void;
}

export type WordChainStoreData = Pick<
  WordChainStoreState,
  | 'opened'
  | 'status'
  | 'state'
  | 'points'
  | 'hintPrice'
  | 'guesses'
  | 'messages'
  | 'hasMore'
  | 'loadingMore'
  | 'leaderboards'
  | 'leaderboardPending'
  | 'wins'
  | 'winsMine'
  | 'winsHasMore'
  | 'winsNextBefore'
  | 'winsLoading'
>;

export interface WordChainPrefsState {
  hintAutoSend: boolean;
  setHintAutoSend: (hintAutoSend: boolean) => void;
}

export type PersistedWordChainPrefs = Pick<WordChainPrefsState, 'hintAutoSend'>;

export type WordChainSet = StoreApi<WordChainStoreState>['setState'];
export type WordChainGet = StoreApi<WordChainStoreState>['getState'];
