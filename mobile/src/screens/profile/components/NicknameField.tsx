import { useEffect, useState } from 'react';
import { useTranslation } from 'react-i18next';
import { Image, Pressable, Text, View } from 'react-native';
import { authTokens } from '@ola/shared/lib';
import { SocketService } from '@ola/shared/services';
import { requireAppConfig } from '@ola/shared/stores/appConfigStore';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { removeSavedAccount } from '@lib/session';
import { TEXT_SECONDARY } from '@constants';
import { ChangeNicknameDialog } from './ChangeNicknameDialog';

const nicknameIcon = require('@assets/icons/apps/nickname.png');

export function NicknameField({ username }: { username: string }) {
  const { t } = useTranslation();
  const [dialogOpen, setDialogOpen] = useState(false);
  const [changeEnabled, setChangeEnabled] = useState(false);

  useEffect(() => {
    let cancelled = false;
    requireAppConfig('usernameChange')
      .then((config) => {
        if (!cancelled) setChangeEnabled(config.enabled && config.enabledMobile === true);
      })
      .catch(() => {});
    return () => {
      cancelled = true;
    };
  }, []);

  function handleChanged() {
    setDialogOpen(false);
    removeSavedAccount(username);
    authTokens.clear();
    SocketService.disconnect();
    useAuthStore.getState().clearUser();
  }

  return (
    <>
      <View
        className="flex-row items-center gap-2 rounded-lg py-1.5 pl-3 pr-1.5"
        style={{ minHeight: 40, backgroundColor: 'rgba(0,0,0,0.05)' }}
      >
        <Text className="flex-1 text-sm" style={{ color: TEXT_SECONDARY }} numberOfLines={1}>
          {`@${username}`}
        </Text>
        {changeEnabled && (
          <Pressable
            onPress={() => setDialogOpen(true)}
            className="flex-row items-center gap-1 rounded bg-ola-primary px-2.5 py-1"
          >
            <Image source={nicknameIcon} style={{ width: 16, height: 16 }} resizeMode="contain" />
            <Text className="text-xs font-medium text-white">{t('profileEdit.changeNickname')}</Text>
          </Pressable>
        )}
      </View>
      <ChangeNicknameDialog
        visible={dialogOpen}
        onClose={() => setDialogOpen(false)}
        onSuccess={handleChanged}
      />
    </>
  );
}
