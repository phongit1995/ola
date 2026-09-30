import { useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import { Avatar, Dialog, Spinner, UserName } from '@components';
import { colorForName } from '@lib';
import type { WordChainLeaderboardEntry } from '@app-types';
import { useWordChainStore } from '@ola/shared/stores/word-chain/wordChainStore';

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
  highlighted,
}: {
  entry: WordChainLeaderboardEntry;
  highlighted: boolean;
}) {
  const { t } = useTranslation();
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
      <UserName
        name={entry.username}
        fullName={entry.fullName}
        className="min-w-0 flex-1 truncate text-sm text-black/87"
      />
      <span className="shrink-0 text-sm font-semibold text-ola-primary-ink tabular-nums">
        {t('wordChain.points', { value: entry.points })}
      </span>
    </li>
  );
}

export function WordChainLeaderboardDialog({
  open,
  onClose,
}: WordChainLeaderboardDialogProps) {
  const { t } = useTranslation();
  const leaderboard = useWordChainStore((state) => state.leaderboard);
  const loading = useWordChainStore((state) => state.leaderboardLoading);
  const fetchLeaderboard = useWordChainStore((state) => state.fetchLeaderboard);

  useEffect(() => {
    if (open) void fetchLeaderboard();
  }, [open, fetchLeaderboard]);

  const me = leaderboard?.me ?? null;
  const items = leaderboard?.items ?? [];

  return (
    <Dialog
      open={open}
      onClose={onClose}
      title={t('wordChain.leaderboardTitle')}
      showClose
    >
      {loading && leaderboard == null ? (
        <div className="flex justify-center py-6">
          <Spinner size={28} />
        </div>
      ) : items.length === 0 ? (
        <p className="py-6 text-center text-sm text-black/54">
          {t('wordChain.leaderboardEmpty')}
        </p>
      ) : (
        <div className="flex flex-col gap-2">
          <ul className="-mx-2 max-h-[60vh] divide-y divide-black/6 overflow-y-auto">
            {items.map((entry) => (
              <LeaderboardRow
                key={entry.userId}
                entry={entry}
                highlighted={entry.userId === me?.userId}
              />
            ))}
          </ul>
          {me != null && (
            <div className="-mx-2 border-t border-black/12 pt-2">
              <p className="px-3 pb-1 text-xs font-medium text-black/45 uppercase">
                {t('wordChain.leaderboardMe')}
              </p>
              <ul>
                <LeaderboardRow entry={me} highlighted />
              </ul>
            </div>
          )}
          <p className="text-center text-xs text-black/45">
            {t('wordChain.leaderboardTotal', { value: leaderboard?.total ?? 0 })}
          </p>
        </div>
      )}
    </Dialog>
  );
}
