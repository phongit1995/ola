import { SocketService } from '../services';
import type { AppNotification } from '../types';
import { useAppNotificationStore } from './appNotificationStore';
import { useFriendsStore } from './friendsStore';
import { useMarriageStore } from './marriageStore';

interface AppNotificationIncoming {
  notification?: AppNotification | null;
  removedId?: string | null;
  unreadCount: number;
}

let registered = false;

export function registerAppNotificationRealtime() {
  if (registered) return;
  registered = true;

  SocketService.on<AppNotificationIncoming>('APP_NOTIFICATION', (data) => {
    if (data == null) return;
    if (data.notification == null && data.removedId == null) return;
    const store = useAppNotificationStore.getState();
    const type =
      data.notification?.type ?? store.items.find((item) => item.id === data.removedId)?.type;
    store.handleIncoming(data);

    if (type === 'friend_request' || type == null) {
      void useFriendsStore.getState().loadRequests();
    }
    if (type === 'marriage_proposal' || type == null) {
      void useMarriageStore.getState().load();
    }
  });
}
