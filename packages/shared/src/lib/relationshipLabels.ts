import type { TFunction } from 'i18next';
import type { RelationshipStatus } from '../types/api/user.type';
import { RELATIONSHIP_STATUS } from '../constants/relationship';

export function chatFriendActionLabel(
  t: TFunction,
  status: RelationshipStatus | null | undefined
): string {
  if (status === RELATIONSHIP_STATUS.pendingOutgoing) return t('chat.cancelRequest');
  if (status === RELATIONSHIP_STATUS.pendingIncoming) return t('chat.acceptRequest');
  if (status === RELATIONSHIP_STATUS.friend) return t('chat.unfriend');
  return t('chat.menuMakeFriend');
}

export function profileFriendLabel(
  t: TFunction,
  status: RelationshipStatus | null | undefined
): string {
  if (status === RELATIONSHIP_STATUS.friend) return t('profile.alreadyFriend');
  if (status === RELATIONSHIP_STATUS.pendingOutgoing) return t('profile.requestSent');
  if (status === RELATIONSHIP_STATUS.pendingIncoming) return t('profile.acceptFriend');
  return t('profile.makeFriend');
}
