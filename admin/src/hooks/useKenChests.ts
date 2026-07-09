import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { AdminKenChestService } from '@/services/adminKenChest.service'
import type { CreateKenChestRequest, KenChestAutoJobRequest, ListParams } from '@/types'

const KEN_CHESTS_KEY = 'admin-ken-chests'
const KEN_AUTO_JOBS_KEY = 'admin-ken-auto-jobs'
const KEN_AUTO_SETTINGS_KEY = 'admin-ken-auto-settings'

export function useKenChests(params: ListParams) {
  return useQuery({
    queryKey: [KEN_CHESTS_KEY, params],
    queryFn: () => AdminKenChestService.list(params),
    placeholderData: (prev) => prev,
  })
}

export function useKenChestClaims(id: string | null, params: ListParams) {
  return useQuery({
    queryKey: [KEN_CHESTS_KEY, 'claims', id, params],
    queryFn: () => AdminKenChestService.listClaims(id as string, params),
    enabled: !!id,
    placeholderData: (prev) => prev,
  })
}

export function useKenAllClaims(params: ListParams) {
  return useQuery({
    queryKey: [KEN_CHESTS_KEY, 'all-claims', params],
    queryFn: () => AdminKenChestService.listAllClaims(params),
    placeholderData: (prev) => prev,
  })
}

export function useCreateKenChest() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (payload: CreateKenChestRequest) => AdminKenChestService.create(payload),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [KEN_CHESTS_KEY] })
    },
  })
}

export function useDeleteKenChest() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (id: string) => AdminKenChestService.remove(id),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [KEN_CHESTS_KEY] })
    },
  })
}

export function useKenAutoJobs() {
  return useQuery({
    queryKey: [KEN_AUTO_JOBS_KEY],
    queryFn: () => AdminKenChestService.listAutoJobs(),
  })
}

export function useCreateKenAutoJob() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (payload: KenChestAutoJobRequest) => AdminKenChestService.createAutoJob(payload),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [KEN_AUTO_JOBS_KEY] })
    },
  })
}

export function useUpdateKenAutoJob() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: ({ id, payload }: { id: string; payload: KenChestAutoJobRequest }) =>
      AdminKenChestService.updateAutoJob(id, payload),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [KEN_AUTO_JOBS_KEY] })
    },
  })
}

export function useDeleteKenAutoJob() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (id: string) => AdminKenChestService.removeAutoJob(id),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [KEN_AUTO_JOBS_KEY] })
    },
  })
}

export function useKenAutoSettings() {
  return useQuery({
    queryKey: [KEN_AUTO_SETTINGS_KEY],
    queryFn: () => AdminKenChestService.getAutoSettings(),
  })
}

export function useUpdateKenAutoSettings() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (enabled: boolean) => AdminKenChestService.updateAutoSettings(enabled),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [KEN_AUTO_SETTINGS_KEY] })
    },
  })
}
