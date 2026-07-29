import '../global.css';
import { useEffect, useRef } from 'react';
import { AppState, StatusBar } from 'react-native';
import { GestureHandlerRootView } from 'react-native-gesture-handler';
import { KeyboardProvider } from 'react-native-keyboard-controller';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import NetInfo from '@react-native-community/netinfo';
import { NavigationContainer, useNavigationContainerRef } from '@react-navigation/native';
import type { ParamListBase } from '@react-navigation/native';
import { useTranslation } from 'react-i18next';
import { setOnUnauthorized } from '@ola/shared/api';
import { authTokens, toast } from '@ola/shared/lib';
import { SocketService } from '@ola/shared/services';
import { useAuthStore } from '@ola/shared/stores/authStore';
import { useChatStore } from '@ola/shared/stores/chat/chatStore';
import { resyncKenBalance } from '@ola/shared/stores/kenRealtime';
import { useSettingsStore } from '@ola/shared/stores/settingsStore';
import { RootNavigator } from './navigation/RootNavigator';
import { AppFontProvider } from './components/AppFontProvider';
import { StatusBarBackground } from './components/ui/StatusBarBackground';
import { ReconnectingBanner } from './components/ui/ReconnectingBanner';
import { ToastHost } from './components/ui/ToastHost';
import { MediaViewer } from './components/ui/MediaViewer';
import { useMeNotificationRealtime } from './hooks/useMeNotificationRealtime';
import { useAppNotificationRealtime } from './hooks/useAppNotificationRealtime';
import { useKenRealtime } from './hooks/useKenRealtime';
import { KenTreasureOverlay } from './screens/games/ken-treasure/KenTreasureOverlay';
import { ArcadeOverlay } from './screens/apps/ArcadeOverlay';
import { checkForOtaUpdate } from './services/otaUpdate';
import { initTelemetry, setTelemetryUser, trackScreen } from './lib/telemetry';

function clearSession() {
  authTokens.clear();
  useAuthStore.getState().clearUser();
  SocketService.disconnect();
}

export default function App() {
  useMeNotificationRealtime();
  useAppNotificationRealtime();
  useKenRealtime();
  const userId = useAuthStore((s) => s.user?.id);
  const authReady = useAuthStore((s) => s.authReady);
  const { t } = useTranslation();
  const navigationRef = useNavigationContainerRef<ParamListBase>();
  const routeNameRef = useRef<string | null>(null);
  useEffect(() => {
    if (userId != null) void useSettingsStore.getState().hydrate();
    setTelemetryUser(userId ?? null);
  }, [userId]);
  useEffect(() => {
    if (!authReady || userId == null) return;
    SocketService.connect();
    void useChatStore.getState().loadConversations();
    return () => SocketService.disconnect();
  }, [authReady, userId]);
  useEffect(() => {
    const unsubscribeReplaced = SocketService.onSessionReplaced(() => {
      clearSession();
      toast.info(t('auth.sessionReplaced'));
    });
    const unsubscribeForce = SocketService.onForceLogout(({ reason }) => {
      clearSession();
      if (reason === 'banned') toast.error(t('auth.banned'));
      else if (reason !== 'logged_out') toast.info(t('auth.sessionEnded'));
    });
    return () => {
      unsubscribeReplaced();
      unsubscribeForce();
    };
  }, [t]);
  useEffect(() => {
    initTelemetry();
    if (!__DEV__) void checkForOtaUpdate();
    setOnUnauthorized(clearSession);
    const resumeSession = () => {
      SocketService.ensureAlive();
      void resyncKenBalance();
    };
    const appStateSubscription = AppState.addEventListener('change', (state) => {
      if (state === 'active') resumeSession();
    });
    let hasNetworkState = false;
    let wasOnline = false;
    const unsubscribeNetInfo = NetInfo.addEventListener((state) => {
      const isOnline =
        state.isConnected === true && state.isInternetReachable !== false;
      if (hasNetworkState && isOnline && !wasOnline) resumeSession();
      hasNetworkState = true;
      wasOnline = isOnline;
    });
    void useAuthStore.getState().refreshUser();
    return () => {
      setOnUnauthorized(null);
      appStateSubscription.remove();
      unsubscribeNetInfo();
    };
  }, []);

  return (
    <GestureHandlerRootView style={{ flex: 1 }}>
      <AppFontProvider>
        <KeyboardProvider statusBarTranslucent navigationBarTranslucent>
          <SafeAreaProvider>
            <StatusBar translucent barStyle="light-content" />
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
            <StatusBarBackground />
            <ReconnectingBanner />
            <KenTreasureOverlay />
            <ArcadeOverlay />
            <ToastHost />
            <MediaViewer />
          </SafeAreaProvider>
        </KeyboardProvider>
      </AppFontProvider>
    </GestureHandlerRootView>
  );
}
