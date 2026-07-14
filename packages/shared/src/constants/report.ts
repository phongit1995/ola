export const REPORT_REASONS = [
  { value: 'spam', labelKey: 'report.reasonSpam' },
  { value: 'sensitive', labelKey: 'report.reasonSensitive' },
  { value: 'scam', labelKey: 'report.reasonScam' },
  { value: 'harassment', labelKey: 'report.reasonHarassment' },
  { value: 'other', labelKey: 'report.reasonOther' },
] as const;

export type ReportReason = (typeof REPORT_REASONS)[number]['value'];
