import http from '@/api/http'
import { adminTokens } from '@/lib/tokenStorage'
import type {
  ApiResponse,
  AdminAccount,
  AdminLoginRequest,
  AdminLoginResult,
} from '@/types'

export const AdminAuthService = {
  async login(payload: AdminLoginRequest): Promise<AdminLoginResult> {
    const { data } = await http.post<ApiResponse<AdminLoginResult>>(
      '/admin/auth/login',
      payload,
      { skipAuth: true },
    )
    const result = data.data
    adminTokens.setTokens(result.token, result.refreshToken)
    return result
  },

  async me(): Promise<AdminAccount> {
    const { data } = await http.get<ApiResponse<AdminAccount>>('/admin/auth/me')
    return data.data
  },

  logout(): void {
    adminTokens.clear()
  },
}
