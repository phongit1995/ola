import http from '@/api/http'
import type {
  ApiResponse,
  ContentCheckResult,
  MegaphoneListParams,
  MegaphoneListResult,
  RemoveMegaphoneRequest,
  RemoveMegaphoneResult,
} from '@/types'

export const AdminMegaphoneService = {
  async list(params: MegaphoneListParams): Promise<MegaphoneListResult> {
    const { data } = await http.get<ApiResponse<MegaphoneListResult>>('/admin/megaphones', { params })
    return data.data
  },

  async remove(id: string, payload: RemoveMegaphoneRequest): Promise<RemoveMegaphoneResult> {
    const { data } = await http.post<ApiResponse<RemoveMegaphoneResult>>(`/admin/megaphones/${id}/remove`, payload)
    return data.data
  },

  async checkContent(text: string): Promise<ContentCheckResult> {
    const { data } = await http.post<ApiResponse<ContentCheckResult>>('/admin/content-filter/check', { text })
    return data.data
  },
}
