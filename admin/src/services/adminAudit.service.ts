import http from '@/api/http'
import type { AdminAuditLog, ApiResponse, AuditLogListParams, ListResult } from '@/types'

export const AdminAuditService = {
  async list(params: AuditLogListParams = {}): Promise<ListResult<AdminAuditLog>> {
    const { data } = await http.get<ApiResponse<ListResult<AdminAuditLog>>>('/admin/logs', {
      params,
    })
    return data.data
  },
}
