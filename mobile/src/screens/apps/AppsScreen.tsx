import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, Pressable, ScrollView, Text, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { useNavigation } from '@react-navigation/native';
import type { NativeStackNavigationProp } from '@react-navigation/native-stack';
import { formatKen } from '@ola/shared/lib';
import { AuthService, SocketService } from '@ola/shared/services';
import { useAppNotificationStore } from '@ola/shared/stores/appNotificationStore';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import type { RootStackParamList } from '@navigation/types';
import { ROOT_ROUTES } from '@navigation/routes';
import { CachedImage } from '@components/ui/CachedImage';
import { ConfirmDialog } from '@components/ui/ConfirmDialog';
import { trackEvent } from '@lib/telemetry';
import { useArcadeOverlayStore } from '@store/arcadeOverlayStore';
import { useArcadeStore } from '@store/arcadeStore';
import { SocialConnectionsDialog } from './SocialConnectionsDialog';
import { APP_ITEMS, type AppItem } from './constants';

const iconGameDefault = require('@assets/icons/apps/game.png');
const kenIcon = require('@assets/icons/apps/ken.png');

interface PanelRowProps {
  icon: number;
  iconUrl?: string;
  title: string;
  subtitle?: string;
  badge?: number;
  onPress: () => void;
}

function PanelRow({
  icon,
  iconUrl,
  title,
  subtitle,
  badge,
  onPress,
}: PanelRowProps) {
  return (
    <Pressable
      onPress={onPress}
      className="min-h-[72px] flex-row items-center gap-4 px-4 active:opacity-70"
      style={{
        backgroundColor: 'rgba(255,255,255,0.8)',
        borderBottomWidth: 1,
        borderBottomColor: 'rgba(0,0,0,0.12)',
      }}
    >
      <CachedImage
        uri={iconUrl}
        placeholder={icon}
        style={{ width: 40, height: 40, borderRadius: 8 }}
        resizeMode="contain"
      />
      <View className="min-w-0 flex-1">
        <Text numberOfLines={1} className="text-base font-bold text-black/87">
          {title}
        </Text>
        {subtitle != null && (
          <Text numberOfLines={1} className="text-sm text-black/54">
            {subtitle}
          </Text>
        )}
      </View>
      {badge != null && badge > 0 && (
        <View className="h-5 min-w-5 items-center justify-center rounded-full bg-ola-accent px-1.5">
          <Text className="text-xs font-bold text-white">
            {badge > 99 ? '99+' : badge}
          </Text>
        </View>
      )}
    </Pressable>
  );
}

export function AppsScreen() {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const navigation =
    useNavigation<NativeStackNavigationProp<RootStackParamList>>();
  const push = useToastStore(s => s.push);
  const miniGames = useArcadeStore(s => s.games);
  const fetchGames = useArcadeStore(s => s.fetchGames);
  const openArcade = useArcadeOverlayStore(s => s.open);
  const notifUnread = useAppNotificationStore(s => s.unreadCount);
  const user = useAuthStore(s => s.user);
  const [logoutOpen, setLogoutOpen] = useState(false);
  const [socialOpen, setSocialOpen] = useState(false);

  useEffect(() => {
    void fetchGames();
  }, [fetchGames]);

  function handleOpen(item: AppItem) {
    if (item.action === 'logout') {
      setLogoutOpen(true);
      return;
    }
    if (item.action === 'notifications') {
      navigation.navigate(ROOT_ROUTES.Notifications);
      return;
    }
    if (item.action === 'profile') {
      navigation.navigate(ROOT_ROUTES.EditProfile);
      return;
    }
    if (item.action === 'vip') {
      navigation.navigate(ROOT_ROUTES.VipStore);
      return;
    }
    if (item.action === 'ken') {
      navigation.navigate(ROOT_ROUTES.KenStore);
      return;
    }
    if (item.action === 'media') {
      navigation.navigate(ROOT_ROUTES.MediaStore);
      return;
    }
    if (item.action === 'social') {
      setSocialOpen(true);
      return;
    }
    if (item.action === 'settings') {
      navigation.navigate(ROOT_ROUTES.Settings);
      return;
    }
    if (item.action === 'pen') {
      navigation.navigate(ROOT_ROUTES.PenGame);
      return;
    }
    if (item.action === 'wheel') {
      navigation.navigate(ROOT_ROUTES.SpinWheel);
      return;
    }
    if (item.action === 'egg') {
      navigation.navigate(ROOT_ROUTES.EggGame);
      return;
    }
    push('info', t('chat.comingSoon'));
  }

  async function confirmLogout() {
    setLogoutOpen(false);
    try {
      await AuthService.logout();
    } catch {
      push('error', t('chat.logoutError'));
    } finally {
      SocketService.disconnect();
      useAuthStore.getState().clearUser();
    }
  }

  function handleOpenArcade(game: (typeof miniGames)[number]) {
    const isNewGame = useArcadeOverlayStore.getState().active == null;
    if (!openArcade(game)) {
      push('info', t('arcade.alreadyRunning'));
      return;
    }
    if (isNewGame) {
      trackEvent('arcade_open', {
        game_id: game.id,
        game_slug: game.slug,
      });
    }
  }

  function renderAppItem(item: AppItem) {
    return (
      <PanelRow
        key={item.titleKey}
        icon={item.icon}
        title={t(item.titleKey)}
        subtitle={item.subtitleKey != null ? t(item.subtitleKey) : undefined}
        badge={item.action === 'notifications' ? notifUnread : undefined}
        onPress={() => handleOpen(item)}
      />
    );
  }

  return (
    <View className="flex-1" style={{ backgroundColor: '#d5d5d5' }}>
      <View className="bg-ola-primary" style={{ paddingTop: insets.top }}>
        <View className="h-12 flex-row items-center gap-2 px-3">
          <Text
            numberOfLines={1}
            className="min-w-0 flex-1 text-sm font-medium text-white"
          >
            {user?.username != null ? `@${user.username}` : ''}
          </Text>
          <Text className="text-lg font-medium text-white">
            {t('home.tabApps')}
          </Text>
          <View className="min-w-0 flex-1 flex-row justify-end">
            <Pressable
              onPress={() => navigation.navigate(ROOT_ROUTES.KenStore)}
              className="flex-row items-center gap-1 rounded-full px-3 py-1 active:opacity-80"
              style={{ backgroundColor: 'rgba(255,255,255,0.15)' }}
            >
              <Image
                source={kenIcon}
                className="h-4 w-4"
                resizeMode="contain"
              />
              <Text className="text-sm font-bold text-white">
                {formatKen(user?.ken ?? 0)}
              </Text>
            </Pressable>
          </View>
        </View>
      </View>
      <ScrollView className="flex-1">
        {APP_ITEMS.slice(0, 1).map(renderAppItem)}
        {miniGames.map(game => (
          <PanelRow
            key={game.id}
            icon={iconGameDefault}
            iconUrl={game.iconUrl || undefined}
            title={game.name}
            subtitle={game.description || undefined}
            onPress={() => handleOpenArcade(game)}
          />
        ))}
        {APP_ITEMS.slice(1).map(renderAppItem)}
      </ScrollView>
      <ConfirmDialog
        visible={logoutOpen}
        danger
        showIcon={false}
        title={t('dialog.logoutTitle')}
        message={t('dialog.logoutMessage')}
        confirmLabel={t('dialog.logoutButton')}
        cancelLabel={t('dialog.no')}
        onConfirm={() => void confirmLogout()}
        onCancel={() => setLogoutOpen(false)}
      />
      <SocialConnectionsDialog
        visible={socialOpen}
        onClose={() => setSocialOpen(false)}
      />
    </View>
  );
}
