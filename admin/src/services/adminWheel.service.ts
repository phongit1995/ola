import http from '@/api/http'
import type {
  AdminWheelSpin,
  ApiResponse,
  CreateWheelRequest,
  ListResult,
  MessageResult,
  SaveWheelConfigRequest,
  UpdateWheelRequest,
  Wheel,
  WheelSpinListParams,
  WheelStatsParams,
  WheelStatsResponse,
  WheelUserStatsItem,
  WheelUserStatsParams,
  WheelVipStatsParams,
  WheelVipStatsRow,
} from '@/types'

export const AdminWheelService = {
  async listWheels(): Promise<Wheel[]> {
    const { data } = await http.get<ApiResponse<{ items: Wheel[] }>>('/admin/wheel/wheels')
    return data.data.items
  },

  async createWheel(payload: CreateWheelRequest): Promise<Wheel> {
    const { data } = await http.post<ApiResponse<Wheel>>('/admin/wheel/wheels', payload)
    return data.data
  },

  async updateWheel(id: string, payload: UpdateWheelRequest): Promise<Wheel> {
    const { data } = await http.patch<ApiResponse<Wheel>>(`/admin/wheel/wheels/${id}`, payload)
    return data.data
  },

  async removeWheel(id: string): Promise<MessageResult> {
    const { data } = await http.delete<ApiResponse<MessageResult>>(`/admin/wheel/wheels/${id}`)
    return data.data
  },

  async saveConfig(id: string, payload: SaveWheelConfigRequest): Promise<Wheel> {
    const { data } = await http.put<ApiResponse<Wheel>>(`/admin/wheel/wheels/${id}/config`, payload)
    return data.data
  },

  async listSpins(params: WheelSpinListParams = {}): Promise<ListResult<AdminWheelSpin>> {
    const { data } = await http.get<ApiResponse<ListResult<AdminWheelSpin>>>('/admin/wheel/spins', {
      params,
    })
    return data.data
  },

  async getStats(params: WheelStatsParams = {}): Promise<WheelStatsResponse> {
    const { data } = await http.get<ApiResponse<WheelStatsResponse>>('/admin/wheel/stats', {
      params,
    })
    return data.data
  },

  async getUserStats(params: WheelUserStatsParams = {}): Promise<ListResult<WheelUserStatsItem>> {
    const { data } = await http.get<ApiResponse<ListResult<WheelUserStatsItem>>>(
      '/admin/wheel/stats/users',
      { params },
    )
    return data.data
  },

  async getVipStats(params: WheelVipStatsParams = {}): Promise<{ items: WheelVipStatsRow[] }> {
    const { data } = await http.get<ApiResponse<{ items: WheelVipStatsRow[] }>>(
      '/admin/wheel/stats/vip',
      { params },
    )
    return data.data
  },
}
