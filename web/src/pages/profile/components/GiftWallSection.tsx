import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { useGiftWall } from '@ola/shared/stores/gift/useGiftWall';
import { formatKen, giftDisplayName, randomUuid } from '@lib';
import type { GiftWallItem } from '@app-types';
import { useGiftAnimationStore } from '@/store/giftAnimationStore';
import {
  GIFT_WALL_GRID_CLASS,
  GIFT_WALL_PREVIEW_ROWS,
  type GiftWallColumns,
} from '../constants';

interface GiftWallSectionProps {
  userId: string;
  isSelf: boolean;
  refreshKey: number;
  columns?: GiftWallColumns;
  onOpenHistory?: () => void;
}

export function GiftWallSection({
  userId,
  isSelf,
  refreshKey,
  columns = 4,
  onOpenHistory,
}: GiftWallSectionProps) {
  const { t, i18n } = useTranslation();
  const wall = useGiftWall(userId, refreshKey);
  const [expanded, setExpanded] = useState(false);
  const play = useGiftAnimationStore((s) => s.play);

  if (wall == null) return null;

  const items = expanded ? wall.items : wall.items.slice(0, columns * GIFT_WALL_PREVIEW_ROWS);
  const hiddenCount = wall.items.length - items.length;

  function replay(item: GiftWallItem) {
    play({
      id: randomUuid(),
      imageUrl: item.gift.imageUrl,
      animation: item.gift.animation,
      name: giftDisplayName(item.gift, i18n.language),
      quantity: item.quantity,
      charmPoints: item.gift.charmPoints * item.quantity,
    });
  }

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
        {hiddenCount > 0 && (
          <button
            type="button"
            onClick={() => setExpanded(true)}
            className="text-xs font-medium text-ola-accent-dark active:opacity-70"
          >
            {t('profile.viewAll')}
          </button>
        )}
      </div>

      {wall.items.length === 0 ? (
        <p className="py-4 text-center text-sm text-black/45">{t('gift.wall.empty')}</p>
      ) : (
        <ul className={`mt-2 grid ${GIFT_WALL_GRID_CLASS[columns]} gap-x-1 gap-y-2`}>
          {items.map((item) => (
            <li key={item.gift.id}>
              <button
                type="button"
                onClick={() => replay(item)}
                className="flex w-full flex-col items-center rounded-lg transition-transform active:scale-90"
              >
                <span className="relative">
                  <img
                    src={item.gift.imageUrl}
                    alt={giftDisplayName(item.gift, i18n.language)}
                    loading="lazy"
                    className="h-16 w-16 object-contain"
                  />
                  <span className="absolute -right-2 -bottom-1 rounded-full bg-ola-accent px-1 text-[10px] leading-4 font-bold text-white">
                    {t('gift.quantityTimes', { count: item.quantity })}
                  </span>
                </span>
                <span className="mt-1 w-full truncate text-center text-xs text-black/54">
                  {giftDisplayName(item.gift, i18n.language)}
                </span>
              </button>
            </li>
          ))}
        </ul>
      )}
    </section>
  );
}
