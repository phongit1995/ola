import { create } from 'zustand';
import { formatDateDMY, toApiError, toast } from '@lib';
import { KenService } from '@services';
import type { KenTransaction } from '@app-types';

export const KEN_HISTORY_PAGE = 20;

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

interface KenHistorySection {
  items: KenTransaction[];
  groups: KenHistoryGroup[];
  total: number;
  page: number;
  loading: boolean;
}

interface KenHistoryState {
  sections: Record<KenHistoryTab, KenHistorySection>;
  load: (tab: KenHistoryTab, page: number) => Promise<void>;
  reset: () => void;
}

const emptySection: KenHistorySection = { items: [], groups: [], total: 0, page: 0, loading: false };

function emptySections(): Record<KenHistoryTab, KenHistorySection> {
  return { all: { ...emptySection }, credit: { ...emptySection }, debit: { ...emptySection } };
}

function dayKey(date: Date): string {
  return `${date.getFullYear()}-${date.getMonth()}-${date.getDate()}`;
}

function timeText(iso: string): string {
  const date = new Date(iso);
  if (Number.isNaN(date.getTime())) return '';
  return `${String(date.getHours()).padStart(2, '0')}:${String(date.getMinutes()).padStart(2, '0')}`;
}

function groupByDay(items: KenTransaction[]): KenHistoryGroup[] {
  const now = new Date();
  const todayKey = dayKey(now);
  const yesterdayKey = dayKey(new Date(now.getTime() - 86_400_000));
  const groups: KenHistoryGroup[] = [];
  for (const item of items) {
    const key = dayKey(new Date(item.createdAt));
    let group = groups[groups.length - 1];
    if (group == null || group.key !== key) {
      group = {
        key,
        dayLabel: key === todayKey ? 'today' : key === yesterdayKey ? 'yesterday' : null,
        dateText: formatDateDMY(item.createdAt),
        rows: [],
      };
      groups.push(group);
    }
    group.rows.push({ ...item, timeText: timeText(item.createdAt) });
  }
  return groups;
}

export const useKenHistoryStore = create<KenHistoryState>((set, get) => ({
  sections: emptySections(),
  load: async (tab, page) => {
    if (get().sections[tab].loading) return;
    set((state) => ({
      sections: { ...state.sections, [tab]: { ...state.sections[tab], loading: true } },
    }));
    try {
      const res = await KenService.history({
        limit: KEN_HISTORY_PAGE,
        offset: page * KEN_HISTORY_PAGE,
        ...(tab === 'all' ? {} : { direction: tab }),
      });
      set((state) => ({
        sections: {
          ...state.sections,
          [tab]: { items: res.items, groups: groupByDay(res.items), total: res.total, page, loading: false },
        },
      }));
    } catch (e) {
      set((state) => ({
        sections: { ...state.sections, [tab]: { ...state.sections[tab], loading: false } },
      }));
      toast.error(toApiError(e).message);
    }
  },
  reset: () => set({ sections: emptySections() }),
}));
