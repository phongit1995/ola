import { useTranslation } from 'react-i18next';
import { formatKen, giftDisplayName } from '@lib';
import type { GiftMessageMetadata } from '@app-types';

interface GiftMessageBubbleProps {
  gift: GiftMessageMetadata;
  isOut: boolean;
  corners: string;
}

export function GiftMessageBubble({ gift, isOut, corners }: GiftMessageBubbleProps) {
  const { t, i18n } = useTranslation();
  const name = giftDisplayName({ name: gift.giftName, nameEn: gift.giftNameEn }, i18n.language);
  return (
    <div
      className={`w-[228px] overflow-hidden border border-ola-accent/25 bg-linear-to-br from-white via-ola-marriage-soft/50 to-ola-accent/15 shadow-sm ${corners}`}
    >
      <div className="flex items-center gap-2.5 px-3 pt-3 pb-2">
        <span className="relative shrink-0">
          <img src={gift.imageUrl} alt="" className="h-16 w-16 object-contain" />
          {gift.quantity > 1 && (
            <span className="absolute -right-1.5 -bottom-1 rounded-full bg-ola-accent px-1.5 text-xs font-bold text-white shadow">
              {t('gift.quantityTimes', { count: gift.quantity })}
            </span>
          )}
        </span>
        <span className="flex min-w-0 flex-col">
          <span className="text-xs text-black/54">
            {isOut ? t('gift.messageOut') : t('gift.messageIn')}
          </span>
          <span className="truncate text-base font-bold text-ola-accent-dark">{name}</span>
          {gift.charmPoints > 0 && (
            <span className="text-xs font-medium text-ola-warning">
              {t('gift.charmGain', { value: formatKen(gift.charmPoints) })}
            </span>
          )}
        </span>
      </div>
      {gift.note != null && (
        <p className="border-t border-ola-accent/15 px-3 py-2 text-sm break-words text-black/80 italic">
          “{gift.note}”
        </p>
      )}
    </div>
  );
}
