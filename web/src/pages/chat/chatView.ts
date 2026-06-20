import type { Conversation, Message, MessageStatus } from '@app-types';
import { colorForName, DEFAULT_AVATAR_COLOR, kulImageForText } from '@lib';
import type { ChatMessage, ChatMessageStatus } from './types';

export interface ConversationView {
  id: string;
  name: string;
  username: string;
  title: string;
  avatar?: string;
  color: string;
  preview: string;
  previewIsSticker: boolean;
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
  const lastText = conversation.lastMessageText ?? '';
  const isSticker = kulImageForText(lastText) != null;
  return {
    id: conversation.id,
    name,
    username: conversation.otherUser?.username ?? '',
    title: conversationHeaderTitle(conversation),
    avatar: conversation.otherUser?.avatar ?? conversation.avatar,
    color: name ? colorForName(name) : DEFAULT_AVATAR_COLOR,
    preview: isSticker ? '' : lastText,
    previewIsSticker: isSticker,
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

function parseMetadata(metadata?: string): { url?: string; duration?: number } {
  if (metadata == null || metadata === '') return {};
  try {
    return JSON.parse(metadata) as { url?: string; duration?: number };
  } catch {
    return {};
  }
}

export function formatDuration(seconds?: number): string {
  const total = Math.max(0, Math.round(seconds ?? 0));
  const minutes = Math.floor(total / 60);
  return `${minutes}:${String(total % 60).padStart(2, '0')}`;
}

export function toBubble(message: Message, myId: string): ChatMessage {
  const isImage = message.type === 'image';
  const isAudio = message.type === 'audio';
  const meta = isImage || isAudio ? parseMetadata(message.metadata) : {};
  return {
    id: message.id,
    direction: message.senderId === myId ? 'out' : 'in',
    kind: isImage ? 'image' : isAudio ? 'voice' : 'text',
    text: isImage || isAudio ? undefined : message.content,
    image: isImage ? meta.url : undefined,
    audioUrl: isAudio ? meta.url : undefined,
    audioDuration: isAudio ? meta.duration : undefined,
    voiceDuration: isAudio ? formatDuration(meta.duration) : undefined,
    time: formatClock(message.createdAt),
    createdAt: message.createdAt,
    status: STATUS_MAP[message.status] ?? 'sent',
    reactions: message.reactions,
  };
}
