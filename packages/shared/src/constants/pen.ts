import type { PenStatus } from '../types/api/pen.type';
import type { PenHistorySection, PenRowOutcome } from '../types/client/penHistory.type';

export const PEN_SHOTS_PAGE_SIZE = 10;
export const PEN_SHOTS_MOBILE_PAGE_SIZE = 12;
export const PEN_HISTORY_PAGE_SIZE = 10;
export const PEN_LEADERBOARD_PAGE_SIZE = 10;

export const PEN_STATUS = {
  open: 'open',
  settled: 'settled',
  cancelled: 'cancelled',
} as const satisfies Record<string, PenStatus>;

export const PEN_ROW_OUTCOME = {
  win: 'win',
  lose: 'lose',
  pending: 'pending',
  cancelled: 'cancelled',
} as const satisfies Record<string, PenRowOutcome>;

export const PEN_HISTORY_SECTION = {
  shoot: 'shoot',
  catch: 'catch',
  all: 'all',
} as const satisfies Record<string, PenHistorySection>;
