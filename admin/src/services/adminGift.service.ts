import http from '@/api/http'
import type {
  AdminGift,
  ApiResponse,
  CreateGiftRequest,
  GiftTransactionListParams,
  GiftTransactionListResult,
  MessageResult,
  UpdateGiftRequest,
} from '@/types'

export const AdminGiftService = {
  async list(): Promise<AdminGift[]> {
    const { data } = await http.get<ApiResponse<{ items: AdminGift[] }>>('/admin/gifts')
    return data.data.items
  },

  async create(payload: CreateGiftRequest): Promise<AdminGift> {
    const { data } = await http.post<ApiResponse<AdminGift>>('/admin/gifts', payload)
    return data.data
  },

  async update(id: string, payload: UpdateGiftRequest): Promise<AdminGift> {
    const { data } = await http.patch<ApiResponse<AdminGift>>(`/admin/gifts/${id}`, payload)
    return data.data
  },

  async remove(id: string): Promise<MessageResult> {
    const { data } = await http.delete<ApiResponse<MessageResult>>(`/admin/gifts/${id}`)
    return data.data
  },

  async transactions(params: GiftTransactionListParams): Promise<GiftTransactionListResult> {
    const { data } = await http.get<ApiResponse<GiftTransactionListResult>>(
      '/admin/gifts/transactions',
      { params },
    )
    return data.data
  },
}
