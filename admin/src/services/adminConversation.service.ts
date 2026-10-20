import http from '@/api/http'
import type {
  AdminConversationDetail,
  AdminConversationList,
  AdminConversationMessages,
  ApiResponse,
} from '@/types'

export interface ConversationListParams {
  userId: string
  hidden: boolean
  limit?: number
  offset?: number
  snapshot?: string
}

export interface ConversationMessagesParams {
  limit?: number
  before?: string
  around?: string
}

export const AdminConversationService = {
  async listByUser(params: ConversationListParams): Promise<AdminConversationList> {
    const { data } = await http.get<ApiResponse<AdminConversationList>>('/admin/conversations', { params })
    return data.data
  },

  async detail(id: string): Promise<AdminConversationDetail> {
    const { data } = await http.get<ApiResponse<AdminConversationDetail>>(`/admin/conversations/${id}`)
    return data.data
  },

  async messages(id: string, params: ConversationMessagesParams = {}): Promise<AdminConversationMessages> {
    const { data } = await http.get<ApiResponse<AdminConversationMessages>>(
      `/admin/conversations/${id}/messages`,
      { params },
    )
    return data.data
  },
}
