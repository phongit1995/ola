import { APP_NOTIFICATION_SOCKET_EVENT } from '../../constants/socket';
import { SocketService } from '../../services/socket.service';
import type { AppNotificationIncoming } from '../../types/realtime/notification.type';
import { useAppNotificationStore } from './appNotificationStore';
import { useFriendsStore } from '../friends/friendsStore';
import { useMarriageStore } from '../marriageStore';
import { claimRealtimeRegistration } from '../realtimeRegistration.state';

export function registerAppNotificationRealtime() {
  if (!claimRealtimeRegistration('app-notification')) return;

  SocketService.on<AppNotificationIncoming>(APP_NOTIFICATION_SOCKET_EVENT, (data) => {
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
