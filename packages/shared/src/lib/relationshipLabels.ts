import type { TFunction } from 'i18next';
import type { RelationshipStatus } from '../types';

export function chatFriendActionLabel(
  t: TFunction,
  status: RelationshipStatus | null | undefined
): string {
  if (status === 'pending_outgoing') return t('chat.cancelRequest');
  if (status === 'pending_incoming') return t('chat.acceptRequest');
  if (status === 'friend') return t('chat.unfriend');
  return t('chat.menuMakeFriend');
}

export function profileFriendLabel(
  t: TFunction,
  status: RelationshipStatus | null | undefined
): string {
  if (status === 'friend') return t('profile.alreadyFriend');
  if (status === 'pending_outgoing') return t('profile.requestSent');
  if (status === 'pending_incoming') return t('profile.acceptFriend');
  return t('profile.makeFriend');
}
