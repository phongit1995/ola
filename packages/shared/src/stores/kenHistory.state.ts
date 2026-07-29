import type {
  KenHistorySection,
  KenHistoryTab,
} from '../types/client/kenHistory.type';

const emptyKenHistorySection: KenHistorySection = {
  items: [],
  groups: [],
  total: 0,
  page: 0,
  loading: false,
};

export function createEmptyKenHistorySections(): Record<
  KenHistoryTab,
  KenHistorySection
> {
  return {
    all: { ...emptyKenHistorySection },
    credit: { ...emptyKenHistorySection },
    debit: { ...emptyKenHistorySection },
  };
}
