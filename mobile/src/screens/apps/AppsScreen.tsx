import { useEffect } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, Pressable, ScrollView, Text, View, type ImageSourcePropType } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { useNavigation } from '@react-navigation/native';
import type { NativeStackNavigationProp } from '@react-navigation/native-stack';
import { useAppNotificationStore } from '@ola/shared/stores/appNotificationStore';
import { useToastStore } from '@ola/shared/stores/toastStore';
import type { RootStackParamList } from '@navigation/types';
import { ROOT_ROUTES } from '@navigation/routes';
import { useArcadeStore } from '@store/arcadeStore';
import { APP_ITEMS, type AppItem } from './constants';

const iconGameDefault = require('@assets/icons/apps/game.png');

interface PanelRowProps {
  icon: ImageSourcePropType;
  title: string;
  subtitle?: string;
  badge?: number;
  onPress: () => void;
}

function PanelRow({ icon, title, subtitle, badge, onPress }: PanelRowProps) {
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
      <Image source={icon} className="h-10 w-10 rounded-lg" resizeMode="contain" />
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
          <Text className="text-xs font-bold text-white">{badge > 99 ? '99+' : badge}</Text>
        </View>
      )}
    </Pressable>
  );
}

export function AppsScreen() {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const navigation = useNavigation<NativeStackNavigationProp<RootStackParamList>>();
  const push = useToastStore((s) => s.push);
  const miniGames = useArcadeStore((s) => s.games);
  const fetchGames = useArcadeStore((s) => s.fetchGames);
  const notifUnread = useAppNotificationStore((s) => s.unreadCount);

  useEffect(() => {
    void fetchGames();
  }, [fetchGames]);

  function handleOpen(item: AppItem) {
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
        <View className="h-12 items-center justify-center px-2">
          <Text className="text-lg font-medium text-white">{t('home.tabApps')}</Text>
        </View>
      </View>
      <ScrollView className="flex-1">
        {APP_ITEMS.slice(0, 1).map(renderAppItem)}
        {miniGames.map((game) => (
          <PanelRow
            key={game.id}
            icon={game.iconUrl ? { uri: game.iconUrl } : iconGameDefault}
            title={game.name}
            subtitle={game.description || undefined}
            onPress={() => navigation.navigate(ROOT_ROUTES.ArcadeGame, { game })}
          />
        ))}
        {APP_ITEMS.slice(1).map(renderAppItem)}
      </ScrollView>
    </View>
  );
}
