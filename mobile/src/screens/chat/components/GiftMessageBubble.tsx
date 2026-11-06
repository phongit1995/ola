import { useTranslation } from 'react-i18next';
import { Pressable, Text, View } from 'react-native';
import { formatKen, giftDisplayName, randomUuid } from '@ola/shared/lib';
import { useGiftAnimationStore } from '@ola/shared/stores/gift/giftAnimationStore';
import type { GiftMessageMetadata } from '@ola/shared/types';
import { CachedImage } from '@components/ui/CachedImage';
import { GIFT_ACCENT, GIFT_ACCENT_DARK } from '@components/gift/constants';
import { TEXT_PRIMARY, TEXT_SECONDARY } from '@constants';
import { CharmIcon } from '@components/gift/CharmIcon';

const GIFT_BUBBLE_WIDTH = 208;
const GIFT_BUBBLE_STYLE = {
  width: GIFT_BUBBLE_WIDTH,
  borderWidth: 1,
  borderColor: 'rgba(0,0,0,0.08)',
  backgroundColor: '#ffffff',
  shadowColor: '#000',
  shadowOpacity: 0.06,
  shadowRadius: 2,
  shadowOffset: { width: 0, height: 1 },
  elevation: 1,
};

interface GiftMessageBubbleProps {
  gift: GiftMessageMetadata;
  isOut: boolean;
  cornerClass: string;
  onLongPress?: () => void;
}

export function GiftMessageBubble({ gift, isOut, cornerClass, onLongPress }: GiftMessageBubbleProps) {
  const { t, i18n } = useTranslation();
  const play = useGiftAnimationStore((s) => s.play);
  const name = giftDisplayName({ name: gift.giftName, nameEn: gift.giftNameEn }, i18n.language);
  const quantityLabel = t('gift.quantityTimes', { count: gift.quantity });
  const charmGain = isOut ? (gift.senderCharmPoints ?? 0) : gift.charmPoints;

  function replay() {
    play({
      id: randomUuid(),
      imageUrl: gift.imageUrl,
      animation: gift.animation,
      name,
      quantity: gift.quantity,
      charmPoints: charmGain,
      caption: isOut
        ? t('gift.sentToast', { name, quantity: gift.quantity })
        : `${t('gift.messageIn')} ${name} ${quantityLabel}`,
    });
  }

  return (
    <Pressable
      onPress={replay}
      onLongPress={onLongPress}
      className={`rounded-2xl px-2.5 py-2 active:opacity-80 ${cornerClass}`}
      style={GIFT_BUBBLE_STYLE}
    >
      <View className="flex-row items-center gap-2">
        <CachedImage uri={gift.imageUrl} style={{ width: 44, height: 44 }} resizeMode="contain" />
        <View className="min-w-0 flex-1">
          <Text className="text-[11px]" style={{ color: TEXT_SECONDARY }}>
            {isOut ? t('gift.messageOut') : t('gift.messageIn')}
          </Text>
          <Text numberOfLines={1} className="text-sm font-semibold" style={{ color: TEXT_PRIMARY }}>
            {name}
            {gift.quantity > 1 && <Text style={{ color: GIFT_ACCENT }}>{` ${quantityLabel}`}</Text>}
          </Text>
          {charmGain > 0 && (
            <View className="flex-row items-center" style={{ gap: 2 }}>
              <Text className="text-[11px] font-medium" style={{ color: GIFT_ACCENT_DARK }}>
                {`+${formatKen(charmGain)}`}
              </Text>
              <CharmIcon size={14} />
            </View>
          )}
        </View>
      </View>
      {gift.note != null && (
        <Text
          className="mt-1.5 pt-1.5 text-sm"
          style={{ color: 'rgba(0,0,0,0.7)', borderTopWidth: 1, borderTopColor: 'rgba(0,0,0,0.06)' }}
        >
          {gift.note}
        </Text>
      )}
    </Pressable>
  );
}
