import { http } from '../api/http';
import {
  appendUploadFile,
  audioUploadFilename,
  uploadFileMimeType,
} from '../lib/upload';
import { API_PATH } from '../config/api';
import { AUDIO_UPLOAD_TIMEOUT_MS } from '../constants/upload';
import type {
  GetMessagesParams,
  Message,
  MessagesListResult,
  ReactionType,
  SendAudioOptions,
  SendDirectMessageRequest,
  SendMessageRequest,
} from '../types/api/chat.type';
import type { MessageResult } from '../types/api/auth.type';
import type { UploadFile } from '../types/client/upload.type';

export type { SendAudioOptions } from '../types/api/chat.type';

export class MessageService {
  static list(conversationId: string, params: GetMessagesParams = {}): Promise<MessagesListResult> {
    return http.get<MessagesListResult>(API_PATH.messages.byConversation(conversationId), {
      params,
    });
  }

  static send(payload: SendMessageRequest): Promise<Message> {
    return http.post<Message>(API_PATH.messages.base, payload);
  }

  static sendImage(
    conversationId: string,
    file: UploadFile,
    clientMsgId?: string,
    filename?: string
  ): Promise<Message> {
    const form = new FormData();
    appendUploadFile(form, 'file', file, filename);
    form.append('conversationId', conversationId);
    if (clientMsgId != null) form.append('clientMsgId', clientMsgId);
    return http.postForm<Message>(API_PATH.messages.images, form);
  }

  static sendAudio(
    conversationId: string,
    file: UploadFile,
    duration: number,
    options: SendAudioOptions = {}
  ): Promise<Message> {
    const form = new FormData();
    appendUploadFile(form, 'file', file, audioUploadFilename(uploadFileMimeType(file)));
    form.append('conversationId', conversationId);
    form.append('duration', String(duration));
    if (options.clientMsgId != null) form.append('clientMsgId', options.clientMsgId);
    if (options.replyToId != null) form.append('replyToId', options.replyToId);
    if (options.waveform != null && options.waveform.length > 0) {
      form.append('waveform', JSON.stringify(options.waveform));
    }
    return http.postForm<Message>(API_PATH.messages.audio, form, {
      timeout: AUDIO_UPLOAD_TIMEOUT_MS,
    });
  }

  static sendDirect(payload: SendDirectMessageRequest): Promise<Message> {
    return http.post<Message>(API_PATH.messages.direct, payload);
  }

  static update(conversationId: string, messageId: string, content: string): Promise<Message> {
    return http.patch<Message>(API_PATH.messages.detail(conversationId, messageId), { content });
  }

  static remove(conversationId: string, messageId: string): Promise<MessageResult> {
    return http.del<MessageResult>(API_PATH.messages.detail(conversationId, messageId));
  }

  static toggleReaction(
    conversationId: string,
    messageId: string,
    type: ReactionType
  ): Promise<Message> {
    return http.post<Message>(API_PATH.messages.reactions(conversationId, messageId), { type });
  }
}
