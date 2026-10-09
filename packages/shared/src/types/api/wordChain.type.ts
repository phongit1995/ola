export type WordChainCode =
  | 'ok'
  | 'win'
  | 'mismatch'
  | 'repeated'
  | 'not_in_dict'
  | 'invalid_format';

export type WordChainMessageType =
  | 'move'
  | 'win'
  | 'game_started'
  | 'session_started'
  | 'wrong_answer';

export type WordChainSenderType = 'user' | 'bot';

export interface WordChainMessage {
  id: string;
  seq: number;
  sessionId: string;
  type: WordChainMessageType;
  senderType: WordChainSenderType;
  senderId?: string;
  senderName?: string;
  senderAvatar?: string;
  senderGender?: string;
  senderVip?: string | null;
  senderVipEnd?: string | null;
  senderVipTypeId?: number | null;
  content: string;
  word?: string;
  code?: WordChainCode;
  reaction?: string;
  requiredSyllable?: string;
  remainingGuesses?: number;
  createdAt: string;
}

export interface WordChainState {
  sessionId?: string;
  revision: number;
  turn: number;
  guessLimit: number;
  word?: string;
  requiredSyllable?: string;
  historyCount: number;
  sessionStartedAt?: string;
  lastProgressAt?: string;
  wordExpiresAt?: string;
  wordOwnerId?: string;
}

export interface WordChainOverview {
  state: WordChainState;
  points: number;
  remainingGuesses: number;
  hintPrice: number;
  guessPrice: number;
  guessPackSize: number;
}

export interface WordChainGuessPurchaseRequest {
  sessionId: string;
  turn: number;
  price: number;
}

export interface WordChainGuessPurchase {
  sessionId: string;
  turn: number;
  guesses: number;
  remainingGuesses: number;
  price: number;
  kenBalance: number;
  state: WordChainState;
}

export interface WordChainHint {
  sessionId: string;
  turn: number;
  word: string;
  hints: string[];
  price: number;
  kenBalance: number;
  charged: boolean;
}

export interface WordChainMessagesResult {
  items: WordChainMessage[];
  hasMore: boolean;
  nextBefore?: string;
}

export interface WordChainMessagesParams {
  limit?: number;
  before?: string;
}

export interface WordChainMoveRequest {
  content: string;
  sessionId?: string;
  turn?: number;
}

export interface WordChainMoveResult {
  message: WordChainMessage;
  botMessages: WordChainMessage[];
  state: WordChainState;
  points: number;
  remainingGuesses: number;
}

export type WordChainLeaderboardSort = 'points' | 'wins';

export type WordChainLeaderboardPeriod = 'day' | 'week' | 'month' | 'all';

export interface WordChainLeaderboardQuery {
  sort: WordChainLeaderboardSort;
  period: WordChainLeaderboardPeriod;
}

export interface WordChainLeaderboardEntry {
  rank: number;
  userId: string;
  username: string;
  fullName?: string;
  avatar?: string;
  points: number;
  wins: number;
}

export interface WordChainLeaderboard {
  items: WordChainLeaderboardEntry[];
  total: number;
  me: WordChainLeaderboardEntry | null;
  sort: WordChainLeaderboardSort;
  period: WordChainLeaderboardPeriod;
}

export interface WordChainWin {
  id: string;
  userId: string;
  username: string;
  fullName?: string;
  avatar?: string;
  word: string;
  previousWord: string;
  createdAt: string;
}

export interface WordChainWinsParams {
  limit?: number;
  before?: string;
  mine?: boolean;
}

export interface WordChainWinsResult {
  items: WordChainWin[];
  hasMore: boolean;
  nextBefore?: string;
}

export interface WordChainLookupMeaning {
  definition: string;
  pos?: string;
  subPos?: string;
  example?: string;
}

export interface WordChainLookupTranslation {
  translation: string;
  langName: string;
}

export interface WordChainLookupRelation {
  word: string;
  type: string;
}

export interface WordChainLookupResult {
  langCode: string;
  langName: string;
  meanings: WordChainLookupMeaning[];
  translations: WordChainLookupTranslation[];
  relations: WordChainLookupRelation[];
}

export interface WordChainLookup {
  word: string;
  found: boolean;
  message?: string;
  results: WordChainLookupResult[];
  source: string;
}
