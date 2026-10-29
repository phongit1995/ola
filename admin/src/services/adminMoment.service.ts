import http from '@/api/http'
import type {
  AdminMoment,
  AdminMomentComment,
  AdminMomentDetail,
  AdminMomentListParams,
  AdminMomentViewer,
  ApiResponse,
  MomentMediaPurgeLogs,
  MomentMediaPurgeRunResult,
  ListParams,
  ListResult,
} from '@/types'

export const AdminMomentService = {
  async list(params: AdminMomentListParams = {}): Promise<ListResult<AdminMoment>> {
    const { data } = await http.get<ApiResponse<ListResult<AdminMoment>>>('/admin/moments', {
      params,
    })
    return data.data
  },

  async get(id: string): Promise<AdminMomentDetail> {
    const { data } = await http.get<ApiResponse<AdminMomentDetail>>(`/admin/moments/${id}`)
    return data.data
  },

  async setStatus(id: string, enabled: boolean): Promise<AdminMomentDetail> {
    const { data } = await http.patch<ApiResponse<AdminMomentDetail>>(`/admin/moments/${id}/status`, {
      enabled,
    })
    return data.data
  },

  async purgeMedia(id: string): Promise<AdminMomentDetail> {
    const { data } = await http.post<ApiResponse<AdminMomentDetail>>(`/admin/moments/${id}/purge-media`)
    return data.data
  },

  async purgeLogs(params: ListParams = {}): Promise<MomentMediaPurgeLogs> {
    const { data } = await http.get<ApiResponse<MomentMediaPurgeLogs>>(
      '/admin/moment-media-purge/logs',
      { params },
    )
    return data.data
  },

  async runPurge(): Promise<MomentMediaPurgeRunResult> {
    const { data } = await http.post<ApiResponse<MomentMediaPurgeRunResult>>('/admin/moment-media-purge/run')
    return data.data
  },

  async listViewers(id: string, params: ListParams = {}): Promise<ListResult<AdminMomentViewer>> {
    const { data } = await http.get<ApiResponse<ListResult<AdminMomentViewer>>>(
      `/admin/moments/${id}/viewers`,
      { params },
    )
    return data.data
  },

  async listComments(id: string, params: ListParams = {}): Promise<ListResult<AdminMomentComment>> {
    const { data } = await http.get<ApiResponse<ListResult<AdminMomentComment>>>(
      `/admin/moments/${id}/comments`,
      { params },
    )
    return data.data
  },
}
