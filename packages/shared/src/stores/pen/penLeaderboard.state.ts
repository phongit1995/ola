import type { PenLeaderboardState } from '../../types/client/pen.type';

export const initialPenLeaderboardState: Pick<
  PenLeaderboardState,
  'period' | 'page' | 'loading' | 'cache'
> = {
  period: 'day',
  page: 0,
  loading: false,
  cache: {},
};
