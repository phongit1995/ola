import { act, create, type ReactTestRenderer } from 'react-test-renderer';
import { useToastStore } from '@ola/shared/stores/toast/toastStore';
import { useChatPeerActions } from '@ola/shared/stores/chat/useChatPeerActions';

const mockStore = {
  blockPeer: jest.fn(),
  unblockPeer: jest.fn(),
  friendAction: jest.fn(),
};

jest.mock('@ola/shared/stores/chat/chatStore', () => ({
  useChatStore: (selector: (s: typeof mockStore) => unknown) => selector(mockStore),
}));

jest.mock('i18next', () => ({
  __esModule: true,
  default: { t: (key: string, options?: { name?: string }) => (options?.name ? `${key}:${options.name}` : key) },
}));

type Actions = ReturnType<typeof useChatPeerActions>;
let actions: Actions;

function Harness({ blocked }: { blocked: boolean }) {
  actions = useChatPeerActions('Lan', blocked);
  return null;
}

function lastToast() {
  const toasts = useToastStore.getState().toasts;
  const last = toasts[toasts.length - 1];
  return last == null ? null : { type: last.type, message: last.message };
}

describe('useChatPeerActions', () => {
  let renderer: ReactTestRenderer | null = null;

  beforeEach(() => {
    useToastStore.setState({ toasts: [] });
    Object.values(mockStore).forEach((fn) => fn.mockReset());
  });

  afterEach(() => {
    act(() => renderer?.unmount());
    renderer = null;
  });

  it('blocks friend actions while blocked without calling the store', async () => {
    act(() => {
      renderer = create(<Harness blocked />);
    });
    await act(() => actions.handleFriendAction());
    expect(mockStore.friendAction).not.toHaveBeenCalled();
    expect(lastToast()).toEqual({ type: 'info', message: 'chat.makeFriendBlocked' });
  });

  it('maps each friend action result to its toast', async () => {
    act(() => {
      renderer = create(<Harness blocked={false} />);
    });
    const cases: [string, string, string][] = [
      ['request', 'success', 'chat.friendRequestSent'],
      ['cancel', 'success', 'chat.requestCancelled'],
      ['accept', 'success', 'chat.friendAccepted'],
      ['unfriend', 'success', 'chat.unfriendDone'],
      ['error', 'error', 'chat.actionError'],
    ];
    for (const [result, type, message] of cases) {
      mockStore.friendAction.mockResolvedValueOnce(result);
      await act(() => actions.handleFriendAction());
      expect(lastToast()).toEqual({ type, message });
    }
  });

  it('reports block and unblock outcomes with the peer name', async () => {
    act(() => {
      renderer = create(<Harness blocked={false} />);
    });
    mockStore.blockPeer.mockResolvedValueOnce(true).mockResolvedValueOnce(false);
    await act(() => actions.handleBlock());
    expect(lastToast()).toEqual({ type: 'success', message: 'chat.blockDone:Lan' });
    await act(() => actions.handleBlock());
    expect(lastToast()).toEqual({ type: 'error', message: 'chat.actionError' });
    mockStore.unblockPeer.mockResolvedValueOnce(true);
    await act(() => actions.handleUnblock());
    expect(lastToast()).toEqual({ type: 'success', message: 'chat.unblockDone:Lan' });
  });
});
