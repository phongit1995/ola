import { useTranslation } from 'react-i18next';
import {
  Avatar,
  CharmIcon,
  FullScreenOverlay,
  ScreenHeader,
  Spinner,
  UserName,
} from '@components';
import {
  GIFT_LEADERBOARD_PERIOD_LABEL,
  GIFT_LEADERBOARD_PERIODS,
  GIFT_LEADERBOARD_PODIUM_SIZE,
  GIFT_LEADERBOARD_TYPE,
  GIFT_LEADERBOARD_TYPE_TABS,
  GIFT_PODIUM_MEDALS,
} from '@constants';
import { useGiftLeaderboard } from '@ola/shared/stores/gift/useGiftLeaderboard';
import { cn, colorForName, formatKen } from '@lib';

interface GiftLeaderboardPageProps {
  onClose: () => void;
  z?: 40 | 50 | 60;
}

export function GiftLeaderboardPage({ onClose, z }: GiftLeaderboardPageProps) {
  const { t } = useTranslation();
  const { type, period, selectType, selectPeriod, board, failed } =
    useGiftLeaderboard();

  function valueText(value: number): string {
    return type === GIFT_LEADERBOARD_TYPE.sender
      ? t('gift.leaderboard.kenValue', { value: formatKen(value) })
      : t('gift.leaderboard.charmValue', { value: formatKen(value) });
  }

  return (
    <FullScreenOverlay z={z}>
      <ScreenHeader title={t('gift.leaderboard.title')} onBack={onClose} />

      <div className="bg-linear-to-b from-ola-accent to-ola-marriage px-3 pt-3 pb-4 text-white">
        <div className="flex rounded-full bg-white/20 p-1">
          {GIFT_LEADERBOARD_TYPE_TABS.map((tab) => (
            <button
              key={tab.value}
              type="button"
              onClick={() => selectType(tab.value)}
              className={cn(
                'flex-1 rounded-full py-1.5 text-sm font-semibold transition-colors',
                tab.value === type
                  ? 'bg-white text-ola-accent-dark shadow'
                  : 'text-white/90'
              )}
            >
              {t(tab.labelKey)}
            </button>
          ))}
        </div>
        <div className="mt-3 flex justify-center gap-2">
          {GIFT_LEADERBOARD_PERIODS.map((value) => (
            <button
              key={value}
              type="button"
              onClick={() => selectPeriod(value)}
              className={cn(
                'rounded-full border px-3 py-0.5 text-xs font-medium',
                value === period
                  ? 'border-white bg-white/25'
                  : 'border-white/50 text-white/85'
              )}
            >
              {t(GIFT_LEADERBOARD_PERIOD_LABEL[value])}
            </button>
          ))}
        </div>
      </div>

      <div className="flex-1 overflow-y-auto">
        {board == null ? (
          <div className="flex justify-center py-10">
            {failed ? (
              <span className="text-sm text-black/54">
                {t('gift.loadFailed')}
              </span>
            ) : (
              <Spinner size={24} />
            )}
          </div>
        ) : board.items.length === 0 ? (
          <p className="py-16 text-center text-sm text-black/54">
            {t('gift.leaderboard.empty')}
          </p>
        ) : (
          <ol className="divide-y divide-black/6 bg-white">
            {board.items.map((entry) => {
              const name = entry.user.fullName || entry.user.username;
              const podium = entry.rank <= GIFT_LEADERBOARD_PODIUM_SIZE;
              return (
                <li
                  key={entry.user.id}
                  className="flex items-center gap-3 px-4 py-2.5"
                >
                  <span
                    className={cn(
                      'w-7 text-center font-bold',
                      podium ? 'text-xl' : 'text-sm text-black/45'
                    )}
                  >
                    {podium ? GIFT_PODIUM_MEDALS[entry.rank - 1] : entry.rank}
                  </span>
                  <Avatar
                    name={name}
                    src={entry.user.avatar}
                    color={colorForName(name)}
                    size={podium ? 44 : 36}
                  />
                  <span className="flex min-w-0 flex-1">
                    <UserName
                      name={entry.user.username}
                      fullName={entry.user.fullName}
                      className="min-w-0 truncate text-sm font-medium text-black/87"
                    />
                  </span>
                  <span className="flex items-center gap-1 text-sm font-semibold text-ola-accent-dark">
                    {type !== GIFT_LEADERBOARD_TYPE.sender && <CharmIcon />}
                    {valueText(entry.value)}
                  </span>
                </li>
              );
            })}
          </ol>
        )}
      </div>

      {board != null && (
        <div className="flex items-center gap-3 border-t border-black/10 bg-white px-4 py-3 shadow-[0_-2px_8px_rgba(0,0,0,0.06)]">
          <span className="text-sm text-black/54">
            {t('gift.leaderboard.myRank')}
          </span>
          <span className="text-base font-bold text-black/87">
            {board.me.rank > 0
              ? `#${board.me.rank}`
              : t('gift.leaderboard.notRanked')}
          </span>
          <span className="flex-1" />
          <span className="flex items-center gap-1 text-sm font-semibold text-ola-accent-dark">
            {type !== GIFT_LEADERBOARD_TYPE.sender && <CharmIcon />}
            {valueText(board.me.value)}
          </span>
        </div>
      )}
    </FullScreenOverlay>
  );
}
