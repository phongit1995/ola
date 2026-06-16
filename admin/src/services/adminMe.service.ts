import http from '@/api/http'
import type {
  ApiResponse,
  ListParams,
  ListResult,
  MessageResult,
  MeComment,
  MeDetail,
  MeListItem,
  MeListParams,
} from '@/types'

export const AdminMeService = {
  async list(params: MeListParams = {}): Promise<ListResult<MeListItem>> {
    const { data } = await http.get<ApiResponse<ListResult<MeListItem>>>('/admin/me', {
      params,
    })
    return data.data
  },

  async get(id: string): Promise<MeDetail> {
    const { data } = await http.get<ApiResponse<MeDetail>>(`/admin/me/${id}`)
    return data.data
  },

  async setStatus(id: string, enabled: boolean): Promise<MeDetail> {
    const { data } = await http.patch<ApiResponse<MeDetail>>(`/admin/me/${id}/status`, {
      enabled,
    })
    return data.data
  },

  async listComments(id: string, params: ListParams = {}): Promise<ListResult<MeComment>> {
    const { data } = await http.get<ApiResponse<ListResult<MeComment>>>(
      `/admin/me/${id}/comments`,
      { params },
    )
    return data.data
  },

  async removeComment(id: string, commentId: string): Promise<MessageResult> {
    const { data } = await http.delete<ApiResponse<MessageResult>>(
      `/admin/me/${id}/comments/${commentId}`,
    )
    return data.data
  },
}
