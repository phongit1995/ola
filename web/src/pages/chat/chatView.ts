import type { Conversation, Message, MessageStatus } from '@app-types';
import { colorForName, DEFAULT_AVATAR_COLOR } from '@lib';
import type { ChatMessage, ChatMessageStatus } from './types';

export interface ConversationView {
  id: string;
  name: string;
  title: string;
  avatar?: string;
  color: string;
  preview: string;
  fromMe: boolean;
  seen: boolean;
  senderName?: string;
  isGroup: boolean;
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

export function conversationHeaderTitle(conversation: Conversation): string {
  const username = conversation.otherUser?.username ?? '';
  const fullName = conversation.otherUser?.fullName ?? '';
  if (username !== '' && fullName !== '') return `${username} · ${fullName}`;
  return conversationDisplayName(conversation);
}

export function toConversationView(conversation: Conversation): ConversationView {
  const name = conversationDisplayName(conversation);
  return {
    id: conversation.id,
    name,
    title: conversationHeaderTitle(conversation),
    avatar: conversation.otherUser?.avatar ?? conversation.avatar,
    color: name ? colorForName(name) : DEFAULT_AVATAR_COLOR,
    preview: conversation.lastMessageText ?? '',
    fromMe: conversation.isLastMessageFromMe,
    seen: conversation.seen,
    senderName: conversation.lastMessageSenderName,
    isGroup: conversation.type === 'group',
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

export const REACTION_EMOJI: Record<string, string> = {
  LIKE: '👍',
  LOVE: '❤️',
  HAHA: '😂',
  WOW: '😮',
  SAD: '😢',
  ANGRY: '😡',
};

export const REACTION_ORDER = ['LIKE', 'LOVE', 'HAHA', 'WOW', 'SAD', 'ANGRY'] as const;

export interface ReactionChip {
  type: string;
  emoji: string;
  count: number;
}

export function reactionChips(reactions?: Record<string, string[]>): ReactionChip[] {
  if (reactions == null) return [];
  return Object.entries(reactions)
    .filter(([, users]) => users.length > 0)
    .map(([type, users]) => ({ type, emoji: REACTION_EMOJI[type] ?? '❓', count: users.length }));
}

function imageUrlFromMetadata(metadata?: string): string | undefined {
  if (metadata == null || metadata === '') return undefined;
  try {
    const parsed = JSON.parse(metadata) as { url?: string };
    return parsed.url;
  } catch {
    return undefined;
  }
}

export function toBubble(message: Message, myId: string): ChatMessage {
  const isImage = message.type === 'image';
  return {
    id: message.id,
    direction: message.senderId === myId ? 'out' : 'in',
    kind: isImage ? 'image' : 'text',
    text: isImage ? undefined : message.content,
    image: isImage ? imageUrlFromMetadata(message.metadata) : undefined,
    time: formatClock(message.createdAt),
    createdAt: message.createdAt,
    status: STATUS_MAP[message.status] ?? 'sent',
    reactions: message.reactions,
  };
}
