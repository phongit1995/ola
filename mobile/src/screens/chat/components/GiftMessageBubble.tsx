import { useTranslation } from 'react-i18next';
import { Text, View } from 'react-native';
import LinearGradient from 'react-native-linear-gradient';
import { formatKen, giftDisplayName, withAlpha } from '@ola/shared/lib';
import type { GiftMessageMetadata } from '@ola/shared/types';
import { CachedImage } from '@components/ui/CachedImage';
import {
  GIFT_ACCENT,
  GIFT_ACCENT_DARK,
  GIFT_MARRIAGE_SOFT,
} from '@components/gift/constants';
import { TEXT_SECONDARY, WARNING } from '@constants';

const GIFT_BUBBLE_WIDTH = 228;

interface GiftMessageBubbleProps {
  gift: GiftMessageMetadata;
  isOut: boolean;
  cornerClass: string;
}

export function GiftMessageBubble({ gift, isOut, cornerClass }: GiftMessageBubbleProps) {
  const { t, i18n } = useTranslation();
  const name = giftDisplayName({ name: gift.giftName, nameEn: gift.giftNameEn }, i18n.language);
  return (
    <View
      className={`overflow-hidden rounded-2xl ${cornerClass}`}
      style={{
        width: GIFT_BUBBLE_WIDTH,
        borderWidth: 1,
        borderColor: withAlpha(GIFT_ACCENT, 0.25),
      }}
    >
      <LinearGradient
        colors={['#ffffff', withAlpha(GIFT_MARRIAGE_SOFT, 0.5), withAlpha(GIFT_ACCENT, 0.15)]}
        start={{ x: 0, y: 0 }}
        end={{ x: 1, y: 1 }}
      >
        <View className="flex-row items-center gap-2.5 px-3 pb-2 pt-3">
          <View>
            <CachedImage uri={gift.imageUrl} style={{ width: 64, height: 64 }} resizeMode="contain" />
            {gift.quantity > 1 && (
              <View
                className="absolute rounded-full px-1.5"
                style={{ right: -6, bottom: -4, backgroundColor: GIFT_ACCENT }}
              >
                <Text className="text-xs font-bold text-white">
                  {t('gift.quantityTimes', { count: gift.quantity })}
                </Text>
              </View>
            )}
          </View>
          <View className="min-w-0 flex-1">
            <Text className="text-xs" style={{ color: TEXT_SECONDARY }}>
              {isOut ? t('gift.messageOut') : t('gift.messageIn')}
            </Text>
            <Text numberOfLines={1} className="text-base font-bold" style={{ color: GIFT_ACCENT_DARK }}>
              {name}
            </Text>
            {gift.charmPoints > 0 && (
              <Text className="text-xs font-medium" style={{ color: WARNING }}>
                {t('gift.charmGain', { value: formatKen(gift.charmPoints) })}
              </Text>
            )}
          </View>
        </View>
        {gift.note != null && (
          <Text
            className="px-3 py-2 text-sm italic"
            style={{
              color: 'rgba(0,0,0,0.8)',
              borderTopWidth: 1,
              borderTopColor: withAlpha(GIFT_ACCENT, 0.15),
            }}
          >
            “{gift.note}”
          </Text>
        )}
      </LinearGradient>
    </View>
  );
}
