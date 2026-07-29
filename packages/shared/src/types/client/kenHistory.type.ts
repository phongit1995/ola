import type { KenTransaction } from '../api/ken.type';

export type KenHistoryTab = 'all' | 'credit' | 'debit';

export interface KenHistoryRow extends KenTransaction {
  timeText: string;
}

export interface KenHistoryGroup {
  key: string;
  dayLabel: 'today' | 'yesterday' | null;
  dateText: string;
  rows: KenHistoryRow[];
}

export interface KenHistorySection {
  items: KenTransaction[];
  groups: KenHistoryGroup[];
  total: number;
  page: number;
  loading: boolean;
}

export interface KenHistoryState {
  sections: Record<KenHistoryTab, KenHistorySection>;
  load: (tab: KenHistoryTab, page: number) => Promise<void>;
  reset: () => void;
}
