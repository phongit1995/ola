import i18n from 'i18next';
import { CHAT_TYPING_THROTTLE_MS } from '../../constants/chat';
import { parseMessageMetadata } from '../../lib/messageMetadata';
import { randomUuid } from '../../lib/randomUuid';
import { toast } from '../../lib/toast';
import {
  asNativeUploadFile,
  blobWithType,
  nativeUploadFileFromUri,
  uploadPreviewUrl,
} from '../../lib/upload';
import { ConversationService } from '../../services/conversation.service';
import { MessageService } from '../../services/message.service';
import type { Message } from '../../types/api/chat.type';
import type { ChatMessageActions } from '../../types/client/chat.type';
import type { UploadFile } from '../../types/client/upload.type';
import { upsertConversation } from './chatHelpers';
import {
  buildOptimisticMessage,
  markByClientMsgId,
  markById,
  replySnapshotOf,
  runOptimisticSend,
} from './messageHelpers';
import {
  showDirectMessagingError,
  showMessagingPolicyError,
} from './chatPolicy';
import type { ChatGet, ChatSet } from './chatState';
import {
  claimTypingSend,
  resetLastTypingSentAt,
} from './chatRuntime.state';

export function resetChatMessageActionState(): void {
  resetLastTypingSentAt();
}

export function createChatMessageActions(
  set: ChatSet,
  get: ChatGet
): ChatMessageActions {
  return {
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
          }),
        undefined,
        (error) => {
          showMessagingPolicyError(error);
        }
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
        showDirectMessagingError(error);
      }
    },

    sendImage: async (file) => {
      const conversationId = get().currentConversationId;
      if (conversationId == null) return;

      const clientMsgId = randomUuid();
      const previewUrl = uploadPreviewUrl(file);
      const nativeFile = asNativeUploadFile(file);
      await runOptimisticSend(
        set,
        buildOptimisticMessage({
          clientMsgId,
          conversationId,
          type: 'image',
          metadata: JSON.stringify({
            url: previewUrl,
            uploadName: nativeFile?.name,
            uploadType: nativeFile?.type,
          }),
          status: 'uploading',
        }),
        (id) => MessageService.sendImage(conversationId, file, id),
        undefined,
        (error) => {
          showMessagingPolicyError(error);
        }
      );
    },

    sendAudio: async (blob, duration, waveform) => {
      let conversationId = get().currentConversationId;
      if (conversationId == null) {
        const draft = get().draftRecipient;
        if (draft == null) return false;
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
          if (!showDirectMessagingError(error)) {
            toast.error(i18n.t('chat.voiceSendError'));
          }
          throw error;
        }
      }

      const reply = get().replyTarget;
      if (reply != null) set({ replyTarget: null });
      const clientMsgId = randomUuid();
      const previewUrl = uploadPreviewUrl(blob);
      const nativeFile = asNativeUploadFile(blob);
      return runOptimisticSend(
        set,
        buildOptimisticMessage({
          clientMsgId,
          conversationId,
          type: 'audio',
          metadata: JSON.stringify({
            url: previewUrl,
            duration,
            waveform,
            uploadName: nativeFile?.name,
            uploadType: nativeFile?.type,
          }),
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
        (error) => {
          if (!showMessagingPolicyError(error)) {
            toast.error(i18n.t('chat.voiceSendError'));
          }
        }
      );
    },

    resendMessage: async (messageId) => {
      const conversationId = get().currentConversationId;
      if (conversationId == null) return false;
      const target = get().messages.find((item) => item.id === messageId);
      if (target == null || target.status !== 'failed') return false;

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
          const previewUrl = meta.url ?? '';
          const fallbackName =
            target.type === 'audio'
              ? 'voice.m4a'
              : previewUrl.split('/').pop()?.split('?')[0] ?? 'photo.jpg';
          let upload: UploadFile | undefined = nativeUploadFileFromUri(
            previewUrl,
            meta.uploadName ?? fallbackName,
            meta.uploadType ??
              (target.type === 'audio' ? 'audio/mp4' : 'image/jpeg')
          );
          if (upload == null) {
            const blob = await (await fetch(previewUrl)).blob();
            upload = target.type === 'image' ? blobWithType(blob, 'image/jpeg') : blob;
          }
          if (target.type === 'image') {
            saved = await MessageService.sendImage(
              conversationId,
              upload,
              clientMsgId,
              'image'
            );
          } else {
            saved = await MessageService.sendAudio(
              conversationId,
              upload,
              meta.duration ?? 0,
              {
                clientMsgId,
                replyToId: target.replyToId,
                waveform: meta.waveform,
              }
            );
          }
        }
        set((state) => ({
          messages: markByClientMsgId(state.messages, clientMsgId, {
            ...saved,
            status: 'sent',
          }),
        }));
        return true;
      } catch (error) {
        set((state) => ({
          messages: markByClientMsgId(state.messages, clientMsgId, {
            status: 'failed',
          }),
        }));
        if (!showMessagingPolicyError(error) && target.type === 'audio') {
          toast.error(i18n.t('chat.voiceSendError'));
        }
        return false;
      }
    },

    reactToMessage: async (messageId, type) => {
      const conversationId = get().currentConversationId;
      if (conversationId == null) return;
      try {
        const updated = await MessageService.toggleReaction(
          conversationId,
          messageId,
          type
        );
        set((state) => ({
          messages: markById(state.messages, messageId, {
            reactions: updated.reactions,
          }),
        }));
      } catch (error) {
        showMessagingPolicyError(error);
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
        if (get().currentConversationId === conversationId) {
          set({ messages: snapshot });
        }
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
        const updated = await MessageService.update(
          conversationId,
          messageId,
          text
        );
        set((state) => ({
          messages: state.messages.map((item) =>
            item.id === messageId ? { ...updated, status: 'sent' } : item
          ),
        }));
      } catch (error) {
        if (get().currentConversationId === conversationId) {
          set({ messages: snapshot });
        }
        showMessagingPolicyError(error);
      }
    },

    notifyTyping: () => {
      const conversationId = get().currentConversationId;
      if (conversationId == null) return;
      const now = Date.now();
      if (!claimTypingSend(now, CHAT_TYPING_THROTTLE_MS)) return;
      ConversationService.sendTyping(conversationId).catch(() => {});
    },
  };
}
