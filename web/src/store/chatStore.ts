import { create } from 'zustand';
import { parseMessageMetadata } from '@lib';
import {
  buildOptimisticMessage,
  markById,
  markByClientMsgId,
  runOptimisticSend,
} from './messageHelpers';
import {
  ConversationService,
  MessageService,
  RelationshipService,
  SocketService,
  UserService,
} from '@services';
import type { Conversation, Message, ReactionType, RelationshipInfo } from '@app-types';
import { upsertConversation } from './chatHelpers';
import { clearTypingTimers, registerChatRealtime } from './chatRealtime';

const MESSAGE_PAGE_SIZE = 50;
const TYPING_THROTTLE = 2000;

export interface TypingUser {
  userId: string;
  username: string;
}

export interface DraftRecipient {
  id: string;
  name: string;
  avatar?: string;
}

export interface ChatState {
  conversations: Conversation[];
  currentConversationId: string | null;
  draftRecipient: DraftRecipient | null;
  peerRelationship: RelationshipInfo | null;
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
  hideConversation: (conversationId: string) => Promise<void>;
  loadMoreMessages: () => Promise<void>;
  sendText: (content: string) => Promise<void>;
  sendFirstToDraft: (content: string) => Promise<void>;
  sendImage: (file: File) => Promise<void>;
  sendAudio: (blob: Blob, duration: number) => Promise<void>;
  resendMessage: (messageId: string) => Promise<void>;
  reactToMessage: (messageId: string, type: ReactionType) => Promise<void>;
  deleteMessage: (messageId: string) => Promise<void>;
  deleteAllConversations: () => Promise<void>;
  editMessage: (messageId: string, content: string) => Promise<void>;
  blockPeer: () => Promise<boolean>;
  unblockPeer: () => Promise<boolean>;
  addPeerFriend: () => Promise<boolean>;
  notifyTyping: () => void;
  markRead: (conversationId: string) => Promise<void>;
  reset: () => void;
}

let lastTypingSentAt = 0;

const initialState = {
  conversations: [] as Conversation[],
  currentConversationId: null as string | null,
  draftRecipient: null as DraftRecipient | null,
  peerRelationship: null as RelationshipInfo | null,
  messages: [] as Message[],
  hasMore: false,
  loadingConversations: false,
  loadingMessages: false,
  loadingMore: false,
  typingUsers: [] as TypingUser[],
};

export const useChatStore = create<ChatState>((set, get) => {
  registerChatRealtime(set, get);

  const peerUserId = (): string => {
    const state = get();
    const conversation = state.conversations.find((item) => item.id === state.currentConversationId);
    return conversation?.otherUser?.id ?? state.draftRecipient?.id ?? '';
  };

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
      const conversation = get().conversations.find((item) => item.id === conversationId) ?? null;
      set({
        currentConversationId: conversationId,
        draftRecipient: null,
        peerRelationship: null,
        messages: [],
        typingUsers: [],
        hasMore: false,
        loadingMessages: true,
      });
      const otherUserId = conversation?.otherUser?.id;
      if (otherUserId != null && otherUserId !== '') {
        UserService.publicProfile(otherUserId)
          .then((profile) => {
            if (get().currentConversationId === conversationId) {
              set({ peerRelationship: profile.relationship ?? null });
            }
          })
          .catch(() => {});
      }
      try {
        const result = await MessageService.list(conversationId, { limit: MESSAGE_PAGE_SIZE });
        if (get().currentConversationId !== conversationId) return;
        set({
          messages: [...result.messages].reverse(),
          hasMore: result.messages.length >= MESSAGE_PAGE_SIZE,
          loadingMessages: false,
        });
        if ((conversation?.unreadCount ?? 0) > 0) {
          void get().markRead(conversationId);
        }
      } catch {
        if (get().currentConversationId === conversationId) set({ loadingMessages: false });
      }
    },

    startDirect: async (recipientId) => {
      SocketService.connect();
      try {
        const existing = await ConversationService.checkDirect(recipientId);
        if (existing != null && existing.id !== '') {
          set((state) => ({ conversations: upsertConversation(state.conversations, existing) }));
          await get().openConversation(existing.id);
          return existing;
        }
        set({
          currentConversationId: null,
          messages: [],
          typingUsers: [],
          hasMore: false,
          peerRelationship: null,
          draftRecipient: { id: recipientId, name: existing?.name ?? '', avatar: existing?.avatar },
        });
        UserService.publicProfile(recipientId)
          .then((profile) => {
            if (get().draftRecipient?.id !== recipientId) return;
            set((state) => ({
              peerRelationship: profile.relationship ?? null,
              draftRecipient:
                state.draftRecipient != null
                  ? {
                      ...state.draftRecipient,
                      name: state.draftRecipient.name || profile.fullName || profile.username,
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
        peerRelationship: null,
        messages: [],
        typingUsers: [],
      }),

    hideConversation: async (conversationId) => {
      const isCurrent = get().currentConversationId === conversationId;
      set((state) => ({
        conversations: state.conversations.filter((item) => item.id !== conversationId),
        ...(isCurrent ? { currentConversationId: null, messages: [], typingUsers: [] } : {}),
      }));
      try {
        await ConversationService.hide(conversationId);
      } catch {
        void get().loadConversations();
      }
    },

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
      if (text === '') return;
      const conversationId = get().currentConversationId;
      if (conversationId == null) {
        if (get().draftRecipient != null) await get().sendFirstToDraft(text);
        return;
      }

      const clientMsgId = crypto.randomUUID();
      await runOptimisticSend(
        set,
        buildOptimisticMessage({ clientMsgId, conversationId, type: 'text', content: text, status: 'sending' }),
        (id) => MessageService.send({ conversationId, type: 'text', content: text, clientMsgId: id })
      );
    },

    sendFirstToDraft: async (content) => {
      const draft = get().draftRecipient;
      const text = content.trim();
      if (draft == null || text === '') return;
      try {
        await MessageService.sendDirect({
          recipientId: draft.id,
          type: 'text',
          content: text,
          clientMsgId: crypto.randomUUID(),
        });
        await get().loadConversations();
        const conversation = await ConversationService.checkDirect(draft.id);
        if (conversation != null && conversation.id !== '') {
          await get().openConversation(conversation.id);
        }
      } catch {
        return;
      }
    },

    sendImage: async (file) => {
      const conversationId = get().currentConversationId;
      if (conversationId == null) return;

      const clientMsgId = crypto.randomUUID();
      const previewUrl = URL.createObjectURL(file);
      await runOptimisticSend(
        set,
        buildOptimisticMessage({
          clientMsgId,
          conversationId,
          type: 'image',
          metadata: JSON.stringify({ url: previewUrl }),
          status: 'uploading',
        }),
        (id) => MessageService.sendImage(conversationId, file, id),
        () => URL.revokeObjectURL(previewUrl)
      );
    },

    sendAudio: async (blob, duration) => {
      const conversationId = get().currentConversationId;
      if (conversationId == null) return;

      const clientMsgId = crypto.randomUUID();
      const previewUrl = URL.createObjectURL(blob);
      await runOptimisticSend(
        set,
        buildOptimisticMessage({
          clientMsgId,
          conversationId,
          type: 'audio',
          metadata: JSON.stringify({ url: previewUrl, duration }),
          status: 'uploading',
        }),
        (id) => MessageService.sendAudio(conversationId, blob, duration, id),
        () => URL.revokeObjectURL(previewUrl)
      );
    },

    resendMessage: async (messageId) => {
      const conversationId = get().currentConversationId;
      if (conversationId == null) return;
      const target = get().messages.find((item) => item.id === messageId);
      if (target == null || target.status !== 'failed') return;

      const clientMsgId = target.clientMsgId ?? crypto.randomUUID();
      const sendingStatus = target.type === 'text' ? 'sending' : 'uploading';
      set((state) => ({
        messages: markById(state.messages, messageId, { status: sendingStatus, clientMsgId }),
      }));

      try {
        let saved: Message;
        if (target.type === 'text') {
          saved = await MessageService.send({
            conversationId,
            type: 'text',
            content: target.content,
            clientMsgId,
          });
        } else {
          const meta = parseMessageMetadata(target.metadata);
          const blob = await (await fetch(meta.url ?? '')).blob();
          if (target.type === 'image') {
            const file = new File([blob], 'image', { type: blob.type || 'image/jpeg' });
            saved = await MessageService.sendImage(conversationId, file, clientMsgId);
          } else {
            saved = await MessageService.sendAudio(conversationId, blob, meta.duration ?? 0, clientMsgId);
          }
        }
        set((state) => ({
          messages: markByClientMsgId(state.messages, clientMsgId, { ...saved, status: 'sent' }),
        }));
      } catch {
        set((state) => ({
          messages: markByClientMsgId(state.messages, clientMsgId, { status: 'failed' }),
        }));
      }
    },

    reactToMessage: async (messageId, type) => {
      const conversationId = get().currentConversationId;
      if (conversationId == null) return;
      try {
        const updated = await MessageService.toggleReaction(conversationId, messageId, type);
        set((state) => ({
          messages: state.messages.map((item) =>
            item.id === messageId ? { ...item, reactions: updated.reactions } : item
          ),
        }));
      } catch {
        return;
      }
    },

    deleteMessage: async (messageId) => {
      const conversationId = get().currentConversationId;
      if (conversationId == null) return;
      const snapshot = get().messages;
      set((state) => ({ messages: state.messages.filter((item) => item.id !== messageId) }));
      try {
        await MessageService.remove(conversationId, messageId);
      } catch {
        set({ messages: snapshot });
      }
    },

    deleteAllConversations: async () => {
      const ids = get().conversations.map((item) => item.id);
      if (ids.length === 0) return;
      set({ conversations: [], currentConversationId: null, messages: [], typingUsers: [] });
      const results = await Promise.allSettled(ids.map((id) => ConversationService.hide(id)));
      if (results.some((item) => item.status === 'rejected')) {
        await get().loadConversations();
      }
    },

    editMessage: async (messageId, content) => {
      const conversationId = get().currentConversationId;
      const text = content.trim();
      if (conversationId == null || text === '') return;
      const snapshot = get().messages;
      set((state) => ({
        messages: state.messages.map((item) =>
          item.id === messageId ? { ...item, content: text } : item
        ),
      }));
      try {
        const updated = await MessageService.update(conversationId, messageId, text);
        set((state) => ({
          messages: state.messages.map((item) =>
            item.id === messageId ? { ...updated, status: 'sent' } : item
          ),
        }));
      } catch {
        set({ messages: snapshot });
      }
    },

    blockPeer: async () => {
      const userId = peerUserId();
      if (userId === '') return false;
      try {
        const relationship = await RelationshipService.block(userId);
        const current = get().peerRelationship;
        set({
          peerRelationship: {
            status: 'blocked_by_me',
            requestId: relationship.id,
            isFollowing: current?.isFollowing ?? false,
            followsMe: current?.followsMe ?? false,
          },
        });
        return true;
      } catch {
        return false;
      }
    },

    unblockPeer: async () => {
      const current = get().peerRelationship;
      if (current?.requestId == null || current.requestId === '') return false;
      try {
        await RelationshipService.unblock(current.requestId);
        set({ peerRelationship: { ...current, status: 'none', requestId: undefined } });
        return true;
      } catch {
        return false;
      }
    },

    addPeerFriend: async () => {
      const userId = peerUserId();
      if (userId === '') return false;
      try {
        const relationship = await RelationshipService.sendRequest(userId);
        const current = get().peerRelationship;
        set({
          peerRelationship: {
            status: 'pending_outgoing',
            requestId: relationship.id,
            isFollowing: current?.isFollowing ?? false,
            followsMe: current?.followsMe ?? false,
          },
        });
        return true;
      } catch {
        return false;
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
