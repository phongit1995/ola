import http from '@/api/http'
import type {
  AdminEggDraw,
  ApiResponse,
  CreateEggPackRequest,
  EggDrawListParams,
  EggPack,
  EggStatsParams,
  EggStatsResponse,
  ListResult,
  MessageResult,
  SaveEggConfigRequest,
  UpdateEggPackRequest,
} from '@/types'

export const AdminEggService = {
  async listPacks(): Promise<EggPack[]> {
    const { data } = await http.get<ApiResponse<{ items: EggPack[] }>>('/admin/egg/packs')
    return data.data.items
  },

  async createPack(payload: CreateEggPackRequest): Promise<EggPack> {
    const { data } = await http.post<ApiResponse<EggPack>>('/admin/egg/packs', payload)
    return data.data
  },

  async updatePack(id: string, payload: UpdateEggPackRequest): Promise<EggPack> {
    const { data } = await http.patch<ApiResponse<EggPack>>(`/admin/egg/packs/${id}`, payload)
    return data.data
  },

  async removePack(id: string): Promise<MessageResult> {
    const { data } = await http.delete<ApiResponse<MessageResult>>(`/admin/egg/packs/${id}`)
    return data.data
  },

  async saveConfig(id: string, payload: SaveEggConfigRequest): Promise<EggPack> {
    const { data } = await http.put<ApiResponse<EggPack>>(`/admin/egg/packs/${id}/config`, payload)
    return data.data
  },

  async listDraws(params: EggDrawListParams = {}): Promise<ListResult<AdminEggDraw>> {
    const { data } = await http.get<ApiResponse<ListResult<AdminEggDraw>>>('/admin/egg/draws', {
      params,
    })
    return data.data
  },

  async getStats(params: EggStatsParams = {}): Promise<EggStatsResponse> {
    const { data } = await http.get<ApiResponse<EggStatsResponse>>('/admin/egg/stats', { params })
    return data.data
  },
}
