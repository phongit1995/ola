import { createChatConversationActions } from '@ola/shared/stores/chat/chatConversationActions';
import { ConversationService } from '@ola/shared/services/conversation.service';
import { MessageService } from '@ola/shared/services/message.service';
import type { ChatState, Conversation } from '@ola/shared/types';

jest.mock('@ola/shared/services/conversation.service', () => ({
  ConversationService: { list: jest.fn(), markRead: jest.fn() },
}));
jest.mock('@ola/shared/services/message.service', () => ({
  MessageService: { list: jest.fn() },
}));
jest.mock('@ola/shared/services/socket.service', () => ({
  SocketService: { connect: jest.fn() },
}));
jest.mock('@ola/shared/services/user.service', () => ({
  UserService: { publicProfile: jest.fn(() => new Promise(() => {})) },
}));

const list = ConversationService.list as jest.Mock;
const markRead = ConversationService.markRead as jest.Mock;
const listMessages = MessageService.list as jest.Mock;

function conv(id: string, unreadCount: number): Conversation {
  return { id, unreadCount } as Conversation;
}

function setup(initial: Partial<ChatState>) {
  let state = { conversations: [], currentConversationId: null, messages: [], ...initial } as unknown as ChatState;
  const get = () => state;
  const set = (patch: Partial<ChatState> | ((s: ChatState) => Partial<ChatState>)) => {
    state = { ...state, ...(typeof patch === 'function' ? patch(state) : patch) };
  };
  const actions = createChatConversationActions(set as never, get as never);
  state = { ...state, ...actions };
  return { actions, get };
}

const flush = () => new Promise<void>((resolve) => setTimeout(resolve, 0));

describe('chat unread mark read', () => {
  beforeEach(() => {
    jest.clearAllMocks();
    markRead.mockResolvedValue({});
    listMessages.mockResolvedValue({ messages: [] });
  });

  it('marks read when opening a conversation the list has not loaded yet', async () => {
    const { actions } = setup({});
    await actions.openConversation('c1');
    await flush();
    expect(markRead).toHaveBeenCalledWith('c1');
  });

  it('marks read on open even when the cached list says nothing is unread', async () => {
    const { actions } = setup({ conversations: [conv('c1', 0)] });
    await actions.openConversation('c1');
    await flush();
    expect(markRead).toHaveBeenCalledWith('c1');
  });

  it('marks the open conversation read when a list reload brings back unread', async () => {
    list.mockResolvedValue({ conversations: [conv('c1', 4), conv('c2', 2)] });
    const { actions, get } = setup({ currentConversationId: 'c1' });
    await actions.loadConversations();
    await flush();
    expect(markRead).toHaveBeenCalledTimes(1);
    expect(markRead).toHaveBeenCalledWith('c1');
    expect(get().conversations.find((c: Conversation) => c.id === 'c1')?.unreadCount).toBe(0);
    expect(get().conversations.find((c: Conversation) => c.id === 'c2')?.unreadCount).toBe(2);
  });

  it('keeps the peer seen flag when my message is the last one', async () => {
    const mine = { ...conv('c1', 0), isLastMessageFromMe: true, seen: false };
    const theirs = { ...conv('c2', 3), isLastMessageFromMe: false, seen: false };
    const { actions, get } = setup({ conversations: [mine, theirs] });
    await actions.markRead('c1');
    await actions.markRead('c2');
    expect(get().conversations.find((c: Conversation) => c.id === 'c1')?.seen).toBe(false);
    expect(get().conversations.find((c: Conversation) => c.id === 'c2')).toMatchObject({ seen: true, unreadCount: 0 });
  });

  it('does not mark anything read on list reload when no conversation is open', async () => {
    list.mockResolvedValue({ conversations: [conv('c1', 4)] });
    const { actions } = setup({});
    await actions.loadConversations();
    await flush();
    expect(markRead).not.toHaveBeenCalled();
  });
});
