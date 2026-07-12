import http from '@/api/http'
import type { ApiResponse, DashboardOverview, DashboardOverviewParams } from '@/types'

export const AdminDashboardService = {
  async getOverview(params: DashboardOverviewParams = {}): Promise<DashboardOverview> {
    const { data } = await http.get<ApiResponse<DashboardOverview>>('/admin/dashboard/overview', {
      params,
    })
    return data.data
  },
}
