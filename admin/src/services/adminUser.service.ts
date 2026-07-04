import http from '@/api/http'
import type {
  ApiResponse,
  AdminUserDetail,
  AdminUserListItem,
  AdminUserVipIcon,
  ListParams,
  ListResult,
  MessageResult,
  UserListParams,
} from '@/types'

export const AdminUserService = {
  async list(params: UserListParams = {}): Promise<ListResult<AdminUserListItem>> {
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

  async listVips(id: string, params: ListParams = {}): Promise<ListResult<AdminUserVipIcon>> {
    const { data } = await http.get<ApiResponse<ListResult<AdminUserVipIcon>>>(
      `/admin/users/${id}/vips`,
      { params },
    )
    return data.data
  },

  async updateStatus(id: string, isActive: boolean): Promise<AdminUserDetail> {
    const { data } = await http.patch<ApiResponse<AdminUserDetail>>(
      `/admin/users/${id}/status`,
      { isActive },
    )
    return data.data
  },

  async updateUsername(id: string, username: string): Promise<AdminUserDetail> {
    const { data } = await http.patch<ApiResponse<AdminUserDetail>>(
      `/admin/users/${id}/username`,
      { username },
    )
    return data.data
  },

  async resetPassword(id: string, password: string): Promise<MessageResult> {
    const { data } = await http.patch<ApiResponse<MessageResult>>(
      `/admin/users/${id}/password`,
      { password },
    )
    return data.data
  },

  async remove(id: string): Promise<MessageResult> {
    const { data } = await http.delete<ApiResponse<MessageResult>>(`/admin/users/${id}`)
    return data.data
  },
}
