export type PenStatus = 'open' | 'settled' | 'cancelled'

export type PenResult = 'saved' | 'goal'

export type PenSide = 'left' | 'right'

export interface PenUserBrief {
  id: string
  username: string
  fullName?: string
  avatar?: string
}

export interface AdminPenShot {
  id: string
  shooter?: PenUserBrief
  keeper?: PenUserBrief
  betAmount: number
  status: PenStatus
  shooterSide?: PenSide
  keeperSide?: PenSide
  result?: PenResult
  winnerId?: string
  pot?: number
  commission?: number
  payout?: number
  createdAt: string
  settledAt?: string
  cancelledAt?: string
}

export interface PenShotListParams {
  shooterId?: string
  keeperId?: string
  status?: PenStatus
  result?: PenResult
  minBet?: number
  maxBet?: number
  from?: string
  to?: string
  limit?: number
  offset?: number
}

export interface PenStatsOverview {
  totalShots: number
  settledShots: number
  openShots: number
  cancelledShots: number
  uniqueShooters: number
  uniqueKeepers: number
  totalVolume: number
  houseTake: number
  totalPayout: number
  savedCount: number
  goalCount: number
  keeperWinRate: number
}

export interface PenStatsResult {
  result: PenResult
  count: number
  percent: number
}

export interface PenStatsStatus {
  status: PenStatus
  count: number
  percent: number
}

export interface PenStatsTimePoint {
  date: string
  shots: number
  settled: number
  volume: number
  houseTake: number
}

export interface PenStatsPlayer {
  user: PenUserBrief
  shots: number
  staked: number
  won: number
}

export interface PenStatsResponse {
  overview: PenStatsOverview
  byResult: PenStatsResult[]
  byStatus: PenStatsStatus[]
  timeseries: PenStatsTimePoint[]
  topPlayers: PenStatsPlayer[]
  bucket: 'day' | 'month'
}

export interface PenStatsParams {
  from?: string
  to?: string
}

export type PenUserStatsSortBy = 'staked' | 'netKen' | 'shots' | 'catches'

export interface PenUserStatsItem {
  user: PenUserBrief
  shots: number
  shooterSettled: number
  shooterWins: number
  shooterWinRate: number
  catches: number
  keeperWins: number
  keeperSaveRate: number
  cancelled: number
  cancelRate: number
  staked: number
  netKen: number
  lastPlayAt: string
}

export interface PenUserStatsParams {
  userId?: string
  from?: string
  to?: string
  sortBy?: PenUserStatsSortBy
  limit?: number
  offset?: number
}

export interface PenSideStatsResponse {
  shooterLeft: number
  shooterRight: number
  keeperLeft: number
  keeperRight: number
}

export interface PenSideStatsParams {
  userId?: string
  from?: string
  to?: string
}
