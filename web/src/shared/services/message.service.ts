import { http } from '@api';
import { API_PATH } from '@config';
import type {
  GetMessagesParams,
  Message,
  MessageResult,
  MessagesListResult,
  ReactionType,
  SendDirectMessageRequest,
  SendMessageRequest,
} from '@app-types';

export class MessageService {
  static list(conversationId: string, params: GetMessagesParams = {}): Promise<MessagesListResult> {
    return http.get<MessagesListResult>(API_PATH.messages.byConversation(conversationId), {
      params,
    });
  }

  static send(payload: SendMessageRequest): Promise<Message> {
    return http.post<Message>(API_PATH.messages.base, payload);
  }

  static sendImage(conversationId: string, file: File, clientMsgId?: string): Promise<Message> {
    const form = new FormData();
    form.append('file', file);
    form.append('conversationId', conversationId);
    if (clientMsgId != null) form.append('clientMsgId', clientMsgId);
    return http.postForm<Message>(API_PATH.messages.images, form);
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
