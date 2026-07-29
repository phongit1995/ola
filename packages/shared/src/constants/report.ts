import type { ReportReason } from '../types/report';

export type { ReportReason } from '../types/report';

export const REPORT_REASONS = [
  { value: 'spam', labelKey: 'report.reasonSpam' },
  { value: 'sensitive', labelKey: 'report.reasonSensitive' },
  { value: 'scam', labelKey: 'report.reasonScam' },
  { value: 'harassment', labelKey: 'report.reasonHarassment' },
  { value: 'other', labelKey: 'report.reasonOther' },
] as const satisfies ReadonlyArray<{ value: ReportReason; labelKey: string }>;
