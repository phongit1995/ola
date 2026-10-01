import http from '@/api/http'
import type {
  ApiResponse,
  WordChainMessage,
  WordChainOverview,
  WordChainPage,
  WordChainWin,
} from '@/types'

interface CursorParams {
  limit?: number
  before?: string
}

export const AdminWordChainService = {
  async overview(): Promise<WordChainOverview> {
    const { data } = await http.get<ApiResponse<WordChainOverview>>('/admin/word-chain')
    return data.data
  },

  async messages(params: CursorParams = {}): Promise<WordChainPage<WordChainMessage>> {
    const { data } = await http.get<ApiResponse<WordChainPage<WordChainMessage>>>(
      '/admin/word-chain/messages',
      { params },
    )
    return data.data
  },

  async wins(
    params: CursorParams & { userId?: string } = {},
  ): Promise<WordChainPage<WordChainWin>> {
    const { data } = await http.get<ApiResponse<WordChainPage<WordChainWin>>>(
      '/admin/word-chain/wins',
      { params },
    )
    return data.data
  },
}
