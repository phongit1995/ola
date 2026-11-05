import type { MouseEvent } from 'react';
import { useTranslation } from 'react-i18next';
import { formatKen, giftDisplayName, randomUuid } from '@lib';
import type { GiftMessageMetadata } from '@app-types';
import { useGiftAnimationStore } from '@/store/giftAnimationStore';

interface GiftMessageBubbleProps {
  gift: GiftMessageMetadata;
  isOut: boolean;
  corners: string;
}

export function GiftMessageBubble({
  gift,
  isOut,
  corners,
}: GiftMessageBubbleProps) {
  const { t, i18n } = useTranslation();
  const play = useGiftAnimationStore((s) => s.play);
  const name = giftDisplayName(
    { name: gift.giftName, nameEn: gift.giftNameEn },
    i18n.language
  );
  const quantityLabel = t('gift.quantityTimes', { count: gift.quantity });

  function replay(event: MouseEvent<HTMLButtonElement>) {
    event.stopPropagation();
    play({
      id: randomUuid(),
      imageUrl: gift.imageUrl,
      name,
      quantity: gift.quantity,
      charmPoints: gift.charmPoints,
      caption: isOut
        ? t('gift.sentToast', { name, quantity: gift.quantity })
        : `${t('gift.messageIn')} ${name} ${quantityLabel}`,
    });
  }

  return (
    <button
      type="button"
      onClick={replay}
      className={`block w-[208px] rounded-2xl border border-black/8 bg-white px-2.5 py-2 text-left shadow-sm transition-transform active:scale-[0.98] ${corners}`}
    >
      <span className="flex items-center gap-2">
        <img
          src={gift.imageUrl}
          alt=""
          className="h-11 w-11 shrink-0 object-contain drop-shadow-[0_2px_3px_rgba(0,0,0,0.15)]"
        />
        <span className="flex min-w-0 flex-col leading-tight">
          <span className="text-[11px] text-black/54">
            {isOut ? t('gift.messageOut') : t('gift.messageIn')}
          </span>
          <span className="truncate text-sm font-semibold text-black/87">
            {name}
            {gift.quantity > 1 && (
              <span className="ml-1 text-ola-accent">{quantityLabel}</span>
            )}
          </span>
          {!isOut && gift.charmPoints > 0 && (
            <span className="text-[11px] font-medium whitespace-nowrap text-ola-accent-dark">
              {t('gift.charmGain', { value: formatKen(gift.charmPoints) })}
            </span>
          )}
        </span>
      </span>
      {gift.note != null && (
        <span className="mt-1.5 block border-t border-black/6 pt-1.5 text-sm break-words text-black/70">
          {gift.note}
        </span>
      )}
    </button>
  );
}
