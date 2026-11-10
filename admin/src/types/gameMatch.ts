export type GameMatchStatus = 'playing' | 'finished'

export type GameMatchReason = 'win' | 'forfeit' | 'timeout' | 'draw' | 'disconnect' | 'void'

export type GameMatchMode = 'queue' | 'room'

export interface GameMatchUserBrief {
  id: string
  username: string
  fullName?: string
  avatar?: string
}

export interface AdminGameMatchPlayer {
  user: GameMatchUserBrief
  seat: number
  place?: number
}

export interface AdminGameMatch {
  id: string
  matchId: string
  gameId: string
  player0?: GameMatchUserBrief
  player1?: GameMatchUserBrief
  playerCount: number
  players?: AdminGameMatchPlayer[]
  winnerId?: string
  status: GameMatchStatus
  reason?: GameMatchReason
  mode: GameMatchMode
  bet: number
  kenDelta: number
  houseTake: number
  moveCount: number
  startedAt: string
  finishedAt?: string
}

export interface GameMatchListParams {
  gameId?: string
  userId?: string
  winnerId?: string
  status?: GameMatchStatus
  reason?: GameMatchReason
  mode?: GameMatchMode
  minBet?: number
  maxBet?: number
  from?: string
  to?: string
  limit?: number
  offset?: number
}

export interface GameMatchStatsOverview {
  totalMatches: number
  playingMatches: number
  finishedMatches: number
  decidedMatches: number
  drawMatches: number
  voidMatches: number
  uniquePlayers: number
  totalVolume: number
  totalPayout: number
  houseTake: number
}

export interface GameMatchStatsGameRow {
  gameId: string
  matches: number
  finished: number
  volume: number
  houseTake: number
}

export interface GameMatchStatsReasonRow {
  reason: GameMatchReason
  count: number
  percent: number
}

export interface GameMatchStatsTimePoint {
  date: string
  matches: number
  finished: number
  volume: number
  houseTake: number
}

export interface GameMatchStatsPlayer {
  user: GameMatchUserBrief
  matches: number
  wins: number
  losses: number
  winRate: number
  staked: number
  netKen: number
}

export interface GameMatchStatsResponse {
  overview: GameMatchStatsOverview
  byGame: GameMatchStatsGameRow[]
  byReason: GameMatchStatsReasonRow[]
  timeseries: GameMatchStatsTimePoint[]
  topPlayers: GameMatchStatsPlayer[]
  bucket: 'day' | 'month'
}

export interface GameMatchStatsParams {
  gameId?: string
  mode?: GameMatchMode
  from?: string
  to?: string
}

export interface GameMatchSuspectPair {
  userA: GameMatchUserBrief
  userB: GameMatchUserBrief
  matches: number
  decided: number
  aWins: number
  bWins: number
  oneSidedRate: number
  totalBet: number
  netA: number
}

export interface GameMatchSuspectsResponse {
  minMatches: number
  minPairMatches: number
  players: GameMatchStatsPlayer[]
  pairs: GameMatchSuspectPair[]
}

export interface GameMatchSuspectsParams {
  gameId?: string
  from?: string
  to?: string
  minMatches?: number
  minPairMatches?: number
}

export interface AdminGameLevel {
  user: GameMatchUserBrief
  gameId: string
  level: number
  exp: number
  updatedAt: string
}

export interface GameLevelListParams {
  gameId?: string
  userId?: string
  search?: string
  limit?: number
  offset?: number
}
