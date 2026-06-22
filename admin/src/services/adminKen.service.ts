import http from '@/api/http'
import type {
  ApiResponse,
  KenAdjustRequest,
  KenAdjustResult,
  KenTransaction,
  ListParams,
  ListResult,
} from '@/types'

export const AdminKenService = {
  async adjust(userId: string, payload: KenAdjustRequest): Promise<KenAdjustResult> {
    const { data } = await http.post<ApiResponse<KenAdjustResult>>(
      `/admin/ken/users/${userId}/adjust`,
      payload,
    )
    return data.data
  },

  async listTransactions(
    userId: string,
    params: ListParams = {},
  ): Promise<ListResult<KenTransaction>> {
    const { data } = await http.get<ApiResponse<ListResult<KenTransaction>>>(
      `/admin/ken/users/${userId}/transactions`,
      { params },
    )
    return data.data
  },
}
