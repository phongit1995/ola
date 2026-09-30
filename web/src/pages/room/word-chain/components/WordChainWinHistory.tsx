import { useEffect, useMemo, useState } from 'react';
import { Trans, useTranslation } from 'react-i18next';
import { Avatar, Spinner } from '@components';
import { colorForName, createTimeFormatter } from '@lib';
import type { WordChainWin } from '@app-types';
import { useAuthStore } from '@/store/authStore';
import { useWordChainStore } from '@ola/shared/stores/word-chain/wordChainStore';
import { WordChainFilterChips } from './WordChainTabs';
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
    <li
      className={`flex items-center gap-2 px-3 py-2 ${
        highlighted ? 'bg-ola-primary-light' : ''
      }`}
    >
      <Avatar
        name={win.username}
        color={colorForName(win.username)}
        src={win.avatar}
        size={36}
      />
      <span className="flex min-w-0 flex-1 flex-col">
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
      </span>
      <span aria-hidden="true" className="shrink-0 text-lg">
        🏆
      </span>
    </li>
  );
}

export function WordChainWinHistory({ open }: { open: boolean }) {
  const { t, i18n } = useTranslation();
  const [filter, setFilter] = useState<WinFilter>('all');
  const currentUserId = useAuthStore((store) => store.user?.id);
  const wins = useWordChainStore((store) => store.wins);
  const hasMore = useWordChainStore((store) => store.winsHasMore);
  const loading = useWordChainStore((store) => store.winsLoading);
  const fetchWins = useWordChainStore((store) => store.fetchWins);
  const formatTime = useMemo(
    () => createTimeFormatter(i18n.language),
    [i18n.language]
  );
  const mine = filter === 'mine';

  useEffect(() => {
    if (open) void fetchWins({ mine });
  }, [open, mine, fetchWins]);

  const filters = [
    { key: 'all' as const, label: t('wordChain.winHistoryAll') },
    { key: 'mine' as const, label: t('wordChain.winHistoryMine') },
  ];

  return (
    <div className={`flex flex-col gap-2 ${WORD_CHAIN_PANEL_HEIGHT}`}>
      <WordChainFilterChips
        items={filters}
        value={filter}
        onChange={setFilter}
      />
      {wins.length === 0 ? (
        <div className="flex min-h-0 flex-1 items-center justify-center text-center text-sm text-black/54">
          {loading ? (
            <Spinner size={28} />
          ) : (
            t(
              mine
                ? 'wordChain.winHistoryMineEmpty'
                : 'wordChain.winHistoryEmpty'
            )
          )}
        </div>
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
