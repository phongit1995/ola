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
    adminTokens.setAccessToken(result.token)
    return result
  },

  async me(): Promise<AdminAccount> {
    const { data } = await http.get<ApiResponse<AdminAccount>>('/admin/auth/me')
    return data.data
  },

  async changePassword(payload: {
    currentPassword: string
    newPassword: string
  }): Promise<void> {
    await http.post<ApiResponse<{ message: string }>>('/admin/auth/change-password', payload)
  },

  async logout(): Promise<void> {
    try {
      await http.post<ApiResponse<{ message: string }>>('/admin/auth/logout')
    } finally {
      // A failed server-side revoke is surfaced to the caller, but this browser
      // must still stop using its access token immediately.
      adminTokens.clear()
    }
  },
}
