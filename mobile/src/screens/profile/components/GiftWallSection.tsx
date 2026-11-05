import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, Text, View } from 'react-native';
import { formatKen, giftDisplayName, randomUuid } from '@ola/shared/lib';
import { useGiftAnimationStore } from '@ola/shared/stores/gift/giftAnimationStore';
import { useGiftWall } from '@ola/shared/stores/gift/useGiftWall';
import type { GiftWallItem } from '@ola/shared/types';
import { CachedImage } from '@components/ui/CachedImage';
import { GIFT_ACCENT, GIFT_ACCENT_DARK } from '@components/gift/constants';
import { useThemeColors } from '@hooks/useThemeColors';
import { TEXT_FAINT, TEXT_PRIMARY, TEXT_SECONDARY } from '@constants';
import { CARD_SHADOW, GIFT_WALL_COLUMNS, GIFT_WALL_PREVIEW_COUNT } from '../constants';

interface GiftWallSectionProps {
  userId: string;
  isSelf: boolean;
  refreshKey: number;
  onOpenHistory?: () => void;
}

export function GiftWallSection({
  userId,
  isSelf,
  refreshKey,
  onOpenHistory,
}: GiftWallSectionProps) {
  const { t, i18n } = useTranslation();
  const colors = useThemeColors();
  const wall = useGiftWall(userId, refreshKey);
  const [expanded, setExpanded] = useState(false);
  const play = useGiftAnimationStore((s) => s.play);

  if (wall == null) return null;

  const items = expanded ? wall.items : wall.items.slice(0, GIFT_WALL_PREVIEW_COUNT);
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
    <View className="mb-2 bg-white px-3 py-3" style={CARD_SHADOW}>
      <View className="flex-row items-center gap-2">
        <Text className="text-base font-medium" style={{ color: TEXT_PRIMARY }}>
          {t('gift.wall.title')}
        </Text>
        <Text className="flex-1 text-xs" style={{ color: TEXT_SECONDARY }}>
          {t('gift.wall.totalGifts', { value: formatKen(wall.totalGifts) })}
        </Text>
        {isSelf && onOpenHistory != null && (
          <Pressable onPress={onOpenHistory} hitSlop={8} className="active:opacity-70">
            <Text className="text-xs font-medium" style={{ color: colors.primaryDarker }}>
              {t('gift.wall.history')}
            </Text>
          </Pressable>
        )}
        {hiddenCount > 0 && (
          <Pressable onPress={() => setExpanded(true)} hitSlop={8} className="active:opacity-70">
            <Text className="text-xs font-medium" style={{ color: GIFT_ACCENT_DARK }}>
              {t('profile.viewAll')}
            </Text>
          </Pressable>
        )}
      </View>

      {wall.items.length === 0 ? (
        <Text className="py-4 text-center text-sm" style={{ color: TEXT_FAINT }}>
          {t('gift.wall.empty')}
        </Text>
      ) : (
        <View className="mt-2 flex-row flex-wrap">
          {items.map((item) => {
            const name = giftDisplayName(item.gift, i18n.language);
            return (
              <Pressable
                key={item.gift.id}
                accessibilityRole="button"
                accessibilityLabel={name}
                onPress={() => replay(item)}
                className="items-center px-0.5 py-1"
                style={({ pressed }) => ({
                  width: `${100 / GIFT_WALL_COLUMNS}%`,
                  transform: [{ scale: pressed ? 0.9 : 1 }],
                })}
              >
                <View>
                  <CachedImage uri={item.gift.imageUrl} style={{ width: 44, height: 44 }} resizeMode="contain" />
                  <View
                    className="absolute rounded-full px-1"
                    style={{ right: -8, bottom: -4, backgroundColor: GIFT_ACCENT }}
                  >
                    <Text className="text-[10px] font-bold leading-4 text-white">
                      {t('gift.quantityTimes', { count: item.quantity })}
                    </Text>
                  </View>
                </View>
                <Text numberOfLines={1} className="mt-1 text-[11px]" style={{ color: TEXT_SECONDARY }}>
                  {name}
                </Text>
              </Pressable>
            );
          })}
        </View>
      )}
    </View>
  );
}
