import type { MeNotificationType } from '../types/api/me.type';
import type { AppNotificationType } from '../types/api/notification.type';

export const APP_NOTIFICATION_TYPE = {
  friendRequest: 'friend_request',
  marriageProposal: 'marriage_proposal',
} as const satisfies Record<string, AppNotificationType>;

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
