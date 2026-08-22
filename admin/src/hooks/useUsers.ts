import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { AdminUserService } from '@/services/adminUser.service'
import type {
  AddVipDaysRequest,
  GrantVipRequest,
  ListParams,
  UserListParams,
  UsernameChangeListParams,
} from '@/types'

const USERS_KEY = 'admin-users'

export function useUsers(params: UserListParams) {
  return useQuery({
    queryKey: [USERS_KEY, params],
    queryFn: () => AdminUserService.list(params),
    placeholderData: (prev) => prev,
  })
}

export function useUsernameChanges(params: UsernameChangeListParams) {
  return useQuery({
    queryKey: [USERS_KEY, 'username-changes', params],
    queryFn: () => AdminUserService.listUsernameChanges(params),
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

export function useUserVips(id: string | null) {
  return useQuery({
    queryKey: [USERS_KEY, 'vips', id],
    queryFn: () => AdminUserService.listVips(id as string, { limit: 200 }),
    enabled: id != null,
  })
}

export function useUserSessions(id: string | null, params: ListParams) {
  return useQuery({
    queryKey: [USERS_KEY, 'sessions', id, params],
    queryFn: () => AdminUserService.listSessions(id as string, params),
    enabled: id != null,
    placeholderData: (prev) => prev,
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

export function useUpdateUsername() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: ({ id, username }: { id: string; username: string }) =>
      AdminUserService.updateUsername(id, username),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [USERS_KEY] })
    },
  })
}

export function useResetPassword() {
  return useMutation({
    mutationFn: ({ id, password }: { id: string; password: string }) =>
      AdminUserService.resetPassword(id, password),
  })
}

export function useGrantVip() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: ({ id, payload }: { id: string; payload: GrantVipRequest }) =>
      AdminUserService.grantVip(id, payload),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [USERS_KEY] })
    },
  })
}

export function useDeleteUserVip() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: ({ id, instanceId }: { id: string; instanceId: string }) =>
      AdminUserService.deleteVip(id, instanceId),
    onSuccess: (_data, { id }) => {
      void queryClient.invalidateQueries({ queryKey: [USERS_KEY] })
      void queryClient.invalidateQueries({ queryKey: [USERS_KEY, 'detail', id] })
    },
  })
}

export function useAddVipDays() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: ({ id, payload }: { id: string; payload: AddVipDaysRequest }) =>
      AdminUserService.addVipDays(id, payload),
    onSuccess: (_data, { id }) => {
      void queryClient.invalidateQueries({ queryKey: [USERS_KEY] })
      void queryClient.invalidateQueries({ queryKey: [USERS_KEY, 'detail', id] })
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
