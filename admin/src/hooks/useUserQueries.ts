import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { AdminUserService } from '@/services/adminUser.service'
import type {
  AddVipDaysRequest,
  GrantUserAvatarFrameRequest,
  GrantVipRequest,
  ListParams,
  UserListParams,
  UsernameChangeListParams,
} from '@/types'

export const USERS_KEY = 'admin-users'

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

export function useUserViolations(id: string | null) {
  return useQuery({
    queryKey: [USERS_KEY, 'violations', id],
    queryFn: () => AdminUserService.listViolations(id as string),
    enabled: id != null,
  })
}

export function useRevokeUserViolation() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: ({ id, violationId }: { id: string; violationId: string }) =>
      AdminUserService.revokeViolation(id, violationId),
    onSuccess: (summary, { id }) => {
      queryClient.setQueryData([USERS_KEY, 'violations', id], summary)
    },
    onError: (_err, { id }) => {
      void queryClient.invalidateQueries({ queryKey: [USERS_KEY, 'violations', id] })
    },
  })
}

export function useClearUserViolations() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (id: string) => AdminUserService.clearViolations(id),
    onSuccess: (summary, id) => {
      queryClient.setQueryData([USERS_KEY, 'violations', id], summary)
    },
    onError: (_err, id) => {
      void queryClient.invalidateQueries({ queryKey: [USERS_KEY, 'violations', id] })
    },
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

export function useUserAvatarFrames(id: string | null) {
  return useQuery({
    queryKey: [USERS_KEY, 'avatar-frames', id],
    queryFn: () => AdminUserService.listAvatarFrames(id as string, { limit: 100 }),
    enabled: id != null,
  })
}

export function useGrantUserAvatarFrame() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: ({ id, payload }: { id: string; payload: GrantUserAvatarFrameRequest }) =>
      AdminUserService.grantAvatarFrame(id, payload),
    onSuccess: (_, { id }) => {
      void queryClient.invalidateQueries({ queryKey: [USERS_KEY, 'avatar-frames', id] })
    },
  })
}

export function useRevokeUserAvatarFrame() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: ({ id, frameId }: { id: string; frameId: string }) =>
      AdminUserService.revokeAvatarFrame(id, frameId),
    onSuccess: (_, { id }) => {
      void queryClient.invalidateQueries({ queryKey: [USERS_KEY, 'avatar-frames', id] })
    },
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
