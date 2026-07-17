export type AppNotificationType = 'friend_request' | 'marriage_proposal';

export interface AppNotificationActor {
  id: string;
  username: string;
  fullName?: string;
  avatar?: string;
}

export interface AppNotification {
  id: string;
  type: AppNotificationType | (string & {});
  actor?: AppNotificationActor;
  refId?: string;
  preview?: string;
  isRead: boolean;
  createdAt: string;
}

export interface AppNotificationListResult {
  items: AppNotification[];
  unreadCount: number;
  nextCursor: string | null;
}

export interface AppNotificationUnreadResult {
  count: number;
}
