import type { TFunction } from 'i18next';
import type { Friend, Message } from '@ola/shared/types';
import { normalizeDevice } from '@lib/deviceIcons';
import {
  isCopyableMessageText,
  messageReplyExcerpt,
} from '@lib/messageView';
import { MESSAGE_TYPE } from '@ola/shared/constants';
import {
  activeVipTypeId,
  colorForName,
  formatLastActive,
  isBirthdayToday,
  isVipActive,
  isWithinMessageDeleteWindow,
} from '@ola/shared/lib';
import type { Contact } from './types';

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
  return {
    canReply: !isOwn && !blocked && message.type !== 'call',
    canCopy: isCopyableMessageText(message),
    canEdit: isOwn && message.type === MESSAGE_TYPE.text,
    canDelete: isOwn && isWithinMessageDeleteWindow(message.createdAt),
    canReport: !isOwn && message.type !== 'call',
  };
}

export function mapFriendsToContacts(friends: Friend[], locale: string, now: number): Contact[] {
  const today = new Date(now);
  return friends.map((friend) => ({
    id: friend.id,
    name: friend.username,
    fullName: friend.fullName,
    status: friend.bio,
    color: colorForName(friend.id),
    avatar: friend.avatar,
    vip: isVipActive(friend.vipEndTime),
    vipTypeId: activeVipTypeId(friend.vipUsed, friend.vipEndTime),
    online: friend.isOnline,
    deviceType: normalizeDevice(friend.deviceType),
    lastActive: friend.isOnline ? undefined : formatLastActive(locale, friend.lastActiveAt, now),
    statusImage: friend.bioImage ?? undefined,
    group: isBirthdayToday(friend.dateOfBirth, today) ? 'birthday' : 'friend',
  }));
}
