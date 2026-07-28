import { create } from 'zustand';
import i18n from 'i18next';
import {
  blobWithType,
  parseMessageMetadata,
  randomUuid,
  releaseUploadPreviewUrl,
  toApiError,
  toast,
  uploadPreviewUrl,
  type UploadFile,
} from '../../lib';
import {
  buildOptimisticMessage,
  markById,
  markByClientMsgId,
  replySnapshotOf,
  runOptimisticSend,
} from './messageHelpers';
import {
  ConversationService,
  MessageService,
  RelationshipService,
  SocketService,
  UserService,
} from '../../services';
import type {
  ChatReactionNotice,
  Conversation,
  Message,
  PublicProfile,
  ReactionType,
  RelationshipInfo,
} from '../../types';
import { registerOnLogout } from '../authStore';
import { upsertConversation } from './chatHelpers';
import { clearMarkReadTimers, clearTypingTimers, registerChatRealtime } from './chatRealtime';

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
  messagesCursor: string | null;
  loadingConversations: boolean;
  loadingMessages: boolean;
  loadingMore: boolean;
  typingUsers: TypingUser[];
  replyTarget: Message | null;
  reactionNotice: ChatReactionNotice | null;
  setReplyTarget: (message: Message) => void;
  clearReplyTarget: () => void;
  clearReactionNotice: (seq: number) => void;
  loadConversations: () => Promise<void>;
  syncCurrentConversation: () => Promise<void>;
  openConversation: (conversationId: string) => Promise<void>;
  startDirect: (recipientId: string) => Promise<Conversation | null>;
  closeConversation: () => void;
  hideConversation: (
    conversationId: string,
    options?: { clearMessages?: boolean }
  ) => Promise<void>;
  loadMoreMessages: () => Promise<void>;
  sendText: (content: string) => Promise<void>;
  sendFirstToDraft: (content: string) => Promise<void>;
  sendImage: (file: UploadFile) => Promise<void>;
  sendAudio: (blob: UploadFile, duration: number, waveform?: number[]) => Promise<void>;
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
  messagesCursor: null as string | null,
  loadingConversations: false,
  loadingMessages: false,
  loadingMore: false,
  typingUsers: [] as TypingUser[],
  replyTarget: null as Message | null,
  reactionNotice: null as ChatReactionNotice | null,
};

const clearedPeerView = {
  peerRelationship: null as RelationshipInfo | null,
  peerProfile: null as PublicProfile | null,
  peerCardRoll: false,
};

export const useChatStore = create<ChatState>((set, get) => {
  registerChatRealtime(set, get);

  const peerUserId = (): string => {
    const state = get();
    const conversation = state.conversations.find(
      (item) => item.id === state.currentConversationId
    );
    return conversation?.otherUser?.id ?? state.draftRecipient?.id ?? '';
  };

  return {
    ...initialState,

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
          limit: MESSAGE_PAGE_SIZE,
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
          hasMore: result.hasMore ?? result.messages.length >= MESSAGE_PAGE_SIZE,
          messagesCursor: result.nextBefore ?? null,
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
                peerCardRoll: Math.random() < PEER_CARD_LONG_CHAT_SHOW_RATE,
              });
            }
          })
          .catch(() => {});
      }
      try {
        const result = await MessageService.list(conversationId, {
          limit: MESSAGE_PAGE_SIZE,
        });
        if (get().currentConversationId !== conversationId) return;
        set({
          messages: [...result.messages].reverse(),
          hasMore: result.hasMore ?? result.messages.length >= MESSAGE_PAGE_SIZE,
          messagesCursor: result.nextBefore ?? null,
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
          peerRelationship: null,
          peerProfile: null,
          peerCardRoll: false,
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
        ...clearedPeerView,
        messages: [],
        typingUsers: [],
        replyTarget: null,
      }),

    setReplyTarget: (message) => set({ replyTarget: message }),

    clearReplyTarget: () => set({ replyTarget: null }),

    clearReactionNotice: (seq) =>
      set((state) => (state.reactionNotice?.seq === seq ? { reactionNotice: null } : {})),

    hideConversation: async (conversationId, options) => {
      const isCurrent = get().currentConversationId === conversationId;
      set((state) => ({
        conversations: state.conversations.filter((item) => item.id !== conversationId),
        ...(isCurrent ? { currentConversationId: null, messages: [], typingUsers: [] } : {}),
      }));
      try {
        await ConversationService.hide(conversationId, options?.clearMessages === true);
      } catch {
        void get().loadConversations();
      }
    },

    loadMoreMessages: async () => {
      const { currentConversationId, messages, hasMore, loadingMore, messagesCursor } = get();
      if (!currentConversationId || !hasMore || loadingMore) return;
      const before = messagesCursor ?? messages[0]?.id;
      if (before == null) return;
      set({ loadingMore: true });
      try {
        const result = await MessageService.list(currentConversationId, {
          limit: MESSAGE_PAGE_SIZE,
          before,
        });
        if (get().currentConversationId !== currentConversationId) return;
        const older = [...result.messages].reverse();
        const existingIds = new Set(get().messages.map((item) => item.id));
        const deduped = older.filter((item) => !existingIds.has(item.id));
        set({
          messages: [...deduped, ...get().messages],
          hasMore: result.hasMore ?? result.messages.length >= MESSAGE_PAGE_SIZE,
          messagesCursor: result.nextBefore ?? null,
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

      const reply = get().replyTarget;
      if (reply != null) set({ replyTarget: null });
      const clientMsgId = randomUuid();
      await runOptimisticSend(
        set,
        buildOptimisticMessage({
          clientMsgId,
          conversationId,
          type: 'text',
          content: text,
          status: 'sending',
          ...(reply != null ? { replyTo: replySnapshotOf(reply) } : {}),
        }),
        (id) =>
          MessageService.send({
            conversationId,
            type: 'text',
            content: text,
            clientMsgId: id,
            ...(reply != null ? { replyToId: reply.id } : {}),
          })
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
      } catch (error) {
        if (toApiError(error).status === 403) toast.error(i18n.t('chat.sendErrFriendsOnly'));
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

    sendAudio: async (blob, duration, waveform) => {
      let conversationId = get().currentConversationId;
      if (conversationId == null) {
        const draft = get().draftRecipient;
        if (draft == null) return;
        try {
          const conversation = await ConversationService.createDirect(draft.id);
          conversationId = conversation.id;
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
        } catch (error) {
          if (toApiError(error).status === 403) {
            toast.error(i18n.t('chat.sendErrFriendsOnly'));
          } else {
            toast.error(i18n.t('chat.voiceSendError'));
          }
          throw error;
        }
      }

      const reply = get().replyTarget;
      if (reply != null) set({ replyTarget: null });
      const clientMsgId = randomUuid();
      const previewUrl = uploadPreviewUrl(blob);
      await runOptimisticSend(
        set,
        buildOptimisticMessage({
          clientMsgId,
          conversationId,
          type: 'audio',
          metadata: JSON.stringify({ url: previewUrl, duration, waveform }),
          status: 'uploading',
          ...(reply != null ? { replyTo: replySnapshotOf(reply) } : {}),
        }),
        (id) =>
          MessageService.sendAudio(conversationId, blob, duration, {
            clientMsgId: id,
            replyToId: reply?.id,
            waveform,
          }),
        undefined,
        () => toast.error(i18n.t('chat.voiceSendError'))
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
        messages: markById(state.messages, messageId, {
          status: sendingStatus,
          clientMsgId,
        }),
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
            saved = await MessageService.sendAudio(conversationId, blob, meta.duration ?? 0, {
              clientMsgId,
              replyToId: target.replyToId,
              waveform: meta.waveform,
            });
          }
        }
        set((state) => ({
          messages: markByClientMsgId(state.messages, clientMsgId, {
            ...saved,
            status: 'sent',
          }),
        }));
        if (target.type !== 'text') {
          const previewUrl = parseMessageMetadata(target.metadata).url ?? '';
          if (target.type !== 'audio') releaseUploadPreviewUrl(previewUrl);
        }
      } catch {
        set((state) => ({
          messages: markByClientMsgId(state.messages, clientMsgId, {
            status: 'failed',
          }),
        }));
        if (target.type === 'audio') toast.error(i18n.t('chat.voiceSendError'));
      }
    },

    reactToMessage: async (messageId, type) => {
      const conversationId = get().currentConversationId;
      if (conversationId == null) return;
      try {
        const updated = await MessageService.toggleReaction(conversationId, messageId, type);
        set((state) => ({
          messages: markById(state.messages, messageId, {
            reactions: updated.reactions,
          }),
        }));
      } catch {
        return;
      }
    },

    deleteMessage: async (messageId) => {
      const conversationId = get().currentConversationId;
      if (conversationId == null) return;
      const snapshot = get().messages;
      set((state) => ({
        messages: state.messages.filter((item) => item.id !== messageId),
        ...(state.replyTarget?.id === messageId ? { replyTarget: null } : {}),
      }));
      try {
        await MessageService.remove(conversationId, messageId);
      } catch {
        if (get().currentConversationId === conversationId) set({ messages: snapshot });
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
        messages: markById(state.messages, messageId, { content: text }),
      }));
      try {
        const updated = await MessageService.update(conversationId, messageId, text);
        set((state) => ({
          messages: state.messages.map((item) =>
            item.id === messageId ? { ...updated, status: 'sent' } : item
          ),
        }));
      } catch {
        if (get().currentConversationId === conversationId) set({ messages: snapshot });
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
        set({
          peerRelationship: {
            ...current,
            status: 'none',
            requestId: undefined,
          },
        });
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
          set({
            peerRelationship: {
              ...base,
              status: 'pending_outgoing',
              requestId: relationship.id,
            },
          });
          return 'request';
        }
        if (status === 'pending_outgoing' && requestId !== '') {
          await RelationshipService.cancel(requestId);
          set({
            peerRelationship: { ...base, status: 'none', requestId: undefined },
          });
          return 'cancel';
        }
        if (status === 'pending_incoming' && requestId !== '') {
          await RelationshipService.respond(requestId, 'accept');
          set({ peerRelationship: { ...base, status: 'friend', requestId } });
          return 'accept';
        }
        if (status === 'friend' && requestId !== '') {
          await RelationshipService.unfriend(requestId);
          set({
            peerRelationship: { ...base, status: 'none', requestId: undefined },
          });
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
      clearMarkReadTimers();
      lastTypingSentAt = 0;
      set({ ...initialState });
    },
  };
});

registerOnLogout(() => useChatStore.getState().reset());
