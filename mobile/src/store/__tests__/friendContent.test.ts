import {
  friendContentLabel,
  friendContentName,
  useFriendContentStore,
  type FriendContentNotice,
} from '@ola/shared/stores/friendContent';

jest.mock('@ola/shared/services/socket.service', () => ({ SocketService: { on: () => () => undefined } }));

const mockLoadTray = jest.fn(() => Promise.resolve());
jest.mock('@ola/shared/stores/moment/momentStore', () => ({
  useMomentStore: { getState: () => ({ load: mockLoadTray }) },
}));

jest.mock('i18next', () => ({
  __esModule: true,
  default: { t: (key: string) => key },
}));

const notice: FriendContentNotice = {
  kind: 'post',
  contentId: 'p1',
  author: { id: 'a1', username: 'minhanh99', fullName: 'Minh Anh' },
  preview: 'Đi Đà Lạt không',
};

describe('friend content banner', () => {
  beforeEach(() => {
    useFriendContentStore.setState({ notice: null, openSeq: 0 });
  });

  it('prefers the display name and falls back to the username', () => {
    expect(friendContentName(notice)).toBe('Minh Anh');
    expect(friendContentName({ ...notice, author: { id: 'a1', username: 'minhanh99' } })).toBe('minhanh99');
  });

  it('labels posts and moments differently', () => {
    expect(friendContentLabel('post')).toBe('friendContent.post');
    expect(friendContentLabel('moment')).toBe('friendContent.moment');
  });

  it('shows, dismisses and opens without keeping the banner', () => {
    const store = useFriendContentStore.getState();
    store.show(notice);
    expect(useFriendContentStore.getState().notice).toEqual(notice);
    store.dismiss();
    expect(useFriendContentStore.getState().notice).toBeNull();
    store.show(notice);
    store.open();
    expect(useFriendContentStore.getState()).toMatchObject({ notice: null, openSeq: 1 });
    expect(mockLoadTray).not.toHaveBeenCalled();
  });

  it('reloads the moment tray when opening a moment banner', () => {
    useFriendContentStore.getState().show({ ...notice, kind: 'moment' });
    useFriendContentStore.getState().open();
    expect(mockLoadTray).toHaveBeenCalledTimes(1);
  });
});
