import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { AdminUserService } from '@/services/adminUser.service'
import type { UserListParams } from '@/types'

const USERS_KEY = 'admin-users'

export function useUsers(params: UserListParams) {
  return useQuery({
    queryKey: [USERS_KEY, params],
    queryFn: () => AdminUserService.list(params),
    placeholderData: (prev) => prev,
  })
}

export function useUserDetail(id: string | null) {
  return useQuery({
    queryKey: [USERS_KEY, 'detail', id],
    queryFn: () => AdminUserService.get(id as string),
    enabled: id != null,
  })
}

export function useUpdateUserStatus() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: ({ id, isActive }: { id: string; isActive: boolean }) =>
      AdminUserService.updateStatus(id, isActive),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [USERS_KEY] })
    },
  })
}

export function useDeleteUser() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (id: string) => AdminUserService.remove(id),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [USERS_KEY] })
    },
  })
}
