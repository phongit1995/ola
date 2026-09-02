import { Platform } from 'react-native';
import {
  getMessaging,
  getToken,
  onTokenRefresh,
  setBackgroundMessageHandler,
} from '@react-native-firebase/messaging';
import type { FirebaseMessagingTypes } from '@react-native-firebase/messaging';
import type { ParseKeys } from 'i18next';
import notifee, { AndroidImportance, EventType, type Event } from 'react-native-notify-kit';
import { CommonActions } from '@react-navigation/native';
import type { NavigationContainerRefWithCurrent } from '@react-navigation/native';
import type { ParamListBase } from '@react-navigation/native';
import { PushService } from '@ola/shared/services';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import i18n from '../i18n';
import { ROOT_ROUTES } from '../navigation/routes';

type PushData = Record<string, string>;
type NavRef = NavigationContainerRefWithCurrent<ParamListBase>;

const CHANNELS = ['messages', 'social', 'system'] as const;
const CHANNEL_NAME_KEYS = {
  messages: 'push.channelMessages',
  social: 'push.channelSocial',
  system: 'push.channelSystem',
} as const satisfies Record<(typeof CHANNELS)[number], ParseKeys>;

let navRef: NavRef | null = null;
let pendingData: PushData | null = null;

const isAndroid = Platform.OS === 'android';

function extractData(
  message: FirebaseMessagingTypes.RemoteMessage,
): PushData | null {
  const raw = message.data;
  if (raw == null) return null;
  const data: PushData = {};
  for (const [key, value] of Object.entries(raw)) {
    if (typeof value === 'string') data[key] = value;
  }
  return data;
}

async function displayPush(data: PushData): Promise<void> {
  if (!data.title || !data.body) return;
  const channelId = (CHANNELS as readonly string[]).includes(data.channel)
    ? data.channel
    : 'messages';
  try {
    await notifee.displayNotification({
      id: data.notifId || undefined,
      title: data.title,
      body: data.body,
      data,
      android: {
        channelId,
        pressAction: { id: 'default' },
      },
    });
  } catch {
    return;
  }
}

function routeFromData(data: PushData): { name: string; params?: object } | null {
  switch (data.type) {
    case 'dm':
      if (!data.conversationId) return null;
      return { name: ROOT_ROUTES.ChatDetail, params: { conversationId: data.conversationId } };
    case 'me_notification':
      return { name: ROOT_ROUTES.MeNotifications };
    case 'app_notification':
      return { name: ROOT_ROUTES.Notifications };
    default:
      return null;
  }
}

function tryNavigate(): void {
  if (pendingData == null) return;
  const ref = navRef;
  const { authReady, user } = useAuthStore.getState();
  const mainMounted =
    ref?.isReady() === true &&
    (ref.getRootState()?.routeNames ?? []).includes(ROOT_ROUTES.MainTabs);
  if (!authReady || user == null || !mainMounted) return;
  const route = routeFromData(pendingData);
  pendingData = null;
  if (route == null) return;
  ref.dispatch(CommonActions.navigate({ name: route.name, params: route.params }));
}

function queueNavigation(data: PushData | null | undefined): void {
  if (data == null || routeFromData(data) == null) return;
  pendingData = data;
  tryNavigate();
}

function notificationEventData(event: Event): PushData | null {
  if (event.type !== EventType.PRESS) return null;
  const data = event.detail.notification?.data;
  if (data == null) return null;
  const result: PushData = {};
  for (const [key, value] of Object.entries(data)) {
    if (typeof value === 'string') result[key] = value;
  }
  return result;
}

export function registerPushBackgroundHandler(): void {
  if (!isAndroid) return;
  setBackgroundMessageHandler(getMessaging(), async (message) => {
    const data = extractData(message);
    if (data != null) await displayPush(data);
  });
  notifee.onBackgroundEvent(async (event) => {
    const data = notificationEventData(event);
    if (data != null) queueNavigation(data);
  });
}

export function initPush(ref: NavRef): () => void {
  if (!isAndroid) return () => undefined;
  navRef = ref;

  void (async () => {
    try {
      await notifee.requestPermission();
      await Promise.all(
        CHANNELS.map((id) =>
          notifee.createChannel({
            id,
            name: i18n.t(CHANNEL_NAME_KEYS[id]),
            importance: AndroidImportance.HIGH,
          }),
        ),
      );
      const initial = await notifee.getInitialNotification();
      const data = initial?.notification.data;
      if (data != null) {
        const parsed: PushData = {};
        for (const [key, value] of Object.entries(data)) {
          if (typeof value === 'string') parsed[key] = value;
        }
        queueNavigation(parsed);
      }
    } catch {
      return;
    }
  })();

  const unsubscribeForeground = notifee.onForegroundEvent((event) => {
    const data = notificationEventData(event);
    if (data != null) queueNavigation(data);
  });
  const unsubscribeAuth = useAuthStore.subscribe(() => {
    if (pendingData != null) tryNavigate();
  });

  return () => {
    unsubscribeForeground();
    unsubscribeAuth();
    navRef = null;
  };
}

export function notifyPushNavReady(): void {
  if (pendingData != null) tryNavigate();
}

export async function registerPushToken(): Promise<void> {
  if (!isAndroid) return;
  try {
    const token = await getToken(getMessaging());
    if (token) await PushService.registerToken(token);
  } catch {
    return;
  }
}

export function watchPushTokenRefresh(): () => void {
  if (!isAndroid) return () => undefined;
  return onTokenRefresh(getMessaging(), (token) => {
    if (useAuthStore.getState().user == null) return;
    void PushService.registerToken(token).catch(() => undefined);
  });
}
