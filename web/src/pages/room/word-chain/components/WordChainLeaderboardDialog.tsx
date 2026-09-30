import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Avatar, Dialog, Spinner, UserName } from '@components';
import {
  WORD_CHAIN_LEADERBOARD_PERIOD,
  WORD_CHAIN_LEADERBOARD_SORT,
} from '@constants';
import { colorForName } from '@lib';
import type {
  WordChainLeaderboardEntry,
  WordChainLeaderboardPeriod,
  WordChainLeaderboardSort,
} from '@app-types';
import { useWordChainStore } from '@ola/shared/stores/word-chain/wordChainStore';
import { wordChainLeaderboardKey } from '@ola/shared/stores/word-chain/wordChainHelpers';
import { WordChainFilterChips, WordChainSegmentedTabs } from './WordChainTabs';
import { WordChainWinHistory } from './WordChainWinHistory';
import { WORD_CHAIN_PANEL_HEIGHT } from './wordChainLayout';

const MEDALS = ['🥇', '🥈', '🥉'];

type LeaderboardTab = WordChainLeaderboardSort | 'history';

const TABS = [
  {
    key: WORD_CHAIN_LEADERBOARD_SORT.points,
    labelKey: 'wordChain.leaderboardTabPoints',
  },
  {
    key: WORD_CHAIN_LEADERBOARD_SORT.wins,
    labelKey: 'wordChain.leaderboardTabWins',
  },
  { key: 'history', labelKey: 'wordChain.leaderboardTabHistory' },
] as const satisfies readonly { key: LeaderboardTab; labelKey: string }[];

const PERIOD_LABEL_KEYS = {
  day: 'wordChain.periodDay',
  week: 'wordChain.periodWeek',
  month: 'wordChain.periodMonth',
  all: 'wordChain.periodAll',
} as const satisfies Record<WordChainLeaderboardPeriod, string>;

interface WordChainLeaderboardDialogProps {
  open: boolean;
  onClose: () => void;
}

function RankBadge({ rank }: { rank: number }) {
  const medal = MEDALS[rank - 1];
  return (
    <span className="flex w-8 shrink-0 justify-center text-sm font-semibold text-black/54 tabular-nums">
      {medal ?? `#${rank}`}
    </span>
  );
}

function LeaderboardRow({
  entry,
  sort,
  highlighted,
}: {
  entry: WordChainLeaderboardEntry;
  sort: WordChainLeaderboardSort;
  highlighted: boolean;
}) {
  const { t } = useTranslation();
  const points = t('wordChain.points', { value: entry.points });
  const wins = t('wordChain.wins', { value: entry.wins });
  const byWins = sort === WORD_CHAIN_LEADERBOARD_SORT.wins;
  return (
    <li
      className={`flex items-center gap-2 px-3 py-2 ${
        highlighted ? 'bg-ola-primary-light' : ''
      }`}
    >
      <RankBadge rank={entry.rank} />
      <Avatar
        name={entry.username}
        color={colorForName(entry.username)}
        src={entry.avatar}
        size={36}
      />
      <span className="flex min-w-0 flex-1 flex-col">
        <UserName
          name={entry.username}
          fullName={entry.fullName}
          className="truncate text-sm text-black/87"
        />
        <span className="truncate text-xs text-black/45 tabular-nums">
          {byWins ? points : wins}
        </span>
      </span>
      <span className="shrink-0 text-sm font-semibold text-ola-primary-ink tabular-nums">
        {byWins ? wins : points}
      </span>
    </li>
  );
}

function LeaderboardPanel({
  open,
  sort,
  period,
  onPeriodChange,
}: {
  open: boolean;
  sort: WordChainLeaderboardSort;
  period: WordChainLeaderboardPeriod;
  onPeriodChange: (period: WordChainLeaderboardPeriod) => void;
}) {
  const { t } = useTranslation();
  const key = wordChainLeaderboardKey({ sort, period });
  const leaderboard = useWordChainStore((state) => state.leaderboards[key]);
  const loading = useWordChainStore((state) =>
    state.leaderboardPending.includes(key)
  );
  const fetchLeaderboard = useWordChainStore((state) => state.fetchLeaderboard);

  useEffect(() => {
    if (open) void fetchLeaderboard({ sort, period });
  }, [open, sort, period, fetchLeaderboard]);

  const me = leaderboard?.me ?? null;
  const items = leaderboard?.items ?? [];
  const periods = Object.values(WORD_CHAIN_LEADERBOARD_PERIOD).map((item) => ({
    key: item,
    label: t(PERIOD_LABEL_KEYS[item]),
  }));

  return (
    <div className={`flex flex-col gap-2 ${WORD_CHAIN_PANEL_HEIGHT}`}>
      <WordChainFilterChips
        items={periods}
        value={period}
        onChange={onPeriodChange}
      />
      {loading && leaderboard == null ? (
        <div className="flex min-h-0 flex-1 items-center justify-center">
          <Spinner size={28} />
        </div>
      ) : items.length === 0 ? (
        <p className="flex min-h-0 flex-1 items-center justify-center text-center text-sm text-black/54">
          {t(
            sort === WORD_CHAIN_LEADERBOARD_SORT.wins
              ? 'wordChain.winsEmpty'
              : 'wordChain.leaderboardEmpty'
          )}
        </p>
      ) : (
        <ul className="-mx-2 min-h-0 flex-1 divide-y divide-black/6 overflow-y-auto">
          {items.map((entry) => (
            <LeaderboardRow
              key={entry.userId}
              entry={entry}
              sort={sort}
              highlighted={entry.userId === me?.userId}
            />
          ))}
        </ul>
      )}
      {me != null && (
        <div className="-mx-2 border-t border-black/12 pt-2">
          <p className="px-3 pb-1 text-xs font-medium text-black/45 uppercase">
            {t('wordChain.leaderboardMe')}
          </p>
          <ul>
            <LeaderboardRow entry={me} sort={sort} highlighted />
          </ul>
        </div>
      )}
      {items.length > 0 && (
        <p className="text-center text-xs text-black/45">
          {t('wordChain.leaderboardTotal', { value: leaderboard?.total ?? 0 })}
        </p>
      )}
    </div>
  );
}

export function WordChainLeaderboardDialog({
  open,
  onClose,
}: WordChainLeaderboardDialogProps) {
  const { t } = useTranslation();
  const [tab, setTab] = useState<LeaderboardTab>(
    WORD_CHAIN_LEADERBOARD_SORT.points
  );
  const [period, setPeriod] = useState<WordChainLeaderboardPeriod>(
    WORD_CHAIN_LEADERBOARD_PERIOD.all
  );
  const tabs = TABS.map((item) => ({ key: item.key, label: t(item.labelKey) }));

  return (
    <Dialog
      open={open}
      onClose={onClose}
      title={t('wordChain.leaderboardTitle')}
      showClose
    >
      <div className="flex flex-col gap-3">
        <WordChainSegmentedTabs items={tabs} value={tab} onChange={setTab} />
        {tab === 'history' ? (
          <WordChainWinHistory open={open} />
        ) : (
          <LeaderboardPanel
            open={open}
            sort={tab}
            period={period}
            onPeriodChange={setPeriod}
          />
        )}
      </div>
    </Dialog>
  );
}
