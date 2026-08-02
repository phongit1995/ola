import {
  CHAT_MESSAGE_PAGE_SIZE,
  CHAT_PEER_CARD_LONG_CHAT_SHOW_RATE,
} from '../../constants/chat';
import { ConversationService } from '../../services/conversation.service';
import { MessageService } from '../../services/message.service';
import { SocketService } from '../../services/socket.service';
import { UserService } from '../../services/user.service';
import type { ChatConversationActions } from '../../types/client/chat.type';
import { upsertConversation } from './chatHelpers';
import {
  clearedPeerView,
  type ChatGet,
  type ChatSet,
} from './chatState';

export function createChatConversationActions(
  set: ChatSet,
  get: ChatGet
): ChatConversationActions {
  return {
    loadConversations: async () => {
      SocketService.connect();
      set({ loadingConversations: true });
      try {
        const result = await ConversationService.list();
        set({
          conversations: result.conversations,
          loadingConversations: false,
        });
      } catch {
        set({ loadingConversations: false });
      }
    },

    syncCurrentConversation: async () => {
      const conversationId = get().currentConversationId;
      if (conversationId == null) return;
      try {
        const result = await MessageService.list(conversationId, {
          limit: CHAT_MESSAGE_PAGE_SIZE,
        });
        if (get().currentConversationId !== conversationId) return;
        const fetched = [...result.messages].reverse();
        const savedIds = new Set(fetched.map((item) => item.id));
        const savedClientMsgIds = new Set(
          fetched.map((item) => item.clientMsgId).filter((id): id is string => id != null)
        );
        const pending = get().messages.filter(
          (item) =>
            item.status !== 'sent' &&
            !savedIds.has(item.id) &&
            (item.clientMsgId == null || !savedClientMsgIds.has(item.clientMsgId))
        );
        set({
          messages: [...fetched, ...pending],
          hasMore: result.hasMore ?? result.messages.length >= CHAT_MESSAGE_PAGE_SIZE,
          messagesCursor: result.nextBefore ?? null,
        });
        const conversation = get().conversations.find(
          (item) => item.id === conversationId
        );
        if ((conversation?.unreadCount ?? 0) > 0) void get().markRead(conversationId);
      } catch {
        return;
      }
    },

    ensureDirectConversation: async () => {
      const conversationId = get().currentConversationId;
      if (conversationId != null) return conversationId;
      const draft = get().draftRecipient;
      if (draft == null) return null;

      const conversation = await ConversationService.createDirect(draft.id);
      set((state) => ({
        conversations: upsertConversation(state.conversations, conversation),
        currentConversationId: conversation.id,
        draftRecipient: null,
        messages: [],
        typingUsers: [],
        replyTarget: null,
        hasMore: false,
        messagesCursor: null,
        loadingMessages: false,
        loadingMore: false,
      }));
      return conversation.id;
    },

    openConversation: async (conversationId) => {
      SocketService.connect();
      const conversation =
        get().conversations.find((item) => item.id === conversationId) ?? null;
      set({
        currentConversationId: conversationId,
        draftRecipient: null,
        ...clearedPeerView,
        messages: [],
        typingUsers: [],
        replyTarget: null,
        hasMore: false,
        messagesCursor: null,
        loadingMore: false,
        loadingMessages: true,
      });
      const otherUserId = conversation?.otherUser?.id;
      if (otherUserId != null && otherUserId !== '') {
        UserService.publicProfile(otherUserId)
          .then((profile) => {
            if (get().currentConversationId === conversationId) {
              set({
                peerRelationship: profile.relationship ?? null,
                peerProfile: profile,
                peerCardRoll: Math.random() < CHAT_PEER_CARD_LONG_CHAT_SHOW_RATE,
              });
            }
          })
          .catch(() => {});
      }
      try {
        const result = await MessageService.list(conversationId, {
          limit: CHAT_MESSAGE_PAGE_SIZE,
        });
        if (get().currentConversationId !== conversationId) return;
        set({
          messages: [...result.messages].reverse(),
          hasMore: result.hasMore ?? result.messages.length >= CHAT_MESSAGE_PAGE_SIZE,
          messagesCursor: result.nextBefore ?? null,
          loadingMessages: false,
        });
        if ((conversation?.unreadCount ?? 0) > 0) {
          void get().markRead(conversationId);
        }
      } catch {
        if (get().currentConversationId === conversationId) {
          set({ loadingMessages: false });
        }
      }
    },

    startDirect: async (recipientId) => {
      SocketService.connect();
      try {
        const existing = await ConversationService.checkDirect(recipientId);
        if (existing != null && existing.id !== '') {
          set((state) => ({
            conversations: upsertConversation(state.conversations, existing),
          }));
          await get().openConversation(existing.id);
          return existing;
        }
        set({
          currentConversationId: null,
          messages: [],
          typingUsers: [],
          replyTarget: null,
          hasMore: false,
          ...clearedPeerView,
          draftRecipient: {
            id: recipientId,
            name: existing?.name ?? '',
            avatar: existing?.avatar,
          },
        });
        UserService.publicProfile(recipientId)
          .then((profile) => {
            if (get().draftRecipient?.id !== recipientId) return;
            set((state) => ({
              peerRelationship: profile.relationship ?? null,
              peerProfile: profile,
              peerCardRoll: Math.random() < CHAT_PEER_CARD_LONG_CHAT_SHOW_RATE,
              draftRecipient:
                state.draftRecipient != null
                  ? {
                      ...state.draftRecipient,
                      name:
                        state.draftRecipient.name ||
                        profile.fullName ||
                        profile.username,
                      avatar: state.draftRecipient.avatar ?? profile.avatar,
                    }
                  : state.draftRecipient,
            }));
          })
          .catch(() => {});
        return null;
      } catch {
        return null;
      }
    },

    closeConversation: () =>
      set({
        currentConversationId: null,
        draftRecipient: null,
        ...clearedPeerView,
        messages: [],
        typingUsers: [],
        replyTarget: null,
      }),

    hideConversation: async (conversationId, options) => {
      const isCurrent = get().currentConversationId === conversationId;
      set((state) => ({
        conversations: state.conversations.filter(
          (item) => item.id !== conversationId
        ),
        ...(isCurrent
          ? { currentConversationId: null, messages: [], typingUsers: [] }
          : {}),
      }));
      try {
        await ConversationService.hide(
          conversationId,
          options?.clearMessages === true
        );
      } catch {
        void get().loadConversations();
      }
    },

    loadMoreMessages: async () => {
      const {
        currentConversationId,
        messages,
        hasMore,
        loadingMore,
        messagesCursor,
      } = get();
      if (!currentConversationId || !hasMore || loadingMore) return;
      const before = messagesCursor ?? messages[0]?.id;
      if (before == null) return;
      set({ loadingMore: true });
      try {
        const result = await MessageService.list(currentConversationId, {
          limit: CHAT_MESSAGE_PAGE_SIZE,
          before,
        });
        if (get().currentConversationId !== currentConversationId) return;
        const older = [...result.messages].reverse();
        const existingIds = new Set(get().messages.map((item) => item.id));
        const deduped = older.filter((item) => !existingIds.has(item.id));
        set({
          messages: [...deduped, ...get().messages],
          hasMore: result.hasMore ?? result.messages.length >= CHAT_MESSAGE_PAGE_SIZE,
          messagesCursor: result.nextBefore ?? null,
          loadingMore: false,
        });
      } catch {
        if (get().currentConversationId === currentConversationId) {
          set({ loadingMore: false });
        }
      }
    },

    deleteAllConversations: async () => {
      const ids = get().conversations.map((item) => item.id);
      if (ids.length === 0) return;
      set({
        conversations: [],
        currentConversationId: null,
        messages: [],
        typingUsers: [],
      });
      const results = await Promise.allSettled(
        ids.map((id) => ConversationService.hide(id))
      );
      if (results.some((item) => item.status === 'rejected')) {
        await get().loadConversations();
      }
    },

    markRead: async (conversationId) => {
      try {
        await ConversationService.markRead(conversationId);
        set((state) => ({
          conversations: state.conversations.map((item) =>
            item.id === conversationId
              ? { ...item, unreadCount: 0, seen: true }
              : item
          ),
        }));
      } catch {
        return;
      }
    },
  };
}
