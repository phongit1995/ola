import { http } from '@api';
import { API_PATH } from '@config';
import type {
  Conversation,
  ConversationsListResult,
  MessageResult,
} from '@app-types';

export class ConversationService {
  static list(limit = 50): Promise<ConversationsListResult> {
    return http.get<ConversationsListResult>(API_PATH.conversations.base, { params: { limit } });
  }

  static getById(id: string): Promise<Conversation> {
    return http.get<Conversation>(API_PATH.conversations.detail(id));
  }

  static checkDirect(recipientId: string): Promise<Conversation | null> {
    return http.get<Conversation | null>(API_PATH.conversations.directCheck, {
      params: { recipientId },
    });
  }

  static createDirect(recipientId: string): Promise<Conversation> {
    return http.post<Conversation>(API_PATH.conversations.direct, { recipientId });
  }

  static markRead(id: string): Promise<MessageResult> {
    return http.put<MessageResult>(API_PATH.conversations.read(id));
  }

  static hide(id: string): Promise<MessageResult> {
    return http.post<MessageResult>(API_PATH.conversations.hide(id));
  }

  static unhide(id: string): Promise<MessageResult> {
    return http.post<MessageResult>(API_PATH.conversations.unhide(id));
  }

  static mute(id: string): Promise<MessageResult> {
    return http.post<MessageResult>(API_PATH.conversations.mute(id));
  }

  static unmute(id: string): Promise<MessageResult> {
    return http.post<MessageResult>(API_PATH.conversations.unmute(id));
  }

  static sendTyping(conversationId: string): Promise<MessageResult> {
    return http.post<MessageResult>(API_PATH.conversations.typing, { conversationId });
  }
}
