import type { ParseKeys } from 'i18next';
import notifee, {
  AndroidImportance,
  TriggerType,
  type TimestampTrigger,
} from 'react-native-notify-kit';
import { useAuthStore } from '@ola/shared/stores/auth/authStore';
import { androidNotificationBase } from '@lib/notificationAndroid';
import i18n from '../i18n';

const REMINDER_ID = 'come-back-reminder';
const LEGACY_CHANNEL_ID = 'reminders';
const CHANNEL_ID = 'reminders_v2';
const REMINDER_DELAY_MS = 2 * 24 * 60 * 60 * 1000;

const MESSAGE_KEYS = [
  'reminder.m1',
  'reminder.m2',
  'reminder.m3',
  'reminder.m4',
  'reminder.m5',
  'reminder.m6',
  'reminder.m7',
  'reminder.m8',
  'reminder.m9',
  'reminder.m10',
  'reminder.m11',
  'reminder.m12',
  'reminder.m13',
  'reminder.m14',
  'reminder.m15',
  'reminder.m16',
  'reminder.m17',
  'reminder.m18',
  'reminder.m19',
  'reminder.m20',
] as const satisfies readonly ParseKeys[];

function randomMessageKey(): ParseKeys {
  return MESSAGE_KEYS[Math.floor(Math.random() * MESSAGE_KEYS.length)];
}

async function migrateLegacyChannel(): Promise<void> {
  try {
    const channel = await notifee.getChannel(LEGACY_CHANNEL_ID);
    if (channel == null) return;
    await notifee.cancelTriggerNotification(REMINDER_ID);
    await notifee.deleteChannel(LEGACY_CHANNEL_ID);
    await scheduleComeBackReminder();
  } catch {
    return;
  }
}

export async function initComeBackReminder(): Promise<void> {
  try {
    await notifee.requestPermission();
    await notifee.createChannel({
      id: CHANNEL_ID,
      name: i18n.t('reminder.channelName'),
      importance: AndroidImportance.DEFAULT,
      badge: false,
    });
  } catch {
    return;
  }
  await migrateLegacyChannel();
}

export async function scheduleComeBackReminder(): Promise<void> {
  if (useAuthStore.getState().user == null) return;
  const trigger: TimestampTrigger = {
    type: TriggerType.TIMESTAMP,
    timestamp: Date.now() + REMINDER_DELAY_MS,
  };
  try {
    await notifee.cancelTriggerNotification(REMINDER_ID);
    await notifee.createTriggerNotification(
      {
        id: REMINDER_ID,
        title: i18n.t('reminder.comeBackTitle'),
        body: i18n.t(randomMessageKey()),
        android: androidNotificationBase(CHANNEL_ID),
      },
      trigger,
    );
  } catch {
    return;
  }
}

export async function cancelComeBackReminder(): Promise<void> {
  try {
    await notifee.cancelTriggerNotification(REMINDER_ID);
  } catch {
    return;
  }
}
