import http from '@/api/http'
import type {
  AdminVipTransfer,
  ApiResponse,
  CreateVipPackageRequest,
  CreateVipShopItemRequest,
  ListParams,
  ListResult,
  MessageResult,
  UpdateVipPackageRequest,
  UpdateVipShopItemRequest,
  VipPackage,
  VipPurchaseHistory,
  VipShopItem,
  VipTransferListParams,
} from '@/types'

export const AdminVipService = {
  async listPackages(params: ListParams = {}): Promise<ListResult<VipPackage>> {
    const { data } = await http.get<ApiResponse<ListResult<VipPackage>>>(
      '/admin/vip/packages',
      { params },
    )
    return data.data
  },

  async create(payload: CreateVipPackageRequest): Promise<VipPackage> {
    const { data } = await http.post<ApiResponse<VipPackage>>('/admin/vip/packages', payload)
    return data.data
  },

  async update(id: string, payload: UpdateVipPackageRequest): Promise<VipPackage> {
    const { data } = await http.patch<ApiResponse<VipPackage>>(
      `/admin/vip/packages/${id}`,
      payload,
    )
    return data.data
  },

  async remove(id: string): Promise<MessageResult> {
    const { data } = await http.delete<ApiResponse<MessageResult>>(`/admin/vip/packages/${id}`)
    return data.data
  },

  async listShopItems(): Promise<VipShopItem[]> {
    const { data } = await http.get<ApiResponse<{ total: number; items: VipShopItem[] }>>(
      '/admin/vip/shop',
    )
    return data.data.items
  },

  async createShopItem(payload: CreateVipShopItemRequest): Promise<VipShopItem> {
    const { data } = await http.post<ApiResponse<VipShopItem>>('/admin/vip/shop', payload)
    return data.data
  },

  async updateShopItem(id: string, payload: UpdateVipShopItemRequest): Promise<VipShopItem> {
    const { data } = await http.patch<ApiResponse<VipShopItem>>(`/admin/vip/shop/${id}`, payload)
    return data.data
  },

  async removeShopItem(id: string): Promise<MessageResult> {
    const { data } = await http.delete<ApiResponse<MessageResult>>(`/admin/vip/shop/${id}`)
    return data.data
  },

  async listTransfers(
    params: VipTransferListParams = {},
  ): Promise<ListResult<AdminVipTransfer>> {
    const { data } = await http.get<ApiResponse<ListResult<AdminVipTransfer>>>(
      '/admin/vip/transfers',
      { params },
    )
    return data.data
  },

  async listHistory(
    userId: string,
    params: ListParams = {},
  ): Promise<ListResult<VipPurchaseHistory>> {
    const { data } = await http.get<ApiResponse<ListResult<VipPurchaseHistory>>>(
      '/admin/vip/history',
      { params: { ...params, userId } },
    )
    return data.data
  },
}
