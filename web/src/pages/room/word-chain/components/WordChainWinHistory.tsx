import { useEffect, useMemo, useState } from 'react';
import { Trans, useTranslation } from 'react-i18next';
import { Spinner } from '@components';
import { createTimeFormatter } from '@lib';
import type { WordChainWin } from '@app-types';
import { useAuthStore } from '@/store/authStore';
import { useWordChainStore } from '@ola/shared/stores/word-chain/wordChainStore';
import { WordChainListStatus, WordChainUserRow } from './WordChainList';
import { WordChainStatusIcon } from './WordChainStatusIcon';
import { WordChainTabs } from './WordChainTabs';
import { WORD_CHAIN_PANEL_HEIGHT } from './wordChainLayout';

type WinFilter = 'all' | 'mine';

const WIN_TEXT_COMPONENTS = {
  mention: <strong className="font-semibold text-black/87" />,
  word: <strong className="font-semibold text-ola-primary-ink" />,
};

function WinRow({
  win,
  highlighted,
  formatTime,
}: {
  win: WordChainWin;
  highlighted: boolean;
  formatTime: (iso: string) => string;
}) {
  const { t } = useTranslation();
  return (
    <WordChainUserRow
      name={win.username}
      avatar={win.avatar}
      highlighted={highlighted}
      trailing={
        <WordChainStatusIcon status="win" className="h-6 w-6" decorative />
      }
    >
      <span className="truncate text-sm text-black/80">
        <Trans
          i18nKey="wordChain.winHistoryItem"
          values={{ name: win.username, word: win.word }}
          components={WIN_TEXT_COMPONENTS}
        />
      </span>
      <span className="truncate text-xs text-black/45">
        {t('wordChain.winHistoryFrom', { word: win.previousWord })} ·{' '}
        {formatTime(win.createdAt)}
      </span>
    </WordChainUserRow>
  );
}

export function WordChainWinHistory() {
  const { t, i18n } = useTranslation();
  const [filter, setFilter] = useState<WinFilter>('all');
  const currentUserId = useAuthStore((store) => store.user?.id);
  const wins = useWordChainStore((store) => store.wins);
  const hasMore = useWordChainStore((store) => store.winsHasMore);
  const loading = useWordChainStore((store) => store.winsLoading);
  const failed = useWordChainStore((store) => store.winsFailed);
  const fetchWins = useWordChainStore((store) => store.fetchWins);
  const formatTime = useMemo(
    () => createTimeFormatter(i18n.language),
    [i18n.language]
  );
  const mine = filter === 'mine';

  useEffect(() => {
    void fetchWins({ mine });
  }, [mine, fetchWins]);

  const filters = [
    { key: 'all' as const, label: t('wordChain.winHistoryAll') },
    { key: 'mine' as const, label: t('wordChain.winHistoryMine') },
  ];

  return (
    <div className={`flex flex-col gap-2 ${WORD_CHAIN_PANEL_HEIGHT}`}>
      <WordChainTabs
        variant="chips"
        items={filters}
        value={filter}
        onChange={setFilter}
      />
      {wins.length === 0 ? (
        <WordChainListStatus
          loading={loading}
          failed={failed}
          emptyText={t(
            mine ? 'wordChain.winHistoryMineEmpty' : 'wordChain.winHistoryEmpty'
          )}
          errorText={t('wordChain.winsError')}
          onRetry={() => void fetchWins({ mine })}
        />
      ) : (
        <div className="-mx-2 min-h-0 flex-1 overflow-y-auto">
          <ul className="divide-y divide-black/6">
            {wins.map((win) => (
              <WinRow
                key={win.id}
                win={win}
                highlighted={win.userId === currentUserId}
                formatTime={formatTime}
              />
            ))}
          </ul>
          {hasMore && (
            <button
              type="button"
              disabled={loading}
              onClick={() => void fetchWins({ mine, more: true })}
              className="flex w-full items-center justify-center py-3 text-sm font-medium text-ola-primary-ink hover:bg-black/5 disabled:opacity-60"
            >
              {loading ? <Spinner size={16} /> : t('wordChain.winHistoryMore')}
            </button>
          )}
        </div>
      )}
    </div>
  );
}
