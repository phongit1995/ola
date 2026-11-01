import type { MeNotificationType } from '../types/api/me.type';
import type { AppNotificationType } from '../types/api/notification.type';

export const APP_NOTIFICATION_TYPE = {
  friendRequest: 'friend_request',
  marriageProposal: 'marriage_proposal',
  contentViolation: 'content_violation',
  reportResolved: 'report_resolved',
} as const satisfies Record<string, AppNotificationType>;

const SYSTEM_NOTICE_TYPES: ReadonlySet<string> = new Set([
  APP_NOTIFICATION_TYPE.contentViolation,
  APP_NOTIFICATION_TYPE.reportResolved,
]);

export function isSystemNotice(type: string): boolean {
  return SYSTEM_NOTICE_TYPES.has(type);
}

export const NOTIFICATION_PAGE_SIZE = 30;

export const ME_NOTIFICATION_LABEL_KEY = {
  like: 'me.notifLike',
  comment: 'me.notifComment',
  reply: 'me.notifReply',
  mention: 'me.notifMention',
  comment_like: 'me.notifCommentLike',
  moment_comment: 'me.notifMomentComment',
  moment_reaction: 'me.notifMomentReaction',
} as const satisfies Record<MeNotificationType, string>;
