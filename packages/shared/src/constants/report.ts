import type { ReportReason, ReportTargetType } from '../types/report';

export type { ReportReason } from '../types/report';

export const REPORT_REASONS = [
  { value: 'spam', labelKey: 'report.reasonSpam' },
  { value: 'sensitive', labelKey: 'report.reasonSensitive' },
  { value: 'scam', labelKey: 'report.reasonScam' },
  { value: 'harassment', labelKey: 'report.reasonHarassment' },
  { value: 'other', labelKey: 'report.reasonOther' },
] as const satisfies ReadonlyArray<{ value: ReportReason; labelKey: string }>;

export const REPORT_TARGET_TYPE = {
  account: 'account',
  post: 'post',
  comment: 'comment',
  storyComment: 'story_comment',
  message: 'message',
  roomMessage: 'room_message',
} as const satisfies Record<string, ReportTargetType>;

export const REPORT_ERROR_CODE = {
  alreadySubmitted: 'REPORT_ALREADY_SUBMITTED',
} as const;

export const REPORT_NOTE_MAX_LENGTH = 500;
