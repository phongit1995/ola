import http from '@/api/http'
import type {
  ApiResponse,
  WordChainMessage,
  WordChainOverview,
  WordChainCursorPage,
  WordChainCursorParams,
  WordChainWin,
  WordChainWinsParams,
} from '@/types'

export const AdminWordChainService = {
  async overview(): Promise<WordChainOverview> {
    const { data } = await http.get<ApiResponse<WordChainOverview>>('/admin/word-chain')
    return data.data
  },

  async messages(params: WordChainCursorParams = {}): Promise<WordChainCursorPage<WordChainMessage>> {
    const { data } = await http.get<ApiResponse<WordChainCursorPage<WordChainMessage>>>(
      '/admin/word-chain/messages',
      { params },
    )
    return data.data
  },

  async wins(
    params: WordChainWinsParams = {},
  ): Promise<WordChainCursorPage<WordChainWin>> {
    const { data } = await http.get<ApiResponse<WordChainCursorPage<WordChainWin>>>(
      '/admin/word-chain/wins',
      { params },
    )
    return data.data
  },
}
