import { useSyncExternalStore } from 'react';
import { ActivityIndicator, Text, View } from 'react-native';
import { useTranslation } from 'react-i18next';
import { useSafeAreaInsets } from 'react-native-safe-area-context';
import { SocketService } from '@ola/shared/services';

export function ReconnectingBanner() {
  const { t } = useTranslation();
  const insets = useSafeAreaInsets();
  const status = useSyncExternalStore(SocketService.subscribeStatus, SocketService.getStatus);
  if (status !== 'reconnecting') return null;
  return (
    <View
      pointerEvents="none"
      style={{
        position: 'absolute',
        left: 0,
        right: 0,
        top: insets.top + 8,
        zIndex: 50,
        alignItems: 'center',
      }}
    >
      <View
        className="flex-row items-center gap-2 rounded-full px-3 py-1.5"
        style={{ backgroundColor: 'rgba(0,0,0,0.75)' }}
      >
        <ActivityIndicator size="small" color="#ffffff" />
        <Text className="text-sm text-white">{t('connection.reconnecting')}</Text>
      </View>
    </View>
  );
}
