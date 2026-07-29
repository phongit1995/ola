import {
  CHAT_MARK_READ_DEBOUNCE_MS,
  CHAT_MARK_READ_MAX_WAIT_MS,
  CHAT_TYPING_TTL_MS,
} from '../../constants/chat';
import { CHAT_SOCKET_EVENTS } from '../../constants/socket';
import { playMessageSound } from '../../platform/sound';
import { SocketService } from '../../services/socket.service';
import type { Conversation } from '../../types/api/chat.type';
import type {
  ConversationUpdatedEvent,
  MessageDeletedEvent,
  MessageReactionUpdatedEvent,
  MessageUpdatedEvent,
  NewMessageEvent,
  UserTypingEvent,
} from '../../types/realtime/chat.type';
import { currentUserId, moveToTop, previewOf } from './chatHelpers';
import { markById } from './messageHelpers';
import type { ChatGet, ChatSet } from './chatState';
import { claimRealtimeRegistration } from '../realtimeRegistration.state';
import {
  chatMarkReadTimers,
  chatTypingTimers,
} from './chatRuntime.state';

function scheduleMarkRead(get: ChatGet, conversationId: string) {
  const existing = chatMarkReadTimers.get(conversationId);
  const firstAt = existing?.firstAt ?? Date.now();
  if (existing) clearTimeout(existing.timer);
  const fire = () => {
    chatMarkReadTimers.delete(conversationId);
    void get().markRead(conversationId);
  };
  if (Date.now() - firstAt >= CHAT_MARK_READ_MAX_WAIT_MS) {
    fire();
    return;
  }
  chatMarkReadTimers.set(conversationId, {
    timer: setTimeout(fire, CHAT_MARK_READ_DEBOUNCE_MS),
    firstAt,
  });
}

export function clearMarkReadTimers() {
  chatMarkReadTimers.forEach((entry) => clearTimeout(entry.timer));
  chatMarkReadTimers.clear();
}

function handleNewMessage(get: ChatGet, set: ChatSet, event: NewMessageEvent) {
  const { conversation, message } = event;
  const myId = currentUserId();
  const fromMe = message.senderId === myId;
  const isCurrent = message.conversationId === get().currentConversationId;

  if (!fromMe && !isCurrent) playMessageSound();

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
    const senderInfo: Partial<Conversation> =
      conversation.type === 'direct' && !fromMe && message.senderName != null
        ? {
            name: message.senderName,
            avatar: message.senderAvatar ?? '',
            otherUser: {
              id: message.senderId,
              username: message.senderName,
              fullName: message.senderName,
              avatar: message.senderAvatar,
              isOnline: false,
            },
          }
        : {};
    set({
      conversations: [
        { ...conversation, ...senderInfo, ...patch, unreadCount: fromMe || isCurrent ? 0 : 1 },
        ...conversations,
      ],
    });
    void get().loadConversations();
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
    scheduleMarkRead(get, message.conversationId);
  }
}

function applyTypingUser(get: ChatGet, set: ChatSet, event: UserTypingEvent) {
  if (event.userId === currentUserId() || event.conversationId !== get().currentConversationId) {
    return;
  }
  const existing = chatTypingTimers.get(event.userId);
  if (existing) clearTimeout(existing);
  const timer = setTimeout(() => {
    chatTypingTimers.delete(event.userId);
    set((state) => ({ typingUsers: state.typingUsers.filter((item) => item.userId !== event.userId) }));
  }, CHAT_TYPING_TTL_MS);
  chatTypingTimers.set(event.userId, timer);
  set((state) =>
    state.typingUsers.some((item) => item.userId === event.userId)
      ? state
      : { typingUsers: [...state.typingUsers, { userId: event.userId, username: event.username }] }
  );
}

function clearTypingUser(set: ChatSet, userId: string) {
  const existing = chatTypingTimers.get(userId);
  if (existing) {
    clearTimeout(existing);
    chatTypingTimers.delete(userId);
  }
  set((state) => ({ typingUsers: state.typingUsers.filter((item) => item.userId !== userId) }));
}

export function clearTypingTimers() {
  chatTypingTimers.forEach((timer) => clearTimeout(timer));
  chatTypingTimers.clear();
}

export function registerChatRealtime(set: ChatSet, get: ChatGet) {
  if (!claimRealtimeRegistration('chat')) return;

  SocketService.onReconnect(() => {
    void get().loadConversations();
    void get().syncCurrentConversation();
  });

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
    const myId = currentUserId();
    const target = get().messages.find((item) => item.id === data.messageId);
    const notifyOwnMessageReaction =
      data.action === 'added' &&
      target?.senderId === myId &&
      data.actorUserId !== myId &&
      data.type !== '';
    set((state) => ({
      messages: markById(state.messages, data.messageId, { reactions: data.reactions }),
      ...(notifyOwnMessageReaction
        ? { reactionNotice: { seq: (state.reactionNotice?.seq ?? 0) + 1, type: data.type } }
        : {}),
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

  SocketService.on<ConversationUpdatedEvent>(CHAT_SOCKET_EVENTS.conversationUpdated, (data) => {
    const conversationId = data?.id;
    if (conversationId != null && conversationId !== '' && typeof data.seen === 'boolean') {
      const seen = data.seen;
      set((state) => ({
        conversations: state.conversations.map((item) =>
          item.id === conversationId ? { ...item, seen } : item
        ),
      }));
      return;
    }
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
