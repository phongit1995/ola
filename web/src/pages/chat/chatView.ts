import type { TFunction } from 'i18next';
import type { ChatReplySnapshot, Conversation, Message } from '@app-types';
import {
  colorForName,
  DEFAULT_AVATAR_COLOR,
  formatClockHM,
  formatDuration,
  kulImageForText,
  parseMessageMetadata,
} from '@lib';
import type { ChatMessage } from './types';
import { STATUS_MAP } from './constants';

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
  online: boolean;
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
    time: formatClockHM(conversation.lastMessageAt),
    unread: conversation.unreadCount,
    online: conversation.type === 'direct' ? (conversation.otherUser?.isOnline ?? false) : false,
  };
}

export function chatQuoteExcerpt(
  t: TFunction,
  replyTo: Pick<ChatReplySnapshot, 'type' | 'excerpt'>
): string {
  if (replyTo.type === 'image') return t('chat.replyImage');
  if (replyTo.type === 'audio') return t('chat.replyAudio');
  if (kulImageForText(replyTo.excerpt) != null) return t('chat.replySticker');
  return replyTo.excerpt;
}

export function toBubble(message: Message, myId: string): ChatMessage {
  const isImage = message.type === 'image';
  const isAudio = message.type === 'audio';
  const meta = isImage || isAudio ? parseMessageMetadata(message.metadata) : {};
  return {
    id: message.id,
    key: message.clientMsgId ?? message.id,
    direction: message.senderId === myId ? 'out' : 'in',
    kind: isImage ? 'image' : isAudio ? 'voice' : 'text',
    text: isImage || isAudio ? undefined : message.content,
    image: isImage ? meta.url : undefined,
    audioUrl: isAudio ? meta.url : undefined,
    audioDuration: isAudio ? meta.duration : undefined,
    voiceDuration: isAudio ? formatDuration(meta.duration) : undefined,
    time: formatClockHM(message.createdAt),
    createdAt: message.createdAt,
    status: STATUS_MAP[message.status] ?? 'sent',
    reactions: message.reactions,
    replyTo: message.replyTo,
  };
}
