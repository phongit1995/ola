import type {
  PenLeaderboardEntry,
  PenLeaderboardPeriod,
  PenShotView,
} from '../api/pen.type';

export interface PenState {
  shots: PenShotView[];
  loading: boolean;
  page: number;
  total: number;
  pageSize: number;
  loadShots: (page?: number) => Promise<void>;
  setPageSize: (size: number) => void;
}

export interface PenLeaderboardState {
  period: PenLeaderboardPeriod;
  page: number;
  loading: boolean;
  cache: Partial<Record<PenLeaderboardPeriod, PenLeaderboardEntry[]>>;
  setPeriod: (period: PenLeaderboardPeriod) => void;
  setPage: (page: number) => void;
  load: (period: PenLeaderboardPeriod) => Promise<void>;
  reset: () => void;
}
