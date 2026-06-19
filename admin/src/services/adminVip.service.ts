import http from '@/api/http'
import type {
  ApiResponse,
  CreateVipPackageRequest,
  ListParams,
  ListResult,
  MessageResult,
  UpdateVipPackageRequest,
  VipPackage,
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
}
