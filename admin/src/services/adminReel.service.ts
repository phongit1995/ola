import http from '@/api/http'
import type {
  AdminReel,
  AdminReelListParams,
  AdminReelViewer,
  ApiResponse,
  ListParams,
  ListResult,
} from '@/types'

export const AdminReelService = {
  async list(params: AdminReelListParams = {}): Promise<ListResult<AdminReel>> {
    const { data } = await http.get<ApiResponse<ListResult<AdminReel>>>('/admin/reels', {
      params,
    })
    return data.data
  },

  async get(id: string): Promise<AdminReel> {
    const { data } = await http.get<ApiResponse<AdminReel>>(`/admin/reels/${id}`)
    return data.data
  },

  async setStatus(id: string, enabled: boolean): Promise<AdminReel> {
    const { data } = await http.patch<ApiResponse<AdminReel>>(`/admin/reels/${id}/status`, {
      enabled,
    })
    return data.data
  },

  async listViewers(id: string, params: ListParams = {}): Promise<ListResult<AdminReelViewer>> {
    const { data } = await http.get<ApiResponse<ListResult<AdminReelViewer>>>(
      `/admin/reels/${id}/viewers`,
      { params },
    )
    return data.data
  },
}
