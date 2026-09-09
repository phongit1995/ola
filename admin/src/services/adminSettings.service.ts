import http from '@/api/http'
import type { ApiResponse, AppSetting } from '@/types'

export const AdminSettingsService = {
  async list(): Promise<AppSetting[]> {
    const { data } = await http.get<ApiResponse<{ items: AppSetting[] }>>('/admin/settings')
    return data.data.items
  },

  async put(key: string, value: Record<string, unknown>): Promise<AppSetting> {
    const { data } = await http.put<ApiResponse<AppSetting>>(`/admin/settings/${key}`, { value })
    return data.data
  },

  async putMany(items: { key: string; value: Record<string, unknown> }[]): Promise<AppSetting[]> {
    const { data } = await http.put<ApiResponse<{ items: AppSetting[] }>>('/admin/settings', {
      items,
    })
    return data.data.items
  },
}
