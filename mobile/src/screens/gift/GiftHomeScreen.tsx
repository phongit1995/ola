import { useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import { Pressable, ScrollView, StyleSheet, Text, View } from 'react-native';
import LinearGradient from 'react-native-linear-gradient';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { formatKen } from '@ola/shared/lib';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import type { RootStackParamList } from '@navigation/types';
import { ROOT_ROUTES } from '@navigation/routes';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { GIFT_HEADER_GRADIENT } from '@components/gift/constants';
import { DIVIDER, TEXT_PRIMARY } from '@constants';
import { GiftWallSection } from '@screens/profile/components/GiftWallSection';
import { CARD_SHADOW } from '@screens/profile/constants';

type Props = NativeStackScreenProps<RootStackParamList, 'GiftHome'>;

function HomeRow({ label, emoji, onPress }: { label: string; emoji: string; onPress: () => void }) {
  return (
    <Pressable onPress={onPress} className="flex-row items-center gap-3 px-4 py-3 active:bg-black/5">
      <Text className="text-lg">{emoji}</Text>
      <Text className="flex-1 text-sm" style={{ color: TEXT_PRIMARY }}>
        {label}
      </Text>
      <Text className="text-lg text-ola-ink-hint">›</Text>
    </Pressable>
  );
}

export function GiftHomeScreen({ navigation }: Props) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const userId = useAuthStore((s) => s.user?.id ?? '');
  const charm = useAuthStore((s) => s.user?.charm ?? 0);
  const refreshUser = useAuthStore((s) => s.refreshUser);

  useEffect(() => {
    void refreshUser();
  }, [refreshUser]);

  return (
    <View className="flex-1 bg-ola-surface">
      <ScreenHeader title={t('home.apps.gifts')} onBack={() => navigation.goBack()} />
      <ScrollView contentContainerStyle={{ paddingBottom: insets.bottom + 16 }}>
        <View className="mb-2 items-center px-4 py-5">
          <LinearGradient
            colors={GIFT_HEADER_GRADIENT}
            start={{ x: 0, y: 0 }}
            end={{ x: 1, y: 1 }}
            style={StyleSheet.absoluteFill}
          />
          <Text className="text-sm" style={{ color: 'rgba(255,255,255,0.85)' }}>
            {t('gift.charm')}
          </Text>
          <Text className="mt-1 text-3xl font-bold text-white">{`✨ ${formatKen(charm)}`}</Text>
        </View>

        <View className="mb-2 bg-white" style={CARD_SHADOW}>
          <HomeRow
            emoji="🏆"
            label={t('gift.wall.leaderboard')}
            onPress={() => navigation.navigate(ROOT_ROUTES.GiftLeaderboard)}
          />
          <View className="mx-4" style={{ height: 1, backgroundColor: DIVIDER }} />
          <HomeRow
            emoji="🎁"
            label={t('gift.wall.history')}
            onPress={() => navigation.navigate(ROOT_ROUTES.GiftHistory)}
          />
        </View>

        <GiftWallSection userId={userId} isSelf refreshKey={0} />
      </ScrollView>
    </View>
  );
}
