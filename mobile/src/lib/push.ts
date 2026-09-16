import { Platform } from 'react-native';
import {
  getMessaging,
  getToken,
  onTokenRefresh,
  setBackgroundMessageHandler,
} from '@react-native-firebase/messaging';
import type { FirebaseMessagingTypes } from '@react-native-firebase/messaging';
import type { ParseKeys } from 'i18next';
import notifee, {
  AndroidBadgeIconType,
  AndroidImportance,
  AndroidStyle,
  AndroidVisibility,
  EventType,
  type AndroidPerson,
  type DisplayedNotification,
  type Event,
  type NotificationAndroid,
} from 'react-native-notify-kit';
import { CommonActions } from '@react-navigation/native';
import type { NavigationContainerRefWithCurrent } from '@react-navigation/native';
import type { ParamListBase } from '@react-navigation/native';
import { PushService } from '@ola/shared/services';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { useChatStore } from '@ola/shared/stores/chat/chatStore';
import { useMeNotificationStore } from '@ola/shared/stores/meNotificationStore';
import { useAppNotificationStore } from '@ola/shared/stores/app-notification/appNotificationStore';
import { androidNotificationBase } from '@lib/notificationAndroid';
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

const DM_NOTIF_PREFIX = 'dm:';
export const ME_NOTIF_ID = 'me';
export const APP_NOTIF_ID = 'app';
const INBOX_MAX_LINES = 5;
const TRAY_SYNC_DEBOUNCE_MS = 300;

let navRef: NavRef | null = null;
let pendingData: PushData | null = null;

const isAndroid = Platform.OS === 'android';

export function dmNotifId(conversationId: string): string {
  return DM_NOTIF_PREFIX + conversationId;
}

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

function sentAtMs(value: string | undefined): number {
  const parsed = value ? Date.parse(value) : Number.NaN;
  return Number.isNaN(parsed) ? Date.now() : parsed;
}

function person(name: string, id?: string, icon?: string): AndroidPerson {
  const out: AndroidPerson = { name };
  if (id) out.id = id;
  if (icon) out.icon = icon;
  return out;
}

function unreadOf(data: PushData): number {
  const parsed = Number.parseInt(data.unreadCount ?? '', 10);
  return Number.isFinite(parsed) && parsed > 0 ? parsed : 0;
}

type InboxLine = { id: string; text: string };

function parseLines(raw: unknown): InboxLine[] {
  if (typeof raw !== 'string') return [];
  try {
    const parsed: unknown = JSON.parse(raw);
    if (!Array.isArray(parsed)) return [];
    return parsed.filter(
      (v): v is InboxLine =>
        typeof v === 'object' && v != null && typeof (v as InboxLine).text === 'string',
    );
  } catch {
    return [];
  }
}

function ownedBy(data: Record<string, unknown> | undefined, ownerId: string): boolean {
  const owner = stringField(data, 'ownerId');
  return owner === '' || owner === ownerId;
}

async function previousLines(notifId: string, ownerId: string): Promise<InboxLine[]> {
  try {
    const displayed = await notifee.getDisplayedNotifications();
    const match = displayed.find((item) => item.id === notifId);
    if (match == null || !ownedBy(match.notification.data, ownerId)) return [];
    return parseLines(match.notification.data?.lines);
  } catch {
    return [];
  }
}

async function inboxLines(data: PushData, notifId: string, ownerId: string): Promise<InboxLine[]> {
  const unread = unreadOf(data);
  const current: InboxLine = { id: data.itemId ?? '', text: `${data.title}: ${data.body}` };
  if (unread <= 1) return [current];
  const previous = (await previousLines(notifId, ownerId)).filter(
    (line) => line.id === '' || line.id !== current.id,
  );
  return [current, ...previous].slice(0, Math.min(unread, INBOX_MAX_LINES));
}

function androidOptions(
  data: PushData,
  channelId: string,
  lines: InboxLine[],
): NotificationAndroid {
  const base = androidNotificationBase(channelId, data.senderAvatar);
  const unread = unreadOf(data);
  const withBadge: NotificationAndroid = {
    ...base,
    badgeIconType: AndroidBadgeIconType.SMALL,
    ...(unread > 0 ? { badgeCount: unread } : {}),
  };
  if (lines.length > 1) {
    return {
      ...withBadge,
      style: {
        type: AndroidStyle.INBOX,
        lines: lines.map((line) => line.text),
        title: i18n.t('push.newCount', { count: unread }),
        summary: data.title,
      },
    };
  }
  if (data.type !== 'dm') return withBadge;
  const me = useAuthStore.getState().user;
  return {
    ...withBadge,
    visibility: AndroidVisibility.PRIVATE,
    style: {
      type: AndroidStyle.MESSAGING,
      person: person(me?.fullName || me?.username || i18n.t('push.you'), me?.id),
      messages: [
        {
          text: data.body,
          timestamp: sentAtMs(data.sentAt),
          person: person(data.title, data.senderId, data.senderAvatar),
        },
      ],
    },
  };
}

async function displayPush(data: PushData): Promise<void> {
  if (!data.title || !data.body) return;
  const channelId = (CHANNELS as readonly string[]).includes(data.channel)
    ? data.channel
    : 'messages';
  const notifId = data.notifId || '';
  const ownerId = useAuthStore.getState().user?.id ?? '';
  const lines = notifId && data.type !== 'dm' ? await inboxLines(data, notifId, ownerId) : [];
  const payload: PushData = {
    ...data,
    ...(ownerId ? { ownerId } : {}),
    ...(lines.length > 0 ? { lines: JSON.stringify(lines) } : {}),
  };
  try {
    await notifee.displayNotification({
      ...(notifId ? { id: notifId } : {}),
      title: data.title,
      body: data.body,
      data: payload,
      android: androidOptions(data, channelId, lines),
    });
  } catch {
    return;
  }
}

export async function clearPushNotification(id: string): Promise<void> {
  if (!isAndroid) return;
  try {
    await notifee.cancelDisplayedNotification(id);
  } catch {
    return;
  }
}

export async function clearAllPushNotifications(): Promise<void> {
  if (!isAndroid) return;
  try {
    await notifee.cancelDisplayedNotifications();
  } catch {
    return;
  }
}

function stringField(data: Record<string, unknown> | undefined, key: string): string {
  const value = data?.[key];
  return typeof value === 'string' ? value : '';
}

const TRAY_STORES = {
  [ME_NOTIF_ID]: useMeNotificationStore,
  [APP_NOTIF_ID]: useAppNotificationStore,
} as const;

function trayStoreOf(id: string) {
  return id === ME_NOTIF_ID || id === APP_NOTIF_ID ? TRAY_STORES[id] : null;
}

function isReadInStore(item: DisplayedNotification, ownerId: string): boolean {
  const id = item.id;
  const data = item.notification.data;
  if (id == null || !ownedBy(data, ownerId)) return false;
  const store = trayStoreOf(id);
  if (store != null) {
    const itemId = stringField(data, 'itemId');
    const { unreadCount, items } = store.getState();
    return unreadCount === 0 && items.some((n) => n.id === itemId);
  }
  if (!id.startsWith(DM_NOTIF_PREFIX)) return false;
  const conversationId = id.slice(DM_NOTIF_PREFIX.length);
  const conversation = useChatStore.getState().conversations.find((c) => c.id === conversationId);
  if (conversation == null || (conversation.unreadCount ?? 0) > 0) return false;
  const sentAt = Date.parse(stringField(data, 'sentAt'));
  const lastMessageAt = Date.parse(conversation.lastMessageAt ?? '');
  return Number.isFinite(sentAt) && Number.isFinite(lastMessageAt) && lastMessageAt >= sentAt;
}

async function syncPushTray(): Promise<void> {
  if (!isAndroid) return;
  const ownerId = useAuthStore.getState().user?.id ?? '';
  if (!ownerId) return;
  try {
    const displayed = await notifee.getDisplayedNotifications();
    const stale = displayed
      .filter((item) => isReadInStore(item, ownerId))
      .map((item) => item.id)
      .filter((id): id is string => id != null);
    if (stale.length === 0) return;
    await notifee.cancelDisplayedNotifications(stale);
  } catch {
    return;
  }
}

function watchPushTray(): () => void {
  let timer: ReturnType<typeof setTimeout> | null = null;
  const schedule = () => {
    if (timer != null) clearTimeout(timer);
    timer = setTimeout(() => {
      timer = null;
      void syncPushTray();
    }, TRAY_SYNC_DEBOUNCE_MS);
  };
  const unsubscribes = [
    useChatStore.subscribe((state, prev) => {
      if (state.conversations === prev.conversations) return;
      const before = new Map(prev.conversations.map((c) => [c.id, c.unreadCount ?? 0]));
      const becameRead = state.conversations.some(
        (c) => (c.unreadCount ?? 0) === 0 && (before.get(c.id) ?? -1) !== 0,
      );
      if (becameRead) schedule();
    }),
    ...Object.values(TRAY_STORES).map((store) =>
      store.subscribe((state, prev) => {
        if (state.unreadCount !== 0) return;
        if (prev.unreadCount !== 0 || state.items !== prev.items) schedule();
      }),
    ),
  ];
  return () => {
    if (timer != null) clearTimeout(timer);
    unsubscribes.forEach((fn) => fn());
  };
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
            badge: true,
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
  const unsubscribeTray = watchPushTray();

  return () => {
    unsubscribeForeground();
    unsubscribeAuth();
    unsubscribeTray();
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
