export type ConversationKind = 'direct' | 'group';

export type MessageType = 'text' | 'image' | 'file' | 'video' | 'audio';

export type MessageStatus = 'sending' | 'uploading' | 'sent' | 'failed';

export type ReactionType = 'LIKE' | 'LOVE' | 'HAHA' | 'WOW' | 'SAD' | 'ANGRY';

export interface ConversationOtherUser {
  id: string;
  username: string;
  fullName?: string;
  avatar?: string;
  bio?: string;
  isOnline: boolean;
  lastActiveAt?: string;
}

export interface Conversation {
  id: string;
  type: ConversationKind;
  name?: string;
  avatar?: string;
  createdAt: string;
  updatedAt: string;
  lastMessageText?: string;
  lastMessageAt?: string;
  lastMessageSenderId?: string;
  lastMessageSenderName?: string;
  isLastMessageFromMe: boolean;
  seen: boolean;
  participantCount: number;
  unreadCount: number;
  isNew?: boolean;
  isMuted: boolean;
  otherUser?: ConversationOtherUser;
}

export interface ConversationsListResult {
  conversations: Conversation[];
  total: number;
}

export interface ChatReplySnapshot {
  messageId: string;
  senderId: string;
  senderName?: string;
  excerpt: string;
  type?: MessageType;
  imageUrl?: string;
}

export interface Message {
  id: string;
  conversationId: string;
  senderId: string;
  senderName?: string;
  senderAvatar?: string;
  type: MessageType;
  content: string;
  metadata?: string;
  status: MessageStatus;
  createdAt: string;
  updatedAt: string;
  editedAt?: string;
  replyToId?: string;
  replyTo?: ChatReplySnapshot;
  clientMsgId?: string;
  reactions?: Record<string, string[]>;
}

export interface MessagesListResult {
  messages: Message[];
  total: number;
}

export interface CreateDirectConversationRequest {
  recipientId: string;
}

export interface SendMessageRequest {
  conversationId: string;
  type: MessageType;
  content: string;
  metadata?: string;
  replyToId?: string;
  clientMsgId?: string;
}

export interface SendDirectMessageRequest {
  recipientId: string;
  type: MessageType;
  content: string;
  metadata?: string;
  clientMsgId?: string;
}

export interface GetMessagesParams {
  limit?: number;
  before?: string;
}

export const CHAT_SOCKET_EVENTS = {
  message: 'message',
  newMessage: 'NEW_MESSAGE',
  messageUpdated: 'MESSAGE_UPDATED',
  messageDeleted: 'MESSAGE_DELETED',
  reactionUpdated: 'MESSAGE_REACTION_UPDATED',
  conversationCreated: 'CONVERSATION_CREATED',
  conversationUpdated: 'CONVERSATION_UPDATED',
  conversationDeleted: 'CONVERSATION_DELETED',
  userTyping: 'USER_TYPING',
  userStopTyping: 'USER_STOP_TYPING',
} as const;

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
