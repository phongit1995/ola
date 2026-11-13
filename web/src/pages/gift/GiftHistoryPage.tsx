import { useTranslation } from 'react-i18next';
import {
  CharmIcon,
  FullScreenOverlay,
  ScreenHeader,
  Spinner,
  UserName,
} from '@components';
import { AvatarWithFrame } from '@components/ui/AvatarWithFrame';
import { GIFT_HISTORY_DIRECTION, GIFT_HISTORY_TABS } from '@constants';
import { useGiftHistory } from '@ola/shared/stores/gift/useGiftHistory';
import {
  cn,
  colorForName,
  formatCompactDateTime,
  formatKen,
  randomUuid,
} from '@lib';
import type { GiftHistoryItem, GiftUserBrief } from '@app-types';
import kenIcon from '@/assets/icons/apps/ken.png';
import { useGiftAnimationStore } from '@ola/shared/stores/gift/giftAnimationStore';

interface GiftHistoryPageProps {
  onClose: () => void;
  onOpenUser?: (user: GiftUserBrief) => void;
  z?: 40 | 50 | 60;
}

function CharmPill({ value }: { value: number }) {
  return (
    <span className="flex items-center gap-1 rounded-full bg-ola-accent/10 py-0.5 pr-1.5 pl-2 text-xs font-semibold text-ola-accent-dark">
      +{formatKen(value)}
      <CharmIcon className="h-3.5 w-3.5" />
    </span>
  );
}

export function GiftHistoryPage({
  onClose,
  onOpenUser,
  z,
}: GiftHistoryPageProps) {
  const { t } = useTranslation();
  const { direction, selectDirection, items, done, loading, loadMore } =
    useGiftHistory();
  const received = direction === GIFT_HISTORY_DIRECTION.received;
  const play = useGiftAnimationStore((s) => s.play);

  function replay(item: GiftHistoryItem) {
    play({
      id: randomUuid(),
      imageUrl: item.giftImageUrl,
      animation: item.giftAnimation,
      name: item.giftName,
      quantity: item.quantity,
      charmPoints: item.charmPoints,
    });
  }

  return (
    <FullScreenOverlay z={z}>
      <ScreenHeader title={t('gift.wall.history')} onBack={onClose} />
      <div className="flex border-b border-black/10 bg-white">
        {GIFT_HISTORY_TABS.map((tab) => (
          <button
            key={tab.value}
            type="button"
            onClick={() => selectDirection(tab.value)}
            className={cn(
              'flex-1 border-b-2 py-2.5 text-sm font-medium',
              tab.value === direction
                ? 'border-ola-accent text-ola-accent-dark'
                : 'border-transparent text-black/54'
            )}
          >
            {t(tab.labelKey)}
          </button>
        ))}
      </div>

      <div className="flex-1 overflow-y-auto">
        {items.length === 0 ? (
          <div className="flex justify-center py-12">
            {loading || !done ? (
              <Spinner size={24} />
            ) : (
              <span className="text-sm text-black/54">
                {t('gift.history.empty')}
              </span>
            )}
          </div>
        ) : (
          <ul className="divide-y divide-black/6 bg-white">
            {items.map((item) => {
              const { fullName, username, avatar, avatarFrameId } =
                item.counterparty;
              const name = fullName || username;
              return (
                <li key={item.id} className="flex items-start gap-3 px-4 py-3">
                  <button
                    type="button"
                    onClick={() => onOpenUser?.(item.counterparty)}
                    disabled={onOpenUser == null}
                    aria-label={name}
                    className="relative shrink-0 rounded-full active:opacity-70"
                  >
                    <AvatarWithFrame
                      name={name}
                      src={avatar}
                      color={colorForName(name)}
                      size={44}
                      frameId={avatarFrameId}
                    />
                    <span
                      aria-hidden="true"
                      className={cn(
                        'absolute -right-1 -bottom-1 flex h-5 w-5 items-center justify-center rounded-full text-xs leading-none font-bold text-white ring-2 ring-white',
                        received ? 'bg-ola-accent' : 'bg-ola-warning'
                      )}
                    >
                      {received ? '↙' : '↗'}
                    </span>
                  </button>
                  <div className="min-w-0 flex-1">
                    <div className="flex items-center gap-2">
                      <button
                        type="button"
                        onClick={() => onOpenUser?.(item.counterparty)}
                        disabled={onOpenUser == null}
                        className="flex min-w-0 flex-1 text-left active:opacity-70"
                      >
                        <UserName
                          name={username}
                          fullName={fullName}
                          className="min-w-0 truncate text-sm font-semibold text-black/87"
                          fullNameClassName="font-normal text-black/45"
                        />
                      </button>
                      <span className="shrink-0 text-xs text-black/45">
                        {formatCompactDateTime(item.createdAt)}
                      </span>
                    </div>
                    <p className="mt-0.5 text-sm text-black/60">
                      {received ? t('gift.messageIn') : t('gift.messageOut')}{' '}
                      <span className="font-semibold text-black/87">
                        {item.giftName}
                      </span>{' '}
                      <span
                        className={cn(
                          'font-semibold',
                          received ? 'text-ola-accent' : 'text-ola-warning'
                        )}
                      >
                        {t('gift.quantityTimes', { count: item.quantity })}
                      </span>
                    </p>
                    {item.note != null && item.note !== '' && (
                      <p className="mt-1.5 rounded-lg bg-black/4 px-2.5 py-1.5 text-sm break-words text-black/70">
                        {item.note}
                      </p>
                    )}
                    <div className="mt-1.5 flex items-center gap-2">
                      {received ? (
                        <CharmPill value={item.charmPoints} />
                      ) : (
                        <span className="flex items-center gap-1 rounded-full bg-ola-warning/12 px-2 py-0.5 text-xs font-semibold text-ola-warning">
                          <img
                            src={kenIcon}
                            alt=""
                            className="h-3.5 w-3.5 object-contain"
                          />
                          −{formatKen(item.totalKen)}
                        </span>
                      )}
                      {!received && (item.senderCharmPoints ?? 0) > 0 && (
                        <CharmPill value={item.senderCharmPoints ?? 0} />
                      )}
                    </div>
                  </div>
                  <button
                    type="button"
                    onClick={() => replay(item)}
                    aria-label={item.giftName}
                    className="shrink-0 rounded-xl p-0.5 transition-transform active:scale-90"
                  >
                    <img
                      src={item.giftImageUrl}
                      alt=""
                      className="h-20 w-20 object-contain drop-shadow-[0_2px_3px_rgba(0,0,0,0.15)]"
                    />
                  </button>
                </li>
              );
            })}
          </ul>
        )}
        {items.length > 0 && !done && (
          <div className="flex justify-center py-3">
            {loading ? (
              <Spinner size={20} />
            ) : (
              <button
                type="button"
                onClick={loadMore}
                className="text-sm font-medium text-ola-primary-darker"
              >
                {t('gift.history.loadMore')}
              </button>
            )}
          </div>
        )}
      </div>
    </FullScreenOverlay>
  );
}
