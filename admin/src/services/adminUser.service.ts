import http from '@/api/http'
import type {
  ApiResponse,
  AdminUserDetail,
  AdminUserListItem,
  ListParams,
  ListResult,
  MessageResult,
} from '@/types'

export const AdminUserService = {
  async list(params: ListParams = {}): Promise<ListResult<AdminUserListItem>> {
    const { data } = await http.get<ApiResponse<ListResult<AdminUserListItem>>>(
      '/admin/users',
      { params },
    )
    return data.data
  },

  async get(id: string): Promise<AdminUserDetail> {
    const { data } = await http.get<ApiResponse<AdminUserDetail>>(`/admin/users/${id}`)
    return data.data
  },

  async updateStatus(id: string, isActive: boolean): Promise<AdminUserDetail> {
    const { data } = await http.patch<ApiResponse<AdminUserDetail>>(
      `/admin/users/${id}/status`,
      { isActive },
    )
    return data.data
  },

  async remove(id: string): Promise<MessageResult> {
    const { data } = await http.delete<ApiResponse<MessageResult>>(`/admin/users/${id}`)
    return data.data
  },
}
