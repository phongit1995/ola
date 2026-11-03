import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { GiftService } from '@services';
import { formatKen, giftDisplayName } from '@lib';
import type { GiftWall } from '@app-types';
import { GIFT_WALL_PREVIEW_COUNT } from '../constants';

interface GiftWallSectionProps {
  userId: string;
  isSelf: boolean;
  refreshKey: number;
  onOpenLeaderboard?: () => void;
  onOpenHistory?: () => void;
}

export function GiftWallSection({
  userId,
  isSelf,
  refreshKey,
  onOpenLeaderboard,
  onOpenHistory,
}: GiftWallSectionProps) {
  const { t, i18n } = useTranslation();
  const [wall, setWall] = useState<GiftWall | null>(null);
  const [expanded, setExpanded] = useState(false);

  useEffect(() => {
    if (userId === '') return;
    let cancelled = false;
    GiftService.wall(userId)
      .then((result) => {
        if (!cancelled) setWall(result);
      })
      .catch(() => {
        if (!cancelled) setWall(null);
      });
    return () => {
      cancelled = true;
    };
  }, [userId, refreshKey]);

  if (wall == null) return null;

  const items = expanded ? wall.items : wall.items.slice(0, GIFT_WALL_PREVIEW_COUNT);
  const hiddenCount = wall.items.length - items.length;

  return (
    <section className="mx-2 mt-2 rounded-lg bg-white px-3 py-3 shadow-sm">
      <div className="flex items-center gap-2">
        <h3 className="text-base font-medium text-black/87">{t('gift.wall.title')}</h3>
        <span className="text-xs text-black/54">
          {t('gift.wall.totalGifts', { value: formatKen(wall.totalGifts) })}
        </span>
        <span className="flex-1" />
        {isSelf && onOpenHistory != null && (
          <button
            type="button"
            onClick={onOpenHistory}
            className="text-xs font-medium text-ola-primary-darker active:opacity-70"
          >
            {t('gift.wall.history')}
          </button>
        )}
        {onOpenLeaderboard != null && (
          <button
            type="button"
            onClick={onOpenLeaderboard}
            className="text-xs font-medium text-ola-accent-dark active:opacity-70"
          >
            {t('gift.wall.leaderboard')}
          </button>
        )}
      </div>

      {wall.items.length === 0 ? (
        <p className="py-4 text-center text-sm text-black/45">{t('gift.wall.empty')}</p>
      ) : (
        <ul className="mt-2 grid grid-cols-5 gap-x-1 gap-y-2">
          {items.map((item) => (
            <li key={item.gift.id} className="flex flex-col items-center">
              <span className="relative">
                <img
                  src={item.gift.imageUrl}
                  alt={giftDisplayName(item.gift, i18n.language)}
                  loading="lazy"
                  className="h-11 w-11 object-contain"
                />
                <span className="absolute -right-2 -bottom-1 rounded-full bg-ola-accent px-1 text-[10px] leading-4 font-bold text-white">
                  {t('gift.quantityTimes', { count: item.quantity })}
                </span>
              </span>
              <span className="mt-1 w-full truncate text-center text-[11px] text-black/54">
                {giftDisplayName(item.gift, i18n.language)}
              </span>
            </li>
          ))}
        </ul>
      )}

      {hiddenCount > 0 && (
        <button
          type="button"
          onClick={() => setExpanded(true)}
          className="mt-2 w-full text-center text-xs font-medium text-ola-primary-darker active:opacity-70"
        >
          {t('profile.viewAll')}
        </button>
      )}
    </section>
  );
}
