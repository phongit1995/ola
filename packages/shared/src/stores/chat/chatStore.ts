import { create } from 'zustand';
import { blobWithType, parseMessageMetadata, randomUuid, releaseUploadPreviewUrl, uploadPreviewUrl, type UploadFile } from '../../lib';
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
} from '../../services';
import type { Conversation, Message, PublicProfile, ReactionType, RelationshipInfo } from '../../types';
import { upsertConversation } from './chatHelpers';
import { clearTypingTimers, registerChatRealtime } from './chatRealtime';

const MESSAGE_PAGE_SIZE = 50;
const TYPING_THROTTLE = 2000;
const PEER_CARD_LONG_CHAT_SHOW_RATE = 0.3;

export interface TypingUser {
  userId: string;
  username: string;
}

export interface DraftRecipient {
  id: string;
  name: string;
  avatar?: string;
}

export type FriendActionResult = 'request' | 'cancel' | 'accept' | 'unfriend' | 'none' | 'error';

export interface ChatState {
  conversations: Conversation[];
  currentConversationId: string | null;
  draftRecipient: DraftRecipient | null;
  peerRelationship: RelationshipInfo | null;
  peerProfile: PublicProfile | null;
  peerCardRoll: boolean;
  messages: Message[];
  hasMore: boolean;
  loadingConversations: boolean;
  loadingMessages: boolean;
  loadingMore: boolean;
  typingUsers: TypingUser[];
  loadConversations: () => Promise<void>;
  syncCurrentConversation: () => Promise<void>;
  openConversation: (conversationId: string) => Promise<void>;
  startDirect: (recipientId: string) => Promise<Conversation | null>;
  closeConversation: () => void;
  hideConversation: (conversationId: string) => Promise<void>;
  loadMoreMessages: () => Promise<void>;
  sendText: (content: string) => Promise<void>;
  sendFirstToDraft: (content: string) => Promise<void>;
  sendImage: (file: UploadFile) => Promise<void>;
  sendAudio: (blob: UploadFile, duration: number) => Promise<void>;
  resendMessage: (messageId: string) => Promise<void>;
  reactToMessage: (messageId: string, type: ReactionType) => Promise<void>;
  deleteMessage: (messageId: string) => Promise<void>;
  deleteAllConversations: () => Promise<void>;
  editMessage: (messageId: string, content: string) => Promise<void>;
  blockPeer: () => Promise<boolean>;
  unblockPeer: () => Promise<boolean>;
  friendAction: () => Promise<FriendActionResult>;
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
  peerProfile: null as PublicProfile | null,
  peerCardRoll: false,
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

    syncCurrentConversation: async () => {
      const conversationId = get().currentConversationId;
      if (conversationId == null) return;
      try {
        const result = await MessageService.list(conversationId, { limit: MESSAGE_PAGE_SIZE });
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
          hasMore: result.messages.length >= MESSAGE_PAGE_SIZE,
        });
        const conversation = get().conversations.find((item) => item.id === conversationId);
        if ((conversation?.unreadCount ?? 0) > 0) void get().markRead(conversationId);
      } catch {
        return;
      }
    },

    openConversation: async (conversationId) => {
      SocketService.connect();
      const conversation = get().conversations.find((item) => item.id === conversationId) ?? null;
      set({
        currentConversationId: conversationId,
        draftRecipient: null,
        peerRelationship: null,
        peerProfile: null,
        peerCardRoll: false,
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
              set({
                peerRelationship: profile.relationship ?? null,
                peerProfile: profile,
                peerCardRoll: Math.random() < PEER_CARD_LONG_CHAT_SHOW_RATE,
              });
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
          peerProfile: null,
          peerCardRoll: false,
          draftRecipient: { id: recipientId, name: existing?.name ?? '', avatar: existing?.avatar },
        });
        UserService.publicProfile(recipientId)
          .then((profile) => {
            if (get().draftRecipient?.id !== recipientId) return;
            set((state) => ({
              peerRelationship: profile.relationship ?? null,
              peerProfile: profile,
              peerCardRoll: Math.random() < PEER_CARD_LONG_CHAT_SHOW_RATE,
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
        peerProfile: null,
        peerCardRoll: false,
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

      const clientMsgId = randomUuid();
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
          clientMsgId: randomUuid(),
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

      const clientMsgId = randomUuid();
      const previewUrl = uploadPreviewUrl(file);
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
        () => releaseUploadPreviewUrl(previewUrl)
      );
    },

    sendAudio: async (blob, duration) => {
      const conversationId = get().currentConversationId;
      if (conversationId == null) return;

      const clientMsgId = randomUuid();
      const previewUrl = uploadPreviewUrl(blob);
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
        () => releaseUploadPreviewUrl(previewUrl)
      );
    },

    resendMessage: async (messageId) => {
      const conversationId = get().currentConversationId;
      if (conversationId == null) return;
      const target = get().messages.find((item) => item.id === messageId);
      if (target == null || target.status !== 'failed') return;

      const clientMsgId = target.clientMsgId ?? randomUuid();
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
            const imageBlob = blobWithType(blob, 'image/jpeg');
            saved = await MessageService.sendImage(conversationId, imageBlob, clientMsgId, 'image');
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

    friendAction: async () => {
      const current = get().peerRelationship;
      const status = current?.status ?? 'none';
      const requestId = current?.requestId ?? '';
      const base = {
        isFollowing: current?.isFollowing ?? false,
        followsMe: current?.followsMe ?? false,
      };
      try {
        if (status === 'none') {
          const userId = peerUserId();
          if (userId === '') return 'none';
          const relationship = await RelationshipService.sendRequest(userId);
          set({ peerRelationship: { ...base, status: 'pending_outgoing', requestId: relationship.id } });
          return 'request';
        }
        if (status === 'pending_outgoing' && requestId !== '') {
          await RelationshipService.cancel(requestId);
          set({ peerRelationship: { ...base, status: 'none', requestId: undefined } });
          return 'cancel';
        }
        if (status === 'pending_incoming' && requestId !== '') {
          await RelationshipService.respond(requestId, 'accept');
          set({ peerRelationship: { ...base, status: 'friend', requestId } });
          return 'accept';
        }
        if (status === 'friend' && requestId !== '') {
          await RelationshipService.unfriend(requestId);
          set({ peerRelationship: { ...base, status: 'none', requestId: undefined } });
          return 'unfriend';
        }
        return 'none';
      } catch {
        return 'error';
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
