import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Pressable, Text, View } from 'react-native';
import { FlashList } from '@shopify/flash-list';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { GIFT_HISTORY_DIRECTION, GIFT_HISTORY_TABS } from '@ola/shared/constants';
import { colorForName, formatClockHM, formatDateDMY, formatKen } from '@ola/shared/lib';
import { useGiftHistory } from '@ola/shared/stores/gift/useGiftHistory';
import type { GiftHistoryItem } from '@ola/shared/types';
import type { RootStackParamList } from '@navigation/types';
import { Avatar } from '@components/ui/Avatar';
import { CachedImage } from '@components/ui/CachedImage';
import { InsetListSeparator } from '@components/ui/InsetListSeparator';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { GIFT_ACCENT, GIFT_ACCENT_DARK } from '@components/gift/constants';
import { useThemeColors } from '@hooks/useThemeColors';
import { DIVIDER, TEXT_FAINT, TEXT_PRIMARY, TEXT_SECONDARY } from '@constants';
import { CharmIcon } from '@components/gift/CharmIcon';

type Props = NativeStackScreenProps<RootStackParamList, 'GiftHistory'>;

function CharmText({ value }: { value: number }) {
  return (
    <View className="flex-row items-center" style={{ gap: 2 }}>
      <Text className="text-xs font-semibold" style={{ color: GIFT_ACCENT_DARK }}>
        {`+${formatKen(value)}`}
      </Text>
      <CharmIcon size={13} />
    </View>
  );
}

export function GiftHistoryScreen({ navigation }: Props) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const insets = useSafeAreaInsets();
  const { direction, selectDirection, items, done, loading, loadMore } = useGiftHistory();
  const received = direction === GIFT_HISTORY_DIRECTION.received;

  function renderItem({ item }: { item: GiftHistoryItem }) {
    const name = item.counterparty.fullName || item.counterparty.username;
    const line = received
      ? t('gift.history.receivedLine', { name, gift: item.giftName, quantity: item.quantity })
      : t('gift.history.sentLine', { name, gift: item.giftName, quantity: item.quantity });
    return (
      <View className="flex-row items-start gap-3 bg-white px-4 py-3">
        <Avatar name={name} uri={item.counterparty.avatar} color={colorForName(name)} size={40} />
        <View className="min-w-0 flex-1">
          <View className="flex-row items-start" style={{ gap: 8 }}>
            <Text className="flex-1 text-sm" style={{ color: TEXT_PRIMARY }}>
              {line}
            </Text>
            <Text className="text-xs" style={{ color: TEXT_FAINT }}>
              {`${formatDateDMY(item.createdAt)} ${formatClockHM(item.createdAt)}`}
            </Text>
          </View>
          {item.note != null && item.note !== '' && (
            <Text className="mt-0.5 text-sm italic" style={{ color: 'rgba(0,0,0,0.6)' }}>
              “{item.note}”
            </Text>
          )}
          <View className="mt-1 flex-row flex-wrap items-center" style={{ gap: 4 }}>
            {received ? (
              <CharmText value={item.charmPoints} />
            ) : (
              <Text className="text-xs" style={{ color: TEXT_FAINT }}>
                {t('gift.kenAmount', { ken: formatKen(item.totalKen) })}
              </Text>
            )}
            {!received && (item.senderCharmPoints ?? 0) > 0 && (
              <>
                <Text className="text-xs" style={{ color: TEXT_FAINT }}>
                  ·
                </Text>
                <CharmText value={item.senderCharmPoints ?? 0} />
              </>
            )}
          </View>
        </View>
        <CachedImage uri={item.giftImageUrl} style={{ width: 48, height: 48 }} resizeMode="contain" />
      </View>
    );
  }

  return (
    <View className="flex-1 bg-white">
      <ScreenHeader title={t('gift.wall.history')} onBack={() => navigation.goBack()} />
      <View className="flex-row bg-white" style={{ borderBottomWidth: 1, borderBottomColor: DIVIDER }}>
        {GIFT_HISTORY_TABS.map((tab) => {
          const active = tab.value === direction;
          return (
            <Pressable
              key={tab.value}
              onPress={() => selectDirection(tab.value)}
              className="flex-1 items-center py-2.5"
              style={{ borderBottomWidth: 2, borderBottomColor: active ? GIFT_ACCENT : 'transparent' }}
            >
              <Text
                className="text-sm font-medium"
                style={{ color: active ? GIFT_ACCENT_DARK : TEXT_SECONDARY }}
              >
                {t(tab.labelKey)}
              </Text>
            </Pressable>
          );
        })}
      </View>

      {items.length === 0 ? (
        <View className="items-center py-12">
          {loading || !done ? (
            <ActivityIndicator color={GIFT_ACCENT} />
          ) : (
            <Text className="text-sm" style={{ color: TEXT_SECONDARY }}>
              {t('gift.history.empty')}
            </Text>
          )}
        </View>
      ) : (
        <FlashList
          key={direction}
          data={items}
          keyExtractor={(item) => item.id}
          renderItem={renderItem}
          ItemSeparatorComponent={InsetListSeparator}
          contentContainerStyle={{ paddingBottom: insets.bottom }}
          ListFooterComponent={
            done ? null : (
              <View className="items-center py-3">
                {loading ? (
                  <ActivityIndicator color={GIFT_ACCENT} />
                ) : (
                  <Pressable onPress={loadMore} hitSlop={8}>
                    <Text className="text-sm font-medium" style={{ color: colors.primaryDarker }}>
                      {t('gift.history.loadMore')}
                    </Text>
                  </Pressable>
                )}
              </View>
            )
          }
        />
      )}
    </View>
  );
}
