import { useTranslation } from 'react-i18next';
import { ActivityIndicator, Image, Pressable, ScrollView, StyleSheet, Text, View } from 'react-native';
import Animated, { FadeInDown, ZoomIn } from 'react-native-reanimated';
import LinearGradient from 'react-native-linear-gradient';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import {
  GIFT_LEADERBOARD_PERIOD_LABEL,
  GIFT_LEADERBOARD_PERIODS,
  GIFT_LEADERBOARD_PODIUM_SIZE,
  GIFT_LEADERBOARD_TYPE,
  GIFT_LEADERBOARD_TYPE_TABS,
} from '@ola/shared/constants';
import { colorForName, formatKen } from '@ola/shared/lib';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { useGiftLeaderboard } from '@ola/shared/stores/gift/useGiftLeaderboard';
import type { GiftLeaderboardEntry, GiftLeaderboardType } from '@ola/shared/types';
import type { RootStackParamList } from '@navigation/types';
import { AvatarWithFrame } from '@components/ui/AvatarWithFrame';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { GIFT_ACCENT, GIFT_ACCENT_DARK } from '@components/gift/constants';
import { GIFT_ASSETS } from '@components/gift/giftAssets';
import { DIVIDER, TEXT_FAINT, TEXT_PRIMARY, TEXT_SECONDARY } from '@constants';
import { CharmIcon } from '@components/gift/CharmIcon';
import { UserName } from '@components/ui/UserName';

type Props = NativeStackScreenProps<RootStackParamList, 'GiftLeaderboard'>;

const PODIUM_POP_DELAY_MS = 180;
const PODIUM_RISE_MS = 450;
const RANK_BADGE_ASPECT = 0.73;
const MY_RANK_BADGE_HEIGHT = 28;
const ROW_BASE_DELAY_MS = 420;
const ROW_STAGGER_MS = 35;
const ROW_STAGGER_MAX_INDEX = 12;
const ROW_FADE_MS = 220;
const KEN_ICON_STYLE = { width: 16, height: 16 };

interface PodiumSlotStyle {
  rank: number;
  delayMs: number;
  avatarSize: number;
  ring: string;
  blockHeight: number;
  blockColors: string[];
  badge: number;
  badgeHeight: number;
}

function rankBadgeSize(height: number) {
  return { width: height * RANK_BADGE_ASPECT, height };
}

const PODIUM_SLOTS: PodiumSlotStyle[] = [
  {
    rank: 2,
    delayMs: 120,
    avatarSize: 60,
    ring: '#aab3c2',
    blockHeight: 64,
    blockColors: ['#e3e7ee', '#f3f5f8'],
    badge: GIFT_ASSETS.rank2,
    badgeHeight: 44,
  },
  {
    rank: 1,
    delayMs: 240,
    avatarSize: 76,
    ring: '#f5b301',
    blockHeight: 80,
    blockColors: ['#ffe9a8', '#fff6dc'],
    badge: GIFT_ASSETS.rank1,
    badgeHeight: 60,
  },
  {
    rank: 3,
    delayMs: 0,
    avatarSize: 60,
    ring: '#d0894a',
    blockHeight: 52,
    blockColors: ['#f6d9bf', '#fcefe3'],
    badge: GIFT_ASSETS.rank3,
    badgeHeight: 44,
  },
];

function BoardValue({ type, value }: { type: GiftLeaderboardType; value: number }) {
  return (
    <View className="flex-row items-center" style={{ gap: 4 }}>
      <Text className="text-sm font-bold" style={{ color: TEXT_PRIMARY }}>
        {formatKen(value)}
      </Text>
      {type === GIFT_LEADERBOARD_TYPE.sender ? (
        <Image source={GIFT_ASSETS.ken} style={KEN_ICON_STYLE} resizeMode="contain" />
      ) : (
        <CharmIcon />
      )}
    </View>
  );
}

function PodiumSlot({
  slot,
  entry,
  type,
}: {
  slot: PodiumSlotStyle;
  entry: GiftLeaderboardEntry | undefined;
  type: GiftLeaderboardType;
}) {
  const name = entry == null ? '' : entry.user.fullName || entry.user.username;
  const ringSize = slot.avatarSize + 6;
  return (
    <View className="min-w-0 flex-1 items-center">
      <Animated.View
        entering={ZoomIn.delay(slot.delayMs + PODIUM_POP_DELAY_MS).springify()}
        style={styles.podiumPerson}
      >
        {entry == null ? (
          <View
            style={{
              width: slot.avatarSize,
              height: slot.avatarSize,
              borderRadius: slot.avatarSize / 2,
              borderWidth: 2,
              borderStyle: 'dashed',
              borderColor: DIVIDER,
            }}
          />
        ) : (
          <View
            style={{
              width: ringSize,
              height: ringSize,
              borderRadius: ringSize / 2,
              borderWidth: entry.user.avatarFrameId ? 0 : 3,
              borderColor: slot.ring,
              alignItems: 'center',
              justifyContent: 'center',
            }}
          >
            <AvatarWithFrame
              name={name}
              uri={entry.user.avatar}
              color={colorForName(name)}
              size={slot.avatarSize}
              frameId={entry.user.avatarFrameId}
            />
          </View>
        )}
        <Text
          numberOfLines={1}
          className="mt-2 text-sm font-semibold"
          style={styles.podiumName}
        >
          {entry == null ? '—' : `@${entry.user.username}`}
        </Text>
        <View style={styles.podiumValue}>
          {entry != null && <BoardValue type={type} value={entry.value} />}
        </View>
      </Animated.View>
      <Animated.View
        entering={FadeInDown.delay(slot.delayMs).duration(PODIUM_RISE_MS)}
        style={[styles.podiumBlock, { height: slot.blockHeight }]}
      >
        <LinearGradient colors={slot.blockColors} style={StyleSheet.absoluteFill} />
        <Image
          source={slot.badge}
          style={rankBadgeSize(slot.badgeHeight)}
          resizeMode="contain"
          accessibilityLabel={String(slot.rank)}
        />
      </Animated.View>
    </View>
  );
}

export function GiftLeaderboardScreen({ navigation }: Props) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const me = useAuthStore((s) => s.user);
  const { type, period, selectType, selectPeriod, board, failed } = useGiftLeaderboard();
  const myName = me?.fullName || me?.username || '';
  const myBadge = PODIUM_SLOTS.find((slot) => slot.rank === board?.me.rank)?.badge;
  const restEntries = board?.items.filter((entry) => entry.rank > GIFT_LEADERBOARD_PODIUM_SIZE) ?? [];

  return (
    <View className="flex-1 bg-white">
      <ScreenHeader title={t('gift.leaderboard.title')} onBack={() => navigation.goBack()} />

      <View className="flex-row bg-white" style={{ borderBottomWidth: 1, borderBottomColor: DIVIDER }}>
        {GIFT_LEADERBOARD_TYPE_TABS.map((tab) => {
          const active = tab.value === type;
          return (
            <Pressable
              key={tab.value}
              onPress={() => selectType(tab.value)}
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

      <ScrollView className="flex-1" contentContainerStyle={styles.scrollContent}>
        <View className="flex-row justify-center gap-2 pt-3">
          {GIFT_LEADERBOARD_PERIODS.map((value) => {
            const active = value === period;
            return (
              <Pressable
                key={value}
                onPress={() => selectPeriod(value)}
                className="rounded-full px-3 py-1"
                style={{ backgroundColor: active ? 'rgba(255,64,129,0.1)' : 'rgba(0,0,0,0.04)' }}
              >
                <Text
                  className="text-xs font-medium"
                  style={{ color: active ? GIFT_ACCENT_DARK : TEXT_SECONDARY }}
                >
                  {t(GIFT_LEADERBOARD_PERIOD_LABEL[value])}
                </Text>
              </Pressable>
            );
          })}
        </View>

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
          <View key={`${type}:${period}`}>
            <View style={styles.podium}>
              {PODIUM_SLOTS.map((slot) => (
                <PodiumSlot
                  key={slot.rank}
                  slot={slot}
                  type={type}
                  entry={board.items.find((item) => item.rank === slot.rank)}
                />
              ))}
            </View>
            {restEntries.map((entry, index) => {
              const name = entry.user.fullName || entry.user.username;
              const stagger = Math.min(index, ROW_STAGGER_MAX_INDEX);
              return (
                <Animated.View
                  key={entry.user.id}
                  entering={FadeInDown.delay(ROW_BASE_DELAY_MS + stagger * ROW_STAGGER_MS).duration(ROW_FADE_MS)}
                  style={styles.row}
                >
                  <Text className="text-center text-sm font-semibold" style={styles.rowRank}>
                    {entry.rank}
                  </Text>
                  <AvatarWithFrame
                    name={name}
                    uri={entry.user.avatar}
                    color={colorForName(name)}
                    size={36}
                    frameId={entry.user.avatarFrameId}
                  />
                  <View className="min-w-0 flex-1">
                    <UserName
                      name={`@${entry.user.username}`}
                      fullName={entry.user.fullName}
                      className="text-sm font-medium"
                      fullNameClassName="font-normal"
                      style={{ color: TEXT_PRIMARY }}
                      fullNameStyle={{ color: TEXT_SECONDARY }}
                    />
                  </View>
                  <BoardValue type={type} value={entry.value} />
                </Animated.View>
              );
            })}
          </View>
        )}
      </ScrollView>

      {board != null && (
        <View
          className="flex-row items-center gap-3 bg-white px-4 pt-2.5"
          style={{
            paddingBottom: 10 + insets.bottom,
            borderTopWidth: 1,
            borderTopColor: DIVIDER,
            shadowColor: '#000',
            shadowOpacity: 0.06,
            shadowRadius: 8,
            shadowOffset: { width: 0, height: -2 },
            elevation: 4,
          }}
        >
          {myBadge != null ? (
            <View style={styles.myBadge}>
              <Image
                source={myBadge}
                style={rankBadgeSize(MY_RANK_BADGE_HEIGHT)}
                resizeMode="contain"
                accessibilityLabel={String(board.me.rank)}
              />
            </View>
          ) : (
            <Text className="text-center text-sm font-bold" style={styles.myRank}>
              {board.me.rank > 0 ? board.me.rank : '—'}
            </Text>
          )}
          <AvatarWithFrame
            name={myName}
            uri={me?.avatar}
            color={colorForName(myName)}
            size={36}
            frameId={me?.avatarFrameId}
          />
          <View className="min-w-0 flex-1">
            <UserName
              name={`@${me?.username ?? ''}`}
              fullName={me?.fullName}
              className="text-sm font-semibold"
              fullNameClassName="font-normal"
              style={{ color: TEXT_PRIMARY }}
              fullNameStyle={{ color: TEXT_SECONDARY }}
            />
            <Text className="text-xs" style={{ color: TEXT_SECONDARY }}>
              {board.me.rank > 0 ? t('gift.leaderboard.myRank') : t('gift.leaderboard.notRanked')}
            </Text>
          </View>
          <BoardValue type={type} value={board.me.value} />
        </View>
      )}
    </View>
  );
}

const styles = StyleSheet.create({
  scrollContent: { paddingBottom: 16 },
  podium: {
    flexDirection: 'row',
    alignItems: 'flex-end',
    gap: 6,
    paddingHorizontal: 12,
    paddingTop: 24,
    borderBottomWidth: 1,
    borderBottomColor: DIVIDER,
  },
  podiumPerson: { width: '100%', alignItems: 'center' },
  podiumName: { color: TEXT_PRIMARY, width: '100%', paddingHorizontal: 4, textAlign: 'center' },
  podiumValue: { height: 20, marginTop: 2, marginBottom: 8, justifyContent: 'center' },
  podiumBlock: {
    width: '100%',
    alignItems: 'center',
    justifyContent: 'center',
    borderTopLeftRadius: 8,
    borderTopRightRadius: 8,
    overflow: 'hidden',
  },
  row: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 12,
    paddingHorizontal: 16,
    paddingVertical: 10,
    borderBottomWidth: StyleSheet.hairlineWidth,
    borderBottomColor: DIVIDER,
  },
  rowRank: { width: 24, color: TEXT_FAINT },
  myRank: { width: 24, color: GIFT_ACCENT_DARK },
  myBadge: { width: 24, alignItems: 'center' },
});
