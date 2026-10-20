import http from '@/api/http'
import type { ApiResponse, AppSetting, ChatBotPrompt, ChatBotType } from '@/types'

export const AdminSettingsService = {
  async list(): Promise<AppSetting[]> {
    const { data } = await http.get<ApiResponse<{ items: AppSetting[] }>>('/admin/settings')
    return data.data.items
  },

  async put(
    key: string,
    value: Record<string, unknown>,
    expectedUpdatedAt?: string | null,
  ): Promise<AppSetting> {
    const { data } = await http.put<ApiResponse<AppSetting>>(`/admin/settings/${key}`, {
      value,
      expectedUpdatedAt: expectedUpdatedAt ?? undefined,
    })
    return data.data
  },

  async chatBotDefaults(): Promise<Record<ChatBotType, ChatBotPrompt>> {
    const { data } = await http.get<ApiResponse<Record<ChatBotType, ChatBotPrompt>>>(
      '/admin/settings/chat-bot/defaults',
    )
    return data.data
  },

  async putMany(items: { key: string; value: Record<string, unknown> }[]): Promise<AppSetting[]> {
    const { data } = await http.put<ApiResponse<{ items: AppSetting[] }>>('/admin/settings', {
      items,
    })
    return data.data.items
  },
}
