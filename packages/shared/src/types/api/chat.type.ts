export type ConversationKind = 'direct' | 'group';

export type MessageType = 'text' | 'image' | 'file' | 'video' | 'audio' | 'call';

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
  hasMore?: boolean;
  nextBefore?: string;
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

export interface SendAudioOptions {
  clientMsgId?: string;
  replyToId?: string;
  waveform?: number[];
}

export interface ChatReactionNotice {
  seq: number;
  type: string;
}
