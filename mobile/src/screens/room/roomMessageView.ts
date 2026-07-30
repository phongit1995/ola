import type { TFunction } from 'i18next';
import type { RoomMessage } from '@ola/shared/types';
import {
  isCopyableMessageText,
  messageReplyExcerpt,
} from '@lib/messageView';

export function replyExcerpt(t: TFunction, message: RoomMessage): string {
  return messageReplyExcerpt(message, {
    image: t('room.replyImage'),
    audio: t('chat.replyAudio'),
    sticker: t('room.replySticker'),
  });
}

interface RoomMessageAbilities {
  isOwn: boolean;
  canCopy: boolean;
}

export function roomMessageAbilities(
  message: RoomMessage,
  currentUserId: string,
): RoomMessageAbilities {
  return {
    isOwn: message.senderId === currentUserId,
    canCopy: isCopyableMessageText(message),
  };
}
