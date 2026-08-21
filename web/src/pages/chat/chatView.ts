import type { TFunction } from 'i18next';
import type { ChatReplySnapshot, Conversation, Message } from '@app-types';
import { MESSAGE_TYPE } from '@constants';
import {
  colorForName,
  DEFAULT_AVATAR_COLOR,
  formatClockHM,
  formatDuration,
  kulImageForText,
  parseMessageMetadata,
} from '@lib';
import type {
  ChatMessage,
  ChatMessageAbilities,
  ConversationView,
} from './interface';
import { STATUS_MAP } from './constants';

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

export function toConversationView(
  conversation: Conversation,
  formatTime: (iso: string) => string = formatClockHM,
): ConversationView {
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
    time: formatTime(conversation.lastMessageAt ?? ''),
    unread: conversation.unreadCount,
    online:
      conversation.type === 'direct'
        ? conversation.otherUser?.isOnline ?? false
        : false,
  };
}

export function chatQuoteExcerpt(
  t: TFunction,
  replyTo: Pick<ChatReplySnapshot, 'type' | 'excerpt'>
): string {
  if (replyTo.type === MESSAGE_TYPE.image) return t('chat.replyImage');
  if (replyTo.type === MESSAGE_TYPE.audio) return t('chat.replyAudio');
  if (kulImageForText(replyTo.excerpt) != null) return t('chat.replySticker');
  return replyTo.excerpt;
}

export function isCopyableText(message: ChatMessage): boolean {
  return (
    message.kind === 'text' &&
    message.text != null &&
    message.text.trim() !== '' &&
    kulImageForText(message.text) == null
  );
}

export function chatMessageAbilities(
  message: ChatMessage,
  blocked: boolean
): ChatMessageAbilities {
  const isOwn = message.direction === 'out';
  return {
    canReply: !isOwn && !blocked && message.kind !== 'call',
    canCopy: isCopyableText(message),
    canEdit: isOwn && message.kind === 'text',
    canDelete: isOwn,
    canReport: !isOwn && message.kind !== 'call',
  };
}

export function toBubble(message: Message, myId: string): ChatMessage {
  const isImage = message.type === MESSAGE_TYPE.image;
  const isAudio = message.type === MESSAGE_TYPE.audio;
  const isCall = message.type === MESSAGE_TYPE.call;
  const meta =
    isImage || isAudio || isCall ? parseMessageMetadata(message.metadata) : {};
  return {
    id: message.id,
    key: message.clientMsgId ?? message.id,
    direction: message.senderId === myId ? 'out' : 'in',
    kind: isImage ? 'image' : isAudio ? 'voice' : isCall ? 'call' : 'text',
    text: isImage || isAudio || isCall ? undefined : message.content,
    call: isCall ? meta : undefined,
    image: isImage ? meta.url : undefined,
    audioUrl: isAudio ? meta.url : undefined,
    audioDuration: isAudio ? meta.duration : undefined,
    audioWaveform: isAudio ? meta.waveform : undefined,
    voiceDuration: isAudio ? formatDuration(meta.duration) : undefined,
    time: formatClockHM(message.createdAt),
    createdAt: message.createdAt,
    status: STATUS_MAP[message.status] ?? 'sent',
    reactions: message.reactions,
    replyTo: message.replyTo,
  };
}
