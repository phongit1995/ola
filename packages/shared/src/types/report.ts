export type ReportTargetType = 'account' | 'post' | 'comment';

export interface ReportTarget {
  type: ReportTargetType;
  id: string;
}
