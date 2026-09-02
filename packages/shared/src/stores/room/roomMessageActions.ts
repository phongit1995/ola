import {
  audioUploadFilename,
  nativeUploadFileFromUri,
  uploadFileMimeType,
  uploadPreviewUrl,
} from '../../lib/upload';
import { randomUuid } from '../../lib/randomUuid';
import { RoomService } from '../../services/room.service';
import type { RoomMessage } from '../../types/api/room.type';
import type {
  RoomAudioSendResult,
  RoomMessageActions,
} from '../../types/client/roomChat.type';
import {
  buildOptimisticRoomAudio,
  buildOptimisticRoomImage,
  capPinnedRoomMessages,
  markRoomMessageByClientMsgId,
  markRoomMessageById,
  reconcileRoomServerMessage,
  roomReplySnapshotOf,
  withSenderVip,
} from './roomHelpers';
import type { RoomChatGet, RoomChatSet } from './roomChatState';

export function createRoomMessageActions(
  set: RoomChatSet,
  get: RoomChatGet
): RoomMessageActions {
  async function finalizeImageSend(
    roomId: string,
    clientMsgId: string,
    upload: () => Promise<RoomMessage>
  ): Promise<void> {
    try {
      const saved = withSenderVip(await upload());
      if (get().activeRoom?.id !== roomId) return;
      set((state) =>
        capPinnedRoomMessages(
          reconcileRoomServerMessage(state.messages, saved),
          state.pinnedToBottom
        )
      );
    } catch {
      if (get().activeRoom?.id !== roomId) return;
      set((state) => ({
        messages: markRoomMessageByClientMsgId(
          state.messages,
          clientMsgId,
          { status: 'failed' }
        ),
      }));
    }
  }

  async function finalizeAudioSend(
    roomId: string,
    clientMsgId: string,
    upload: () => Promise<RoomMessage>
  ): Promise<RoomAudioSendResult> {
    try {
      const saved = withSenderVip(await upload());
      if (get().activeRoom?.id !== roomId) return 'aborted';
      set((state) =>
        capPinnedRoomMessages(
          reconcileRoomServerMessage(state.messages, saved),
          state.pinnedToBottom
        )
      );
      return 'sent';
    } catch {
      if (get().activeRoom?.id !== roomId) return 'aborted';
      set((state) => ({
        messages: markRoomMessageByClientMsgId(
          state.messages,
          clientMsgId,
          { status: 'failed' }
        ),
      }));
      return 'failed';
    }
  }

  return {
    sendMessage: async (content) => {
      const room = get().activeRoom;
      if (!room) return;
      const trimmed = content.trim();
      if (trimmed === '') return;
      const reply = get().replyTarget;
      const message = withSenderVip(
        await RoomService.sendMessage(room.id, {
          content: trimmed,
          ...(reply != null ? { replyToId: reply.id } : {}),
        })
      );
      if (get().activeRoom?.id !== room.id) return;
      set((state) => ({
        replyTarget:
          state.replyTarget?.id === reply?.id ? null : state.replyTarget,
        ...(state.messages.some((item) => item.id === message.id)
          ? {}
          : capPinnedRoomMessages(
              [...state.messages, message],
              state.pinnedToBottom
            )),
      }));
    },

    sendImage: async (file) => {
      const room = get().activeRoom;
      if (!room) return;
      const clientMsgId = randomUuid();
      const previewUrl = uploadPreviewUrl(file);
      set((state) =>
        capPinnedRoomMessages(
          [
            ...state.messages,
            buildOptimisticRoomImage(room.id, clientMsgId, previewUrl),
          ],
          state.pinnedToBottom
        )
      );
      await finalizeImageSend(room.id, clientMsgId, () =>
        RoomService.sendImage(room.id, file, clientMsgId)
      );
    },

    sendAudio: async (file, duration, waveform) => {
      const room = get().activeRoom;
      if (!room) return 'aborted';
      const reply = get().replyTarget;
      const clientMsgId = randomUuid();
      const previewUrl = uploadPreviewUrl(file);
      const mimeType = uploadFileMimeType(file) || 'audio/mp4';
      set((state) => ({
        replyTarget:
          state.replyTarget?.id === reply?.id ? null : state.replyTarget,
        ...capPinnedRoomMessages(
          [
            ...state.messages,
            buildOptimisticRoomAudio(
              room.id,
              clientMsgId,
              previewUrl,
              duration,
              waveform,
              mimeType,
              reply != null ? roomReplySnapshotOf(reply) : undefined
            ),
          ],
          state.pinnedToBottom
        ),
      }));
      return finalizeAudioSend(room.id, clientMsgId, () =>
        RoomService.sendAudio(room.id, file, duration, {
          clientMsgId,
          replyToId: reply?.id,
          waveform,
        })
      );
    },

    resendRoomImage: async (messageId) => {
      const room = get().activeRoom;
      if (!room) return;
      const target = get().messages.find((item) => item.id === messageId);
      if (
        target == null ||
        target.status !== 'failed' ||
        target.imageUrl == null
      ) {
        return;
      }
      const clientMsgId = target.clientMsgId ?? randomUuid();
      const previewUrl = target.imageUrl;
      set((state) => ({
        messages: markRoomMessageByClientMsgId(
          state.messages,
          clientMsgId,
          {
            clientMsgId,
            status: 'uploading',
          }
        ),
      }));
      await finalizeImageSend(room.id, clientMsgId, async () => {
        const blob = await (await fetch(previewUrl)).blob();
        return RoomService.sendImage(room.id, blob, clientMsgId, 'image');
      });
    },

    resendRoomAudio: async (messageId) => {
      const room = get().activeRoom;
      if (!room) return;
      const target = get().messages.find((item) => item.id === messageId);
      if (
        target == null ||
        target.type !== 'audio' ||
        target.status !== 'failed' ||
        target.clientMsgId == null ||
        target.audioUrl == null ||
        target.audioUrl === ''
      ) {
        return;
      }
      const clientMsgId = target.clientMsgId;
      const previewUrl = target.audioUrl;
      const mimeType = target.audioMimeType || 'audio/mp4';
      set((state) => ({
        messages: markRoomMessageByClientMsgId(
          state.messages,
          clientMsgId,
          {
            clientMsgId,
            status: 'uploading',
          }
        ),
      }));
      await finalizeAudioSend(room.id, clientMsgId, async () => {
        const file =
          nativeUploadFileFromUri(
            previewUrl,
            audioUploadFilename(mimeType),
            mimeType
          ) ?? (await (await fetch(previewUrl)).blob());
        return RoomService.sendAudio(
          room.id,
          file,
          target.audioDuration ?? 0,
          {
            clientMsgId,
            replyToId: target.replyTo?.messageId,
            waveform: target.audioWaveform,
          }
        );
      });
    },

    reactToRoomMessage: async (messageId, type) => {
      const room = get().activeRoom;
      if (!room) return;
      try {
        const updated = await RoomService.toggleMessageReaction(
          room.id,
          messageId,
          type
        );
        if (get().activeRoom?.id !== room.id) return;
        set((state) => ({
          messages: markRoomMessageById(state.messages, messageId, {
            reactions: updated.reactions,
          }),
        }));
      } catch {
        return;
      }
    },

    deleteRoomMessage: async (messageId) => {
      const room = get().activeRoom;
      if (!room) return;
      await RoomService.deleteMessage(room.id, messageId);
      if (get().activeRoom?.id !== room.id) return;
      set((state) => ({
        messages: state.messages.filter((item) => item.id !== messageId),
        replyTarget:
          state.replyTarget?.id === messageId ? null : state.replyTarget,
      }));
    },
  };
}
