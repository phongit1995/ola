import http from '@/api/http'
import type {
  ApiResponse,
  CheckinCreateMonthRequest,
  CheckinHistoryItem,
  CheckinHistoryParams,
  CheckinMonth,
  CheckinMonthDetail,
  CheckinSlot,
  CheckinStats,
  CheckinUserMonth,
  ListResult,
} from '@/types'

const BASE = '/admin/checkin'

export const AdminCheckinService = {
  async listMonths(): Promise<CheckinMonth[]> {
    const { data } = await http.get<ApiResponse<{ items: CheckinMonth[] }>>(`${BASE}/months`)
    return data.data.items
  },

  async getMonth(month: string): Promise<CheckinMonthDetail> {
    const { data } = await http.get<ApiResponse<CheckinMonthDetail>>(`${BASE}/months/${month}`)
    return data.data
  },

  async createMonth(payload: CheckinCreateMonthRequest): Promise<CheckinMonthDetail> {
    const { data } = await http.post<ApiResponse<CheckinMonthDetail>>(`${BASE}/months`, payload)
    return data.data
  },

  async updateSlotCount(month: string, slotCount: number): Promise<CheckinMonthDetail> {
    const { data } = await http.patch<ApiResponse<CheckinMonthDetail>>(`${BASE}/months/${month}`, { slotCount })
    return data.data
  },

  async publishMonth(month: string): Promise<CheckinMonthDetail> {
    const { data } = await http.post<ApiResponse<CheckinMonthDetail>>(`${BASE}/months/${month}/publish`)
    return data.data
  },

  async deleteMonth(month: string): Promise<void> {
    await http.delete(`${BASE}/months/${month}`)
  },

  async saveSlots(month: string, slots: CheckinSlot[]): Promise<CheckinMonthDetail> {
    const { data } = await http.put<ApiResponse<CheckinMonthDetail>>(`${BASE}/months/${month}/slots`, { slots })
    return data.data
  },

  async swapSlots(month: string, from: number, to: number): Promise<CheckinMonthDetail> {
    const { data } = await http.post<ApiResponse<CheckinMonthDetail>>(`${BASE}/months/${month}/slots/swap`, { from, to })
    return data.data
  },

  async stats(month: string): Promise<CheckinStats> {
    const { data } = await http.get<ApiResponse<CheckinStats>>(`${BASE}/stats`, { params: { month } })
    return data.data
  },

  async history(params: CheckinHistoryParams): Promise<ListResult<CheckinHistoryItem>> {
    const { data } = await http.get<ApiResponse<ListResult<CheckinHistoryItem>>>(`${BASE}/history`, { params })
    return data.data
  },

  async userMonth(userId: string, month: string): Promise<CheckinUserMonth> {
    const { data } = await http.get<ApiResponse<CheckinUserMonth>>(`${BASE}/users/${userId}`, { params: { month } })
    return data.data
  },
}
