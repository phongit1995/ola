import http from '@/api/http'
import type {
  AdminUserMegaphoneTicket,
  AdminUserMegaphoneTicketList,
  ApiResponse,
  ContentCheckResult,
  GrantMegaphoneTicketsRequest,
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

  async userTickets(userId: string): Promise<AdminUserMegaphoneTicketList> {
    const { data } = await http.get<ApiResponse<AdminUserMegaphoneTicketList>>(`/admin/users/${userId}/megaphone-tickets`)
    return data.data
  },

  async grantUserTickets(userId: string, payload: GrantMegaphoneTicketsRequest): Promise<AdminUserMegaphoneTicketList> {
    const { data } = await http.post<ApiResponse<AdminUserMegaphoneTicketList>>(
      `/admin/users/${userId}/megaphone-tickets`,
      payload,
    )
    return data.data
  },

  async revokeUserTicket(userId: string, ticketId: string): Promise<AdminUserMegaphoneTicket> {
    const { data } = await http.post<ApiResponse<AdminUserMegaphoneTicket>>(
      `/admin/users/${userId}/megaphone-tickets/${ticketId}/revoke`,
    )
    return data.data
  },

  async checkContent(text: string): Promise<ContentCheckResult> {
    const { data } = await http.post<ApiResponse<ContentCheckResult>>('/admin/content-filter/check', { text })
    return data.data
  },
}
