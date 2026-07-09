import http from '@/api/http'
import type {
  ApiResponse,
  CreateKenChestRequest,
  KenChest,
  KenChestAutoJob,
  KenChestAutoJobRequest,
  KenChestAutoSettings,
  KenChestClaim,
  ListParams,
  ListResult,
  MessageResult,
} from '@/types'

export const AdminKenChestService = {
  async list(params: ListParams = {}): Promise<ListResult<KenChest>> {
    const { data } = await http.get<ApiResponse<ListResult<KenChest>>>('/admin/ken/chests', {
      params,
    })
    return data.data
  },

  async create(payload: CreateKenChestRequest): Promise<KenChest> {
    const { data } = await http.post<ApiResponse<KenChest>>('/admin/ken/chests', payload)
    return data.data
  },

  async detail(id: string): Promise<KenChest> {
    const { data } = await http.get<ApiResponse<KenChest>>(`/admin/ken/chests/${id}`)
    return data.data
  },

  async listClaims(id: string, params: ListParams = {}): Promise<ListResult<KenChestClaim>> {
    const { data } = await http.get<ApiResponse<ListResult<KenChestClaim>>>(
      `/admin/ken/chests/${id}/claims`,
      { params },
    )
    return data.data
  },

  async remove(id: string): Promise<MessageResult> {
    const { data } = await http.delete<ApiResponse<MessageResult>>(`/admin/ken/chests/${id}`)
    return data.data
  },

  async listAutoJobs(): Promise<KenChestAutoJob[]> {
    const { data } = await http.get<ApiResponse<KenChestAutoJob[]>>('/admin/ken/auto-jobs')
    return data.data
  },

  async createAutoJob(payload: KenChestAutoJobRequest): Promise<KenChestAutoJob> {
    const { data } = await http.post<ApiResponse<KenChestAutoJob>>('/admin/ken/auto-jobs', payload)
    return data.data
  },

  async updateAutoJob(id: string, payload: KenChestAutoJobRequest): Promise<KenChestAutoJob> {
    const { data } = await http.put<ApiResponse<KenChestAutoJob>>(`/admin/ken/auto-jobs/${id}`, payload)
    return data.data
  },

  async removeAutoJob(id: string): Promise<MessageResult> {
    const { data } = await http.delete<ApiResponse<MessageResult>>(`/admin/ken/auto-jobs/${id}`)
    return data.data
  },

  async getAutoSettings(): Promise<KenChestAutoSettings> {
    const { data } = await http.get<ApiResponse<KenChestAutoSettings>>('/admin/ken/auto-settings')
    return data.data
  },

  async updateAutoSettings(enabled: boolean): Promise<KenChestAutoSettings> {
    const { data } = await http.put<ApiResponse<KenChestAutoSettings>>('/admin/ken/auto-settings', {
      enabled,
    })
    return data.data
  },
}
