import type { ReactNode } from 'react';
import { useTranslation } from 'react-i18next';
import kenIcon from '@/assets/icons/apps/ken.png';
import rankBadge1 from '@/assets/icons/gift/gift-rank-1.webp';
import rankBadge2 from '@/assets/icons/gift/gift-rank-2.webp';
import rankBadge3 from '@/assets/icons/gift/gift-rank-3.webp';
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
} from '@constants';
import { useGiftLeaderboard } from '@ola/shared/stores/gift/useGiftLeaderboard';
import type { GiftLeaderboardEntry } from '@app-types';
import { cn, colorForName, formatKen } from '@lib';
import { useAuthStore } from '@/store/authStore';

interface GiftLeaderboardPageProps {
  onClose: () => void;
  z?: 40 | 50 | 60;
}

const PODIUM_POP_DELAY_MS = 180;
const ROW_BASE_DELAY_MS = 420;
const ROW_STAGGER_MS = 35;
const ROW_STAGGER_MAX_INDEX = 12;

interface PodiumSlotStyle {
  rank: number;
  delayMs: number;
  avatarSize: number;
  ring: string;
  block: string;
  badge: string;
  badgeHeight: number;
}

const PODIUM_SLOTS: PodiumSlotStyle[] = [
  {
    rank: 2,
    delayMs: 120,
    avatarSize: 60,
    ring: 'ring-[#aab3c2]',
    block: 'h-16 from-[#e3e7ee] to-[#f3f5f8]',
    badge: rankBadge2,
    badgeHeight: 44,
  },
  {
    rank: 1,
    delayMs: 240,
    avatarSize: 76,
    ring: 'ring-[#f5b301]',
    block: 'h-20 from-[#ffe9a8] to-[#fff6dc]',
    badge: rankBadge1,
    badgeHeight: 60,
  },
  {
    rank: 3,
    delayMs: 0,
    avatarSize: 60,
    ring: 'ring-[#d0894a]',
    block: 'h-13 from-[#f6d9bf] to-[#fcefe3]',
    badge: rankBadge3,
    badgeHeight: 44,
  },
];

function PodiumSlot({
  slot,
  entry,
  value,
}: {
  slot: PodiumSlotStyle;
  entry: GiftLeaderboardEntry | undefined;
  value: ReactNode;
}) {
  const name =
    entry == null ? '' : entry.user.fullName || entry.user.username;
  return (
    <div className="flex min-w-0 flex-1 flex-col items-center">
      <div
        className="flex w-full animate-gift-rank-pop flex-col items-center"
        style={{ animationDelay: `${slot.delayMs + PODIUM_POP_DELAY_MS}ms` }}
      >
        {entry == null ? (
          <span
            className="rounded-full border-2 border-dashed border-black/15"
            style={{ width: slot.avatarSize, height: slot.avatarSize }}
          />
        ) : (
          <span className={cn('rounded-full ring-3', slot.ring)}>
            <Avatar
              name={name}
              src={entry.user.avatar}
              color={colorForName(name)}
              size={slot.avatarSize}
            />
          </span>
        )}
        <span className="mt-2.5 w-full truncate px-1 text-center text-sm font-semibold text-black/87">
          {entry == null ? '—' : `@${entry.user.username}`}
        </span>
        <span className="mt-0.5 mb-2 flex h-5 items-center gap-1 text-sm font-bold text-black/87">
          {value}
        </span>
      </div>
      <span
        className={cn(
          'flex w-full origin-bottom animate-gift-rank-rise items-center justify-center rounded-t-lg bg-linear-to-b',
          slot.block
        )}
        style={{ animationDelay: `${slot.delayMs}ms` }}
      >
        <img
          src={slot.badge}
          alt={String(slot.rank)}
          className="object-contain"
          style={{ height: slot.badgeHeight }}
        />
      </span>
    </div>
  );
}

export function GiftLeaderboardPage({ onClose, z }: GiftLeaderboardPageProps) {
  const { t } = useTranslation();
  const me = useAuthStore((s) => s.user);
  const { type, period, selectType, selectPeriod, board, failed } =
    useGiftLeaderboard();
  const myName = me?.fullName || me?.username || '';
  const myBadge = PODIUM_SLOTS.find((slot) => slot.rank === board?.me.rank)?.badge;
  const restEntries =
    board?.items.filter(
      (entry) => entry.rank > GIFT_LEADERBOARD_PODIUM_SIZE
    ) ?? [];

  function renderValue(value: number) {
    return (
      <>
        {formatKen(value)}
        {type === GIFT_LEADERBOARD_TYPE.sender ? (
          <img
            src={kenIcon}
            alt=""
            aria-hidden="true"
            className="h-4 w-4 shrink-0 object-contain"
          />
        ) : (
          <CharmIcon />
        )}
      </>
    );
  }

  return (
    <FullScreenOverlay z={z}>
      <ScreenHeader title={t('gift.leaderboard.title')} onBack={onClose} />

      <div className="flex border-b border-black/10 bg-white">
        {GIFT_LEADERBOARD_TYPE_TABS.map((tab) => (
          <button
            key={tab.value}
            type="button"
            onClick={() => selectType(tab.value)}
            className={cn(
              'flex-1 border-b-2 py-2.5 text-sm font-medium',
              tab.value === type
                ? 'border-ola-accent text-ola-accent-dark'
                : 'border-transparent text-black/54'
            )}
          >
            {t(tab.labelKey)}
          </button>
        ))}
      </div>

      <div className="flex-1 overflow-y-auto bg-white">
        <div className="flex justify-center gap-2 pt-3">
          {GIFT_LEADERBOARD_PERIODS.map((value) => (
            <button
              key={value}
              type="button"
              onClick={() => selectPeriod(value)}
              className={cn(
                'rounded-full px-3 py-1 text-xs font-medium',
                value === period
                  ? 'bg-ola-accent/10 text-ola-accent-dark'
                  : 'bg-black/4 text-black/54'
              )}
            >
              {t(GIFT_LEADERBOARD_PERIOD_LABEL[value])}
            </button>
          ))}
        </div>

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
          <div key={`${type}:${period}`}>
            <div className="flex items-end gap-1.5 border-b border-black/6 px-3 pt-6">
              {PODIUM_SLOTS.map((slot) => {
                const entry = board.items.find(
                  (item) => item.rank === slot.rank
                );
                return (
                  <PodiumSlot
                    key={slot.rank}
                    slot={slot}
                    entry={entry}
                    value={entry == null ? null : renderValue(entry.value)}
                  />
                );
              })}
            </div>
            <ol className="divide-y divide-black/6">
              {restEntries.map((entry, index) => {
                const name = entry.user.fullName || entry.user.username;
                const stagger = Math.min(index, ROW_STAGGER_MAX_INDEX);
                return (
                  <li
                    key={entry.user.id}
                    className="flex animate-ola-rise-in items-center gap-3 px-4 py-2.5"
                    style={{
                      animationDelay: `${ROW_BASE_DELAY_MS + stagger * ROW_STAGGER_MS}ms`,
                    }}
                  >
                    <span className="w-6 text-center text-sm font-semibold text-black/45">
                      {entry.rank}
                    </span>
                    <Avatar
                      name={name}
                      src={entry.user.avatar}
                      color={colorForName(name)}
                      size={36}
                    />
                    <span className="flex min-w-0 flex-1">
                      <UserName
                        name={`@${entry.user.username}`}
                        fullName={entry.user.fullName}
                        className="min-w-0 truncate text-sm font-medium text-black/87"
                        fullNameClassName="font-normal text-black/54"
                      />
                    </span>
                    <span className="flex items-center gap-1 text-sm font-bold text-black/87">
                      {renderValue(entry.value)}
                    </span>
                  </li>
                );
              })}
            </ol>
          </div>
        )}
      </div>

      {board != null && (
        <div className="flex items-center gap-3 border-t border-black/10 bg-white px-4 py-2.5 shadow-[0_-2px_8px_rgba(0,0,0,0.06)]">
          <span className="flex w-6 justify-center text-sm font-bold text-ola-accent-dark">
            {myBadge != null ? (
              <img
                src={myBadge}
                alt={String(board.me.rank)}
                className="h-7 object-contain"
              />
            ) : board.me.rank > 0 ? (
              board.me.rank
            ) : (
              '—'
            )}
          </span>
          <Avatar
            name={myName}
            src={me?.avatar}
            color={colorForName(myName)}
            size={36}
          />
          <span className="min-w-0 flex-1">
            <UserName
              name={`@${me?.username ?? ''}`}
              fullName={me?.fullName}
              className="block truncate text-sm font-semibold text-black/87"
              fullNameClassName="font-normal text-black/54"
            />
            <span className="block text-xs text-black/54">
              {board.me.rank > 0
                ? t('gift.leaderboard.myRank')
                : t('gift.leaderboard.notRanked')}
            </span>
          </span>
          <span className="flex items-center gap-1 text-sm font-bold text-black/87">
            {renderValue(board.me.value)}
          </span>
        </div>
      )}
    </FullScreenOverlay>
  );
}
