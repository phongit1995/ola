import http from '@/api/http'
import type {
  ApiResponse,
  Clan,
  ClanMember,
  ListParams,
  ListResult,
  MessageResult,
} from '@/types'

export const AdminClanService = {
  async list(params: ListParams = {}): Promise<ListResult<Clan>> {
    const { data } = await http.get<ApiResponse<ListResult<Clan>>>('/admin/clans', {
      params,
    })
    return data.data
  },

  async members(id: string, params: ListParams = {}): Promise<ListResult<ClanMember>> {
    const { data } = await http.get<ApiResponse<ListResult<ClanMember>>>(
      `/admin/clans/${id}/members`,
      { params },
    )
    return data.data
  },

  async remove(id: string): Promise<MessageResult> {
    const { data } = await http.delete<ApiResponse<MessageResult>>(`/admin/clans/${id}`)
    return data.data
  },
}
