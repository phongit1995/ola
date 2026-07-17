import { http } from '../api';
import { API_PATH } from '../config';
import type {
  AppNotificationListResult,
  AppNotificationUnreadResult,
  MessageResult,
} from '../types';

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
