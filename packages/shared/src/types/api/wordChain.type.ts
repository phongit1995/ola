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
}

export interface WordChainOverview {
  state: WordChainState;
  points: number;
  remainingGuesses: number;
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
}

export interface WordChainMoveResult {
  message: WordChainMessage;
  botMessages: WordChainMessage[];
  state: WordChainState;
  points: number;
  remainingGuesses: number;
}

export interface WordChainLeaderboardEntry {
  rank: number;
  userId: string;
  username: string;
  fullName?: string;
  avatar?: string;
  points: number;
}

export interface WordChainLeaderboard {
  items: WordChainLeaderboardEntry[];
  total: number;
  me: WordChainLeaderboardEntry | null;
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
