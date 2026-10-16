import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { AdminClanService } from '@/services/adminClan.service'
import type { ListParams } from '@/types'

const CLANS_KEY = 'admin-clans'

export function useClans(params: ListParams) {
  return useQuery({
    queryKey: [CLANS_KEY, params],
    queryFn: () => AdminClanService.list(params),
    placeholderData: (prev) => prev,
  })
}

export function useClanMembers(id: string | null, params: ListParams) {
  return useQuery({
    queryKey: [CLANS_KEY, 'members', id, params],
    queryFn: () => AdminClanService.members(id as string, params),
    enabled: id != null,
  })
}

export function useDeleteClan() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: (id: string) => AdminClanService.remove(id),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [CLANS_KEY] })
    },
  })
}
