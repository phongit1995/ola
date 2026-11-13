import { useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import { giftDisplayName, isRecentGift } from '@lib';
import { useGiftAnimationStore } from '@ola/shared/stores/gift/giftAnimationStore';
import type { ChatMessage } from './types';

export function useIncomingGiftAnimation(bubbles: ChatMessage[], senderName: string) {
  const { t, i18n } = useTranslation();
  const play = useGiftAnimationStore((s) => s.play);
  const last = bubbles[bubbles.length - 1];

  useEffect(() => {
    if (last == null || last.kind !== 'gift' || last.direction !== 'in' || last.gift == null) return;
    if (!isRecentGift(last.createdAt, Date.now())) return;
    const name = giftDisplayName(
      { name: last.gift.giftName, nameEn: last.gift.giftNameEn },
      i18n.language
    );
    play({
      id: last.gift.transactionId !== '' ? last.gift.transactionId : last.id,
      imageUrl: last.gift.imageUrl,
      animation: last.gift.animation,
      name,
      quantity: last.gift.quantity,
      charmPoints: last.gift.charmPoints,
      caption: t('gift.history.receivedLine', { name: senderName, gift: name, quantity: last.gift.quantity }),
    });
  }, [last, senderName, play, t, i18n.language]);
}
