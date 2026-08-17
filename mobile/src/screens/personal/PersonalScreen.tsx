import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, Pressable, ScrollView, Text, View } from 'react-native';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { useNavigation } from '@react-navigation/native';
import type { NativeStackNavigationProp } from '@react-navigation/native-stack';
import { formatKen } from '@ola/shared/lib';
import { AuthService, SocketService } from '@ola/shared/services';
import { useAppNotificationStore } from '@ola/shared/stores/app-notification/appNotificationStore';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { useSavedAccountsStore } from '@ola/shared/stores/savedAccountsStore';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import type { RootStackParamList } from '@navigation/types';
import { ROOT_ROUTES } from '@navigation/routes';
import { ConfirmDialog } from '@components/ui/ConfirmDialog';
import { LobbyWallpaper } from '@components/ChatWallpaper';
import { SocialConnectionsDialog } from '../apps/SocialConnectionsDialog';
import { PERSONAL_ITEMS, type AppItem } from '../apps/constants';

const kenIcon = require('@assets/icons/apps/ken.png');

interface PanelRowProps {
  icon: number;
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
      <Image
        source={icon}
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

export function PersonalScreen() {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const navigation =
    useNavigation<NativeStackNavigationProp<RootStackParamList>>();
  const push = useToastStore(s => s.push);
  const notifUnread = useAppNotificationStore(s => s.unreadCount);
  const user = useAuthStore(s => s.user);
  const [logoutOpen, setLogoutOpen] = useState(false);
  const [removeAccountOpen, setRemoveAccountOpen] = useState(false);
  const [socialOpen, setSocialOpen] = useState(false);

  function handleOpen(item: AppItem) {
    if (item.action === 'logout') {
      setLogoutOpen(true);
      return;
    }
    if (item.action === 'remove-account') {
      setRemoveAccountOpen(true);
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
    push('info', t('chat.comingSoon'));
  }

  async function signOut() {
    try {
      await AuthService.logout();
    } catch {
      push('error', t('chat.logoutError'));
    } finally {
      SocketService.disconnect();
      useAuthStore.getState().clearUser();
    }
  }

  async function confirmLogout() {
    setLogoutOpen(false);
    await signOut();
  }

  async function confirmRemoveAccount() {
    setRemoveAccountOpen(false);

    const currentUsername = useAuthStore.getState().user?.username;
    if (currentUsername != null) {
      const normalizedUsername = currentUsername.trim().toLowerCase();
      const savedAccount = useSavedAccountsStore
        .getState()
        .accounts.find(
          account =>
            account.username.trim().toLowerCase() === normalizedUsername,
        );
      if (savedAccount != null) {
        useSavedAccountsStore.getState().removeAccount(savedAccount.username);
      }
    }

    await signOut();
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
            {t('home.tabPersonal')}
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
      <View className="flex-1">
        <LobbyWallpaper />
        <ScrollView className="flex-1">
          {PERSONAL_ITEMS.map(item => (
            <PanelRow
              key={item.titleKey}
              icon={item.icon}
              title={t(item.titleKey)}
              subtitle={
                item.subtitleKey != null ? t(item.subtitleKey) : undefined
              }
              badge={item.action === 'notifications' ? notifUnread : undefined}
              onPress={() => handleOpen(item)}
            />
          ))}
        </ScrollView>
      </View>
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
      <ConfirmDialog
        visible={removeAccountOpen}
        danger
        title={t('dialog.removeAccountTitle')}
        message={t('dialog.removeAccountMessage', {
          username: user?.username != null ? `@${user.username}` : '',
        })}
        confirmLabel={t('dialog.removeAccountButton')}
        cancelLabel={t('dialog.cancel')}
        onConfirm={() => void confirmRemoveAccount()}
        onCancel={() => setRemoveAccountOpen(false)}
      />
      <SocialConnectionsDialog
        visible={socialOpen}
        onClose={() => setSocialOpen(false)}
      />
    </View>
  );
}
