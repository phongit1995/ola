import { useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import { MESSAGE_TYPE } from '@ola/shared/constants';
import { giftDisplayName, isRecentGift, parseGiftMessageMetadata } from '@ola/shared/lib';
import { useGiftAnimationStore } from '@ola/shared/stores/gift/giftAnimationStore';
import type { Message } from '@ola/shared/types';

export function useIncomingGiftAnimation(messages: Message[], myId: string, senderName: string) {
  const { t, i18n } = useTranslation();
  const play = useGiftAnimationStore((s) => s.play);
  const last = messages[messages.length - 1];

  useEffect(() => {
    if (last == null || last.type !== MESSAGE_TYPE.gift || last.senderId === myId) return;
    if (!isRecentGift(last.createdAt, Date.now())) return;
    const gift = parseGiftMessageMetadata(last.metadata);
    if (gift == null) return;
    const name = giftDisplayName({ name: gift.giftName, nameEn: gift.giftNameEn }, i18n.language);
    play({
      id: gift.transactionId !== '' ? gift.transactionId : last.id,
      imageUrl: gift.imageUrl,
      animation: gift.animation,
      name,
      quantity: gift.quantity,
      charmPoints: gift.charmPoints,
      caption: t('gift.history.receivedLine', { name: senderName, gift: name, quantity: gift.quantity }),
    });
  }, [last, myId, senderName, play, t, i18n.language]);
}
