import http from '@/api/http'
import type {
  ApiResponse,
  CreateRoomRequest,
  ListParams,
  ListResult,
  MessageResult,
  Room,
  RoomMessagesList,
  UpdateRoomRequest,
} from '@/types'

export const AdminRoomService = {
  async list(params: ListParams = {}): Promise<ListResult<Room>> {
    const { data } = await http.get<ApiResponse<ListResult<Room>>>('/admin/rooms', {
      params,
    })
    return data.data
  },

  async create(payload: CreateRoomRequest): Promise<Room> {
    const { data } = await http.post<ApiResponse<Room>>('/admin/rooms', payload)
    return data.data
  },

  async update(id: string, payload: UpdateRoomRequest): Promise<Room> {
    const { data } = await http.patch<ApiResponse<Room>>(`/admin/rooms/${id}`, payload)
    return data.data
  },

  async remove(id: string): Promise<MessageResult> {
    const { data } = await http.delete<ApiResponse<MessageResult>>(`/admin/rooms/${id}`)
    return data.data
  },

  async messages(
    id: string,
    params: { limit?: number; before?: string } = {},
  ): Promise<RoomMessagesList> {
    const { data } = await http.get<ApiResponse<RoomMessagesList>>(
      `/admin/rooms/${id}/messages`,
      { params },
    )
    return data.data
  },

  async deleteMessage(roomId: string, messageId: string): Promise<MessageResult> {
    const { data } = await http.delete<ApiResponse<MessageResult>>(
      `/admin/rooms/${roomId}/messages/${messageId}`,
    )
    return data.data
  },
}
