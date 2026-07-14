import '../global.css';
import { useEffect, useRef } from 'react';
import { AppState, StatusBar } from 'react-native';
import { GestureHandlerRootView } from 'react-native-gesture-handler';
import { KeyboardProvider } from 'react-native-keyboard-controller';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import { NavigationContainer, useNavigationContainerRef } from '@react-navigation/native';
import type { ParamListBase } from '@react-navigation/native';
import { setOnUnauthorized } from '@ola/shared/api';
import { authTokens } from '@ola/shared/lib';
import { SocketService } from '@ola/shared/services';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { useSettingsStore } from '@ola/shared/stores/settingsStore';
import { RootNavigator } from './navigation/RootNavigator';
import { ToastHost } from './components/ToastHost';
import { MediaViewer } from './components/MediaViewer';
import { useMeNotificationRealtime } from './hooks/useMeNotificationRealtime';
import { useKenRealtime } from './hooks/useKenRealtime';
import { KenTreasureOverlay } from './screens/games/ken-treasure/KenTreasureOverlay';
import { checkForOtaUpdate } from './services/otaUpdate';
import { initTelemetry, setTelemetryUser, trackScreen } from './lib/telemetry';

function clearSession() {
  authTokens.clear();
  useAuthStore.getState().clearUser();
  SocketService.disconnect();
}

export default function App() {
  useMeNotificationRealtime();
  useKenRealtime();
  const userId = useAuthStore((s) => s.user?.id);
  const navigationRef = useNavigationContainerRef<ParamListBase>();
  const routeNameRef = useRef<string | null>(null);
  useEffect(() => {
    if (userId != null) void useSettingsStore.getState().hydrate();
    setTelemetryUser(userId ?? null);
  }, [userId]);
  useEffect(() => {
    initTelemetry();
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
      <KeyboardProvider statusBarTranslucent navigationBarTranslucent>
      <SafeAreaProvider>
        <StatusBar barStyle="light-content" backgroundColor="#7cb342" />
        <NavigationContainer
          ref={navigationRef}
          onReady={() => {
            const name = navigationRef.getCurrentRoute()?.name ?? null;
            routeNameRef.current = name;
            if (name != null) trackScreen(name);
          }}
          onStateChange={() => {
            const name = navigationRef.getCurrentRoute()?.name ?? null;
            if (name != null && name !== routeNameRef.current) {
              routeNameRef.current = name;
              trackScreen(name);
            }
          }}
        >
          <RootNavigator />
        </NavigationContainer>
        <KenTreasureOverlay />
        <ToastHost />
        <MediaViewer />
      </SafeAreaProvider>
      </KeyboardProvider>
    </GestureHandlerRootView>
  );
}
