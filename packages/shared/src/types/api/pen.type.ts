export type PenSide = 'left' | 'right';

export type PenStatus = 'open' | 'settled' | 'cancelled';

export type PenResult = 'goal' | 'saved';

export interface PenUserBrief {
  id: string;
  username: string;
  fullName?: string;
  avatar?: string;
  vipUsed?: string;
  vipEndTime?: string;
  vipTypeId?: number | null;
}

export interface PenShotView {
  id: string;
  shooter?: PenUserBrief;
  keeper?: PenUserBrief;
  betAmount: number;
  status: PenStatus;
  shooterSide?: PenSide;
  keeperSide?: PenSide;
  result?: PenResult;
  winnerId?: string;
  pot?: number;
  commission?: number;
  payout?: number;
  createdAt: string;
  settledAt?: string;
  cancelledAt?: string;
}

export interface PenShotListResult {
  total: number;
  limit: number;
  offset: number;
  items: PenShotView[];
}

export interface CreateShotRequest {
  betAmount: number;
  side: PenSide;
}

export interface CreateShotResponse {
  shot: PenShotView;
  kenBalance: number;
}

export interface CatchRequest {
  side: PenSide;
}

export interface CatchResult {
  shotId: string;
  result: PenResult;
  win: boolean;
  winnerId: string;
  betAmount: number;
  pot: number;
  commission: number;
  payout: number;
  shooterSide: PenSide;
  keeperSide: PenSide;
  kenBalance: number;
}

export interface CancelResponse {
  shotId: string;
  status: PenStatus;
  refunded: number;
  kenBalance: number;
}

export interface PenSettledEvent {
  shotId: string;
  result: PenResult;
  winnerId: string;
  shooterId: string;
  keeperId: string;
  betAmount: number;
  pot: number;
  commission: number;
  payout: number;
  shooterSide: PenSide;
  keeperSide: PenSide;
}

export type PenOpenSort = 'newest' | 'bet_desc' | 'bet_asc';

export interface PenOpenParams {
  bet?: number;
  minBet?: number;
  maxBet?: number;
  sort?: PenOpenSort;
  limit?: number;
  offset?: number;
}

export interface PenPageParams {
  limit?: number;
  offset?: number;
}

export type PenHistoryRole = 'all' | 'shoot' | 'catch';

export type PenHistoryOutcome = 'win' | 'lose';

export interface PenHistoryParams {
  role?: PenHistoryRole;
  result?: PenHistoryOutcome;
  limit?: number;
  offset?: number;
}

export type PenLeaderboardPeriod = 'day' | 'week';

export interface PenLeaderboardEntry {
  rank: number;
  user: PenUserBrief;
  profit: number;
}

export interface PenLeaderboardResult {
  period: PenLeaderboardPeriod;
  from: string;
  to: string;
  items: PenLeaderboardEntry[];
}
