export type ReportTargetType =
  | 'account'
  | 'post'
  | 'comment'
  | 'story_comment'
  | 'message'
  | 'room_message'
  | 'reel';
export type ReportReason = 'spam' | 'sensitive' | 'scam' | 'harassment' | 'other';

export interface ReportTarget {
  type: ReportTargetType;
  id: string;
  contextId?: string;
}
