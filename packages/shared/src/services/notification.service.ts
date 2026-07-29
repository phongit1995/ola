import { http } from '../api/http';
import { API_PATH } from '../config/api';
import type { MessageResult } from '../types/api/auth.type';
import type {
  AppNotificationListResult,
  AppNotificationUnreadResult,
} from '../types/api/notification.type';

export class NotificationService {
  static list(params: { limit?: number; cursor?: string } = {}): Promise<AppNotificationListResult> {
    return http.get<AppNotificationListResult>(API_PATH.notifications.base, { params });
  }

  static unreadCount(): Promise<AppNotificationUnreadResult> {
    return http.get<AppNotificationUnreadResult>(API_PATH.notifications.unread);
  }

  static markAllRead(): Promise<MessageResult> {
    return http.post<MessageResult>(API_PATH.notifications.readAll, {});
  }
}
