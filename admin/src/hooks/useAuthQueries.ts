import { useMutation } from '@tanstack/react-query'
import { AdminAuthService } from '@/services/adminAuth.service'
import type { AdminLoginRequest } from '@/types'

export function useAdminLogin() {
  return useMutation({
    mutationFn: (payload: AdminLoginRequest) => AdminAuthService.login(payload),
  })
}

export function useAdminLogout() {
  return useMutation({
    mutationFn: () => AdminAuthService.logout(),
  })
}

export function useChangeAdminPassword() {
  return useMutation({
    mutationFn: (payload: { currentPassword: string; newPassword: string }) =>
      AdminAuthService.changePassword(payload),
  })
}
