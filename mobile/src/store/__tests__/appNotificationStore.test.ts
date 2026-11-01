import { NotificationService } from '@ola/shared/services/notification.service';
import { useAppNotificationStore } from '@ola/shared/stores/app-notification/appNotificationStore';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import type { AppNotification } from '@ola/shared/types';

jest.mock('@ola/shared/services/notification.service', () => ({
  NotificationService: { hide: jest.fn(), list: jest.fn() },
}));

const hide = NotificationService.hide as jest.Mock;
const list = NotificationService.list as jest.Mock;

function notification(id: string, isRead: boolean): AppNotification {
  return {
    id,
    type: 'content_violation',
    preview: id,
    isRead,
    createdAt: '2026-11-01T00:00:00Z',
  };
}

describe('appNotificationStore.hide', () => {
  beforeEach(() => {
    hide.mockReset();
    list.mockReset();
    useToastStore.setState({ toasts: [] });
    useAppNotificationStore.setState({
      items: [notification('a', false), notification('b', true)],
      unreadCount: 1,
    });
  });

  it('removes the notification right away and keeps it gone once the server agrees', async () => {
    hide.mockResolvedValue({ message: 'notification hidden' });

    const pending = useAppNotificationStore.getState().hide('a');

    expect(useAppNotificationStore.getState().items.map((item) => item.id)).toEqual(['b']);
    expect(useAppNotificationStore.getState().unreadCount).toBe(0);
    await pending;
    expect(hide).toHaveBeenCalledWith('a');
    expect(useAppNotificationStore.getState().items.map((item) => item.id)).toEqual(['b']);
    expect(list).not.toHaveBeenCalled();
  });

  it('reloads the list and shows an error when the server refuses', async () => {
    hide.mockRejectedValue(new Error('offline'));
    list.mockResolvedValue({
      items: [notification('a', false), notification('b', true)],
      unreadCount: 1,
    });

    await useAppNotificationStore.getState().hide('a');
    await Promise.resolve();

    expect(list).toHaveBeenCalled();
    expect(useAppNotificationStore.getState().items.map((item) => item.id)).toEqual(['a', 'b']);
    expect(useToastStore.getState().toasts.some((item) => item.type === 'error')).toBe(true);
  });

  it('keeps a notification hidden while an older page is still loading', async () => {
    hide.mockResolvedValue({ message: 'notification hidden' });
    const page = deferred<{ items: AppNotification[]; unreadCount: number; nextCursor: string }>();
    list.mockReturnValue(page.promise);
    useAppNotificationStore.setState({ hasMore: true, nextCursor: 'cursor-1', loadingMore: false });

    const loading = useAppNotificationStore.getState().loadMore();
    await useAppNotificationStore.getState().hide('a');
    page.resolve({ items: [notification('c', true)], unreadCount: 0, nextCursor: '' });
    await loading;

    expect(useAppNotificationStore.getState().items.map((item) => item.id)).toEqual(['b', 'c']);
  });

  it('drops a notification hidden while the first page was in flight', async () => {
    hide.mockResolvedValue({ message: 'notification hidden' });
    const page = deferred<{ items: AppNotification[]; unreadCount: number }>();
    list.mockReturnValue(page.promise);

    const loading = useAppNotificationStore.getState().load();
    await useAppNotificationStore.getState().hide('d');
    page.resolve({ items: [notification('d', false), notification('e', true)], unreadCount: 1 });
    await loading;

    expect(useAppNotificationStore.getState().items.map((item) => item.id)).toEqual(['e']);
  });
});

function deferred<T>() {
  let resolve!: (value: T) => void;
  const promise = new Promise<T>((done) => {
    resolve = done;
  });
  return { promise, resolve };
}
