import { create } from 'zustand';
import { useAuthStore } from '@/store/authStore';
import { ConversationService, MessageService, SocketService } from '@services';
import type { Conversation, Message } from '@app-types';
import { upsertConversation } from './chatHelpers';
import { clearTypingTimers, registerChatRealtime } from './chatRealtime';

const MESSAGE_PAGE_SIZE = 50;
const TYPING_THROTTLE = 2000;

export interface TypingUser {
  userId: string;
  username: string;
}

export interface ChatState {
  conversations: Conversation[];
  currentConversationId: string | null;
  messages: Message[];
  hasMore: boolean;
  loadingConversations: boolean;
  loadingMessages: boolean;
  loadingMore: boolean;
  typingUsers: TypingUser[];
  loadConversations: () => Promise<void>;
  openConversation: (conversationId: string) => Promise<void>;
  startDirect: (recipientId: string) => Promise<Conversation | null>;
  closeConversation: () => void;
  loadMoreMessages: () => Promise<void>;
  sendText: (content: string) => Promise<void>;
  notifyTyping: () => void;
  markRead: (conversationId: string) => Promise<void>;
  reset: () => void;
}

let lastTypingSentAt = 0;

const initialState = {
  conversations: [] as Conversation[],
  currentConversationId: null as string | null,
  messages: [] as Message[],
  hasMore: false,
  loadingConversations: false,
  loadingMessages: false,
  loadingMore: false,
  typingUsers: [] as TypingUser[],
};

export const useChatStore = create<ChatState>((set, get) => {
  registerChatRealtime(set, get);

  return {
    ...initialState,

    loadConversations: async () => {
      SocketService.connect();
      set({ loadingConversations: true });
      try {
        const result = await ConversationService.list();
        set({ conversations: result.conversations, loadingConversations: false });
      } catch {
        set({ loadingConversations: false });
      }
    },

    openConversation: async (conversationId) => {
      SocketService.connect();
      set({
        currentConversationId: conversationId,
        messages: [],
        typingUsers: [],
        hasMore: false,
        loadingMessages: true,
      });
      try {
        const result = await MessageService.list(conversationId, { limit: MESSAGE_PAGE_SIZE });
        if (get().currentConversationId !== conversationId) return;
        set({
          messages: [...result.messages].reverse(),
          hasMore: result.messages.length >= MESSAGE_PAGE_SIZE,
          loadingMessages: false,
        });
        void get().markRead(conversationId);
      } catch {
        if (get().currentConversationId === conversationId) set({ loadingMessages: false });
      }
    },

    startDirect: async (recipientId) => {
      SocketService.connect();
      try {
        const existing = await ConversationService.checkDirect(recipientId);
        const conversation = existing ?? (await ConversationService.createDirect(recipientId));
        set((state) => ({ conversations: upsertConversation(state.conversations, conversation) }));
        await get().openConversation(conversation.id);
        return conversation;
      } catch {
        return null;
      }
    },

    closeConversation: () => set({ currentConversationId: null, messages: [], typingUsers: [] }),

    loadMoreMessages: async () => {
      const { currentConversationId, messages, hasMore, loadingMore } = get();
      if (!currentConversationId || !hasMore || loadingMore || messages.length === 0) return;
      const oldest = messages[0];
      if (oldest == null) return;
      set({ loadingMore: true });
      try {
        const result = await MessageService.list(currentConversationId, {
          limit: MESSAGE_PAGE_SIZE,
          before: oldest.id,
        });
        if (get().currentConversationId !== currentConversationId) return;
        const older = [...result.messages].reverse();
        const existingIds = new Set(get().messages.map((item) => item.id));
        const deduped = older.filter((item) => !existingIds.has(item.id));
        set({
          messages: [...deduped, ...get().messages],
          hasMore: result.messages.length >= MESSAGE_PAGE_SIZE,
          loadingMore: false,
        });
      } catch {
        if (get().currentConversationId === currentConversationId) set({ loadingMore: false });
      }
    },

    sendText: async (content) => {
      const text = content.trim();
      const conversationId = get().currentConversationId;
      if (text === '' || conversationId == null) return;

      const clientMsgId = crypto.randomUUID();
      const user = useAuthStore.getState().user;
      const now = new Date().toISOString();
      const optimistic: Message = {
        id: clientMsgId,
        conversationId,
        senderId: user?.id ?? '',
        senderName: user?.fullName ?? user?.username,
        senderAvatar: user?.avatar,
        type: 'text',
        content: text,
        status: 'sending',
        createdAt: now,
        updatedAt: now,
        clientMsgId,
      };
      set((state) => ({ messages: [...state.messages, optimistic] }));

      try {
        const saved = await MessageService.send({
          conversationId,
          type: 'text',
          content: text,
          clientMsgId,
        });
        set((state) => ({
          messages: state.messages.map((item) =>
            item.clientMsgId === clientMsgId ? { ...saved, status: 'sent' } : item
          ),
        }));
      } catch {
        set((state) => ({
          messages: state.messages.map((item) =>
            item.clientMsgId === clientMsgId ? { ...item, status: 'failed' } : item
          ),
        }));
      }
    },

    notifyTyping: () => {
      const conversationId = get().currentConversationId;
      if (conversationId == null) return;
      const now = Date.now();
      if (now - lastTypingSentAt < TYPING_THROTTLE) return;
      lastTypingSentAt = now;
      ConversationService.sendTyping(conversationId).catch(() => {});
    },

    markRead: async (conversationId) => {
      try {
        await ConversationService.markRead(conversationId);
        set((state) => ({
          conversations: state.conversations.map((item) =>
            item.id === conversationId ? { ...item, unreadCount: 0, seen: true } : item
          ),
        }));
      } catch {
        return;
      }
    },

    reset: () => {
      clearTypingTimers();
      lastTypingSentAt = 0;
      set({ ...initialState });
    },
  };
});
