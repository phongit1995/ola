import { http } from '../api/http';
import { API_PATH } from '../config/api';
import type { CreateReportRequest, CreateReportResult } from '../types/api/report.type';

export class ReportService {
  static create(payload: CreateReportRequest): Promise<CreateReportResult> {
    return http.post<CreateReportResult>(API_PATH.reports.base, payload);
  }
}
