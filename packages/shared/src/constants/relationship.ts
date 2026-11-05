import type { RelationshipStatus } from '../types/api/user.type';

export const RELATIONSHIP_STATUS = {
  self: 'self',
  none: 'none',
  friend: 'friend',
  pendingOutgoing: 'pending_outgoing',
  pendingIncoming: 'pending_incoming',
  blockedByMe: 'blocked_by_me',
  blockedByThem: 'blocked_by_them',
} as const satisfies Record<string, RelationshipStatus>;

export const VIP_TRANSFER_BLOCKED_ERROR = 'cannot transfer vip to a blocked user';
