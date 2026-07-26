import http from '@/api/http'
import type {
  ApiResponse,
  FollowItem,
  FollowListParams,
  ListResult,
  RelationshipItem,
  RelationshipListParams,
  RelationshipStats,
  RelationshipStatsParams,
  RelationshipUserStatsItem,
  RelationshipUserStatsParams,
} from '@/types'

export const AdminRelationshipService = {
  async getStats(params: RelationshipStatsParams = {}): Promise<RelationshipStats> {
    const { data } = await http.get<ApiResponse<RelationshipStats>>(
      '/admin/relationships/stats',
      { params },
    )
    return data.data
  },

  async list(params: RelationshipListParams = {}): Promise<ListResult<RelationshipItem>> {
    const { data } = await http.get<ApiResponse<ListResult<RelationshipItem>>>(
      '/admin/relationships',
      { params },
    )
    return data.data
  },

  async listFollows(params: FollowListParams = {}): Promise<ListResult<FollowItem>> {
    const { data } = await http.get<ApiResponse<ListResult<FollowItem>>>(
      '/admin/relationships/follows',
      { params },
    )
    return data.data
  },

  async getUserStats(
    params: RelationshipUserStatsParams = {},
  ): Promise<ListResult<RelationshipUserStatsItem>> {
    const { data } = await http.get<ApiResponse<ListResult<RelationshipUserStatsItem>>>(
      '/admin/relationships/users',
      { params },
    )
    return data.data
  },
}
