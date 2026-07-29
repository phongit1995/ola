import type { AppNotification } from '../api/notification.type';
import type { MeNotification } from '../api/me.type';
import type {
  AppNotificationIncoming,
  MeNotificationIncoming,
} from '../realtime/notification.type';

interface NotificationStateBase<TNotification> {
  items: TNotification[];
  unreadCount: number;
  loading: boolean;
  loadingMore: boolean;
  hasMore: boolean;
  nextCursor: string | null;
  load: () => Promise<void>;
  loadMore: () => Promise<void>;
  markAllRead: () => Promise<void>;
  refreshUnread: () => Promise<void>;
}

export interface AppNotificationState extends NotificationStateBase<AppNotification> {
  handleIncoming: (payload: AppNotificationIncoming) => void;
  removeLocal: (id: string) => void;
}

export interface MeNotificationState extends NotificationStateBase<MeNotification> {
  handleIncoming: (payload: MeNotificationIncoming) => void;
}
