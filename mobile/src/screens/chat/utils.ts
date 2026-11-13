import type { TFunction } from 'i18next';
import type { Message } from '@ola/shared/types';
import {
  isCopyableMessageText,
  messageReplyExcerpt,
} from '@lib/messageView';
import { MESSAGE_TYPE } from '@ola/shared/constants';
import { isWithinMessageDeleteWindow } from '@ola/shared/lib';

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
  canReport: boolean;
}

export function chatMessageAbilities(
  message: Message,
  myId: string,
  blocked: boolean
): ChatMessageAbilities {
  const isOwn = message.senderId === myId;
  const isSystemCard = message.type === MESSAGE_TYPE.call || message.type === MESSAGE_TYPE.gift;
  return {
    canReply: !isOwn && !blocked && !isSystemCard,
    canCopy: isCopyableMessageText(message),
    canEdit: isOwn && message.type === MESSAGE_TYPE.text,
    canDelete: isOwn && isWithinMessageDeleteWindow(message.createdAt),
    canReport: !isOwn && !isSystemCard,
  };
}
