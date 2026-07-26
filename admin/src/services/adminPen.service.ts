import http from '@/api/http'
import type {
  AdminPenShot,
  ApiResponse,
  ListResult,
  PenShotListParams,
  PenSideStatsParams,
  PenSideStatsResponse,
  PenStatsParams,
  PenStatsResponse,
  PenUserStatsItem,
  PenUserStatsParams,
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

  async getUserStats(params: PenUserStatsParams = {}): Promise<ListResult<PenUserStatsItem>> {
    const { data } = await http.get<ApiResponse<ListResult<PenUserStatsItem>>>(
      '/admin/pen/stats/users',
      { params },
    )
    return data.data
  },

  async getSideStats(params: PenSideStatsParams = {}): Promise<PenSideStatsResponse> {
    const { data } = await http.get<ApiResponse<PenSideStatsResponse>>('/admin/pen/stats/sides', {
      params,
    })
    return data.data
  },
}
