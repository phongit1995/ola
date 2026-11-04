import { useTranslation } from 'react-i18next';
import { Avatar, FullScreenOverlay, ScreenHeader, Spinner } from '@components';
import { GIFT_HISTORY_DIRECTION, GIFT_HISTORY_TABS } from '@constants';
import { useGiftHistory } from '@ola/shared/stores/gift/useGiftHistory';
import { cn, colorForName, formatClockHM, formatDateDMY, formatKen } from '@lib';

interface GiftHistoryPageProps {
  onClose: () => void;
  z?: 40 | 50 | 60;
}

export function GiftHistoryPage({ onClose, z }: GiftHistoryPageProps) {
  const { t } = useTranslation();
  const { direction, selectDirection, items, done, loading, loadMore } = useGiftHistory();
  const received = direction === GIFT_HISTORY_DIRECTION.received;

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
              <span className="text-sm text-black/54">{t('gift.history.empty')}</span>
            )}
          </div>
        ) : (
          <ul className="divide-y divide-black/6 bg-white">
            {items.map((item) => {
              const name = item.counterparty.fullName || item.counterparty.username;
              const line =
                received
                  ? t('gift.history.receivedLine', { name, gift: item.giftName, quantity: item.quantity })
                  : t('gift.history.sentLine', { name, gift: item.giftName, quantity: item.quantity });
              return (
                <li key={item.id} className="flex items-start gap-3 px-4 py-3">
                  <Avatar
                    name={name}
                    src={item.counterparty.avatar}
                    color={colorForName(name)}
                    size={40}
                  />
                  <div className="min-w-0 flex-1">
                    <p className="text-sm text-black/87">{line}</p>
                    {item.note != null && item.note !== '' && (
                      <p className="mt-0.5 text-sm break-words text-black/60 italic">“{item.note}”</p>
                    )}
                    <p className="mt-1 text-xs text-black/45">
                      {formatDateDMY(item.createdAt)} {formatClockHM(item.createdAt)} ·{' '}
                      {received
                        ? t('gift.charmGain', { value: formatKen(item.charmPoints) })
                        : t('gift.kenAmount', { ken: formatKen(item.totalKen) })}
                    </p>
                  </div>
                  <img src={item.giftImageUrl} alt="" className="h-12 w-12 shrink-0 object-contain" />
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
