import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { AdminKenChestService } from '@/services/adminKenChest.service'
import type { CreateKenChestRequest, ListParams } from '@/types'

const KEN_CHESTS_KEY = 'admin-ken-chests'

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
