import type { NotificationAndroid } from 'react-native-notify-kit';
import { THEME_COLORS } from '@ola/shared/constants';

export const NOTIFICATION_SMALL_ICON = 'ic_notification';
export const NOTIFICATION_APP_ICON = 'ic_notification_large';
export const NOTIFICATION_COLOR = THEME_COLORS.green.primary;

export function androidNotificationBase(
  channelId: string,
  largeIcon?: string,
): NotificationAndroid {
  return {
    channelId,
    smallIcon: NOTIFICATION_SMALL_ICON,
    color: NOTIFICATION_COLOR,
    largeIcon: largeIcon || NOTIFICATION_APP_ICON,
    pressAction: { id: 'default' },
  };
}
