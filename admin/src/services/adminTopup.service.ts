import http from '@/api/http'
import type {
  ApiResponse,
  ListResult,
  TopupManualCreditResult,
  TopupStatsParams,
  TopupStatsResult,
  TopupTransaction,
  TopupTransactionListParams,
} from '@/types'

export const AdminTopupService = {
  async listTransactions(
    params: TopupTransactionListParams = {},
  ): Promise<ListResult<TopupTransaction>> {
    const { data } = await http.get<ApiResponse<ListResult<TopupTransaction>>>(
      '/admin/topup/transactions',
      { params },
    )
    return data.data
  },

  async getStats(params: TopupStatsParams = {}): Promise<TopupStatsResult> {
    const { data } = await http.get<ApiResponse<TopupStatsResult>>('/admin/topup/stats', {
      params,
    })
    return data.data
  },

  async manualCredit(id: string, username: string): Promise<TopupManualCreditResult> {
    const { data } = await http.post<ApiResponse<TopupManualCreditResult>>(
      `/admin/topup/transactions/${id}/credit`,
      { username },
    )
    return data.data
  },
}
