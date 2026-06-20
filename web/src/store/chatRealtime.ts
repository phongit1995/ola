import type { StoreApi } from 'zustand';
import { SocketService } from '@services';
import {
  CHAT_SOCKET_EVENTS,
  type Conversation,
  type MessageDeletedEvent,
  type MessageReactionUpdatedEvent,
  type MessageUpdatedEvent,
  type NewMessageEvent,
  type UserTypingEvent,
} from '@app-types';
import { currentUserId, moveToTop, previewOf } from './chatHelpers';
import { markById } from './messageHelpers';
import type { ChatState } from './chatStore';

type ChatSet = StoreApi<ChatState>['setState'];
type ChatGet = StoreApi<ChatState>['getState'];

const TYPING_TTL = 3000;
const typingTimers = new Map<string, ReturnType<typeof setTimeout>>();
let registered = false;

function handleNewMessage(get: ChatGet, set: ChatSet, event: NewMessageEvent) {
  const { conversation, message } = event;
  const myId = currentUserId();
  const fromMe = message.senderId === myId;
  const isCurrent = message.conversationId === get().currentConversationId;

  if (isCurrent) {
    set((state) => {
      const index = state.messages.findIndex(
        (item) =>
          item.id === message.id ||
          (message.clientMsgId != null && item.clientMsgId === message.clientMsgId)
      );
      const incoming = { ...message, status: 'sent' as const };
      if (index >= 0) {
        const next = [...state.messages];
        next[index] = incoming;
        return { messages: next };
      }
      return { messages: [...state.messages, incoming] };
    });
  }

  const patch: Partial<Conversation> = {
    lastMessageText: previewOf(message),
    lastMessageAt: message.createdAt,
    lastMessageSenderId: message.senderId,
    lastMessageSenderName: message.senderName,
    isLastMessageFromMe: fromMe,
    seen: fromMe ? false : isCurrent,
  };

  const { conversations } = get();
  const existing = conversations.find((item) => item.id === message.conversationId);
  if (!existing) {
    set({
      conversations: [
        { ...conversation, ...patch, unreadCount: fromMe || isCurrent ? 0 : 1 },
        ...conversations,
      ],
    });
  } else {
    const unreadCount = isCurrent
      ? 0
      : fromMe
        ? existing.unreadCount
        : (existing.unreadCount || 0) + 1;
    set({
      conversations: moveToTop(
        conversations.map((item) =>
          item.id === message.conversationId ? { ...item, ...patch, unreadCount } : item
        ),
        message.conversationId
      ),
    });
  }

  if (isCurrent && !fromMe) {
    void get().markRead(message.conversationId);
  }
}

function applyTypingUser(get: ChatGet, set: ChatSet, event: UserTypingEvent) {
  if (event.userId === currentUserId() || event.conversationId !== get().currentConversationId) {
    return;
  }
  const existing = typingTimers.get(event.userId);
  if (existing) clearTimeout(existing);
  const timer = setTimeout(() => {
    typingTimers.delete(event.userId);
    set((state) => ({ typingUsers: state.typingUsers.filter((item) => item.userId !== event.userId) }));
  }, TYPING_TTL);
  typingTimers.set(event.userId, timer);
  set((state) =>
    state.typingUsers.some((item) => item.userId === event.userId)
      ? state
      : { typingUsers: [...state.typingUsers, { userId: event.userId, username: event.username }] }
  );
}

function clearTypingUser(set: ChatSet, userId: string) {
  const existing = typingTimers.get(userId);
  if (existing) {
    clearTimeout(existing);
    typingTimers.delete(userId);
  }
  set((state) => ({ typingUsers: state.typingUsers.filter((item) => item.userId !== userId) }));
}

export function clearTypingTimers() {
  typingTimers.forEach((timer) => clearTimeout(timer));
  typingTimers.clear();
}

export function registerChatRealtime(set: ChatSet, get: ChatGet) {
  if (registered) return;
  registered = true;

  SocketService.on<NewMessageEvent>(CHAT_SOCKET_EVENTS.newMessage, (data) =>
    handleNewMessage(get, set, data)
  );

  SocketService.on<MessageUpdatedEvent>(CHAT_SOCKET_EVENTS.messageUpdated, ({ message }) => {
    if (message.conversationId !== get().currentConversationId) return;
    set((state) => ({
      messages: markById(state.messages, message.id, { ...message, status: 'sent' }),
    }));
  });

  SocketService.on<MessageDeletedEvent>(CHAT_SOCKET_EVENTS.messageDeleted, (data) => {
    if (data.conversation?.id !== get().currentConversationId) return;
    set((state) => ({ messages: state.messages.filter((item) => item.id !== data.messageId) }));
  });

  SocketService.on<MessageReactionUpdatedEvent>(CHAT_SOCKET_EVENTS.reactionUpdated, (data) => {
    if (data.conversationId !== get().currentConversationId) return;
    set((state) => ({
      messages: markById(state.messages, data.messageId, { reactions: data.reactions }),
    }));
  });

  SocketService.on<UserTypingEvent>(CHAT_SOCKET_EVENTS.userTyping, (data) =>
    applyTypingUser(get, set, data)
  );

  SocketService.on<UserTypingEvent>(CHAT_SOCKET_EVENTS.userStopTyping, (data) =>
    clearTypingUser(set, data.userId)
  );

  SocketService.on(CHAT_SOCKET_EVENTS.conversationCreated, () => {
    void get().loadConversations();
  });

  SocketService.on(CHAT_SOCKET_EVENTS.conversationUpdated, () => {
    void get().loadConversations();
  });

  SocketService.on<{ conversationId: string }>(CHAT_SOCKET_EVENTS.conversationDeleted, (data) => {
    set((state) => ({
      conversations: state.conversations.filter((item) => item.id !== data.conversationId),
      ...(state.currentConversationId === data.conversationId
        ? { currentConversationId: null, messages: [], typingUsers: [] }
        : {}),
    }));
  });
}
