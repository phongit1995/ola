import type { Conversation, Message } from '../api/chat.type';

export interface ChatSocketEnvelope<T = unknown> {
  type: string;
  data: T;
}

export interface NewMessageEvent {
  conversation: Conversation;
  message: Message;
}

export interface MessageUpdatedEvent {
  conversation: Conversation;
  message: Message;
}

export interface MessageDeletedEvent {
  conversation: Conversation;
  messageId: string;
}

export interface ConversationUpdatedEvent {
  id?: string;
  seen?: boolean;
}

export interface MessageReactionUpdatedEvent {
  conversationId: string;
  messageId: string;
  reactions: Record<string, string[]>;
  actorUserId: string;
  type: string;
  action: 'added' | 'removed';
}

export interface UserTypingEvent {
  conversationId: string;
  userId: string;
  username: string;
  time: string;
}
