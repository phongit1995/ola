export type ReportTargetType = 'account' | 'post' | 'comment';
export type ReportReason = 'spam' | 'sensitive' | 'scam' | 'harassment' | 'other';

export interface ReportTarget {
  type: ReportTargetType;
  id: string;
}
