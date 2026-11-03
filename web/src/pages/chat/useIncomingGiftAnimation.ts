import { useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import { giftDisplayName } from '@lib';
import { useGiftAnimationStore } from '@/store/giftAnimationStore';
import type { ChatMessage } from './types';

const INCOMING_GIFT_RECENT_MS = 15_000;

export function useIncomingGiftAnimation(bubbles: ChatMessage[], senderName: string) {
  const { t, i18n } = useTranslation();
  const play = useGiftAnimationStore((s) => s.play);
  const last = bubbles[bubbles.length - 1];

  useEffect(() => {
    if (last == null || last.kind !== 'gift' || last.direction !== 'in' || last.gift == null) return;
    const createdAt = last.createdAt != null ? Date.parse(last.createdAt) : NaN;
    if (Number.isNaN(createdAt) || Date.now() - createdAt > INCOMING_GIFT_RECENT_MS) return;
    const name = giftDisplayName(
      { name: last.gift.giftName, nameEn: last.gift.giftNameEn },
      i18n.language
    );
    play({
      id: last.gift.transactionId !== '' ? last.gift.transactionId : last.id,
      imageUrl: last.gift.imageUrl,
      name,
      quantity: last.gift.quantity,
      charmPoints: last.gift.charmPoints,
      caption: t('gift.history.receivedLine', { name: senderName, gift: name, quantity: last.gift.quantity }),
    });
  }, [last, senderName, play, t, i18n.language]);
}
