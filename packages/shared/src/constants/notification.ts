import type { AppNotificationType } from '../types/api/notification.type';

export const APP_NOTIFICATION_TYPE = {
  friendRequest: 'friend_request',
  marriageProposal: 'marriage_proposal',
} as const satisfies Record<string, AppNotificationType>;

export const NOTIFICATION_PAGE_SIZE = 30;
