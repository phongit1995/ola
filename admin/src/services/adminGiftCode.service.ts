import http from '@/api/http'
import type {
  ApiResponse,
  GiftCodeAttempt,
  GiftCodeAttemptDevice,
  GiftCodeAttemptParams,
  GiftCodeAttemptSummary,
  GiftCodeAttemptUser,
  GiftCodeCampaign,
  GiftCodeCampaignListParams,
  GiftCodeCampaignListResult,
  GiftCodeCampaignRequest,
  GiftCodeItem,
  GiftCodeListParams,
  GiftCodeListResult,
  GiftCodeRedemption,
  GiftCodeRedemptionListParams,
  ListResult,
} from '@/types'

const BASE = '/admin/gift-codes'

export const AdminGiftCodeService = {
  async list(params: GiftCodeCampaignListParams): Promise<GiftCodeCampaignListResult> {
    const { data } = await http.get<ApiResponse<GiftCodeCampaignListResult>>(BASE, { params })
    return data.data
  },

  async get(id: string): Promise<GiftCodeCampaign> {
    const { data } = await http.get<ApiResponse<GiftCodeCampaign>>(`${BASE}/${id}`)
    return data.data
  },

  async create(payload: GiftCodeCampaignRequest): Promise<GiftCodeCampaign> {
    const { data } = await http.post<ApiResponse<GiftCodeCampaign>>(BASE, payload)
    return data.data
  },

  async update(id: string, payload: GiftCodeCampaignRequest): Promise<GiftCodeCampaign> {
    const { data } = await http.put<ApiResponse<GiftCodeCampaign>>(`${BASE}/${id}`, payload)
    return data.data
  },

  async setEnabled(id: string, enabled: boolean): Promise<GiftCodeCampaign> {
    const { data } = await http.patch<ApiResponse<GiftCodeCampaign>>(`${BASE}/${id}/enabled`, { enabled })
    return data.data
  },

  async listCodes(id: string, params: GiftCodeListParams): Promise<GiftCodeListResult> {
    const { data } = await http.get<ApiResponse<GiftCodeListResult>>(`${BASE}/${id}/codes`, { params })
    return data.data
  },

  async exportCodes(id: string, params: GiftCodeListParams): Promise<GiftCodeListResult> {
    const { data } = await http.get<ApiResponse<GiftCodeListResult>>(`${BASE}/${id}/codes/export`, { params })
    return data.data
  },

  async generateCodes(id: string, count: number): Promise<{ generated: number; totalUses: number }> {
    const { data } = await http.post<ApiResponse<{ generated: number; totalUses: number }>>(
      `${BASE}/${id}/codes`,
      { count },
    )
    return data.data
  },

  async setCodeLock(id: string, codeId: string, locked: boolean, reason: string): Promise<GiftCodeItem> {
    const { data } = await http.patch<ApiResponse<GiftCodeItem>>(`${BASE}/${id}/codes/${codeId}/lock`, {
      locked,
      reason,
    })
    return data.data
  },

  async listRedemptions(
    id: string,
    params: GiftCodeRedemptionListParams,
  ): Promise<ListResult<GiftCodeRedemption>> {
    const { data } = await http.get<ApiResponse<ListResult<GiftCodeRedemption>>>(`${BASE}/${id}/redemptions`, {
      params,
    })
    return data.data
  },

  async exportRedemptions(
    id: string,
    params: GiftCodeRedemptionListParams,
  ): Promise<ListResult<GiftCodeRedemption>> {
    const { data } = await http.get<ApiResponse<ListResult<GiftCodeRedemption>>>(
      `${BASE}/${id}/redemptions/export`,
      { params },
    )
    return data.data
  },

  async attemptSummary(params: GiftCodeAttemptParams): Promise<GiftCodeAttemptSummary> {
    const { data } = await http.get<ApiResponse<GiftCodeAttemptSummary>>(`${BASE}/attempts/summary`, { params })
    return data.data
  },

  async attemptUsers(params: GiftCodeAttemptParams): Promise<ListResult<GiftCodeAttemptUser>> {
    const { data } = await http.get<ApiResponse<ListResult<GiftCodeAttemptUser>>>(`${BASE}/attempts/users`, {
      params,
    })
    return data.data
  },

  async attemptDevices(params: GiftCodeAttemptParams): Promise<ListResult<GiftCodeAttemptDevice>> {
    const { data } = await http.get<ApiResponse<ListResult<GiftCodeAttemptDevice>>>(`${BASE}/attempts/devices`, {
      params,
    })
    return data.data
  },

  async attempts(params: GiftCodeAttemptParams): Promise<ListResult<GiftCodeAttempt>> {
    const { data } = await http.get<ApiResponse<ListResult<GiftCodeAttempt>>>(`${BASE}/attempts`, { params })
    return data.data
  },
}
