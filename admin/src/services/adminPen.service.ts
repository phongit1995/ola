import http from '@/api/http'
import type {
  AdminPenShot,
  ApiResponse,
  ListResult,
  PenShotListParams,
  PenStatsParams,
  PenStatsResponse,
} from '@/types'

export const AdminPenService = {
  async listShots(params: PenShotListParams = {}): Promise<ListResult<AdminPenShot>> {
    const { data } = await http.get<ApiResponse<ListResult<AdminPenShot>>>('/admin/pen/shots', {
      params,
    })
    return data.data
  },

  async getStats(params: PenStatsParams = {}): Promise<PenStatsResponse> {
    const { data } = await http.get<ApiResponse<PenStatsResponse>>('/admin/pen/stats', { params })
    return data.data
  },
}
