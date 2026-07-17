import type { TFunction } from 'i18next';
import type { Message } from '@ola/shared/types';
import { kulImageForText } from '@lib/kul';

export function isCopyableText(message: Message): boolean {
  return (
    message.type === 'text' &&
    message.content.trim() !== '' &&
    kulImageForText(message.content) == null
  );
}

export function replyExcerpt(t: TFunction, message: Message): string {
  if (message.type === 'image') return t('chat.replyImage');
  if (message.type === 'audio') return t('chat.replyAudio');
  return kulImageForText(message.content) != null ? t('chat.replySticker') : message.content;
}

export interface ChatMessageAbilities {
  canReply: boolean;
  canCopy: boolean;
  canEdit: boolean;
  canDelete: boolean;
}

export function chatMessageAbilities(message: Message, myId: string): ChatMessageAbilities {
  const isOwn = message.senderId === myId;
  return {
    canReply: !isOwn,
    canCopy: isCopyableText(message),
    canEdit: isOwn && message.type === 'text',
    canDelete: isOwn,
  };
}
