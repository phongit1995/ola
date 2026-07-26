import http from '@/api/http'
import type {
  ApiResponse,
  ListResult,
  MarriageItem,
  MarriageListParams,
  MarriageProposalItem,
  MarriageProposalListParams,
  MarriageStats,
  MarriageStatsParams,
} from '@/types'

export const AdminMarriageService = {
  async getStats(params: MarriageStatsParams = {}): Promise<MarriageStats> {
    const { data } = await http.get<ApiResponse<MarriageStats>>('/admin/marriages/stats', {
      params,
    })
    return data.data
  },

  async list(params: MarriageListParams = {}): Promise<ListResult<MarriageItem>> {
    const { data } = await http.get<ApiResponse<ListResult<MarriageItem>>>('/admin/marriages', {
      params,
    })
    return data.data
  },

  async listProposals(
    params: MarriageProposalListParams = {},
  ): Promise<ListResult<MarriageProposalItem>> {
    const { data } = await http.get<ApiResponse<ListResult<MarriageProposalItem>>>(
      '/admin/marriages/proposals',
      { params },
    )
    return data.data
  },
}
