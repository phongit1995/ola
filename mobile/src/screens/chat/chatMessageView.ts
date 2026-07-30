import type { TFunction } from 'i18next';
import type { Message } from '@ola/shared/types';
import {
  isCopyableMessageText,
  messageReplyExcerpt,
} from '@lib/messageView';

export function replyExcerpt(t: TFunction, message: Message): string {
  return messageReplyExcerpt(message, {
    image: t('chat.replyImage'),
    audio: t('chat.replyAudio'),
    sticker: t('chat.replySticker'),
  });
}

interface ChatMessageAbilities {
  canReply: boolean;
  canCopy: boolean;
  canEdit: boolean;
  canDelete: boolean;
}

export function chatMessageAbilities(
  message: Message,
  myId: string,
  blocked: boolean
): ChatMessageAbilities {
  const isOwn = message.senderId === myId;
  return {
    canReply: !isOwn && !blocked,
    canCopy: isCopyableMessageText(message),
    canEdit: isOwn && message.type === 'text',
    canDelete: isOwn,
  };
}
