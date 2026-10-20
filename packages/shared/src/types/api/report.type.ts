import type { ReportReason, ReportTargetType } from '../report';

export interface CreateReportRequest {
  targetType: ReportTargetType;
  targetId: string;
  contextId?: string;
  reason: ReportReason;
  note?: string;
}

export interface CreateReportResult {
  id: string;
  status: string;
  createdAt: string;
}
