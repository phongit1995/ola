import http from '@/api/http'
import type {
  AdminAvatarFramePurchase,
  AdminAvatarFrameTransfer,
  ApiResponse,
  AvatarFramePurchaseListParams,
  AvatarFramePurchaseStatsParams,
  AvatarFramePurchaseStatsResult,
  AvatarFrameShopItem,
  AvatarFrameTransferListParams,
  CreateAvatarFrameShopItemsRequest,
  CreateAvatarFrameShopItemsResult,
  ListResult,
  MessageResult,
  UpdateAvatarFrameShopItemRequest,
} from '@/types'

export const AdminAvatarFrameService = {
  async listShopItems(): Promise<AvatarFrameShopItem[]> {
    const { data } = await http.get<ApiResponse<{ total: number; items: AvatarFrameShopItem[] }>>(
      '/admin/avatar-frames/shop',
    )
    return data.data.items
  },

  async createShopItems(
    payload: CreateAvatarFrameShopItemsRequest,
  ): Promise<CreateAvatarFrameShopItemsResult> {
    const { data } = await http.post<ApiResponse<CreateAvatarFrameShopItemsResult>>(
      '/admin/avatar-frames/shop',
      payload,
    )
    return data.data
  },

  async updateShopItem(
    id: string,
    payload: UpdateAvatarFrameShopItemRequest,
  ): Promise<AvatarFrameShopItem> {
    const { data } = await http.patch<ApiResponse<AvatarFrameShopItem>>(
      `/admin/avatar-frames/shop/${id}`,
      payload,
    )
    return data.data
  },

  async removeShopItem(id: string): Promise<MessageResult> {
    const { data } = await http.delete<ApiResponse<MessageResult>>(
      `/admin/avatar-frames/shop/${id}`,
    )
    return data.data
  },

  async reorderShopItems(ids: string[]): Promise<MessageResult> {
    const { data } = await http.put<ApiResponse<MessageResult>>('/admin/avatar-frames/shop/order', { ids })
    return data.data
  },

  async listPurchases(
    params: AvatarFramePurchaseListParams = {},
  ): Promise<ListResult<AdminAvatarFramePurchase>> {
    const { data } = await http.get<ApiResponse<ListResult<AdminAvatarFramePurchase>>>(
      '/admin/avatar-frames/purchases',
      { params },
    )
    return data.data
  },

  async getPurchaseStats(
    params: AvatarFramePurchaseStatsParams = {},
  ): Promise<AvatarFramePurchaseStatsResult> {
    const { data } = await http.get<ApiResponse<AvatarFramePurchaseStatsResult>>(
      '/admin/avatar-frames/purchases/stats',
      { params },
    )
    return data.data
  },

  async listTransfers(
    params: AvatarFrameTransferListParams = {},
  ): Promise<ListResult<AdminAvatarFrameTransfer>> {
    const { data } = await http.get<ApiResponse<ListResult<AdminAvatarFrameTransfer>>>(
      '/admin/avatar-frames/transfers',
      { params },
    )
    return data.data
  },
}
