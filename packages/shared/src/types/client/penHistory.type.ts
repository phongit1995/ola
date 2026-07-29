import type { PenShotView, PenSide, PenUserBrief } from '../api/pen.type';

export type PenHistorySection = 'shoot' | 'catch' | 'all';

export type PenRowOutcome = 'win' | 'lose' | 'pending' | 'cancelled';

export interface PenHistoryRowView {
  id: string;
  opponent?: PenUserBrief;
  side?: PenSide;
  bet: number;
  date: string;
  time: string;
  outcome: PenRowOutcome;
  amount: number;
}

export interface PenAllHistoryRowView {
  id: string;
  shooter?: PenUserBrief;
  keeper?: PenUserBrief;
  winnerId?: string;
  bet: number;
  date: string;
  time: string;
}

export interface PenHistorySectionState {
  items: PenShotView[];
  page: number;
  total: number;
  loading: boolean;
}

export interface PenHistoryState {
  sections: Record<PenHistorySection, PenHistorySectionState>;
  load: (section: PenHistorySection, page: number) => Promise<void>;
  reset: () => void;
}
