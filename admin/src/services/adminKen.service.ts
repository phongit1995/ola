import http from '@/api/http'
import type {
  ApiResponse,
  KenAdjustRequest,
  KenAdjustResult,
  KenTransaction,
  KenTransferItem,
  KenTransferListParams,
  KenTransferUserStatsItem,
  KenTransferUserStatsParams,
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

  async listTransfers(params: KenTransferListParams = {}): Promise<ListResult<KenTransferItem>> {
    const { data } = await http.get<ApiResponse<ListResult<KenTransferItem>>>(
      '/admin/ken/transfers',
      { params },
    )
    return data.data
  },

  async getTransferUserStats(
    params: KenTransferUserStatsParams = {},
  ): Promise<ListResult<KenTransferUserStatsItem>> {
    const { data } = await http.get<ApiResponse<ListResult<KenTransferUserStatsItem>>>(
      '/admin/ken/transfers/users',
      { params },
    )
    return data.data
  },
}
