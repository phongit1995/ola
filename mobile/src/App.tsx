import '../global.css';
import { useEffect } from 'react';
import { AppState, StatusBar } from 'react-native';
import { GestureHandlerRootView } from 'react-native-gesture-handler';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import { NavigationContainer } from '@react-navigation/native';
import { setOnUnauthorized } from '@ola/shared/api';
import { authTokens } from '@ola/shared/lib';
import { SocketService } from '@ola/shared/services';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { useSettingsStore } from '@ola/shared/stores/settingsStore';
import { RootNavigator } from './navigation/RootNavigator';
import { ToastHost } from './components/ToastHost';
import { MediaViewer } from './components/MediaViewer';
import { useMeNotificationRealtime } from './hooks/useMeNotificationRealtime';
import { checkForOtaUpdate } from './services/otaUpdate';

function clearSession() {
  authTokens.clear();
  useAuthStore.getState().clearUser();
  SocketService.disconnect();
}

export default function App() {
  useMeNotificationRealtime();
  const userId = useAuthStore((s) => s.user?.id);
  useEffect(() => {
    if (userId != null) void useSettingsStore.getState().hydrate();
  }, [userId]);
  useEffect(() => {
    if (!__DEV__) void checkForOtaUpdate();
    setOnUnauthorized(clearSession);
    const unsubscribeSession = SocketService.onSessionReplaced(() => clearSession());
    const appStateSubscription = AppState.addEventListener('change', (state) => {
      if (state === 'active') SocketService.ensureAlive();
    });
    void useAuthStore.getState().refreshUser();
    return () => {
      setOnUnauthorized(null);
      unsubscribeSession();
      appStateSubscription.remove();
    };
  }, []);

  return (
    <GestureHandlerRootView style={{ flex: 1 }}>
      <SafeAreaProvider>
        <StatusBar barStyle="light-content" backgroundColor="#7cb342" />
        <NavigationContainer>
          <RootNavigator />
        </NavigationContainer>
        <ToastHost />
        <MediaViewer />
      </SafeAreaProvider>
    </GestureHandlerRootView>
  );
}
