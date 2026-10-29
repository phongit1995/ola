import http from '@/api/http'
import type {
  AnalyticsOverview,
  AnalyticsPlatform,
  AnalyticsQueryParams,
  AnalyticsRealtime,
  ApiResponse,
} from '@/types'

export const AdminAnalyticsService = {
  async getOverview(params: AnalyticsQueryParams): Promise<AnalyticsOverview> {
    const { data } = await http.get<ApiResponse<AnalyticsOverview>>('/admin/analytics/overview', {
      params,
    })
    return data.data
  },

  async getRealtime(platform: AnalyticsPlatform, refresh = false): Promise<AnalyticsRealtime> {
    const { data } = await http.get<ApiResponse<AnalyticsRealtime>>('/admin/analytics/realtime', {
      params: { platform, refresh },
    })
    return data.data
  },
}
