import { create } from 'zustand';
import { KEN_HISTORY_PAGE_SIZE } from '../../constants/ken';
import { toApiError } from '../../lib/apiError';
import { formatClockHM, formatDateDMY } from '../../lib/datetime';
import { toast } from '../../lib/toast';
import { KenService } from '../../services/ken.service';
import type { KenTransaction } from '../../types/api/ken.type';
import type {
  KenHistoryGroup,
  KenHistoryState,
} from '../../types/client/kenHistory.type';
import { createEmptyKenHistorySections } from './kenHistory.state';

export { KEN_HISTORY_PAGE_SIZE as KEN_HISTORY_PAGE } from '../../constants/ken';
export type {
  KenHistoryGroup,
  KenHistoryRow,
  KenHistoryTab,
} from '../../types/client/kenHistory.type';

function dayKey(date: Date): string {
  return `${date.getFullYear()}-${date.getMonth()}-${date.getDate()}`;
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
    group.rows.push({ ...item, timeText: formatClockHM(item.createdAt) });
  }
  return groups;
}

export const useKenHistoryStore = create<KenHistoryState>((set, get) => ({
  sections: createEmptyKenHistorySections(),
  load: async (tab, page) => {
    if (get().sections[tab].loading) return;
    set((state) => ({
      sections: { ...state.sections, [tab]: { ...state.sections[tab], loading: true } },
    }));
    try {
      const res = await KenService.history({
        limit: KEN_HISTORY_PAGE_SIZE,
        offset: page * KEN_HISTORY_PAGE_SIZE,
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
  reset: () => set({ sections: createEmptyKenHistorySections() }),
}));
