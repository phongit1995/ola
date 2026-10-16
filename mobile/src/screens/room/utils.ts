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

const LIST_PADDING = 12 * 2;
const AVATAR_WITH_GAP = 32 + 8;
const BUBBLE_PADDING = 14 * 2;

export function roomBubbleTextMaxWidth(windowWidth: number, isOwn: boolean): number {
  const rowWidth = (windowWidth - LIST_PADDING) * (isOwn ? 0.8 : 0.85);
  return Math.floor(rowWidth - AVATAR_WITH_GAP - BUBBLE_PADDING) - 2;
}
