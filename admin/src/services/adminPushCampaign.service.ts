import http from '@/api/http'
import type {
  ApiResponse,
  CreatePushCampaignRequest,
  ListParams,
  ListResult,
  PushAudience,
  PushAudienceCount,
  PushCampaign,
} from '@/types'

export const AdminPushCampaignService = {
  async list(params: ListParams = {}): Promise<ListResult<PushCampaign>> {
    const { data } = await http.get<ApiResponse<ListResult<PushCampaign>>>(
      '/admin/push-campaigns',
      { params },
    )
    return data.data
  },

  async audience(audience: PushAudience, username?: string): Promise<PushAudienceCount> {
    const { data } = await http.get<ApiResponse<PushAudienceCount>>(
      '/admin/push-campaigns/audience',
      { params: { audience, username } },
    )
    return data.data
  },

  async create(payload: CreatePushCampaignRequest): Promise<PushCampaign> {
    const { data } = await http.post<ApiResponse<PushCampaign>>('/admin/push-campaigns', payload)
    return data.data
  },
}
