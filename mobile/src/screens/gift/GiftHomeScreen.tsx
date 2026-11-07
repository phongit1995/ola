import { useCallback, useEffect, useRef, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, type ImageSourcePropType, Platform, Pressable, ScrollView, StyleSheet, Text, View } from 'react-native';
import LinearGradient from 'react-native-linear-gradient';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import type { NativeStackScreenProps } from '@react-navigation/native-stack';
import { GIFT_SOURCE } from '@ola/shared/constants';
import { formatKen } from '@ola/shared/lib';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { useGiftCatalogStore } from '@ola/shared/stores/gift/giftCatalogStore';
import type { RootStackParamList } from '@navigation/types';
import { ROOT_ROUTES } from '@navigation/routes';
import { ScreenHeader } from '@components/ui/ScreenHeader';
import { GIFT_ACCENT_DARK, GIFT_HEADER_GRADIENT } from '@components/gift/constants';
import { GIFT_ASSETS } from '@components/gift/giftAssets';
import { GiftPickerDialog, type GiftReceiver } from '@components/gift/GiftPickerDialog';
import { GiftWallSection } from '@screens/profile/components/GiftWallSection';
import { CharmIcon } from '@components/gift/CharmIcon';
import { GiftRecipientDialog } from './components/GiftRecipientDialog';

type Props = NativeStackScreenProps<RootStackParamList, 'GiftHome'>;

const ACTION_ICON_STYLE = { width: 20, height: 20 };

function HeaderAction({
  label,
  icon,
  onPress,
}: {
  label: string;
  icon: ImageSourcePropType;
  onPress: () => void;
}) {
  return (
    <Pressable
      onPress={onPress}
      className="h-8 flex-row items-center gap-1 rounded-full bg-white/15 px-2 active:bg-white/25"
    >
      <Image source={icon} style={ACTION_ICON_STYLE} resizeMode="contain" />
      <Text className="text-xs font-medium text-white">{label}</Text>
    </Pressable>
  );
}

export function GiftHomeScreen({ navigation }: Props) {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const userId = useAuthStore((s) => s.user?.id ?? '');
  const charm = useAuthStore((s) => s.user?.charm ?? 0);
  const refreshUser = useAuthStore((s) => s.refreshUser);
  const giftsEnabled = useGiftCatalogStore((s) => s.settings.enabled);
  const loadGiftSettings = useGiftCatalogStore((s) => s.loadSettings);
  const [recipientOpen, setRecipientOpen] = useState(false);
  const [receiver, setReceiver] = useState<GiftReceiver | null>(null);
  const pendingReceiverRef = useRef<GiftReceiver | null>(null);

  useEffect(() => {
    void refreshUser();
    void loadGiftSettings();
  }, [refreshUser, loadGiftSettings]);

  const openPendingReceiver = useCallback(() => {
    const picked = pendingReceiverRef.current;
    pendingReceiverRef.current = null;
    if (picked != null) setReceiver(picked);
  }, []);

  function pickReceiver(picked: GiftReceiver) {
    pendingReceiverRef.current = picked;
    setRecipientOpen(false);
    if (Platform.OS !== 'ios') requestAnimationFrame(openPendingReceiver);
  }

  return (
    <View className="flex-1 bg-ola-surface">
      <ScreenHeader
        title={t('home.apps.gifts')}
        onBack={() => navigation.goBack()}
        right={
          <View className="flex-row gap-1">
            <HeaderAction
              icon={GIFT_ASSETS.leaderboard}
              label={t('gift.wall.leaderboard')}
              onPress={() => navigation.navigate(ROOT_ROUTES.GiftLeaderboard)}
            />
            <HeaderAction
              icon={GIFT_ASSETS.history}
              label={t('gift.wall.history')}
              onPress={() => navigation.navigate(ROOT_ROUTES.GiftHistory)}
            />
          </View>
        }
      />
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
          <View className="mt-1 flex-row items-center justify-center" style={{ gap: 8 }}>
            <Text className="text-3xl font-bold text-white">{formatKen(charm)}</Text>
            <CharmIcon size={34} />
          </View>
          {giftsEnabled && (
            <Pressable
              onPress={() => setRecipientOpen(true)}
              className="mt-3 flex-row items-center gap-1.5 rounded-full bg-white px-5 py-1.5 active:opacity-80"
            >
              <Image source={GIFT_ASSETS.sendNow} style={ACTION_ICON_STYLE} resizeMode="contain" />
              <Text className="text-sm font-semibold" style={{ color: GIFT_ACCENT_DARK }}>
                {t('gift.sendNow')}
              </Text>
            </Pressable>
          )}
        </View>

        <GiftWallSection userId={userId} isSelf refreshKey={0} columns={4} />
      </ScrollView>

      <GiftRecipientDialog
        visible={recipientOpen}
        onClose={() => setRecipientOpen(false)}
        onDismiss={openPendingReceiver}
        onPick={pickReceiver}
      />
      {receiver != null && (
        <GiftPickerDialog
          source={GIFT_SOURCE.profile}
          receiver={receiver}
          onClose={() => setReceiver(null)}
          onSent={() => void refreshUser()}
        />
      )}
    </View>
  );
}
