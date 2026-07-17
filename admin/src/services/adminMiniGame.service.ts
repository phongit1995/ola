import http from '@/api/http'
import type {
  ApiResponse,
  CreateMiniGameRequest,
  ListResult,
  MessageResult,
  MiniGame,
  UpdateMiniGameRequest,
} from '@/types'

export const AdminMiniGameService = {
  async list(): Promise<ListResult<MiniGame>> {
    const { data } = await http.get<ApiResponse<ListResult<MiniGame>>>('/admin/mini-games')
    return data.data
  },

  async create(payload: CreateMiniGameRequest): Promise<MiniGame> {
    const { data } = await http.post<ApiResponse<MiniGame>>('/admin/mini-games', payload)
    return data.data
  },

  async update(id: string, payload: UpdateMiniGameRequest): Promise<MiniGame> {
    const { data } = await http.patch<ApiResponse<MiniGame>>(`/admin/mini-games/${id}`, payload)
    return data.data
  },

  async remove(id: string): Promise<MessageResult> {
    const { data } = await http.delete<ApiResponse<MessageResult>>(`/admin/mini-games/${id}`)
    return data.data
  },
}
