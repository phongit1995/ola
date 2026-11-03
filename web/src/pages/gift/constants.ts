import type { ParseKeys } from 'i18next';
import type { GiftHistoryDirection, GiftLeaderboardPeriod, GiftLeaderboardType } from '@app-types';

export const LEADERBOARD_TYPE_TABS: { value: GiftLeaderboardType; labelKey: ParseKeys }[] = [
  { value: 'receiver', labelKey: 'gift.leaderboard.receiver' },
  { value: 'sender', labelKey: 'gift.leaderboard.sender' },
];

export const LEADERBOARD_PERIOD_LABEL: Record<GiftLeaderboardPeriod, ParseKeys> = {
  week: 'gift.leaderboard.week',
  month: 'gift.leaderboard.month',
  all: 'gift.leaderboard.all',
};

export const HISTORY_TABS: { value: GiftHistoryDirection; labelKey: ParseKeys }[] = [
  { value: 'received', labelKey: 'gift.history.received' },
  { value: 'sent', labelKey: 'gift.history.sent' },
];

export const PODIUM_MEDALS = ['🥇', '🥈', '🥉'];
