import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Image, Pressable, Text, View } from 'react-native';
import { FlashList } from '@shopify/flash-list';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { GIFT_HISTORY_DIRECTION, GIFT_HISTORY_TABS } from '@ola/shared/constants';
import { colorForName, formatClockHM, formatDateDMY, formatKen, randomUuid } from '@ola/shared/lib';
import { useGiftAnimationStore } from '@ola/shared/stores/gift/giftAnimationStore';
import { useGiftHistory } from '@ola/shared/stores/gift/useGiftHistory';
import type { GiftHistoryItem } from '@ola/shared/types';
import { ROOT_ROUTES } from '@navigation/routes';
import type { RootStackParamList } from '@navigation/types';
import { Avatar } from '@components/ui/Avatar';
import { CachedImage } from '@components/ui/CachedImage';
import { InsetListSeparator } from '@components/ui/InsetListSeparator';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { GIFT_ACCENT, GIFT_ACCENT_DARK } from '@components/gift/constants';
import { GIFT_ASSETS } from '@components/gift/giftAssets';
import { GiftPill } from '@components/gift/GiftPill';
import { useThemeColors } from '@hooks/useThemeColors';
import { DIVIDER, TEXT_FAINT, TEXT_PRIMARY, TEXT_SECONDARY, WARNING } from '@constants';
import { CharmIcon } from '@components/gift/CharmIcon';
import { UserName } from '@components/ui/UserName';

type Props = NativeStackScreenProps<RootStackParamList, 'GiftHistory'>;

const AVATAR_SIZE = 44;
const DIRECTION_BADGE_SIZE = 20;
const KEN_PILL_ICON = { width: 14, height: 14 };

function CharmPill({ value }: { value: number }) {
  return <GiftPill tone="charm" text={`+${formatKen(value)}`} trailing={<CharmIcon size={14} />} />;
}

export function GiftHistoryScreen({ navigation }: Props) {
  const { t } = useTranslation();
  const colors = useThemeColors();
  const insets = useSafeAreaInsets();
  const { direction, selectDirection, items, done, loading, loadMore } = useGiftHistory();
  const play = useGiftAnimationStore((s) => s.play);
  const received = direction === GIFT_HISTORY_DIRECTION.received;
  const directionColor = received ? GIFT_ACCENT : WARNING;

  function replay(item: GiftHistoryItem) {
    play({
      id: randomUuid(),
      imageUrl: item.giftImageUrl,
      animation: item.giftAnimation,
      name: item.giftName,
      quantity: item.quantity,
      charmPoints: item.charmPoints,
    });
  }

  function renderItem({ item }: { item: GiftHistoryItem }) {
    const { fullName, username, avatar } = item.counterparty;
    const name = fullName || username;
    const color = colorForName(name);
    const openUser = () => navigation.navigate(ROOT_ROUTES.ProfileView, { userId: username, color });
    return (
      <View className="flex-row items-start gap-3 bg-white px-4 py-3">
        <Pressable onPress={openUser} className="active:opacity-70" accessibilityLabel={name}>
          <Avatar name={name} uri={avatar} color={color} size={AVATAR_SIZE} />
          <View
            className="absolute items-center justify-center rounded-full"
            style={{
              right: -4,
              bottom: -4,
              width: DIRECTION_BADGE_SIZE,
              height: DIRECTION_BADGE_SIZE,
              borderWidth: 2,
              borderColor: '#ffffff',
              backgroundColor: directionColor,
            }}
          >
            <Text className="text-xs font-bold text-white" style={{ lineHeight: 14 }}>
              {received ? '↙' : '↗'}
            </Text>
          </View>
        </Pressable>
        <View className="min-w-0 flex-1">
          <View className="flex-row items-center gap-2">
            <Pressable onPress={openUser} className="min-w-0 flex-1 active:opacity-70">
              <UserName
                name={username}
                fullName={fullName}
                className="text-sm font-semibold"
                fullNameClassName="font-normal"
                style={{ color: TEXT_PRIMARY }}
                fullNameStyle={{ color: TEXT_FAINT }}
              />
            </Pressable>
            <Text className="text-xs" style={{ color: TEXT_FAINT }}>
              {`${formatDateDMY(item.createdAt)} ${formatClockHM(item.createdAt)}`}
            </Text>
          </View>
          <Text className="mt-0.5 text-sm" style={{ color: 'rgba(0,0,0,0.6)' }}>
            {received ? t('gift.messageIn') : t('gift.messageOut')}{' '}
            <Text className="font-semibold" style={{ color: TEXT_PRIMARY }}>
              {item.giftName}
            </Text>{' '}
            <Text className="font-semibold" style={{ color: directionColor }}>
              {t('gift.quantityTimes', { count: item.quantity })}
            </Text>
          </Text>
          {item.note != null && item.note !== '' && (
            <Text
              className="mt-1.5 rounded-lg px-2.5 py-1.5 text-sm"
              style={{ backgroundColor: 'rgba(0,0,0,0.04)', color: 'rgba(0,0,0,0.7)' }}
            >
              {item.note}
            </Text>
          )}
          <View className="mt-1.5 flex-row flex-wrap items-center gap-2">
            {received ? (
              <CharmPill value={item.charmPoints} />
            ) : (
              <GiftPill
                tone="ken"
                text={`−${formatKen(item.totalKen)}`}
                leading={<Image source={GIFT_ASSETS.ken} style={KEN_PILL_ICON} resizeMode="contain" />}
              />
            )}
            {!received && (item.senderCharmPoints ?? 0) > 0 && <CharmPill value={item.senderCharmPoints ?? 0} />}
          </View>
        </View>
        <Pressable onPress={() => replay(item)} className="active:opacity-60" accessibilityLabel={item.giftName}>
          <CachedImage uri={item.giftImageUrl} style={{ width: 56, height: 56 }} resizeMode="contain" />
        </Pressable>
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
