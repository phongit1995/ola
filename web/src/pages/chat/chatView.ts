import type { Conversation, Message, MessageStatus } from '@app-types';
import { colorForName, DEFAULT_AVATAR_COLOR } from '@lib';
import type { ChatMessage, ChatMessageStatus } from './types';

export interface ConversationView {
  id: string;
  name: string;
  avatar?: string;
  color: string;
  preview: string;
  time: string;
  unread: number;
}

export function formatClock(iso?: string): string {
  if (iso == null || iso === '') return '';
  const date = new Date(iso);
  if (Number.isNaN(date.getTime())) return '';
  return `${String(date.getHours()).padStart(2, '0')}:${String(date.getMinutes()).padStart(2, '0')}`;
}

export function conversationDisplayName(conversation: Conversation): string {
  return (
    conversation.otherUser?.fullName ||
    conversation.otherUser?.username ||
    conversation.name ||
    ''
  );
}

export function toConversationView(conversation: Conversation): ConversationView {
  const name = conversationDisplayName(conversation);
  return {
    id: conversation.id,
    name,
    avatar: conversation.otherUser?.avatar ?? conversation.avatar,
    color: name ? colorForName(name) : DEFAULT_AVATAR_COLOR,
    preview: conversation.lastMessageText ?? '',
    time: formatClock(conversation.lastMessageAt),
    unread: conversation.unreadCount,
  };
}

const STATUS_MAP: Record<MessageStatus, ChatMessageStatus> = {
  sending: 'sending',
  uploading: 'sending',
  sent: 'sent',
  failed: 'failed',
};

export function toBubble(message: Message, myId: string): ChatMessage {
  return {
    id: message.id,
    direction: message.senderId === myId ? 'out' : 'in',
    kind: 'text',
    text: message.content,
    time: formatClock(message.createdAt),
    status: STATUS_MAP[message.status] ?? 'sent',
  };
}
