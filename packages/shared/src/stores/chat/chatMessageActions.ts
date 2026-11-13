import i18n from 'i18next';
import { CHAT_TYPING_THROTTLE_MS, MESSAGE_STATUS, MESSAGE_TYPE } from '../../constants/chat';
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
import {
  buildOptimisticMessage,
  markByClientMsgId,
  markById,
  replySnapshotOf,
  runOptimisticSend,
} from './messageHelpers';
import {
  showDirectMessagingError,
  showMessageDeleteError,
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
          type: MESSAGE_TYPE.text,
          content: text,
          status: MESSAGE_STATUS.sending,
          ...(reply != null ? { replyTo: replySnapshotOf(reply) } : {}),
        }),
        (id) =>
          MessageService.send({
            conversationId,
            type: MESSAGE_TYPE.text,
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
          type: MESSAGE_TYPE.text,
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
          type: MESSAGE_TYPE.image,
          metadata: JSON.stringify({
            url: previewUrl,
            uploadName: nativeFile?.name,
            uploadType: nativeFile?.type,
          }),
          status: MESSAGE_STATUS.uploading,
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
          conversationId = await get().ensureDirectConversation(draft.id);
        } catch (error) {
          toast.error(i18n.t('chat.voiceSendError'));
          throw error;
        }
        if (conversationId == null) return false;
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
          type: MESSAGE_TYPE.audio,
          metadata: JSON.stringify({
            url: previewUrl,
            duration,
            waveform,
            uploadName: nativeFile?.name,
            uploadType: nativeFile?.type,
          }),
          status: MESSAGE_STATUS.uploading,
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
      if (target == null || target.status !== MESSAGE_STATUS.failed) return false;

      const clientMsgId = target.clientMsgId ?? randomUuid();
      const sendingStatus =
        target.type === MESSAGE_TYPE.text ? MESSAGE_STATUS.sending : MESSAGE_STATUS.uploading;
      set((state) => ({
        messages: markById(state.messages, messageId, {
          status: sendingStatus,
          clientMsgId,
        }),
      }));

      try {
        let saved: Message;
        if (target.type === MESSAGE_TYPE.text) {
          saved = await MessageService.send({
            conversationId,
            type: MESSAGE_TYPE.text,
            content: target.content,
            clientMsgId,
          });
        } else {
          const meta = parseMessageMetadata(target.metadata);
          const previewUrl = meta.url ?? '';
          const fallbackName =
            target.type === MESSAGE_TYPE.audio
              ? 'voice.m4a'
              : previewUrl.split('/').pop()?.split('?')[0] ?? 'photo.jpg';
          let upload: UploadFile | undefined = nativeUploadFileFromUri(
            previewUrl,
            meta.uploadName ?? fallbackName,
            meta.uploadType ??
              (target.type === MESSAGE_TYPE.audio ? 'audio/mp4' : 'image/jpeg')
          );
          if (upload == null) {
            const blob = await (await fetch(previewUrl)).blob();
            upload = target.type === MESSAGE_TYPE.image ? blobWithType(blob, 'image/jpeg') : blob;
          }
          if (target.type === MESSAGE_TYPE.image) {
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
            status: MESSAGE_STATUS.sent,
          }),
        }));
        return true;
      } catch (error) {
        set((state) => ({
          messages: markByClientMsgId(state.messages, clientMsgId, {
            status: MESSAGE_STATUS.failed,
          }),
        }));
        if (!showMessagingPolicyError(error) && target.type === MESSAGE_TYPE.audio) {
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
      } catch (error) {
        if (get().currentConversationId === conversationId) {
          set({ messages: snapshot });
        }
        showMessageDeleteError(error);
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
            item.id === messageId ? { ...updated, status: MESSAGE_STATUS.sent } : item
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
