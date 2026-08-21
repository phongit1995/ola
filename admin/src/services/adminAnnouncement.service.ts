import http from '@/api/http'
import type {
  Announcement,
  ApiResponse,
  CreateAnnouncementRequest,
  ListResult,
  MessageResult,
  UpdateAnnouncementRequest,
} from '@/types'

export const AdminAnnouncementService = {
  async list(): Promise<ListResult<Announcement>> {
    const { data } = await http.get<ApiResponse<ListResult<Announcement>>>('/admin/announcements')
    return data.data
  },

  async create(payload: CreateAnnouncementRequest): Promise<Announcement> {
    const { data } = await http.post<ApiResponse<Announcement>>('/admin/announcements', payload)
    return data.data
  },

  async update(id: string, payload: UpdateAnnouncementRequest): Promise<Announcement> {
    const { data } = await http.patch<ApiResponse<Announcement>>(
      `/admin/announcements/${id}`,
      payload,
    )
    return data.data
  },

  async remove(id: string): Promise<MessageResult> {
    const { data } = await http.delete<ApiResponse<MessageResult>>(`/admin/announcements/${id}`)
    return data.data
  },
}
