import http from '@/api/http'
import type {
  AdminReport,
  ApiResponse,
  ListResult,
  ReportListParams,
  ReportSummary,
  UpdateReportStatusRequest,
  UpdateReportStatusResult,
} from '@/types'

export const AdminReportService = {
  async list(params: ReportListParams = {}): Promise<ListResult<AdminReport>> {
    const { data } = await http.get<ApiResponse<ListResult<AdminReport>>>('/admin/reports', {
      params,
    })
    return data.data
  },

  async summary(): Promise<ReportSummary> {
    const { data } = await http.get<ApiResponse<ReportSummary>>('/admin/reports/summary')
    return data.data
  },

  async updateStatus(
    id: string,
    payload: UpdateReportStatusRequest,
  ): Promise<UpdateReportStatusResult> {
    const { data } = await http.patch<ApiResponse<UpdateReportStatusResult>>(
      `/admin/reports/${id}/status`,
      payload,
    )
    return data.data
  },
}
