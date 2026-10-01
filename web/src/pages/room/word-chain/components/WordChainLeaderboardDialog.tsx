import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Dialog, UserName } from '@components';
import {
  WORD_CHAIN_LEADERBOARD_PERIOD,
  WORD_CHAIN_LEADERBOARD_PERIOD_LABEL_KEYS,
  WORD_CHAIN_LEADERBOARD_SORT,
  WORD_CHAIN_LEADERBOARD_TABS,
} from '@constants';
import { wordChainLeaderboardKey } from '@lib';
import type {
  WordChainLeaderboardEntry,
  WordChainLeaderboardPeriod,
  WordChainLeaderboardSort,
  WordChainLeaderboardTab,
} from '@app-types';
import { useWordChainStore } from '@ola/shared/stores/word-chain/wordChainStore';
import { WordChainListStatus, WordChainUserRow } from './WordChainList';
import { WordChainTabs } from './WordChainTabs';
import { WordChainWinHistory } from './WordChainWinHistory';
import { WORD_CHAIN_PANEL_HEIGHT } from './wordChainLayout';

const MEDALS = ['🥇', '🥈', '🥉'];

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
    <WordChainUserRow
      name={entry.username}
      avatar={entry.avatar}
      highlighted={highlighted}
      leading={<RankBadge rank={entry.rank} />}
      trailing={
        <span className="shrink-0 text-sm font-semibold text-ola-primary-ink tabular-nums">
          {byWins ? wins : points}
        </span>
      }
    >
      <UserName
        name={entry.username}
        fullName={entry.fullName}
        className="truncate text-sm text-black/87"
      />
      <span className="truncate text-xs text-black/45 tabular-nums">
        {byWins ? points : wins}
      </span>
    </WordChainUserRow>
  );
}

function LeaderboardPanel({
  sort,
  period,
  onPeriodChange,
}: {
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
  const failed = useWordChainStore((state) =>
    state.leaderboardFailed.includes(key)
  );
  const fetchLeaderboard = useWordChainStore((state) => state.fetchLeaderboard);

  useEffect(() => {
    void fetchLeaderboard({ sort, period });
  }, [sort, period, fetchLeaderboard]);

  const me = leaderboard?.me ?? null;
  const items = leaderboard?.items ?? [];
  const periods = Object.values(WORD_CHAIN_LEADERBOARD_PERIOD).map((item) => ({
    key: item,
    label: t(WORD_CHAIN_LEADERBOARD_PERIOD_LABEL_KEYS[item]),
  }));

  return (
    <div className={`flex flex-col gap-2 ${WORD_CHAIN_PANEL_HEIGHT}`}>
      <WordChainTabs
        variant="chips"
        items={periods}
        value={period}
        onChange={onPeriodChange}
      />
      {items.length === 0 ? (
        <WordChainListStatus
          loading={loading && leaderboard == null}
          failed={failed}
          emptyText={t(
            sort === WORD_CHAIN_LEADERBOARD_SORT.wins
              ? 'wordChain.winsEmpty'
              : 'wordChain.leaderboardEmpty'
          )}
          errorText={t('wordChain.leaderboardError')}
          onRetry={() => void fetchLeaderboard({ sort, period })}
        />
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
  const [tab, setTab] = useState<WordChainLeaderboardTab>(
    WORD_CHAIN_LEADERBOARD_SORT.wins
  );
  const [period, setPeriod] = useState<WordChainLeaderboardPeriod>(
    WORD_CHAIN_LEADERBOARD_PERIOD.all
  );
  const tabs = WORD_CHAIN_LEADERBOARD_TABS.map((item) => ({
    key: item.key,
    label: t(item.labelKey),
  }));

  return (
    <Dialog
      open={open}
      onClose={onClose}
      title={t('wordChain.leaderboardTitle')}
      showClose
    >
      <div className="flex flex-col gap-3">
        <WordChainTabs
          variant="segmented"
          items={tabs}
          value={tab}
          onChange={setTab}
        />
        {tab === 'history' ? (
          <WordChainWinHistory />
        ) : (
          <LeaderboardPanel
            sort={tab}
            period={period}
            onPeriodChange={setPeriod}
          />
        )}
      </div>
    </Dialog>
  );
}
