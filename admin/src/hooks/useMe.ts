import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { AdminMeService } from '@/services/adminMe.service'
import type { MeListParams } from '@/types'

const ME_KEY = 'admin-me'

export function useMeList(params: MeListParams) {
  return useQuery({
    queryKey: [ME_KEY, params],
    queryFn: () => AdminMeService.list(params),
    placeholderData: (prev) => prev,
  })
}

export function useMeDetail(id: string | null) {
  return useQuery({
    queryKey: [ME_KEY, 'detail', id],
    queryFn: () => AdminMeService.get(id as string),
    enabled: id != null,
  })
}

export function useMeComments(id: string | null) {
  return useQuery({
    queryKey: [ME_KEY, 'comments', id],
    queryFn: () => AdminMeService.listComments(id as string, { limit: 100, offset: 0 }),
    enabled: id != null,
  })
}

export function useUpdateMeStatus() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: ({ id, enabled }: { id: string; enabled: boolean }) =>
      AdminMeService.setStatus(id, enabled),
    onSuccess: (_data, variables) => {
      void queryClient.invalidateQueries({ queryKey: [ME_KEY, 'detail', variables.id] })
      void queryClient.invalidateQueries({ queryKey: [ME_KEY] })
    },
  })
}

export function useDeleteMeComment() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: ({ id, commentId }: { id: string; commentId: string }) =>
      AdminMeService.removeComment(id, commentId),
    onSuccess: (_data, variables) => {
      void queryClient.invalidateQueries({ queryKey: [ME_KEY, 'comments', variables.id] })
      void queryClient.invalidateQueries({ queryKey: [ME_KEY, 'detail', variables.id] })
      void queryClient.invalidateQueries({ queryKey: [ME_KEY] })
    },
  })
}
