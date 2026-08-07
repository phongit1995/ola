import type {
  PenHistorySection,
  PenHistorySectionState,
} from '../../types/client/penHistory.type';

const emptyPenHistorySection: PenHistorySectionState = {
  items: [],
  page: 0,
  total: 0,
  loading: true,
};

export function createEmptyPenHistorySections(): Record<
  PenHistorySection,
  PenHistorySectionState
> {
  return {
    shoot: { ...emptyPenHistorySection },
    catch: { ...emptyPenHistorySection },
    all: { ...emptyPenHistorySection },
  };
}
