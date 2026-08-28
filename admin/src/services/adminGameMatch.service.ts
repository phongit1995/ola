import http from '@/api/http'
import type {
  AdminGameLevel,
  AdminGameMatch,
  ApiResponse,
  GameLevelListParams,
  GameMatchListParams,
  GameMatchStatsParams,
  GameMatchStatsResponse,
  GameMatchSuspectsParams,
  GameMatchSuspectsResponse,
  ListResult,
} from '@/types'

export const AdminGameMatchService = {
  async listMatches(params: GameMatchListParams = {}): Promise<ListResult<AdminGameMatch>> {
    const { data } = await http.get<ApiResponse<ListResult<AdminGameMatch>>>(
      '/admin/game-matches',
      { params },
    )
    return data.data
  },

  async getStats(params: GameMatchStatsParams = {}): Promise<GameMatchStatsResponse> {
    const { data } = await http.get<ApiResponse<GameMatchStatsResponse>>(
      '/admin/game-matches/stats',
      { params },
    )
    return data.data
  },

  async getSuspects(params: GameMatchSuspectsParams = {}): Promise<GameMatchSuspectsResponse> {
    const { data } = await http.get<ApiResponse<GameMatchSuspectsResponse>>(
      '/admin/game-matches/suspects',
      { params },
    )
    return data.data
  },

  async listLevels(params: GameLevelListParams = {}): Promise<ListResult<AdminGameLevel>> {
    const { data } = await http.get<ApiResponse<ListResult<AdminGameLevel>>>(
      '/admin/game-matches/levels',
      { params },
    )
    return data.data
  },
}
