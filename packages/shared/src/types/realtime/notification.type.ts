import type { AppNotification } from '../api/notification.type';
import type { MeNotification } from '../api/me.type';

export interface AppNotificationIncoming {
  notification?: AppNotification | null;
  removedId?: string | null;
  unreadCount: number;
}

export interface MeNotificationIncoming {
  notification?: MeNotification | null;
  removedId?: string | null;
  unreadCount: number;
}
