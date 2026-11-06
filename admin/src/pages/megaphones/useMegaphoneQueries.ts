import { keepPreviousData, useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { AdminMegaphoneService } from '@/services/adminMegaphone.service'
import type { MegaphoneListParams, RemoveMegaphoneRequest } from '@/types'

const MEGAPHONES_KEY = 'admin-megaphones'

export function useMegaphones(params: MegaphoneListParams) {
  return useQuery({
    queryKey: [MEGAPHONES_KEY, params],
    queryFn: () => AdminMegaphoneService.list(params),
    placeholderData: keepPreviousData,
  })
}

export function useRemoveMegaphone() {
  const queryClient = useQueryClient()
  return useMutation({
    mutationFn: ({ id, payload }: { id: string; payload: RemoveMegaphoneRequest }) =>
      AdminMegaphoneService.remove(id, payload),
    onSuccess: () => {
      void queryClient.invalidateQueries({ queryKey: [MEGAPHONES_KEY] })
    },
  })
}

export function useCheckContent() {
  return useMutation({
    mutationFn: (text: string) => AdminMegaphoneService.checkContent(text),
  })
}
