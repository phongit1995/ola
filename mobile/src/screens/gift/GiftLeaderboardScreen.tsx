import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Pressable, StyleSheet, Text, View } from 'react-native';
import LinearGradient from 'react-native-linear-gradient';
import { FlashList } from '@shopify/flash-list';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import {
  GIFT_LEADERBOARD_PERIOD_LABEL,
  GIFT_LEADERBOARD_PERIODS,
  GIFT_LEADERBOARD_PODIUM_SIZE,
  GIFT_LEADERBOARD_TYPE,
  GIFT_LEADERBOARD_TYPE_TABS,
  GIFT_PODIUM_MEDALS,
} from '@ola/shared/constants';
import { colorForName, formatKen } from '@ola/shared/lib';
import { useGiftLeaderboard } from '@ola/shared/stores/gift/useGiftLeaderboard';
import type { GiftLeaderboardEntry } from '@ola/shared/types';
import type { RootStackParamList } from '@navigation/types';
import { Avatar } from '@components/ui/Avatar';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { InsetListSeparator } from '@components/ui/InsetListSeparator';
import { GIFT_ACCENT, GIFT_ACCENT_DARK, GIFT_HEADER_GRADIENT } from '@components/gift/constants';
import { DIVIDER, TEXT_FAINT, TEXT_PRIMARY, TEXT_SECONDARY } from '@constants';

type Props = NativeStackScreenProps<RootStackParamList, 'GiftLeaderboard'>;

export function GiftLeaderboardScreen({ navigation }: Props) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const { type, period, selectType, selectPeriod, board, failed } = useGiftLeaderboard();

  function valueText(value: number): string {
    return type === GIFT_LEADERBOARD_TYPE.sender
      ? t('gift.leaderboard.kenValue', { value: formatKen(value) })
      : t('gift.leaderboard.charmValue', { value: formatKen(value) });
  }

  function renderEntry({ item }: { item: GiftLeaderboardEntry }) {
    const name = item.user.fullName || item.user.username;
    const podium = item.rank <= GIFT_LEADERBOARD_PODIUM_SIZE;
    return (
      <View className="flex-row items-center gap-3 bg-white px-4 py-2.5">
        <Text
          className={`w-7 text-center font-bold ${podium ? 'text-xl' : 'text-sm'}`}
          style={podium ? undefined : { color: TEXT_FAINT }}
        >
          {podium ? GIFT_PODIUM_MEDALS[item.rank - 1] : item.rank}
        </Text>
        <Avatar name={name} uri={item.user.avatar} color={colorForName(name)} size={podium ? 44 : 36} />
        <View className="min-w-0 flex-1">
          <Text numberOfLines={1} className="text-sm font-medium" style={{ color: TEXT_PRIMARY }}>
            {name}
          </Text>
          <Text numberOfLines={1} className="text-xs" style={{ color: TEXT_FAINT }}>
            @{item.user.username}
          </Text>
        </View>
        <Text className="text-sm font-semibold" style={{ color: GIFT_ACCENT_DARK }}>
          {valueText(item.value)}
        </Text>
      </View>
    );
  }

  return (
    <View className="flex-1 bg-ola-surface">
      <ScreenHeader title={t('gift.leaderboard.title')} onBack={() => navigation.goBack()} />

      <View className="px-3 pb-4 pt-3">
        <LinearGradient
          colors={GIFT_HEADER_GRADIENT}
          start={{ x: 0, y: 0 }}
          end={{ x: 0, y: 1 }}
          style={StyleSheet.absoluteFill}
        />
        <View className="flex-row rounded-full p-1" style={{ backgroundColor: 'rgba(255,255,255,0.2)' }}>
          {GIFT_LEADERBOARD_TYPE_TABS.map((tab) => {
            const active = tab.value === type;
            return (
              <Pressable
                key={tab.value}
                onPress={() => selectType(tab.value)}
                className="flex-1 items-center rounded-full py-1.5"
                style={active ? { backgroundColor: '#ffffff' } : undefined}
              >
                <Text
                  className="text-sm font-semibold"
                  style={{ color: active ? GIFT_ACCENT_DARK : 'rgba(255,255,255,0.9)' }}
                >
                  {t(tab.labelKey)}
                </Text>
              </Pressable>
            );
          })}
        </View>
        <View className="mt-3 flex-row justify-center gap-2">
          {GIFT_LEADERBOARD_PERIODS.map((value) => {
            const active = value === period;
            return (
              <Pressable
                key={value}
                onPress={() => selectPeriod(value)}
                className="rounded-full px-3 py-0.5"
                style={{
                  borderWidth: 1,
                  borderColor: active ? '#ffffff' : 'rgba(255,255,255,0.5)',
                  backgroundColor: active ? 'rgba(255,255,255,0.25)' : 'transparent',
                }}
              >
                <Text
                  className="text-xs font-medium"
                  style={{ color: active ? '#ffffff' : 'rgba(255,255,255,0.85)' }}
                >
                  {t(GIFT_LEADERBOARD_PERIOD_LABEL[value])}
                </Text>
              </Pressable>
            );
          })}
        </View>
      </View>

      <View className="flex-1 bg-white">
        {board == null ? (
          <View className="items-center py-10">
            {failed ? (
              <Text className="text-sm" style={{ color: TEXT_SECONDARY }}>
                {t('gift.loadFailed')}
              </Text>
            ) : (
              <ActivityIndicator color={GIFT_ACCENT} />
            )}
          </View>
        ) : board.items.length === 0 ? (
          <Text className="py-16 text-center text-sm" style={{ color: TEXT_SECONDARY }}>
            {t('gift.leaderboard.empty')}
          </Text>
        ) : (
          <FlashList
            key={`${type}:${period}`}
            data={board.items}
            keyExtractor={(entry) => entry.user.id}
            renderItem={renderEntry}
            ItemSeparatorComponent={InsetListSeparator}
          />
        )}
      </View>

      {board != null && (
        <View
          className="flex-row items-center gap-3 bg-white px-4 pt-3"
          style={{
            paddingBottom: 12 + insets.bottom,
            borderTopWidth: 1,
            borderTopColor: DIVIDER,
            shadowColor: '#000',
            shadowOpacity: 0.06,
            shadowRadius: 8,
            shadowOffset: { width: 0, height: -2 },
            elevation: 4,
          }}
        >
          <Text className="text-sm" style={{ color: TEXT_SECONDARY }}>
            {t('gift.leaderboard.myRank')}
          </Text>
          <Text className="flex-1 text-base font-bold" style={{ color: TEXT_PRIMARY }}>
            {board.me.rank > 0 ? `#${board.me.rank}` : t('gift.leaderboard.notRanked')}
          </Text>
          <Text className="text-sm font-semibold" style={{ color: GIFT_ACCENT_DARK }}>
            {valueText(board.me.value)}
          </Text>
        </View>
      )}
    </View>
  );
}
