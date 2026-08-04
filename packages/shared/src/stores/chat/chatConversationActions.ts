import {
  CHAT_MESSAGE_PAGE_SIZE,
  CHAT_PEER_CARD_LONG_CHAT_SHOW_RATE,
} from '../../constants/chat';
import { ConversationService } from '../../services/conversation.service';
import { MessageService } from '../../services/message.service';
import { SocketService } from '../../services/socket.service';
import { UserService } from '../../services/user.service';
import type { Conversation } from '../../types/api/chat.type';
import type {
  ChatConversationActions,
  ChatState,
} from '../../types/client/chat.type';
import { upsertConversation } from './chatHelpers';
import { showDirectMessagingError } from './chatPolicy';
import {
  clearedPeerView,
  type ChatGet,
  type ChatSet,
} from './chatState';

function currentPeerId(get: ChatGet): string | null {
  const state = get();
  const conversation = state.conversations.find(
    (item) => item.id === state.currentConversationId
  );
  return conversation?.otherUser?.id ?? state.draftRecipient?.id ?? null;
}

// checkDirect and createDirect both answer without otherUser, so a conversation
// that is not already cached locally (hidden, or a fresh session) would land in
// the list with no peer at all: openConversation then skips the profile fetch,
// peerRelationship stays null and every peer-dependent action goes dead. Their
// `name`/`avatar` already describe the other user, so rebuild the peer from
// those plus the profile when it happens to be the same person.
function normalizeDirect(
  state: ChatState,
  conversation: Conversation,
  peerId: string
): Conversation {
  if (conversation.otherUser != null) return conversation;
  const known = state.conversations.find((item) => item.id === conversation.id);
  if (known?.otherUser != null) return conversation;

  const profile = state.peerProfile?.id === peerId ? state.peerProfile : null;
  return {
    ...conversation,
    otherUser: {
      id: peerId,
      username: profile?.username ?? '',
      fullName: profile?.fullName ?? conversation.name,
      avatar: profile?.avatar ?? conversation.avatar,
      isOnline: profile?.isOnline ?? false,
      lastActiveAt: profile?.lastActiveAt,
    },
  };
}

// Voice send and call start can both promote the same draft. Without sharing
// the request the loser finds draftRecipient already cleared and gets null,
// which the voice path reports as a plain failure after it has thrown the
// recording away.
const pendingDirectCreates = new Map<string, Promise<Conversation>>();

function createDirectOnce(peerId: string): Promise<Conversation> {
  const inFlight = pendingDirectCreates.get(peerId);
  if (inFlight != null) return inFlight;

  const request = ConversationService.createDirect(peerId);
  pendingDirectCreates.set(peerId, request);
  void request
    .catch(() => {})
    .finally(() => {
      pendingDirectCreates.delete(peerId);
    });
  return request;
}

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

    ensureDirectConversation: async (expectedPeerId) => {
      if (currentPeerId(get) !== expectedPeerId) return null;

      const conversationId = get().currentConversationId;
      if (conversationId != null) return conversationId;
      const draft = get().draftRecipient;
      if (draft == null) return null;

      let created;
      try {
        created = await createDirectOnce(draft.id);
      } catch (error) {
        if (showDirectMessagingError(error)) return null;
        throw error;
      }

      if (get().draftRecipient?.id !== draft.id) {
        return currentPeerId(get) === expectedPeerId
          ? get().currentConversationId
          : null;
      }

      set((state) => ({
        conversations: upsertConversation(
          state.conversations,
          normalizeDirect(state, created, draft.id)
        ),
        currentConversationId: created.id,
        draftRecipient: null,
        messages: [],
        typingUsers: [],
        replyTarget: null,
        hasMore: false,
        messagesCursor: null,
        loadingMessages: false,
        loadingMore: false,
      }));
      return created.id;
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
            conversations: upsertConversation(
              state.conversations,
              normalizeDirect(state, existing, recipientId)
            ),
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
