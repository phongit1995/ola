import type { TFunction } from 'i18next';
import type { RoomMessage } from '@app-types';
import { kulImageForText } from '@lib';

export function isCopyableText(message: RoomMessage): boolean {
  return (
    message.type !== 'image' &&
    kulImageForText(message.content) == null &&
    message.content.trim() !== ''
  );
}

export function replyExcerpt(t: TFunction, message: RoomMessage): string {
  if (message.type === 'image') return t('room.replyImage');
  return kulImageForText(message.content) != null
    ? t('room.replySticker')
    : message.content;
}

export interface RoomMessageAbilities {
  isOwn: boolean;
  canCopy: boolean;
}

export function roomMessageAbilities(
  message: RoomMessage,
  currentUserId: string
): RoomMessageAbilities {
  return {
    isOwn: message.senderId === currentUserId,
    canCopy: isCopyableText(message),
  };
}
