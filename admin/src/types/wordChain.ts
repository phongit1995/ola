export interface WordChainSetting {
  enabled: boolean
  hintPrice: number
  guessPrice: number
  vipRequiredToView: boolean
  vipRequiredToPlay: boolean
}

export type WordChainMessageType =
  | 'move'
  | 'win'
  | 'game_started'
  | 'session_started'
  | 'wrong_answer'

export type WordChainCode =
  | 'ok'
  | 'win'
  | 'mismatch'
  | 'repeated'
  | 'not_in_dict'
  | 'invalid_format'

export interface WordChainState {
  sessionId?: string
  revision: number
  turn: number
  guessLimit: number
  word?: string
  requiredSyllable?: string
  historyCount: number
  sessionStartedAt?: string
  lastProgressAt?: string
  wordExpiresAt?: string
  wordOwnerId?: string
}

export interface WordChainPlayer {
  id: string
  username: string
  fullName?: string
  avatar?: string
}

export interface WordChainOverview {
  state: WordChainState | null
  history: string[]
  wordOwner?: WordChainPlayer
  players: number
  winners: number
}

export interface WordChainMessage {
  id: string
  seq: number
  sessionId: string
  type: WordChainMessageType
  senderType: 'user' | 'bot'
  senderId?: string
  senderName?: string
  senderAvatar?: string
  content: string
  word?: string
  code?: WordChainCode
  reaction?: string
  requiredSyllable?: string
  remainingGuesses?: number
  createdAt: string
}

export interface WordChainWin {
  id: string
  userId: string
  username: string
  fullName?: string
  avatar?: string
  word: string
  previousWord: string
  createdAt: string
}

export interface WordChainCursorPage<T> {
  items: T[]
  hasMore: boolean
  nextBefore?: string
}

export interface WordChainCursorParams {
  limit?: number
  before?: string
}

export interface WordChainWinsParams extends WordChainCursorParams {
  userId?: string
}

export type WordChainPurchaseType = 'hint' | 'guess'

export interface WordChainPurchase {
  id: string
  type: WordChainPurchaseType
  user: { id: string; username: string; fullName?: string; avatar?: string }
  word?: string
  hints?: string[]
  guesses?: number
  amount: number
  createdAt: string
}

export interface WordChainPurchaseList {
  items: WordChainPurchase[]
  total: number
  summary: { hintCount: number; hintKen: number; guessCount: number; guessKen: number }
}

export interface WordChainPurchaseParams {
  type?: WordChainPurchaseType
  search?: string
  from?: string
  to?: string
  limit?: number
  offset?: number
}
